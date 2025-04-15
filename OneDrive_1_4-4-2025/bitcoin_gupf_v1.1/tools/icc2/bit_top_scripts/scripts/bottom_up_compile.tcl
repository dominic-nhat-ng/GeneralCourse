set  enable_page_mode false
set sh_enable_page_mode false
define_design_lib -path ./work work

set mw_design_library top_mw_design_lib
open_mw_lib $mw_design_library


set allow_newer_db_files true
suppress_message {OPT-200 TIM-164 TIM-108 TIM-107 OPT-1209}
set upf_charz_allow_port_punch true


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


foreach design $ucells {

echo "Processing Design $design"

read_ddc $results/${design}_unmapped.ddc

current_design $design
link

remove_attribute [get_lib_cells */*ISO*] dont_use
remove_attribute [get_lib_cells */*ISO*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_use
remove_attribute [get_lib_cells */*LS*] dont_touch
remove_attribute [get_lib_cells */*LS*] dont_use
remove_attribute [get_lib_cells */*AO*] dont_touch
remove_attribute [get_lib_cells */*AO*] dont_use


set_tlu_plus_files  -max_tluplus  $TLUPLUS_MAX_FILE   -tech2itf_map    $MAP_FILE


set_ignored_layers -max_routing_layer M6

report_pst
report_supply_net
report_supply_port

#set_register_merging [all_registers ] false

compile_ultra   -scan -gate_clock -no_auto -no_bound -no_seq
check_mv_design -verb
report_pst

echo "Completed Compiling Design $design"

source -e -v scripts/test_config.tcl

create_test_protocol
dft_drc
report_pst
report_scan_configuration
report_dft_insertion_configuration
insert_dft

set_port_attributes -ports [get_ports test* -filter {@port_direction == in}] -driver_supply VDD_TOP_SS
set_port_attributes -ports [get_ports test* -filter {@port_direction == out}] -receiver_supply VDD_TOP_SS

compile_ultra -incremental -scan -no_auto -no_bound -no_seq
uniquify -force
check_mv_design
change_names -rules verilog -hierarchy
write_scan_def -output $results/${design}_compiled.scan_def
write_test_model -format ctl -output $results/${design}_compiled.ctl
write_test_protocol -test_mode Internal_scan -names verilog -output $results/${design}_compiled.spf

######################### Generate Outputs ##################################################
set write_sdc_output_lumped_net_capacitance false
set write_sdc_output_net_resistance false
echo "Completed Test Insertion and Compiling Design $design"
lint

write -f verilog -h -out   $results/${design}_compiled.v
write -f ddc -h -out       $results/${design}_compiled.ddc
write_sdc -nosplit         $results/${design}_compiled.sdc
write_script  -out         $results/${design}_compiled.script
save_upf                   $results/${design}_compiled.upf
write_physical_constraints -output $results/${design}_compiled.physical_constraints.tcl
write_parasitics -output $results/${design}_compiled.spef
write_sdf $results/${design}_compiled.sdf

#create_block_abstraction 
#write -f ddc -h -o $results/${design}_bam.ddc


############## Create ILMS ##########################
set ilm_enable_power_calculation true
create_ilm -compact none -traverse_disabled_arcs
#create_ilm

write -f ddc -h -o $results/${design}_ilm.ddc

echo "Completed Processing Design $design"


}
exit
