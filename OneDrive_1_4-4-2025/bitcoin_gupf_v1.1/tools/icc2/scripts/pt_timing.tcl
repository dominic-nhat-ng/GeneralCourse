

set power_enable_analysis TRUE
source rm_setup/dc_setup.tcl
set sh_continue_on_error true


source -e -v scripts/pt_setup.tcl

suppress_message UITE-130
suppress_message PARA-007

set wd [pwd]



lappend search_path bc_outputs_icc2
lappend search_path bt_outputs_icc2
lappend search_path bs_outputs_icc2
lappend search_path results
lappend search_path .

echo $search_path


set DESIGN_NAME bit_coin


set svr_keep_unconnected_nets true

echo $search_path
echo $link_library

set_app_var eco_enable_mim true
set_app_var read_parasitics_load_locations true


read_verilog [list bc_outputs_icc2/chip_finish.v.gz bt_outputs_icc2/chip_finish.v.gz bs_outputs_icc2/chip_finish.v.gz]
current_design $DESIGN_NAME
link


set_eco_options -mim_group {bit_secure_0 bit_secure_1 bit_secure_2 bit_secure_3 bit_secure_4 bit_secure_5 bit_secure_6 bit_secure_7 bit_secure_8 bit_secure_9 bit_secure_10 bit_secure_11 bit_secure_12 bit_secure_13 bit_secure_14 bit_secure_15}
set_eco_options -mim_group {bit_secure*/slice_0 bit_secure*/slice_1 bit_secure*/slice_2 bit_secure*/slice_3 bit_secure*/slice_4 bit_secure*/slice_5 bit_secure*/slice_6 bit_secure*/slice_7 bit_secure*/slice_8 bit_secure*/slice_9 bit_secure*/slice_10 bit_secure*/slice_11 bit_secure*/slice_12 bit_secure*/slice_13 bit_secure*/slice_14 bit_secure*/slice_15 bit_secure*/slice_16 bit_secure*/slice_17 bit_secure*/slice_18 bit_secure*/slice_19 bit_secure*/slice_20 bit_secure*/slice_21 bit_secure*/slice_22 bit_secure*/slice_23 bit_secure*/slice_24 bit_secure*/slice_25 bit_secure*/slice_26 bit_secure*/slice_27 bit_secure*/slice_28 bit_secure*/slice_29 bit_secure*/slice_30 bit_secure*/slice_31}

set_eco_options -physical_design_path ./bs_outputs_icc2/chip_finish.def.gz

set LIB_PATH $wd

set_eco_options -physical_design_path "./bt_outputs_icc2/chip_finish.def.gz ./bs_outputs_icc2/chip_finish.def.gz ./bc_outputs_icc2/chip_finish.def.gz" -physical_lib_path "$LIB_PATH/lib/stdcell_hvt/lef/saed32nm_hvt_1p9m.lef $LIB_PATH/lib/stdcell_rvt/lef/saed32nm_rvt_1p9m.lef $LIB_PATH/lib/stdcell_lvt/lef/saed32nm_lvt_1p9m.lef $LIB_PATH/lib/sram/lef/sram.lef ./bt_outputs_icc2/chip_finish.lef ./bs_outputs_icc2/chip_finish.lef" -physical_tech_lib_path $LIB_PATH/tech/milkyway/tech.lef


set all_nets [get_nets -hier *]
remove_capacitance          $all_nets
remove_resistance           $all_nets
remove_annotated_parasitics $all_nets
remove_annotated_delay -all
remove_annotated_check -all


load_upf bc_outputs_icc2/top_wrapper.upf

read_parasitics bs_outputs_icc2/chip_finish.maxTLU_125.spef -path bit_secure*/slice*
read_parasitics bt_outputs_icc2/chip_finish.maxTLU_125.spef -path bit_secure*
read_parasitics bc_outputs_icc2/chip_finish.maxTLU_125.spef

read_sdc bc_outputs_icc2/chip_finish.sdc


update_timing
update_power
### The option below is required only if Vector Based (VCD) analysis is done in PR ####
set report_dir $wd/reports
report_power > $report_dir/ptpx_power_vector.rpt
report_timing -delay max -tran -cap -path full_clock -crosstalk_delta -significant_digits 4 -max_paths 1000 -nosplit > $report_dir/pt_timing.rpt
report_qor -summary > $report_dir/qor.summary.rpt
report_global_timing
report_constraint -all -max_capacitance -max_transition > reports/global_cons.rpt

report_eco_options
check_eco

set_dont_use [get_lib_cells */*AO*] false



fix_eco_timing -type setup -physical_mode open_site
write_changes -format icc2tcl -output results/pt_setup_eco_file.tcl

fix_eco_timing -type hold -physical_mode open_site -buffer_list [list NBUFFX16_HVT NBUFFX4_HVT NBUFFX2_HVT NBUFFX16_RVT NBUFFX4_RVT NBUFFX2_RVT NBUFFX16_LVT NBUFFX4_LVT NBUFFX2_LVT AOBUFX4_LVT AOINVX4_LVT AOBUFX4_RVT AOBUFX4_HVT AOINVX4_HVT]
write_changes -format icc2tcl -output results/pt_hold_eco_file.tcl

fix_eco_leakage -pattern_priority {HVT RVT LVT} 

write_changes -format icc2tcl -output results/pt_leakage_eco_file.tcl

exit

