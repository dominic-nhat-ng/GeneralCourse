##########################################################################################
# Tool: IC Compiler II
# Script: signoff_drc.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage signoff_drc
set report_dir ${REPORTS_DIR}
set_svf ${DESIGN_NAME}_svf -append
START_TIMER bc_timer "Starting Bit Coin ICC2 Signoff DRC"

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${ROUTE_OPT_BLOCK_NAME} -to ${DESIGN_NAME}/${SIGNOFF_DRC_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${SIGNOFF_DRC_BLOCK_NAME}
} else {
	copy_block -from ${ROUTE_OPT_BLOCK_NAME} -to ${SIGNOFF_DRC_BLOCK_NAME}
	current_block ${SIGNOFF_DRC_BLOCK_NAME}
}
link_block

set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false

#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8


## The following only applies to hierarchical designs
## Swap to abstracts specified for signoff_drc
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_SIGNOFF_DRC abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_SIGNOFF_DRC
      report_abstracts
   }
}

if {$SIGNOFF_DRC_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $SIGNOFF_DRC_ACTIVE_SCENARIO_LIST
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
#  (sourced in route_opt step)
#	puts "RM-info: Sourcing [which settings.step.route_opt.tcl]"
#	source -e settings.step.route_opt.tcl

## For signoff DRC step related settings, refer to settings.step.signoff_drc.tcl
puts "RM-info: Sourcing [which settings.step.signoff_drc.tcl]"
source -e settings.step.signoff_drc.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## Pre-signoff_drc_check customizations
####################################
if {[file exists [which $TCL_USER_SIGNOFF_DRC_PRE_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_SIGNOFF_DRC_PRE_SCRIPT]"
        source $TCL_USER_SIGNOFF_DRC_PRE_SCRIPT
} elseif {$TCL_USER_SIGNOFF_DRC_PRE_SCRIPT != ""} {
        puts "RM-error: TCL_USER_SIGNOFF_DRC_PRE_SCRIPT($TCL_USER_SIGNOFF_DRC_PRE_SCRIPT) is invalid. Please correct it."
}

redirect -tee -file ${REPORTS_DIR}/${SIGNOFF_DRC_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

####################################
## signoff_drc_check and signoff_fix_drc
####################################
if {[get_app_option_value -name signoff.check_drc.runset] != ""} {

## signoff_drc_check before signoff_fix_drc
save_block ;# Save to disk is required as ICV reads from disk file instead of memory
set_app_options -name signoff.check_drc.run_dir -value $SIGNOFF_DRC_RUNDIR_BEFORE_ADR ;# RM default z_ADR_before
signoff_check_drc -error_data $SIGNOFF_DRC_RUNDIR_BEFORE_ADR ;# RM default z_ADR_before

## signoff_fix_drc
#  Specify valid SIGNOFF_DRC_DPT_RULES if you want signoff_fix_drc to be used for DPT rules fixing
if {$SIGNOFF_DRC_ADR} {
	set_app_options -name signoff.fix_drc.init_drc_error_db -value $SIGNOFF_DRC_RUNDIR_BEFORE_ADR ;# RM default z_ADR_before
	set_app_options -name signoff.fix_drc.run_dir -value $SIGNOFF_DRC_RUNDIR_ADR ;# RM default z_ADR
	if {$SIGNOFF_DRC_DPT_RULES != ""} {
		set_app_options -name signoff.fix_drc.custom_guidance -value dpt
		signoff_fix_drc -select_rules {$SIGNOFF_DRC_DPT_RULES}
		set_app_options -name signoff.fix_drc.custom_guidance -value off
	} else {
		signoff_fix_drc
	}
	save_block

	## signoff_drc_check after signoff_fix_drc is completed
	set_app_options -name signoff.check_drc.run_dir -value $SIGNOFF_DRC_RUNDIR_AFTER_ADR ;# RM default z_ADR_after
	signoff_check_drc -error_data $SIGNOFF_DRC_RUNDIR_AFTER_ADR ;# RM default z_ADR_after
	save_block
}

} else {
	puts "RM-error: signoff.check_drc.runset is not specified. Please set it through SIGNOFF_DRC_RUNSET!" 
	puts "RM-info: signoff_check_drc and signoff_fix_drc are both skipped." 
}

## Enabled for hierarchical designs; for bottom and intermediate levels of physical hierarchy
if {$DESIGN_STYLE == "hier"} {
   if { $PHYSICAL_HIERARCHY_LEVEL == "bottom" } {
      create_abstract -read_only
      create_frame -block_all true
      derive_hier_antenna_property -design ${DESIGN_NAME}/${SIGNOFF_DRC_BLOCK_NAME}
   } elseif { $PHYSICAL_HIERARCHY_LEVEL == "intermediate"} {
      ## Set the following application option for creating abstract for intermediate level, when bottom-level is an abstract
      set_app_options -name abstract.allow_all_level_abstract -value true
      create_abstract -read_only
      create_frame -block_all true
      derive_hier_antenna_property -design ${DESIGN_NAME}/${SIGNOFF_DRC_BLOCK_NAME}
   }
}

save_lib

####################################
## Post-signoff_drc_check customizations
####################################
if {[file exists [which $TCL_USER_SIGNOFF_DRC_POST_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_SIGNOFF_DRC_POST_SCRIPT]"
        source $TCL_USER_SIGNOFF_DRC_POST_SCRIPT
} elseif {$TCL_USER_SIGNOFF_DRC_POST_SCRIPT != ""} {
        puts "RM-error: TCL_USER_SIGNOFF_DRC_POST_SCRIPT($TCL_USER_SIGNOFF_DRC_POST_SCRIPT) is invalid. Please correct it."
}

####################################
## Report and output
####################################			 
if {$REPORT_QOR} {
	set REPORT_PREFIX $SIGNOFF_DRC_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}

GENERATE_REPORTS_SUMMARY
print_message_info -ids * -summary
echo [date] > signoff_drc
STOP_TIMER bc_timer "Completing Bit Coin ICC2 Signoff DRC"

exit 

