#source -e -v scripts/library.tcl


sh rm -rf top_mw_design_lib
create_mw_lib -mw_reference_library $mw_reference_library -tech $mw_tech_file top_mw_design_lib -open


define_design_lib -path ./work work

#analyze -format verilog [glob rtl/*.v]
#elaborate top
read_verilog [glob rtl/*.v]
current_design top

link

set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_no_main_power_violations  false
set mv_allow_ls_on_leaf_pin_boundary true



remove_attribute [get_lib_cells */*ISO*] dont_use
remove_attribute [get_lib_cells */*ISO*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_use
remove_attribute [get_lib_cells */*LS*] dont_touch
remove_attribute [get_lib_cells */*LS*] dont_use
remove_attribute [get_lib_cells */*AO*] dont_touch
remove_attribute [get_lib_cells */*AO*] dont_use


set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE


source -e -v sdc/top.sdc
source -e -v rtl/top.upf
source -e -v rtl/iso.upf

set_operating_conditions  -max tt0p85v125c

set_voltage -object_list "VDDSW4 VDDSW3 VDDSW2 VDDSW1 VDD_TOP VDD_WRAP" 0.85
set_voltage -object_list VSS 0.0


check_mv_design

set HIERARCHICAL_CELLS "CPU_1 CPU_2 CPU_3 CPU_4"
set hcells [get_cells $HIERARCHICAL_CELLS]
set results ./results

sizeof_collection [get_cells * -hier]


foreach_in_collection cell $hcells {
set cell_name [get_object_name $cell]
name_format  -isolation_prefix "UPF_ISO_${cell_name}_" -isolation_suffix "" -level_shift_prefix "UPF_LS_${cell_name}_" -level_shift_suffix ""
echo "Characterizing hierarchical cell $cell_name"
characterize $cell_name -power
echo "Done Characterizing hierarchical cell $cell_name"
}

set ucells "pwr_ctl or2 nand2 nor2 xor2 xnor2 flop"
set uniquified_cells [get_designs $ucells]
foreach_in_collection ucell $uniquified_cells {
set cell_name [get_object_name $ucell]
echo "Generating constraints for hierarchical cell $cell_name"
current_design $cell_name
name_format  -isolation_prefix "UPF_ISO_${cell_name}_" -isolation_suffix "" -level_shift_prefix "UPF_LS_${cell_name}_" -level_shift_suffix ""
save_upf $results/${cell_name}_unmapped.upf
write -f ddc -h -o $results/${cell_name}_unmapped.ddc
current_design top
echo "Done Generating constraints for hierarchical cell $cell_name"
}

sizeof_collection [get_cells * -hier]


set uniquified_cells [get_designs $ucells]

echo $uniquified_cells > .src
query_object $uniquified_cells >> .src

foreach_in_collection rcell $uniquified_cells {
set cell_name [get_object_name $rcell]
echo "Removing cell $cell_name"
remove_design -h  $cell_name
echo "Done Removing cell $cell_name"
echo "$cell_name WHY Terminating"
}

sizeof_collection [get_cells * -hier]



echo "Generating Top Level Gtech DDC/UPF/SCRIPT files"
name_format  -isolation_prefix "UPF_ISO_top_"  -level_shift_prefix "UPF_LS_top_" -isolation_suffix "" -level_shift_suffix ""
#source -e -v upf/parent_iso.upf
write -f ddc -h -o $results/top_gtech.ddc
save_upf $results/top_gtech.upf
write_script -out $results/top_gtech.script
exit
