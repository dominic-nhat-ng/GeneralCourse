##########################################################################################
# Tool: IC Compiler II
# Script: clock_opt_opto.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage clock_opt_opto
set report_dir ${REPORTS_DIR}
set_svf ${DESIGN_NAME}_svf -append
START_TIMER bc_timer "Starting Bit Coin ICC2 CTS OPT"

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${CLOCK_OPT_CTS_BLOCK_NAME} -to ${DESIGN_NAME}/${CLOCK_OPT_OPTO_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${CLOCK_OPT_OPTO_BLOCK_NAME}
} else {
	copy_block -from ${CLOCK_OPT_CTS_BLOCK_NAME} -to ${CLOCK_OPT_OPTO_BLOCK_NAME}
	current_block ${CLOCK_OPT_OPTO_BLOCK_NAME}
}
link_block

set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false
set_app_options -name clock_opt.flow.enable_clock_power_recovery -value power

#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8


## The following only applies to hierarchical designs
## Swap to abstracts specified for clock_opt_opto
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_CLOCK_OPT_OPTO abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_CLOCK_OPT_OPTO
      report_abstracts
   }
}

if {$CLOCK_OPT_OPTO_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $CLOCK_OPT_OPTO_ACTIVE_SCENARIO_LIST
}

## For common optimization settings that can impact multiple steps across the flow, refer to settings.common.opt.tcl  
#  (sourced in place_opt step)
#	puts "RM-info: Sourcing [which settings.common.opt.tcl]"
#	source -e settings.common.opt.tcl

## For common routing settings, refer to settings.common.routing.tcl
#  (sourced in place_opt step)  
#	puts "RM-info: Sourcing [which settings.common.routing.tcl]"
#	source -e settings.common.routing.tcl

## For CTS related settings, refer to settings.common.cts.tcl 
#  (sourced in place_opt or clock_opt_cts step)
#       puts "RM-info: Sourcing [which settings.common.cts.tcl]"
#	source -e ./rm_icc2_flat_scripts/settings.common.cts.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## Pre-opto customizations	
####################################
if {[file exists [which $TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT]]} {
	puts "RM-info: Sourcing [which $TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT]"
	source $TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT
} elseif {$TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT != ""} {
  puts "RM-error: TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT($TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT) is invalid. Please correct it."
}

####################################
## Post-CTS optimization
####################################
if {$CLOCK_OPT_OPTO_USER_INSTANCE_NAME_PREFIX != ""} {
	set_app_options -name opt.common.user_instance_name_prefix -value $CLOCK_OPT_OPTO_USER_INSTANCE_NAME_PREFIX
	if {[get_app_option_value -name clock_opt.flow.enable_ccd]} {
		# If CCD is enabled, set both opt and cts user prefix as CCD can work on both clock and data paths
		set_app_options -name cts.common.user_instance_name_prefix -value ${CLOCK_OPT_OPTO_USER_INSTANCE_NAME_PREFIX}_cts
	}
}

redirect -tee -file ${REPORTS_DIR}/${CLOCK_OPT_OPTO_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

clock_opt -from final_opto

####################################
## Post-opto customizations	
####################################
if {[file exists [which $TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT]"
        source $TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT
} elseif {$TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT != ""} {
        puts "RM-error: TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT($TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT) is invalid. Please correct it."
}

####################################
## Clock routing	
####################################
route_group -all_clock_nets

####################################
## Post-route clock tree optimization for non-CCD flow	
####################################
if {$CLOCK_OPT_OPTO_CTO && ![get_app_option_value -name clock_opt.flow.enable_ccd]} {
	if {$CLOCK_OPT_OPTO_CTO_USER_INSTANCE_NAME_PREFIX != ""} {
		set_app_options -name cts.common.user_instance_name_prefix -value ${CLOCK_OPT_OPTO_CTO_USER_INSTANCE_NAME_PREFIX}
	}
	if {$USE_RM_BLOCK_NAME_AS_LABEL} {
		save_block -as ${DESIGN_NAME}/${CLOCK_OPT_OPTO_BLOCK_NAME}_pre_cto
	} else {
		save_block -as ${CLOCK_OPT_OPTO_BLOCK_NAME}_pre_cto
	}
	synthesize_clock_trees -postroute -routed_clock_stage detail
}

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
	set REPORT_PREFIX $CLOCK_OPT_OPTO_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}
GENERATE_REPORTS_SUMMARY

print_message_info -ids * -summary
echo [date] > clock_opt_opto
STOP_TIMER bc_timer "Completing Bit Coin ICC2 CTS OPT"

exit 

