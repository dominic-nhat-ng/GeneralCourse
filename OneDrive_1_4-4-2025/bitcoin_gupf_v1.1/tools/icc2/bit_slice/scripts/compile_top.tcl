set  enable_page_mode false
set sh_enable_page_mode false
define_design_lib -path ./work work



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



open_mw_lib $mw_design_library

set upf_charz_allow_port_punch true
set_message_info -id VER-130 -limit 1


read_ddc [glob $results/*_ilm.ddc]
read_ddc $results/top_gtech.ddc

current_design $DESIGN_NAME

set_tlu_plus_files  -max_tluplus  $TLUPLUS_MAX_FILE   -tech2itf_map    $MAP_FILE

extract_physical_constraints def/top.def
source -e -v def/top.dump

remove_attribute [get_lib_cells */*ISO*] dont_use
remove_attribute [get_lib_cells */*ISO*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_use
remove_attribute [get_lib_cells */*LS*] dont_touch
remove_attribute [get_lib_cells */*LS*] dont_use
remove_attribute [get_lib_cells */*AO*] dont_touch
remove_attribute [get_lib_cells */*AO*] dont_use



set_ignored_layers -max_routing_layer M6



set uniquify_naming_style "[current_design_name]_%s_%d"

uniquify

set compile_preserve_subdesign_interfaces true
set_operating_conditions  -max tt0p85v125c

propagate_constraints -power

source -e -v ./sdc/top.sdc
#source -e -v ./rtl/iso.upf


set_voltage -object_list "VDDSW3 VDDSW2 VDDSW1 VDDSW0 VDD_TOP VDD_WRAP" 0.85
set_voltage -object_list VSS 0.0




set_fix_multiple_port_nets -all -buffer_constants


compile_ultra  -scan -no_seq -no_autoungroup -no_boundary_optimization
source -e -v scripts/test_config.tcl
create_test_protocol
dft_drc
report_pst
report_scan_configuration
report_dft_insertion_configuration
set test_insert_isolation_cells false
set test_show_scan_inserted_isolation_cells true
insert_dft
insert_mv_cells -verbose -isolation
check_mv_design
set test_insert_isolation_cells true
compile_ultra -incremental -scan -no_auto -no_bound -no_seq
uniquify -force
check_mv_design
change_names -rules verilog -hierarchy
write_scan_def -output $results/${DESIGN_NAME}_ilm_compiled.scan_def
write_test_model -format ctl -output $results/${DESIGN_NAME}_ilm_compiled.ctl
write_test_protocol -test_mode Internal_scan -names verilog -output $results/${DESIGN_NAME}_ilm_compiled.spf

change_names -rule verilog -hier
write -f ddc -hier -o $results/${DESIGN_NAME}_ilm_compiled.ddc
write -f verilog -hier -o $results/${DESIGN_NAME}_ilm_compiled.vg
check_mv_design -verb > $reports/cmv_verbose_ilm_compiled.rpt
report_power_domain [get_power_domains * -hierarchical] > $reports/dc_pd.rpt
report_power_switch [get_power_switches * -hierarchical] > $reports/dc_power_switches.rpt
report_supply_net [get_supply_nets *] > $reports/dc_supply_nets.rpt
report_pst > $reports/dc_pst.rpt
report_level_shifter -domain [get_power_domains * -hierarchical] > $reports/dc_ls.rpt
report_isolation_cell -domain [get_power_domains * -hierarchical]   > $reports/dc_iso.rpt
report_retention_cell -domain [get_power_domains * -hierarchical] > $reports/dc_retn.rpt
report_power -nosplit > $reports/compile.mapped.power.rpt
lint
check_design

######################### Generate Outputs ##################################################
write -f verilog -h -out   $results/${DESIGN_NAME}_ilm_compiled.v
write -f ddc -h -out       $results/${DESIGN_NAME}_ilm_compiled.ddc
write_sdc -nosplit         $results/${DESIGN_NAME}_ilm_compiled.sdc
write_script  -out         $results/${DESIGN_NAME}_ilm_compiled.script
save_upf                   $results/${DESIGN_NAME}_ilm_compiled.upf

write_parasitics -output $results/${DESIGN_NAME}_ilm_compiled.spef
write_sdf $results/${DESIGN_NAME}_ilm_compiled.sdf


if { ${DC_ILM_HIER_DESIGNS} != ""} {
  remove_design -hierarchy ${DC_ILM_HIER_DESIGNS}
}


foreach design $ucells {

read_ddc $results/${design}_compiled.ddc

}

current_design SYN_TOP_WRAPPER


propagate_constraints -power_supply_data 
set_voltage -object_list "VDDSW3 VDDSW2 VDDSW1 VDDSW0 VDD_TOP VDD_WRAP" 0.85
set_voltage -object_list VSS 0.0

source -e -v ./sdc/top.sdc
#source -e -v ./rtl/iso.upf


write -f verilog -hierarchy -output $results/${DESIGN_NAME}_compiled.v
write -f ddc -hier -o $results/${DESIGN_NAME}_compiled.ddc
check_mv_design -verb > $reports/cmv_verbose.rpt
save_upf $results/${DESIGN_NAME}_compiled.upf
write_sdc -nosplit         $results/${DESIGN_NAME}_compiled.sdc
write_script  -out         $results/${DESIGN_NAME}_compiled.script
write_scan_def -output $results/${DESIGN_NAME}_compiled.scan_def
write_test_model -format ctl -output $results/${DESIGN_NAME}_compiled.ctl
write_test_protocol -test_mode Internal_scan -names verilog -output $results/${DESIGN_NAME}_compiled.spf
lint
check_design
check_mv_design
