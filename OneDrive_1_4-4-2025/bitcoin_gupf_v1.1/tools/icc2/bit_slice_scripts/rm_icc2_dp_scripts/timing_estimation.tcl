##########################################################################################
# Tool: IC Compiler II
# Script: timing_estimation.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

################################################################################
# Open design
################################################################################
exec rm -rf ${WORK_DIR_TIMING_ESTIMATION}
exec cp -rp ${WORK_DIR_PRE_TIMING} ${WORK_DIR_TIMING_ESTIMATION}

puts "RM-info : Opening block ${WORK_DIR_TIMING_ESTIMATION}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_TIMING_ESTIMATION}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

if {[file exists $TCL_TIMING_ESTIMATION_SETUP_FILE]} {
  puts "RM-info : Sourcing  TCL_TIMING_ESTIMATION_SETUP_FILE ($TCL_TIMING_ESTIMATION_SETUP_FILE)"
  source -echo $TCL_TIMING_ESTIMATION_SETUP_FILE
}

################################################################################
# Run timing estimation on the entire top design to ensure quality ################################################################################
if {$DISTRIBUTED} {
  estimate_timing -host_options block_script
} else {
  estimate_timing 
}

report_timing -mode [all_modes] -corner estimated_corner > $REPORTS_DIR_TIMING_ESTIMATION/${DESIGN_NAME}.post_estimated_timing.rpt
report_qor -corner estimated_corner > $REPORTS_DIR_TIMING_ESTIMATION/${DESIGN_NAME}.post_estimated_timing.qor
report_qor -summary > $REPORTS_DIR_TIMING_ESTIMATION/${DESIGN_NAME}.post_estimated_timing.qor.sum

save_lib -all
echo [date] > timing_estimation

   exit 
