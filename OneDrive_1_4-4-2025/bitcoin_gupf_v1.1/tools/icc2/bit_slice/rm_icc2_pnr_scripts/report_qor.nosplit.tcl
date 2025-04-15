puts "RM-info: Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: report_qor.nosplit.tcl
# Purpose: report_qor.tcl with -nosplit options added to commands that could use it
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################
if {$REPORT_PREFIX != ""} {


## Zero interconnect delay reporting is enabled for init_design stage
if {[regexp $REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME]} {
set_app_options -name time.delay_calculation_style -value zero_interconnect
puts "RM-info: time.delay_calculation_style is set to zero_interconnect ...\n"
}

####################################
## Timing Constraints 
####################################
puts "RM-info: Reporting timing constraints ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_mode {report_mode -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_scenarios {report_scenarios -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_pvt {report_pvt -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_constraint {report_constraint -all_violators -max_transition -max_capacitance -scenarios [all_scenarios] -nosplit}

####################################
## Timing and QoR 
####################################
puts "RM-info: Reporting timing and QoR ...\n"
## QoR
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -scenarios [all_scenarios] -nosplit}
redirect -tee -append -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_qor {report_qor -summary -nosplit}

## Timing
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.max {report_timing -delay max -scenarios [all_scenarios] -input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -nosplit}

# Min timing report is generated in postcts
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_CTS_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME|$ROUTE_AUTO_BLOCK_NAME|$ROUTE_OPT_BLOCK_NAME|$CHIP_FINISH_BLOCK_NAME|$SIGNOFF_DRC_BLOCK_NAME"]} {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_timing.min {report_timing -delay min -scenarios [all_scenarios] -input_pins -nets -transition_time -capacitance -attributes -physical -derate -report_by group -nosplit}
}

## Debugging
puts "RM-info: Analyzing design violations ...\n"
# analyze_design_violations for setup
if {[regexp $REPORT_PREFIX "$PLACE_OPT_BLOCK_NAME|$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
analyze_design_violations -type setup -stage preroute -output ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations
}
# analyze_design_violations for hold
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
analyze_design_violations -type hold -stage preroute -output ${REPORTS_DIR}/${REPORT_PREFIX}.analyze_design_violations
}

####################################
## UPF and power 
####################################
# redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_mv_design {check_mv_design} ;# included in the check_design commands
if {![regexp $REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME]} {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_threshold_voltage_group {report_threshold_voltage_group -nosplit}
}
if {$REPORT_QOR_REPORT_POWER} {
puts "RM-info: Reporting power ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_power {report_power -verbose -scenarios [all_scenarios] -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.power {report_clock_qor -type power -nosplit}
}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_mv_path {report_mv_path -all_not_associated }

####################################
## Clock trees 
####################################
if {[regexp $REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME]} {
puts "RM-info: Reporting clock tree information ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.cell_area {report_clock_qor -type area -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.structure {report_clock_qor -type structure -nosplit}
} else {
puts "RM-info: Reporting clock tree information and QoR ...\n"
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.summary {report_clock_qor -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.latency {report_clock_qor -type latency -show_paths -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.cell_area {report_clock_qor -type area -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.structure {report_clock_qor -type structure -nosplit}
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_clock_qor.drc_violators {report_clock_qor -type drc_violators -all -nosplit}
}

####################################
## Routing  
####################################
## check_routes is performed for postroute
if {[regexp $REPORT_PREFIX "$ROUTE_AUTO_BLOCK_NAME|$ROUTE_OPT_BLOCK_NAME|$CHIP_FINISH_BLOCK_NAME|$SIGNOFF_DRC_BLOCK_NAME"]} {
puts "RM-info: Verifying and checking routing ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_routes {check_routes}
}

####################################
## report_design  
####################################
puts "RM-info: Reporting design information ...\n"
if {[regexp $REPORT_PREFIX "$ROUTE_AUTO_BLOCK_NAME|$ROUTE_OPT_BLOCK_NAME|$CHIP_FINISH_BLOCK_NAME|$SIGNOFF_DRC_BLOCK_NAME|$PT_ECO_BLOCK_NAME"]} {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_design {report_design -library -netlist -floorplan -routing -nosplit}
} else {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_design {report_design -library -netlist -floorplan -nosplit}
}
redirect -tee -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_utilization {report_utilization}

####################################
## check_design  
####################################
puts "RM-info: Checking design issues ...\n"

## Run the pre-defined mega-check pre_placement_stage which includes
#  atomic checks such as mv_design, design_mismatch, rp_constraints, timing, and scan chain.
if {[regexp $REPORT_PREFIX "$INIT_DESIGN_BLOCK_NAME"]} {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_placement_stage {check_design -ems_database check_design.pre_placement_stage.ems -checks pre_placement_stage}
}

## Run the pre-defined mega-check pre_clock_tree_stage which includes
#  atomic checks such as mv_design, design_mismatch, timing, scan chain, legality, design_extraction, and clock tree.
if {[regexp $REPORT_PREFIX "$PLACE_OPT_BLOCK_NAME"]} {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_clock_tree_stage {check_design -ems_database check_design.pre_clock_tree_stage.ems -checks pre_clock_tree_stage}
}

## Run the pre-defined mega-check pre_route_stage which includes
#  atomic checks such as mv_design, design_mismatch, timing, scan chain, design_extraction, and routeability. 
if {[regexp $REPORT_PREFIX "$CLOCK_OPT_OPTO_BLOCK_NAME"]} {
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.check_design.pre_route_stage {check_design -ems_database check_design.pre_route_stage.ems -checks pre_route_stage}
}

####################################
## MISC  
####################################
puts "RM-info: Reporting non-default app option settings ...\n"
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_app_options.end {report_app_options -non_default}

} else {

puts "RM-error: REPORTS_DIR is not specified. Exiting."

}

puts "RM-info: Completed script [info script]\n"

