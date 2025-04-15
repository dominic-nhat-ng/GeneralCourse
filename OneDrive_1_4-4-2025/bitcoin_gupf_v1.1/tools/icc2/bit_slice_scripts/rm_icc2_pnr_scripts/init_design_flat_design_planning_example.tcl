##########################################################################################
# Tool: IC Compiler II
# Script: init_design_flat_design_planning_example.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

set REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME

##################################################
# IO placement 
##################################################
if {[file exists [which $TCL_PAD_CONSTRAINTS_FILE]]} {
	puts "RM-info : Loading TCL_PAD_CONSTRAINTS_FILE file ($TCL_PAD_CONSTRAINTS_FILE)"
	source -e $TCL_PAD_CONSTRAINTS_FILE
	
	puts "RM-info : running place_io"
	place_io
	set_attribute -objects [get_cells -quiet -filter is_io==true -hier] -name status -value fixed
	set_attribute -objects [get_cells -quiet -filter pad_cell==true -hier] -name status -value fixed
}

##################################################
# Macro placement 
##################################################
redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_macro_constraints.rpt {report_macro_constraints}

## To place macro only, set the following :
#	set_app_options -name plan.macro.macro_place_only -value true ;# default false
create_placement -floorplan

redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_placement.rpt {report_placement -physical_hierarchy_violations all -wirelength all -hard_macro_overlap -verbose high}

