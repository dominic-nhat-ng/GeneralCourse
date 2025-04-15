##########################################################################################
# Tool: IC Compiler II
# Script: place_opt.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage placeopt
set report_dir ${REPORTS_DIR}
set_svf ${DESIGN_NAME}_svf -append
START_TIMER bs_timer "Starting Bit Slice ICC2 Placeopt"

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${INIT_DESIGN_BLOCK_NAME} -to ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}
} else {
	copy_block -from ${INIT_DESIGN_BLOCK_NAME} -to ${PLACE_OPT_BLOCK_NAME}
	current_block ${PLACE_OPT_BLOCK_NAME}
}
link_block
set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false
#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8
set_app_options -name opt.dft.optimize_scan_chain -value true
set_app_options -name opt.dft.clock_aware_scan -value true



## The following only applies to hierarchical designs
## Swap to abstracts specified for place_opt 
if {$DESIGN_STYLE == "hier"} {
   if {$USE_ABSTRACTS_FOR_BLOCKS != "" } {
      puts "RM-info: Swapping to $BLOCK_ABSTRACT_FOR_PLACE_OPT abstracts for all blocks."
      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_PLACE_OPT
      report_abstracts
   }
}

if {$PLACE_OPT_ACTIVE_SCENARIO_LIST != ""} {
	set_scenario_status -active false [get_scenarios -filter active]
	set_scenario_status -active true $PLACE_OPT_ACTIVE_SCENARIO_LIST
}

## For common optimization settings that can impact multiple steps across the flow, refer to settings.common.opt.tcl  
puts "RM-info: Sourcing [which settings.common.opt.tcl]"
source -e settings.common.opt.tcl 

## For common routing settings, refer to settings.common.routing.tcl  
puts "RM-info: Sourcing [which settings.common.routing.tcl]"
source -e settings.common.routing.tcl

## For place_opt step related settings, refer to settings.step.place_opt.tcl
puts "RM-info: Sourcing [which settings.step.place_opt.tcl]"
source -e settings.step.place_opt.tcl 

## For common CTS settings, refer to settings.common.cts.tcl
#  Normally sourced in clock_opt_cts.tcl. The script will be sourced in place_opt.tcl if PLACE_OPT_OPTIMIZE_ICGS or
#  PLACE_OPT_TRIAL_CTS is enabled.  
if {$PLACE_OPT_OPTIMIZE_ICGS || $PLACE_OPT_TRIAL_CTS} {
puts "RM-info: Sourcing [which settings.common.cts.tcl]"
source -e settings.common.cts.tcl
}

## For non-persistent settings that need to be re-applied in a new ICC-II session, 
#  refer to settings.common.non_persistent.tcl
puts "RM-info: Sourcing [which settings.common.non_persistent.tcl]"
source -e settings.common.non_persistent.tcl

####################################
## read_saif 
####################################
## read_saif is recommended for features such as PREROUTE_LOW_POWER_PLACEMENT, and PREROUTE_TOTAL_POWER_OPTIMIZATION
#  Note : SAIF information is not persistent in this release and must be read in the subsequent ICC-II sessions.
#  For the subsequent steps, reading of SAIF_FILE is included in the settings.common.non_persistent.tcl
if {[file exists [which $SAIF_FILE]]} {
	if {$SAIF_FILE_POWER_SCENARIO != ""} {
		set read_saif_cmd "read_saif $SAIF_FILE -scenarios $SAIF_FILE_POWER_SCENARIO"
	} else {
		set read_saif_cmd "read_saif $SAIF_FILE"
	}
	if {$SAIF_FILE_SOURCE_INSTANCE != ""} {lappend read_saif_cmd -strip_path $SAIF_FILE_SOURCE_INSTANCE}
	if {$SAIF_FILE_TARGET_INSTANCE != ""} {lappend read_saif_cmd -path $SAIF_FILE_TARGET_INSTANCE}
	puts "RM-info : $read_saif_cmd"
	eval $read_saif_cmd
}

####################################
## Pre-place_opt customizations
####################################
if {[file exists [which $TCL_USER_PLACE_OPT_PRE_SCRIPT]]} {
	puts "RM-info: Sourcing [which $TCL_USER_PLACE_OPT_PRE_SCRIPT]"
	source $TCL_USER_PLACE_OPT_PRE_SCRIPT
} elseif {$TCL_USER_PLACE_OPT_PRE_SCRIPT != ""} {
	puts "RM-error: TCL_USER_PLACE_OPT_PRE_SCRIPT($TCL_USER_PLACE_OPT_PRE_SCRIPT) is invalid. Please correct it."
}

####################################
## Core command	
####################################
if {$PLACE_OPT_USER_INSTANCE_NAME_PREFIX != ""} {
	set_app_options -name opt.common.user_instance_name_prefix -value $PLACE_OPT_USER_INSTANCE_NAME_PREFIX
	if {$PLACE_OPT_TRIAL_CTS || $PLACE_OPT_OPTIMIZE_ICGS} {
		set_app_options -name cts.common.user_instance_name_prefix -value ${PLACE_OPT_USER_INSTANCE_NAME_PREFIX}_cts
	} 
}

