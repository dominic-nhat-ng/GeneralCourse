puts "RM-info: Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.step.place_opt.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## Timing
####################################
## Enable clock-to-data analysis
set_app_options -name time.enable_clock_to_data_analysis -value true ;# default false

####################################
## PPA - Performance focused features (place_opt)
####################################
# optimize_icgs
if {$PLACE_OPT_OPTIMIZE_ICGS} {
	set_app_options -name place_opt.flow.optimize_icgs -value true ;# default false
	if {$PLACE_OPT_OPTIMIZE_ICGS_CRITICAL_RANGE != ""} {
	set_app_options -name place_opt.flow.optimize_icgs_critical_range -value $PLACE_OPT_OPTIMIZE_ICGS_CRITICAL_RANGE ;# default 0.75
	}		
}

# trial_clock_tree
if {$PLACE_OPT_TRIAL_CTS && !$PLACE_OPT_OPTIMIZE_ICGS} {
	# Note : if PLACE_OPT_OPTIMIZE_ICGS is set to TRUE, tool enables this feature automatically
	set_app_options -name place_opt.flow.trial_clock_tree -value true ;# default false
}

# clock_aware_placement
if {$PLACE_OPT_CLOCK_AWARE_PLACEMENT && !$PLACE_OPT_OPTIMIZE_ICGS} {
	# Note : if PLACE_OPT_OPTIMIZE_ICGS is set to TRUE, tool enables this feature automatically
	set_app_options -name place_opt.flow.clock_aware_placement -value true ;# default false
}

## Auto bound for ICG placement
if {$PLACE_OPT_ICG_AUTO_BOUND} {
	# Note : optionally can be enabled along with PLACE_OPT_OPTIMIZE_ICGS
	set_app_options -name place.coarse.icg_auto_bound -value true ;# default false
}

# path_opt
if {$PLACE_OPT_DO_PATH_OPT} {
	set_app_options -name place_opt.flow.do_path_opt -value true ;# default false
}

# final_place_effort
if {$PLACE_OPT_FINAL_PLACE_EFFORT_HIGH} {
	set_app_options -name place_opt.final_place.effort -value high ;# default medium
}

####################################
## place_opt/placement specific features
####################################
## To create a buffer-only blockage, follow the example below.
#  The area covered by a buffer-only blockage can only be used by buffers and inverters, which is honored by placement.
#  -blocked_percentage 0 means that 100% of the area can be used by buffers and inverters.
#  -blocked_percentage 100 means that 0% of the area can be used by buffers and inverters. 
#   (as a result, no standard cells can be placed under a buffer only blockage with -blocked_percentage 100).
#
#  Example for creating a buffer only blockage with 100% of the area open to repeaters : 
#	create_placement_blockage -name placement_blockage_1 -type allow_buffer_only -blocked_percentage 0 \
#       -boundary { {x1 y1} {x2 y2} }

## Specify effort level for congestion alleviation in place_opt.
#  Expect a significant increase in runtime for high effort.
if {$PLACE_OPT_CONGESTION_EFFORT_HIGH} {
	set_app_options -name place_opt.congestion.effort -value high ;# default medium
}

## GR-opto : 
#  Run global route based buffering during HFS/DRC fixing. Global routes are deleted after buffering. 
#  This is especially useful for fragmented and narrow-channelled floorplans.
#  For hierachical PNR flow: this feature is disabled for top and intermediate level designs with block abstracts.
if {$PLACE_OPT_GR_BASED_HFSDRC} {
	if {!($DESIGN_STYLE == "hier" && $PHYSICAL_HIERARCHY_LEVEL != "bottom" && $USE_ABSTRACTS_FOR_BLOCKS != "")} {
		set_app_options -name place_opt.initial_drc.global_route_based -value 1 ;# default 0
	}
}


