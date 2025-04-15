##########################################################################################
# Tool: IC Compiler II
# Script: clock_opt_cts.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage cts
set report_dir ${REPORTS_DIR}
set_svf bit_slice_svf -append


open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME} -to ${DESIGN_NAME}/${CLOCK_OPT_CTS_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${CLOCK_OPT_CTS_BLOCK_NAME}
} else {
	copy_block -from ${PLACE_OPT_BLOCK_NAME} -to ${CLOCK_OPT_CTS_BLOCK_NAME}
	current_block ${CLOCK_OPT_CTS_BLOCK_NAME}
}
link_block

set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false

#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8


## The following only applies to hierarchical designs
## Swap to abstracts specified for clock_opt_cts
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_CLOCK_OPT_CTS abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_CLOCK_OPT_CTS
      report_abstracts
   }
}

if {$CLOCK_OPT_CTS_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $CLOCK_OPT_CTS_ACTIVE_SCENARIO_LIST
}

## For common optimization settings that can impact multiple steps across the flow, refer to settings.common.opt.tcl  
#  (sourced in place_opt step)
#	puts "RM-info: Sourcing [which settings.common.opt.tcl]"
#	source -e settings.common.opt.tcl

## For common routing settings, refer to settings.common.routing.tcl
#  (sourced in place_opt step)  
#	puts "RM-info: Sourcing [which settings.common.routing.tcl]"
#	source -e settings.common.routing.tcl

## For common CTS settings, refer to settings.common.cts.tcl
#  If either PLACE_OPT_OPTIMIZE_ICGS or PLACE_OPT_TRIAL_CTS is enabled, the script will be sourced in place_opt.tcl instead. 
if {!$PLACE_OPT_OPTIMIZE_ICGS && !$PLACE_OPT_TRIAL_CTS} {
puts "RM-info: Sourcing [which settings.common.cts.tcl]"
source -e settings.common.cts.tcl
}

## For clock_opt_cts step specific settings, refer to settings.step.clock_opt_cts.tcl
puts "RM-info: Sourcing [which settings.step.clock_opt_cts.tcl]"
source -e settings.step.clock_opt_cts.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## Pre-CTS customizations	
####################################
if {[file exists [which $TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT]]} {
	puts "RM-info: Sourcing [which $TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT]"
	source $TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT
} elseif {$TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT != ""} {
  puts "RM-error: TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT($TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT) speciis invalid. Please correct it."
}
## Sample commands that can be included in $TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT :
#	    set_clock_uncertainty -setup 0.05 [all_clocks] -scenarios [all_scenarios]
#	    set_clock_uncertainty -hold  0.01 [all_clocks] -scenarios [all_scenarios]

## Enabled if used by top level closure flow
if {$DESIGN_STYLE == "hier"} { 
   if { $PHYSICAL_HIERARCHY_LEVEL == "intermediate" || $PHYSICAL_HIERARCHY_LEVEL == "top"} {
	## Promote clock tree exceptions from blocks to top
	if {$USE_ABSTRACTS_FOR_BLOCKS != ""} {
	    foreach block $USE_ABSTRACTS_FOR_BLOCKS {
	      foreach_in_collection blk_inst [get_cells -filter "ref_name == $block"] {
                puts "RM-info : promoting CTS constraints from cell [get_object_name $blk_inst]"
	        promote_constraints -auto_clock connected -cts $blk_inst
	      }
	    }
	}
   }
}

####################################
## Pre-CTS checks	
####################################
## Check for netlist, constraints, or setup issues that could hurt CTS results
redirect -file ${REPORTS_DIR}/${CLOCK_OPT_CTS_BLOCK_NAME}.pre_cts.check_clock_tree {check_clock_tree}

## Report CTS constraints and settings that have been applied
redirect -file ${REPORTS_DIR}/${CLOCK_OPT_CTS_BLOCK_NAME}.pre_cts.report_clock_settings {report_clock_settings}

