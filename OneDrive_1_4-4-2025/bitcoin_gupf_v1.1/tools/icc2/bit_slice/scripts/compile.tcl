#source -e -v scripts/library.tcl



source rm_setup/dc_setup.tcl
source scripts/procs.tcl

define_design_lib -path ./work work

read_ddc [glob results/*.ddc]
link

set design_name [get_object_name [current_design]]

set compile_automatic_clock_phase_inference none
set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_allow_ls_on_leaf_pin_boundary true
set _mv_allow_iss_update_to_ss_function true




remove_attribute [get_lib_cells */*ISO*] dont_use
remove_attribute [get_lib_cells */*ISO*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_use
remove_attribute [get_lib_cells */*LS*] dont_touch
remove_attribute [get_lib_cells */*LS*] dont_use
remove_attribute [get_lib_cells */*AO*] dont_touch
remove_attribute [get_lib_cells */*AO*] dont_use


set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE



check_mv_design

set results ./results
compile_ultra -no_autoungroup
change_names -rule verilog -hier
write -f verilog -hier -o $results/${design_name}.vg
write -f ddc -hier -o $results/${design_name}.ddc
save_upf $results/${design_name}.upf
write_sdc $results/${design_name}.sdc
write_script -output $results/${design_name}.script
write_parasitics -output $results/${design_name}_compiled.spef
write_sdf $results/${design_name}_compiled.sdf
create_block_abstraction 
write -f ddc -h -o $results/${design_name}_bam.ddc

check_mv_design -verbose > reports/${design_name}.cmv.rpt
report_isolation_cell -domain [get_power_domains -hier] > reports/${design_name}.iso.rpt