####################################
## Example to model clock NDR based congestion in place_opt
####################################
if {!$PLACE_OPT_TRIAL_CTS && !$PLACE_OPT_OPTIMIZE_ICGS} {
# The following is only applied if PLACE_OPT_TRIAL_CTS and PLACE_OPT_OPTIMIZE_ICGS are not enabled.
# otherwise trial clock tree would be performed during place_opt and not requiring the clock NDR modeling.

## Rule creation (create_routing_rule) ##
if {$PLACE_OPT_CLOCK_NDR_RULE_NAME != ""} {
	redirect -var x {report_routing_rules $PLACE_OPT_CLOCK_NDR_RULE_NAME}
	if {[regexp "Error" $x]} {
		## Create the NDR if it is not present
		if {$PLACE_OPT_CLOCK_NDR_RULE_NAME == "icc2rm_2w2s"} {
			create_routing_rule $PLACE_OPT_CLOCK_NDR_RULE_NAME -default_reference_rule -multiplier_width 2 -multiplier_spacing 2
		} elseif {$PLACE_OPT_CLOCK_NDR_RULE_NAME == "icc2rm_2w2s_shield_default"} {
			create_routing_rule $PLACE_OPT_CLOCK_NDR_RULE_NAME -default_reference_rule -multiplier_width 2 -multiplier_spacing 2 -shield
		} elseif {$PLACE_OPT_CLOCK_NDR_RULE_NAME == "icc2rm_2w2s_shield_list"} {
			if {$PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_WIDTH_LIST != "" || $PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_SPACING_LIST != ""} {
				set create_routing_rule_cmd "create_routing_rule $PLACE_OPT_CLOCK_NDR_RULE_NAME -default_reference_rule -multiplier_width 2 -multiplier_spacing 2"
				if {$PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_WIDTH_LIST != ""} {lappend create_routing_rule_cmd -shield_widths $PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_WIDTH_LIST} 
				if {$PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_SPACING_LIST != ""} {lappend create_routing_rule_cmd -shield_spacings $PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_SPACING_LIST}
				puts "RM-info: $create_routing_rule_cmd"
			eval ${create_routing_rule_cmd}
			} else {
				puts "RM-error : PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_WIDTH_LIST or PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_SPACING_LIST not specified which is required by $PLACE_OPT_CLOCK_NDR_RULE_NAME"
			}
		} else {
			if {[file exists $TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE]} {
				puts "RM-info: Sourcing [which $TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE]"
				source -e $TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE
			} elseif {$TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE != ""} {
				puts "RM-error: TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE($TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE) is invalid. Pls correct it!"
			} else {
				puts "RM-error: TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE is not specified to create PLACE_OPT_CLOCK_NDR_RULE_NAME($PLACE_OPT_CLOCK_NDR_RULE_NAME). Pls correct it!"
			}
		}
	} else {
		puts "RM-info: PLACE_OPT_CLOCK_NDR_RULE_NAME($PLACE_OPT_CLOCK_NDR_RULE_NAME) already exists. Rule creation skipped."
	}
}

## Rule association (set_clock_routing_rules) ##
if {$PLACE_OPT_CLOCK_NDR_RULE_NAME != ""} {
	## Check if the rule has been created properly
	redirect -var x {report_routing_rules $PLACE_OPT_CLOCK_NDR_RULE_NAME}
	if {![regexp "Error" $x]} {
		# set_clock_routing_rules
		set set_routing_rules_cmd_for_place_opt "set_routing_rule -rule $PLACE_OPT_CLOCK_NDR_RULE_NAME"
		if {$PLACE_OPT_CLOCK_NDR_NET_LIST != ""} {
			lappend set_routing_rules_cmd_for_place_opt $PLACE_OPT_CLOCK_NDR_NET_LIST
		} else {
			lappend set_routing_rules_cmd_for_place_opt [get_nets -physical_context -of [get_clock_tree_pins]]
		} 
		if {$PLACE_OPT_CLOCK_NDR_MIN_ROUTING_LAYER != ""} {lappend set_routing_rules_cmd_for_place_opt -min_routing_layer $PLACE_OPT_CLOCK_NDR_MIN_ROUTING_LAYER}
		if {$PLACE_OPT_CLOCK_NDR_MAX_ROUTING_LAYER != ""} {lappend set_routing_rules_cmd_for_place_opt -max_routing_layer $PLACE_OPT_CLOCK_NDR_MAX_ROUTING_LAYER}
		puts "RM-info: $set_routing_rules_cmd_for_place_opt"
			eval ${set_routing_rules_cmd_for_place_opt}
	} else {
		puts "RM-error: PLACE_OPT_CLOCK_NDR_RULE_NAME($PLACE_OPT_CLOCK_NDR_RULE_NAME) hasn't been created yet. Can not associate it with nets!"
	}
}

}

puts "RM-info: Completed script [info script]\n"
