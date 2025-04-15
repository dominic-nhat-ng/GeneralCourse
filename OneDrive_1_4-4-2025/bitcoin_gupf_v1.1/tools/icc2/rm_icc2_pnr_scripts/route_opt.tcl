##########################################################################################
# Tool: IC Compiler II
# Script: route_opt.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${ROUTE_AUTO_BLOCK_NAME} -to ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}
} else {
	copy_block -from ${ROUTE_AUTO_BLOCK_NAME} -to ${ROUTE_OPT_BLOCK_NAME}
	current_block ${ROUTE_OPT_BLOCK_NAME}
}
link_block

## The following only applies to hierarchical designs
## Swap to abstracts specified for route_opt
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_ROUTE_OPT abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_ROUTE_OPT
      report_abstracts
   }
}

if {$ROUTE_OPT_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $ROUTE_OPT_ACTIVE_SCENARIO_LIST
}

## For common optimization settings that can impact multiple steps across the flow, refer to settings.common.opt.tcl  
#  (sourced in place_opt step)
#	puts "RM-info: Sourcing [which settings.common.opt.tcl]"
#	source -e settings.common.opt.tcl

## For common routing settings, refer to settings.common.routing.tcl
#  (sourced in place_opt step)  
#	puts "RM-info: Sourcing [which settings.common.routing.tcl]"
#	source -e settings.common.routing.tcl

## For route_auto step related settings,refer to settings.step.route_auto.tcl 
#  (sourced in route_auto step)
#       puts "RM-info: Sourcing [which settings.step.route_auto.tcl]"
#       source -e settings.step.route_auto.tcl

## For route_opt step related settings,refer to settings.step.route_opt.tcl
puts "RM-info: Sourcing [which settings.step.route_opt.tcl]"
source -e settings.step.route_opt.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## Pre-route_opt customizations
####################################
if {[file exists [which $TCL_USER_ROUTE_OPT_PRE_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_ROUTE_OPT_PRE_SCRIPT]"
        source $TCL_USER_ROUTE_OPT_PRE_SCRIPT
} elseif {$TCL_USER_ROUTE_OPT_PRE_SCRIPT != ""} {
	puts "RM-error : TCL_USER_ROUTE_OPT_PRE_SCRIPT($TCL_USER_ROUTE_OPT_PRE_SCRIPT) is invalid. Please correct it."
}

####################################
## Post route optimization	
####################################
compute_clock_latency

if {$ROUTE_OPT_USER_INSTANCE_NAME_PREFIX != ""} {
	set_app_options -name opt.common.user_instance_name_prefix -value $ROUTE_OPT_USER_INSTANCE_NAME_PREFIX
}
if {$ROUTE_OPT_CTO && $ROUTE_OPT_CTO_USER_INSTANCE_NAME_PREFIX != ""} {
		set_app_options -name cts.common.user_instance_name_prefix -value $ROUTE_OPT_CTO_USER_INSTANCE_NAME_PREFIX
}

redirect -tee -file ${REPORTS_DIR}/${ROUTE_OPT_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

if {[file exists [which $TCL_USER_ROUTE_OPT_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_ROUTE_OPT_SCRIPT]"
        source $TCL_USER_ROUTE_OPT_SCRIPT
} elseif {$TCL_USER_ROUTE_OPT_SCRIPT != ""} {
	puts "RM-error: TCL_USER_ROUTE_OPT_SCRIPT($TCL_USER_ROUTE_OPT_SCRIPT) is invalid. Please correct it."
} else {
	if {$OPTIMIZATION_FLOW == "ttr"} {

		route_opt

	} elseif {$OPTIMIZATION_FLOW == "qor"} {
		route_opt

		if {$USE_RM_BLOCK_NAME_AS_LABEL} {
			save_block -as ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}_1
		} else {
			save_block -as ${ROUTE_OPT_BLOCK_NAME}_1
		}

		# CCD is disabled for the second route_opt; you can enable it if the timing can benefit from skew optimization
		if {[get_app_option_value -name route_opt.flow.enable_ccd]} {
			set_app_options -name route_opt.flow.enable_ccd -value false
		}
		# CTO is disabled for the second route_opt
		if {[get_app_option_value -name route_opt.flow.enable_cto]} {
			set_app_options -name route_opt.flow.enable_cto -value false
		}
		route_opt
	}
}


####################################
## Reshield after route_opt
####################################
if {$ROUTE_AUTO_CREATE_SHIELDS != "NONE" && $ROUTE_OPT_RESHIELD == "after_route_opt"} {
	create_shields ;# without specifying -nets option, all nets with shielding rules will be shielded 
}

####################################
## Post-route_opt customizations	
####################################
if {[file exists [which $TCL_USER_ROUTE_OPT_POST_SCRIPT]]} {
	puts "RM-info : Sourcing [which $TCL_USER_ROUTE_OPT_POST_SCRIPT]"
        source $TCL_USER_ROUTE_OPT_POST_SCRIPT
} elseif {$TCL_USER_ROUTE_OPT_POST_SCRIPT != ""} {
	puts "RM-error : TCL_USER_ROUTE_OPT_POST_SCRIPT($TCL_USER_ROUTE_OPT_POST_SCRIPT) is invalid. Please correct it."
}

## If there are remaining routing DRCs, you can use the following :
#  route_detail -incremental true -initial_drc_from_input true

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
      derive_hier_antenna_property -design ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}
   } elseif { $PHYSICAL_HIERARCHY_LEVEL == "intermediate"} {
      ## Set the following application option for creating abstract for intermediate level, when bottom-level is an abstract
      set_app_options -name abstract.allow_all_level_abstract -value true
      create_abstract -read_only
      create_frame -block_all true
      derive_hier_antenna_property -design ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME}
   }
}
 

save_lib

####################################
## Report and output
####################################			 
if {$REPORT_QOR} {
	set REPORT_PREFIX $ROUTE_OPT_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}


print_message_info -ids * -summary
echo [date] > route_opt

exit 

