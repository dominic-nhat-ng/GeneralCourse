##########################################################################################
# Tool: IC Compiler II
# Script: chip_finish.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage chip_finish
set report_dir ${REPORTS_DIR}
set_svf ${DESIGN_NAME}_svf -append
START_TIMER bt_timer "Starting Bit Top ICC2 Chip Finish"

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${SIGNOFF_DRC_BLOCK_NAME} -to ${DESIGN_NAME}/${CHIP_FINISH_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${CHIP_FINISH_BLOCK_NAME}
} else {
	copy_block -from ${SIGNOFF_DRC_BLOCK_NAME} -to ${CHIP_FINISH_BLOCK_NAME}
	current_block ${CHIP_FINISH_BLOCK_NAME}
}
link_block
set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false
#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8


#set_app_options -name opt.common.allow_physical_feedthrough -value 1


## The following only applies to hierarchical designs
## Swap to abstracts specified for chip_finish
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_CHIP_FINISH abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_CHIP_FINISH
      report_abstracts
   }
}

if {$CHIP_FINISH_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $CHIP_FINISH_ACTIVE_SCENARIO_LIST
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

## For chip finishing step related settings, refer to settings.step.chip_finish.tcl
puts "RM-info: Sourcing [which settings.step.chip_finish.tcl]"
source -e settings.step.chip_finish.tcl

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## Pre-chip_finish customizations
####################################
if {[file exists [which $TCL_USER_CHIP_FINISH_PRE_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_CHIP_FINISH_PRE_SCRIPT]"
        source $TCL_USER_CHIP_FINISH_PRE_SCRIPT
} elseif {$TCL_USER_CHIP_FINISH_PRE_SCRIPT != ""} {
        puts "RM-error: TCL_USER_CHIP_FINISH_PRE_SCRIPT($TCL_USER_CHIP_FINISH_PRE_SCRIPT) is invalid. Please correct it."
}

redirect -tee -file ${REPORTS_DIR}/${CHIP_FINISH_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

####################################
## Filler cell insertion
####################################
## Metal filler (decap)
if {$CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST != ""} {
	set create_stdcell_filler_metal_cmd "create_stdcell_filler -lib_cell [list $CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST]"
	if {$CHIP_FINISH_METAL_FILLER_PREFIX != ""} {
		lappend create_stdcell_filler_metal_cmd -prefix $CHIP_FINISH_METAL_FILLER_PREFIX
	}
	eval $create_stdcell_filler_metal_cmd
	connect_pg_net
	remove_stdcell_fillers_with_violation
}

## Non-metal filler
if {$CHIP_FINISH_NON_METAL_FILLER_LIB_CELL_LIST != ""} {
	set create_stdcell_filler_non_metal_cmd "create_stdcell_filler -lib_cell [list $CHIP_FINISH_NON_METAL_FILLER_LIB_CELL_LIST]"
	if {$CHIP_FINISH_NON_METAL_FILLER_PREFIX != ""} {
		lappend create_stdcell_filler_non_metal_cmd -prefix $CHIP_FINISH_NON_METAL_FILLER_PREFIX
	}
	eval $create_stdcell_filler_non_metal_cmd
	connect_pg_net
}

## To remove filler cells in the design :
#	remove_cells [get your_filler_cells]

####################################
## Metal fill creation	
####################################
## Metal fill creation command
if {$CHIP_FINISH_CREATE_METAL_FILL} {

if {$CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED == "off"} {
	## Non-track-based metal fill creation requires a valid runset
	if {[get_app_option_value -name signoff.create_metal_fill.runset] != ""} {
		set create_metal_fill_cmd "signoff_create_metal_fill"
	} else {
		puts "RM-error: signoff.create_metal_fill.runset is not specified. Please set it through CHIP_FINISH_CREATE_METAL_FILL_RUNSET!" 
		puts "RM-warning: signoff_create_metal_fill is skipped."
	}
} else {
	## For track-based metal fill creation, it is recommended to specify foundry node for -track_fill in order to use -fill_all_track
	if {$CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED != "generic"} {
		set create_metal_fill_cmd "signoff_create_metal_fill -track_fill $CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED -fill_all_tracks true"
	} else {
		set create_metal_fill_cmd "signoff_create_metal_fill -track_fill $CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED"
	}
	## Track-based metal fill creation: optionally specify a CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED_PARAMETER_FILE  
	if {$CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED_PARAMETER_FILE != "auto" && [file exists [which $CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED_PARAMETER_FILE]]} {
		lappend create_metal_fill_cmd -track_fill_parameter_file $CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED_PARAMETER_FILE
	}
}

if {[info exists create_metal_fill_cmd] && $create_metal_fill_cmd != ""} {
	## Metal fill creation with timing-driven
	if {$CHIP_FINISH_CREATE_METAL_FILL_TIMING_DRIVEN_THRESHOLD != ""} {
		lappend create_metal_fill_cmd -timing_preserve_setup_slack_threshold $CHIP_FINISH_CREATE_METAL_FILL_TIMING_DRIVEN_THRESHOLD
	}

	save_block ;# this is required before ICV operations since ICV reads from disk file instead of memory

	puts "RM-info: Running $create_metal_fill_cmd"
	eval $create_metal_fill_cmd

	save_block ;# this is recommended in case there are subsequent ICV operations added by the user after signoff_create_metal_fill 

	if {[get_app_option_value -name signoff.check_drc.runset] != ""} {
		set_app_options -name signoff.check_drc.always_read_fill -value true
		set_app_options -name signoff.check_drc.run_dir -value $CHIP_FINISH_SIGNOFF_DRC_RUNDIR_AFTER_METAL_FILL ;# RM default z_MFILL_after
		puts "RM-info: Running signoff_check_drc"
		signoff_check_drc -error_data $CHIP_FINISH_SIGNOFF_DRC_RUNDIR_AFTER_METAL_FILL ;# RM default z_MFILL_after
	} else {
		puts "RM-warning: signoff.check_drc.runset is not specified. Please set it through SIGNOFF_DRC_RUNSET!" 
		puts "RM-warning: The signoff_check_drc command after signoff_create_metal_fill is skipped."
	}

	set_extraction_options -real_metalfill_extraction floating
}


}

####################################
## Post-chip_finish customizations
####################################
if {[file exists [which $TCL_USER_CHIP_FINISH_POST_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_CHIP_FINISH_POST_SCRIPT]"
        source $TCL_USER_CHIP_FINISH_POST_SCRIPT
} elseif {$TCL_USER_CHIP_FINISH_POST_SCRIPT != ""} {
        puts "RM-error: TCL_USER_CHIP_FINISH_POST_SCRIPT($TCL_USER_CHIP_FINISH_POST_SCRIPT) is invalid. Please correct it."
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
      derive_hier_antenna_property -design ${DESIGN_NAME}/${CHIP_FINISH_BLOCK_NAME}
   } elseif { $PHYSICAL_HIERARCHY_LEVEL == "intermediate"} {
      ## Set the following application option for creating abstract for intermediate level, when bottom-level is an abstract
      set_app_options -name abstract.allow_all_level_abstract -value true
      create_abstract -read_only
      create_frame -block_all true
      derive_hier_antenna_property -design ${DESIGN_NAME}/${CHIP_FINISH_BLOCK_NAME}
   }
}


save_lib

####################################
## Signal EM analysis	
####################################
## Signal EM analysis does not apply to intermediate/top level of hierarchical implementation with abstracts
if {!($DESIGN_STYLE == "hier" && $PHYSICAL_HIERARCHY_LEVEL != "bottom" && $USE_ABSTRACTS_FOR_BLOCKS != "")} {
	## Recommended to have SI enabled so delta transition and coupling capacitance are considered in signal EM analysis
	if {[file exists [which $CHIP_FINISH_EM_ITF_CONSTRAINT_FILE]]} {
		if {![get_app_option_value -name time.si_enable_analysis]} {
			set RM_current_value_enable_si false
			set_app_options -name time.si_enable_analysis -value true
		}

		## Loading EM constraint is required for EM analysis and fixing. 
		#  It can only be in ITF format.
		read_signal_em_constraints -itf_em $CHIP_FINISH_EM_ITF_CONSTRAINT_FILE
  
		## Loading and setting switching activity steps are optional.
		#  ex, set_switching_activity -rise_toggle_rate <positive number> -fall_toggle_rate -static_probability <0to1> [get_nets -hier *]
		if {[file exists [which $CHIP_FINISH_EM_SAIF]]} {
			read_saif $CHIP_FINISH_EM_SAIF
		} elseif {$CHIP_FINISH_EM_SAIF != ""} {
			puts "RM-error: CHIP_FINISH_EM_SAIF($CHIP_FINISH_EM_SAIF) is invalid. Please correct it."
		}
 
		## Analyze signal EM
		redirect -file ${REPORTS_DIR}/${REPORT_PREFIX}.report_signal_em {report_signal_em -violated}

		## Restore user default of time.enable_si
		if {[info exists RM_current_value_enable_si] && $RM_current_value_enable_si == "false"} {
			set_app_options -name time.si_enable_analysis -value false
		}
	} elseif {$CHIP_FINISH_EM_ITF_CONSTRAINT_FILE != ""} {
		puts "RM-error: CHIP_FINISH_EM_ITF_CONSTRAINT_FILE($CHIP_FINISH_EM_ITF_CONSTRAINT_FILE) is invalid. Please correct it."
	}
}

####################################
## Report and output
####################################			 
if {$REPORT_QOR} {
	set REPORT_PREFIX $CHIP_FINISH_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}

GENERATE_REPORTS_SUMMARY
print_message_info -ids * -summary
echo [date] > chip_finish
STOP_TIMER bt_timer "Completing Bit Top ICC2 Chip Finish"

exit 

