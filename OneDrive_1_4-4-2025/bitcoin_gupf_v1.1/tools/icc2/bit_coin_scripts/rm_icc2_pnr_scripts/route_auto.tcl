##########################################################################################
# Tool: IC Compiler II
# Script: route_auto.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage route_auto
set report_dir ${REPORTS_DIR}
set_svf ${DESIGN_NAME}_svf -append
START_TIMER bc_timer "Starting Bit Coin ICC2 Route"

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${CLOCK_OPT_OPTO_BLOCK_NAME} -to ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}
} else {
	copy_block -from ${CLOCK_OPT_OPTO_BLOCK_NAME} -to ${ROUTE_AUTO_BLOCK_NAME}
	current_block ${ROUTE_AUTO_BLOCK_NAME}
}
link_block


set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false
#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8


## The following only applies to hierarchical designs
## Swap to abstracts specified for route_auto
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_ROUTE_AUTO abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_ROUTE_AUTO
      report_abstracts
   }
}

if {$ROUTE_AUTO_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $ROUTE_AUTO_ACTIVE_SCENARIO_LIST
}

## For common optimization settings that can impact multiple steps across the flow, refer to settings.common.opt.tcl  
#  (sourced in place_opt step)
#	puts "RM-info: Sourcing [which settings.common.opt.tcl]"
#	source -e settings.common.opt.tcl

## For common routing settings, refer to settings.common.routing.tcl
#  (sourced in place_opt step)  
#	puts "RM-info: Sourcing [which settings.common.routing.tcl]"
#	source -e settings.common.routing.tcl

## For route_auto step related settings, refer to settings.step.route_auto.tcl
puts "RM-info: Sourcing [which settings.step.route_auto.tcl]"
source -e settings.step.route_auto.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## Pre-route_auto customizations	
####################################
if {[file exists [which $TCL_USER_ROUTE_AUTO_PRE_SCRIPT]]} {
	puts "RM-info: Sourcing [which $TCL_USER_ROUTE_AUTO_PRE_SCRIPT]"
	source $TCL_USER_ROUTE_AUTO_PRE_SCRIPT
} elseif {$TCL_USER_ROUTE_AUTO_PRE_SCRIPT != ""} {
  puts "RM-error: TCL_USER_ROUTE_AUTO_PRE_SCRIPT($TCL_USER_ROUTE_AUTO_PRE_SCRIPT) is invalid. Please correct it."
}

####################################
## Routing	
####################################
## Antenna fix : source antenna rule file
if {$ROUTE_AUTO_ANTENNA_FIXING} {
	if {[file exists [which $TCL_ANTENNA_RULE_FILE]]} {
		puts "RM-info : Sourcing [which $TCL_ANTENNA_RULE_FILE]"
		source $TCL_ANTENNA_RULE_FILE
	} elseif {$TCL_ANTENNA_RULE_FILE != ""} {
		puts "RM-error : ROUTE_AUTO_ANTENNA_FIXING is true but TCL_ANTENNA_RULE_FILE($TCL_ANTENNA_RULE_FILE) is invalid. Please correct it."
	}
}

## Create shields before signal routing
if {$ROUTE_AUTO_CREATE_SHIELDS == "before_route_auto"} {
	create_shields ;# without specifying -nets option, all nets with shielding rules will be shielded 
	set_extraction_options -virtual_shield_extraction false
}

redirect -tee -file ${REPORTS_DIR}/${ROUTE_AUTO_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

set nets_power       [get_nets -phys -quiet -filter "net_type == power" ]
route_group -nets $nets_power -utilize_dangling_wires false -max_detail_route_iterations 2

route_auto

## Create shields after signal routing; recommended if DRC convergence is a concern
if {$ROUTE_AUTO_CREATE_SHIELDS == "after_route_auto"} {
	create_shields ;# without specifying -nets option, all nets with shielding rules will be shielded 
	set_extraction_options -virtual_shield_extraction false
}

## Antenna fix : check antenna and DRC volations
if {$ROUTE_AUTO_ANTENNA_FIXING && [file exists [which $TCL_ANTENNA_RULE_FILE]]} {
	redirect -tee -file ${REPORTS_DIR}/${ROUTE_AUTO_BLOCK_NAME}.check_route_after_antenna_fixing.rpt {\
        check_route -antenna true \
	}
}


####################################
## Post-route_auto customizations	
####################################
if {[file exists [which $TCL_USER_ROUTE_AUTO_POST_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_ROUTE_AUTO_POST_SCRIPT]"
        source $TCL_USER_ROUTE_AUTO_POST_SCRIPT
} elseif {$TCL_USER_ROUTE_AUTO_POST_SCRIPT != ""} {
        puts "RM-error: TCL_USER_ROUTE_AUTO_POST_SCRIPT($TCL_USER_ROUTE_AUTO_POST_SCRIPT) is invalid. Please correct it."
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
      derive_hier_antenna_property -design ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}
   } elseif { $PHYSICAL_HIERARCHY_LEVEL == "intermediate"} {
      ## Set the following application option for creating abstract for intermediate level, when bottom-level is an abstract
      set_app_options -name abstract.allow_all_level_abstract -value true
      create_abstract -read_only
      create_frame -block_all true
      derive_hier_antenna_property -design ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME}
   }
}


save_lib

####################################
## Report and output
####################################			 
if {$REPORT_QOR} {
	set REPORT_PREFIX $ROUTE_AUTO_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}

GENERATE_REPORTS_SUMMARY
print_message_info -ids * -summary
echo [date] > route_auto
STOP_TIMER bc_timer "Completing Bit Coin ICC2 Route"

exit 