redirect -tee -file ${REPORTS_DIR}/${PLACE_OPT_BLOCK_NAME}.report_app_options.start {report_app_options -non_default}

if {[file exists [which $TCL_USER_PLACE_OPT_SCRIPT]]} {
        puts "RM-info : Sourcing [which $TCL_USER_PLACE_OPT_SCRIPT]"
        source $TCL_USER_PLACE_OPT_SCRIPT

## PPA - Power focused feature : Multi-bit flow
#  You can review, edit the example in multibit_example.tcl and speficy it as TCL_USER_PLACE_OPT_SCRIPT

} else {

if {$OPTIMIZATION_FLOW == "qor"} {
	## Below is the baseline for a two-pass flow. Pls customize it as needed.
	#  Designs starting with SPG input do not require the first 2 commands since seed placement comes from SPG.
	if {!$PLACE_OPT_SPG_FLOW} {
		puts "RM-info: Running place_opt -to initial_drc"
		place_opt -to initial_drc
		puts "RM-info: Running update_timing -full"
		update_timing -full
	}

	#puts "RM-info: Running create_placement -use_seed_locs -timing_driven -congestion"
	puts "RM-info: Running place_opt -to initial_drc"
	#create_placement -use_seed_locs -timing_driven -congestion
        remove_placement_blockages -all
	place_opt -to initial_drc
        legalize_placement
	if {$USE_RM_BLOCK_NAME_AS_LABEL} {
		save_block -as ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}_two_pass_placement
	} else {
		save_block -as ${PLACE_OPT_BLOCK_NAME}_two_pass_placement
	}
	puts "RM-info: Running place_opt -from initial_drc"
	place_opt -from initial_opto
        legalize_placement
} elseif {$OPTIMIZATION_FLOW == "ttr"} {
	if {$PLACE_OPT_SPG_FLOW} {set_app_options -name place_opt.flow.do_spg -value true}
	place_opt
}

}

####################################
## Post-place_opt customizations
####################################
if {[file exists [which $TCL_USER_PLACE_OPT_POST_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_PLACE_OPT_POST_SCRIPT]"
        source $TCL_USER_PLACE_OPT_POST_SCRIPT
} elseif {$TCL_USER_PLACE_OPT_POST_SCRIPT != ""} {
        puts "RM-error:TCL_USER_PLACE_OPT_POST_SCRIPT($TCL_USER_PLACE_OPT_POST_SCRIPT) is invalid. Please correct it."
}

####################################
## refine_opt	
####################################
## Optional command to further optimize the placement and the netlist.
if {$PLACE_OPT_REFINE_OPT == "refine_opt" || $PLACE_OPT_REFINE_OPT == "path_opt" || $PLACE_OPT_REFINE_OPT == "power" || $PLACE_OPT_REFINE_OPT == "area"} {
	if {$PLACE_OPT_REFINE_OPT_USER_INSTANCE_NAME_PREFIX != ""} {
		set_app_options -name opt.common.user_instance_name_prefix -value $PLACE_OPT_REFINE_OPT_USER_INSTANCE_NAME_PREFIX
	}
	if {$USE_RM_BLOCK_NAME_AS_LABEL} {
		save_block -as ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME}_pre_refine_opt
	} else {
		save_block -as ${PLACE_OPT_BLOCK_NAME}_pre_refine_opt
	}
	if {$PLACE_OPT_REFINE_OPT == "refine_opt"} {
		puts "RM-info: Running refine_opt command"
		refine_opt
	} elseif {$PLACE_OPT_REFINE_OPT == "path_opt"} {
		puts "RM-info: Running refine_opt -from final_path_opt command"
		refine_opt -from final_path_opt
	} elseif {$PLACE_OPT_REFINE_OPT == "power"} {
		puts "RM-info: Running refine_opt exclusive power optimization"
		set_app_options -name refine_opt.flow.exclusive -value power
		refine_opt
	} elseif {$PLACE_OPT_REFINE_OPT == "area"} {
		puts "RM-info: Running refine_opt exclusive area recovery"
		set_app_options -name refine_opt.flow.exclusive -value area
		refine_opt 
	}
}

if {$TCL_USER_CONNECT_PG_NET_SCRIPT != ""} {
	if {[file exists [which $TCL_USER_CONNECT_PG_NET_SCRIPT]]} {
		puts "RM-info: Sourcing [which $TCL_USER_CONNECT_PG_NET_SCRIPT]"
  		source $TCL_USER_CONNECT_PG_NET_SCRIPT
	} else {
		puts "RM-error: TCL_USER_CONNECT_PG_NET_SCRIPT($TCL_USER_CONNECT_PG_NET_SCRIPT) is invalid. Pls correct it."
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
        set REPORT_PREFIX $PLACE_OPT_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT
}

report_utilization -verbose -of_objects [get_voltage_areas PD_SIPO]
report_utilization -verbose -of_objects [get_voltage_areas PD_PISO]
report_utilization -verbose -of_objects [get_voltage_areas DEFAULT_VA]



print_message_info -ids * -summary
echo [date] > place_opt
GENERATE_REPORTS_SUMMARY
STOP_TIMER bs_timer "Completing Bit Slice ICC2 Placeopt"
exit
