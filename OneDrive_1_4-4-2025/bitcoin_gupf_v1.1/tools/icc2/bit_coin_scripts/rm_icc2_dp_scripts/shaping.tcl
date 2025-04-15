##########################################################################################
# Tool: IC Compiler II
# Script: shaping.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

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

### "-channels false " Added by Avinash 
   eval shape_blocks $SHAPING_CMD_OPTIONS -channels false
   #eval shape_blocks $SHAPING_CMD_OPTIONS 
# End Added by Avinash

   report_block_shaping -core_area_violations -overlap -flyline_crossing > $REPORTS_DIR_SHAPING/report_block_shape.rpt
}

save_lib -all

echo [date] > shaping
 
   exit 