####################################
## Core command	
####################################
if {$CLOCK_OPT_CTS_USER_INSTANCE_NAME_PREFIX != ""} {
	set_app_options -name cts.common.user_instance_name_prefix -value $CLOCK_OPT_CTS_USER_INSTANCE_NAME_PREFIX
	if {[get_app_option_value -name clock_opt.flow.enable_ccd]} {
		# If CCD is enabled, set both opt and cts user prefix as it can work on both data and clock paths
		set_app_options -name opt.common.user_instance_name_prefix -value ${CLOCK_OPT_CTS_USER_INSTANCE_NAME_PREFIX}_opt
	}
}

redirect -tee -file ${REPORTS_DIR}/${CLOCK_OPT_CTS_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}


## Include flops as part of the cts lib cell purpose list :
#  CCD can size flops to improve timing. Pls make sure flops are enabled for CTS to allow sizing during CCD.
#  Refer to settings.common.cts.tcl and look for set_lib_cell_purpose command.

puts "RM-info: Running clock_opt -from build_clock -to route_clock command"
clock_opt -from build_clock -to route_clock

####################################
## Enable AOCV (recommended after CTS is completed)	
####################################
if {$OCVM_CORNER_TABLE_MAPPING_LIST != ""} {
## Enable the AOCV analysis
set_app_options -name time.aocvm_enable_analysis -value true ;# default false

## Enable the AOCV distance analysis
#  AOCV analysis will now consider path distance when calculating AOCVM derate
#	set_app_options -name time.ocvm_enable_distance_analysis -value true ;# default false

## Set the configuration for the AOCV analysis
#	set_app_options -name time.aocvm_analysis_mode -value separate_launch_capture_depth ;# default separate_launch_capture_depth
}

####################################
## Post-CTS customizations	
####################################
if {[file exists [which $TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT]"
        source $TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT
} elseif {$TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT != ""} {
        puts "RM-error: TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT($TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT) is invalid. Please correct it."
}

####################################
## Propagate all clocks 
####################################
## This should be used only when additional modes/scenarios are activated after CTS is done.
#  Get inactive scenarios, activate them, mark them as propagated, and then deactivate them.
#	if {[sizeof_collection [get_scenarios -filter active==false -quiet]] > 0} {
#	        set active_scenarios [get_scenarios -filter active]
#	        set inactive_scenarios [get_scenarios -filter active==false]
#
#	        set_scenario_status -active false [get_scenarios $active_scenarios]
#	        set_scenario_status -active true [get_scenarios $inactive_scenarios]
#
#	        synthesize_clock_trees -propagate_only ;# only works on active scenarios
#	        set_scenario_status -active true [get_scenarios $active_scenarios]
#	        set_scenario_status -active false [get_scenarios $inactive_scenarios]
#	}

if {$TCL_USER_CONNECT_PG_NET_SCRIPT != ""} {
	if {[file exists [which $TCL_USER_CONNECT_PG_NET_SCRIPT]]} {
		puts "RM-info: Sourcing [which $TCL_USER_CONNECT_PG_NET_SCRIPT]"
  		source $TCL_USER_CONNECT_PG_NET_SCRIPT
	} else {
		puts "RM-error: TCL_USER_CONNECT_PG_NET_SCRIPT($TCL_USER_CONNECT_PG_NET_SCRIPT) is invalid. Please correct it."
	}
} else {
	connect_pg_net
	# For non-MV designs with more than one PG, you should use connect_pg_net in manual mode.
}

save_block

## Enabled for hierarchical designs; for bottom and intermediate levels of physical hierarchy
if {$DESIGN_STYLE == "hier"} {
   if { $PHYSICAL_HIERARCHY_LEVEL == "bottom" } {
      create_abstract -read_only
      create_frame -block_all true
   } elseif { $PHYSICAL_HIERARCHY_LEVEL == "intermediate"} {
      ## Set the following application option for creating abstract for intermediate level, when bottom-level is an abstract
      set_app_options -name abstract.allow_all_level_abstract -value true
      create_abstract -read_only
      create_frame -block_all true
   }
}


save_lib

####################################
## Report and output
####################################			 
if {$REPORT_QOR} {
        set REPORT_PREFIX $CLOCK_OPT_CTS_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}


print_message_info -ids * -summary
echo [date] > clock_opt_cts
GENERATE_REPORTS_SUMMARY

exit 

