##########################################################################################
# Tool: IC Compiler II
# Script: pt_eco.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${PT_ECO_FROM_BLOCK_NAME} -to ${DESIGN_NAME}/${PT_ECO_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${PT_ECO_BLOCK_NAME}
} else {
	copy_block -from ${PT_ECO_FROM_BLOCK_NAME} -to ${PT_ECO_BLOCK_NAME}
	current_block ${PT_ECO_BLOCK_NAME}
}
link_block
set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false
#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8


#set_app_options -name opt.common.allow_physical_feedthrough -value 1


if {$PT_ECO_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $PT_ECO_ACTIVE_SCENARIO_LIST
}

## For common optimization settings that can impact multiple steps across the flow, refer to settings.common.opt.tcl  
#  (sourced in place_opt step)
#	puts "RM-info: Sourcing [which settings.common.opt.tcl]"
#	source -e settings.common.opt.tcl

## For common routing settings, refer to settings.common.routing.tcl
#  (sourced in place_opt step)  
#	puts "RM-info: Sourcing [which settings.common.routing.tcl]"
#	source -e settings.common.routing.tcl

## For route_auto step related settings,refer to common_settings_for_route_auto.tcl 
#  (sourced in route_auto step)
#       puts "RM-info: Sourcing [which common_settings_for_route_auto.tcl]"
#       source -e common_settings_for_route_auto.tcl

## For route_opt step related settings,refer to settings.step.route_opt.tcl
#  (sourced in route_opt step)
#	puts "RM-info: Sourcing [which settings.step.route_opt.tcl]"
#	source -e settings.step.route_opt.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to common_non_persistent_settings.tcl
puts "RM-info: Sourcing [which common_non_persistent_settings.tcl]"
source -e common_non_persistent_settings.tcl

####################################
## Pre-PT ECO customizations
####################################
if {[file exists [which $TCL_USER_PT_ECO_PRE_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_PT_ECO_PRE_SCRIPT]"
        source $TCL_USER_PT_ECO_PRE_SCRIPT
} elseif {$TCL_USER_PT_ECO_PRE_SCRIPT} {
        puts "RM-error: TCL_USER_PT_ECO_PRE_SCRIPT($TCL_USER_PT_ECO_PRE_SCRIPT) is invalid. Please correct it."
}

redirect -tee -file ${REPORTS_DIR}/${PT_ECO_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

####################################
## PT ECO
####################################
## PT ECO change list
if {[file exists [which $PT_ECO_CHANGE_FILE]]} {
        puts "RM-info : Sourcing [which $PT_ECO_CHANGE_FILE]"
        source $PT_ECO_CHANGE_FILE
}

## Legalize ECO cells (MPI mode) 
place_eco_cells -eco_changed_cells -legalize_only -legalize_mode minimum_physical_impact -displacement_threshold $PT_ECO_DISPLACEMENT_THRESHOLD 

redirect -file ${REPORTS_DIR}/${PT_ECO_BLOCK_NAME}.check_legality {check_legality -verbose} 
 
## Turn off timing-driven and crosstalk-driven for ECO routing 
set_app_options -name route.global.timing_driven    -value false -as_user_default  
set_app_options -name route.track.timing_driven     -value false -as_user_default 
set_app_options -name route.detail.timing_driven    -value false -as_user_default  
set_app_options -name route.global.crosstalk_driven -value false -as_user_default  
set_app_options -name route.track.crosstalk_driven  -value false -as_user_default  
 
# ECO routing 
route_eco -utilize_dangling_wires true -reroute modified_nets_first_then_others -open_net_driven true 

####################################
## Post-PT ECO customizations
####################################
if {[file exists [which $TCL_USER_PT_ECO_POST_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_PT_ECO_POST_SCRIPT]"
        source $TCL_USER_PT_ECO_POST_SCRIPT
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
save_lib

####################################
## Report and output
####################################			 
if {$REPORT_QOR} {
	set REPORT_PREFIX $PT_ECO_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}


print_message_info -ids * -summary
echo [date] > pt_eco

exit 

