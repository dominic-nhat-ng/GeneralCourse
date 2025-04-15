set  enable_page_mode false
set sh_enable_page_mode false
source -e -v scripts/library.tcl
define_design_lib -path ./work work



open_mw_lib $mw_design_library

set upf_charz_allow_port_punch true
set_message_info -id VER-130 -limit 1


read_ddc [glob $results/*_ilm.ddc]
read_ddc $results/top_gtech.ddc

current_design $DESIGN_NAME

set_tlu_plus_files  -max_tluplus  $TLUPLUS_MAX_FILE   -tech2itf_map    $MAP_FILE

set uniquify_naming_style "[current_design_name]_%s_%d"

uniquify

set compile_preserve_subdesign_interfaces true
propagate_constraints -power

#source -e -v ./sdc/top.set_voltage.tcl
source -e -v ./sdc/top.sdc

set_voltage -object_list "c0/VDD c1/c1_VDD_SW c1/VDD c2/VDD c3/c3_VDD_SW c3/VDD c4/VDD c5/c5_VDD_SW c5/VDD c6/VDD VDD" 1.08
set_voltage -object_list "c0/VSS c1/VSS c2/VSS c3/VSS c4/VSS c5/VSS c6/VSS VSS" 0.0


source -e -v upf/parent_iso.upf


set_fix_multiple_port_nets -all -buffer_constants


#### Formal Verification will be easy ###############
set_register_merging [all_registers ] false

name_format  -isolation_prefix "UPF_ISO_top_"  -level_shift_prefix "UPF_LS_top_" -isolation_suffix "" -level_shift_suffix ""
compile_ultra  -scan -no_seq -no_autoungroup -no_boundary_optimization
report_isolation_cell -domain [get_power_domains -hierarchical ] > iso_pre_test.rpt
check_mv_design
set test_insert_isolation_cells false
set test_show_scan_inserted_isolation_cells true
#source -e -v scripts/test_config.tcl
#create_test_protocol
#dft_drc
#report_pst
#report_scan_configuration
#report_dft_insertion_configuration
#insert_dft
#source -e -v upf/test_isolators.upf
#insert_mv_cells -verbose -isolation
#check_mv_design
#compile_ultra -incremental -scan -no_auto -no_bound -no_seq
#uniquify -force
#check_mv_design
#change_names -rules verilog -hierarchy
#write_scan_def -output $results/${DESIGN_NAME}_ilm_compiled.scan_def
#write_test_model -format ctl -output $results/${DESIGN_NAME}_ilm_compiled.ctl
#write_test_protocol -test_mode Internal_scan -names verilog -output $results/${DESIGN_NAME}_ilm_compiled.spf
#
#change_names -rule verilog -hier
#write -f ddc -hier -o $results/${DESIGN_NAME}_ilm_compiled.ddc
#write -f verilog -hier -o $results/${DESIGN_NAME}_ilm_compiled.vg
#check_mv_design -verb > $reports/cmv_verbose_ilm_compiled.rpt
#report_power_domain [get_power_domains * -hierarchical] > $reports/dc_pd.rpt
#report_power_switch [get_power_switches * -hierarchical] > $reports/dc_power_switches.rpt
#report_supply_net [get_supply_nets *] > $reports/dc_supply_nets.rpt
#report_pst > $reports/dc_pst.rpt
#report_level_shifter -domain [get_power_domains * -hierarchical] > $reports/dc_ls.rpt
#report_isolation_cell -domain [get_power_domains * -hierarchical]   > $reports/dc_iso.rpt
#report_retention_cell -domain [get_power_domains * -hierarchical] > $reports/dc_retn.rpt
#report_power -nosplit > $reports/compile.mapped.power.rpt
#lint
#check_design
#
########################## Generate Outputs ##################################################
#write -f verilog -h -out   $results/${DESIGN_NAME}_ilm_compiled.v
#write -f ddc -h -out       $results/${DESIGN_NAME}_ilm_compiled.ddc
#write_sdc -nosplit         $results/${DESIGN_NAME}_ilm_compiled.sdc
#write_script  -out         $results/${DESIGN_NAME}_ilm_compiled.script
#save_upf                   $results/${DESIGN_NAME}_ilm_compiled.upf
#
#write_parasitics -output $results/${DESIGN_NAME}_ilm_compiled.spef
#write_sdf $results/${DESIGN_NAME}_ilm_compiled.sdf
#
