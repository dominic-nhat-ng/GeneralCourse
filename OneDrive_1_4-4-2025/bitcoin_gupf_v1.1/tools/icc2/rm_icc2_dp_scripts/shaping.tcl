##########################################################################################
# Tool: IC Compiler II
# Script: shaping.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

source scripts/procs.tcl
START_TIMER BIT_COIN_SHAPING "Starting BIT_COIN ICC2 Actual Shaping "


####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_SHAPING}
exec cp -rp ${WORK_DIR_PLACE_IO} ${WORK_DIR_SHAPING}

puts "RM-info : Opening block ${WORK_DIR_SHAPING}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_SHAPING}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

if [file exists [which $TCL_SHAPING_PNS_STRATEGY_FILE]] {
   puts "RM-info : Sourcing TCL_SHAPING_PNS_STRATEGY_FILE ($TCL_SHAPING_PNS_STRATEGY_FILE)"
   source -echo $TCL_SHAPING_PNS_STRATEGY_FILE
}

if [file exists [which $TCL_MANUAL_SHAPING_FILE]] {
   puts "RM-info : Skipping shaping, loading floorplan information from TCL_MANUAL_SHAPING_FILE ($TCL_MANUAL_SHAPING_FILE) "
   source -echo $TCL_MANUAL_SHAPING_FILE
} else {
   if [file exists [which $TCL_SHAPING_CONSTRAINTS_FILE]] {
      puts "RM-info : sourcing TCL_SHAPING_CONSTRAINTS_FILE ($TCL_SHAPING_CONSTRAINTS_FILE)"
      source -echo $TCL_SHAPING_CONSTRAINTS_FILE
   }

   if [file exists [which $SHAPING_CONSTRAINTS_FILE]] {
      puts "RM-info : Adding -constraint_file $SHAPING_CONSTRAINTS_FILE to SHAPING_CMD_OPTIONS"
      lappend SHAPING_CMD_OPTIONS {*}"-constraint_file $SHAPING_CONSTRAINTS_FILE"
   }
   # Shaping will consider the layer constraints during shaping

   ###############################################
   # Shape the blocks and place top level macros
   ###############################################
   report_shaping_option > $REPORTS_DIR_SHAPING/report_shaping_option.rpt

   puts "RM-info : Running block shaping (shape_blocks $SHAPING_CMD_OPTIONS)"
set_app_options -name plan.shaping.enable_rigid_block_percentage_check -value false
#   eval shape_blocks $SHAPING_CMD_OPTIONS
## Doing Below Commands because shpae_blocks does not give desired results and fails with incorrect calculations and is very sensitive to change in inputs
##WA for shape_blocks
set_working_design -push [get_cells bit_secure_1]
initialize_floorplan -side_length { 1635 465 } -core_offset 2
set_block_pin_constraints -exclude_sides {1 3 4}
create_pin_blockage -boundary {{0.0240 0.0000} {1631.8700 8.2160}} -name bottom_pin_block
create_pin_blockage -boundary {{1623.2320 0.0000} {1639.6160 467.7280}} -name right_pin_block
create_pin_blockage -boundary {{-15.5040 2.8020} {3.0640 468.8160}} -name left_pin_block
source -e -v scripts/bt_va.tcl
commit_upf
connect_pg_net
place_pins -ports [get_ports *]
set_working_design -push [get_cells slice_1]
initialize_floorplan -side_length {200 68}
source ./scripts/bs_va.tcl
set_working_design -pop
source scripts/bs_cell_location.tcl
set_working_design -pop
source -e -v scripts/bt_location.tcl
source -e -v scripts/bc_va.tcl
place_pins -ports [get_ports * -all]
report_block_shaping -core_area_violations -overlap -flyline_crossing > $REPORTS_DIR_SHAPING/report_block_shape.rpt
}

save_lib -all

report_voltage_areas -hierarchical > $REPORTS_DIR_SHAPING/voltage_areas.rpt
write_floorplan -output $REPORTS_DIR_SHAPING/FP
report_design > $REPORTS_DIR_SHAPING/report_design.rpt
check_mv_design > $REPORTS_DIR_SHAPING/check_mv_design.rpt


STOP_TIMER BIT_COIN_SHAPING "Completing BIT_COIN ICC2 Actual Shaping "


echo [date] > shaping
  exit 
