##########################################################################################
# Tool: IC Compiler II
# Script: place_pins.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_dp_setup.tcl 
source scripts/procs.tcl
START_TIMER BIT_COIN_PIN_PLACE "Starting BIT_COIN ICC2 Pin Placement "


####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_PLACE_PINS}
exec cp -rp ${WORK_DIR_CREATE_POWER} ${WORK_DIR_PLACE_PINS}

puts "RM-info : Opening block ${WORK_DIR_PLACE_PINS}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_PLACE_PINS}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

################################################################################
# Constrain pins
# This file contains all the TCL set_*_pin_constraints
# Note: Feedthroughs are not enabled by default; Enable feedthroughs either through the Tcl pin constraints command or through the pin constraints file
################################################################################
if {[file exists [which $TCL_PIN_CONSTRAINT_FILE]] && !$PLACEMENT_PIN_CONSTRAINT_AWARE} {
   source -echo $TCL_PIN_CONSTRAINT_FILE
}

################################################################################
# This file contains the pin constraints in pin constraint format, not TCL
# see above
# If placement was pin costraints aware, the pin constraints have already been loaded
################################################################################
if {[file exists [which $CUSTOM_PIN_CONSTRAINT_FILE]] && !$PLACEMENT_PIN_CONSTRAINT_AWARE} {
   read_pin_constraints -file_name $CUSTOM_PIN_CONSTRAINT_FILE
}

################################################################################
# If incremental pin constraints exist and incremental mode is enabled, load them
################################################################################
if {$USE_INCREMENTAL_DATA && [file exists $OUTPUTS_DIR/preferred_pin_locations.tcl]} {
   read_pin_constraints -file_name $OUTPUTS_DIR/preferred_pin_locations.tcl
}

if {$DP_FLOW == "hier"} {
   place_pins
}

if {$PLACE_PINS_SELF} {
   place_pins -self
}


################################################################################
# Dump pin constraints for re-use later in an incremental build
################################################################################
write_pin_constraints \
    -file_name $OUTPUTS_DIR/preferred_pin_locations.tcl \
    -physical_pin_constraint {side | offset | offset_range 5} \
    -from_existing_pins

################################################################################
# Verfiy Pin assignment results
# If errors are found they will be stored in an .err file and can be browsed
# with the integrated error browser.
################################################################################
check_pin_placement -pin_spacing true -layers true

if {$DP_FLOW == "hier"} {
   report_feedthrough -reporting_style net_based -file_name $REPORTS_DIR_PLACE_PINS/report_feedthrough.rpt
}

################################################################################
#Generate a pin placement report to assess pin placement
################################################################################
report_pin_placement > $REPORTS_DIR_PLACE_PINS/report_pin_placement.rpt
report_block_pin_constraints > $REPORTS_DIR_PLACE_PINS/report_block_pin_constraints.rpt

save_lib -all
echo [date] > place_pins
STOP_TIMER BIT_COIN_PIN_PLACE "Completing BIT_COIN ICC2 Pin Placement "
   exit 

