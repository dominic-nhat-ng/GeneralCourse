puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.common.cts.tcl
# Purpose: Common CTS related settings that can be sourced in clock_opt_cts or place_opt
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## Timer
####################################
set_app_options -name time.remove_clock_reconvergence_pessimism -value true

####################################
## CTS max transition and capacitance 
####################################
# Here are the examples :
# 	Example : set_max_transition -clock_path 0.15 [all_clocks] -scenarios [all_scenarios]
# 	Example : set_max_capacitance -clock_path 0.5 [all_clocks] -scenarios [all_scenarios]

####################################
## CTS target skew and latency 
####################################
# By default CTS targets best skew and latency. These options can be used in case user wants to relax the target.
#	Example : set_clock_tree_options -clocks [get_clocks clk -mode Mode1] -corner Corner1WC -target_latency 1 -target_skew 0.3

####################################
## CTS balance points 
####################################
# To modify the clock tree balancing requirements
#	Example : set_clock_balance_points -delay 2.0 -balance_point gck/CP ;# -clock option is not mandatory

####################################
## CTS skew groups 
####################################
# Create user-defined skew groups which usually are to improve timing
#	Example : 
#	foreach_in_collection m [all_modes] {
#		create_clock_skew_group -name [get_object_name ${m}]_grp1 -mode $m -objects "reg1/clk reg2/clk"
#	}

####################################
## CTS ICDB (Inter-clock delay balancing) constraints
####################################
#  ICDB is performed automatically in build_clock phase of clock_opt
#  Use create_clock_balance_group to control it. For ex,
#	foreach_in_collection m [all_modes] {
#		current_mode $m
#		create_clock_balance_group -objects {clk1 clk2} -name group1 -offset_latencies {0.0 -0.5}
#	}

####################################
## CTS Latency adjustments for compute_clock_latency
####################################
## For non-CCD flow, compute_clock_latency is performed automatically in route_clock phase of clock_opt
#  For CCD flow, compute_clock_latency is performed automatically during both build_clock and route_clock phases.
#  However you have to use set_latency_adjustment_options to control it. For ex, to associate virtual clocks to real clocks :
foreach_in_collection m [all_modes] {
        current_mode $m
#        set_latency_adjustment_options -reference_clock lclk -clocks_to_update [get_clocks virtual*lclk*]
#        set_latency_adjustment_options -reference_clock hclk -clocks_to_update [get_clocks virtual*hclk*]
}

####################################
## Clear clock NDR modeling defined in place_opt 
####################################
if {!$PLACE_OPT_TRIAL_CTS && !$PLACE_OPT_OPTIMIZE_ICGS} {
# The following is only applied if PLACE_OPT_TRIAL_CTS and PLACE_OPT_OPTIMIZE_ICGS are not enabled;
# otherwise trial clock tree would be performed during place_opt and not requiring the clock NDR modeling.
	if {$PLACE_OPT_CLOCK_NDR_RULE_NAME != ""} {
		## Check if the rule has been created properly
		redirect -var x {report_routing_rules $PLACE_OPT_CLOCK_NDR_RULE_NAME}
		if {![regexp "Error" $x]} {
			# Reset existing rule
			set set_routing_rule_clear_cmd "set_routing_rule -clear"  
			if {$PLACE_OPT_CLOCK_NDR_NET_LIST != ""} {
				lappend set_routing_rule_clear_cmd $PLACE_OPT_CLOCK_NDR_NET_LIST
			} else {
				lappend set_routing_rule_clear_cmd [get_nets -physical_context -of [get_clock_tree_pins]]
			}
			puts "RM-info: Running $set_routing_rule_clear_cmd to clear existing PLACE_OPT_CLOCK_NDR_RULE_NAME($PLACE_OPT_CLOCK_NDR_RULE_NAME)"
			eval $set_routing_rule_clear_cmd
		}
	}
}

####################################
## Clock NDR examples
####################################
#  (1) To use RM predefined NDR rule examples
#	- Specify an RM predefined rule name for CTS_NDR_RULE_NAME and/or CTS_LEAF_NDR_RULE_NAME in icc2_pnr_setup.tcl
#	- Script will do the rule creation and association with root/internal nets and sink nets, respectively
#  (2) To use your own NDR rules :
#	- Specify your own CTS_NDR_RULE_NAME and/or CTS_LEAF_NDR_RULE_NAME in icc2_pnr_setup.tcl
#       - Create the rules beforehand, or provide the rule creation scripts through TCL_CTS_NDR_RULE_FILE/TCL_CTS_LEAF_NDR_RULE_FILE
#  	- The specified rules will be associated with root/internal nets and sink nets, respectively

# ++++++++++++++++++++++++++++++++++
# NDR for root and internal nets
# ++++++++++++++++++++++++++++++++++
# - specify icc2rm_2w2s for CTS_NDR_RULE_NAME to create a double width and double spacing rule
# - specify icc2rm_2w2s_shield_default for CTS_NDR_RULE_NAME to create a double width and spacing + shielding with default width and spacing rule
# - specify icc2rm_2w2s_shield_list for CTS_NDR_RULE_NAME to create a double width and spacing + shielding with customized width and spacing rule

## Rule creation (create_routing_rule) ##
if {$CTS_NDR_RULE_NAME != ""} {
	redirect -var x {report_routing_rules $CTS_NDR_RULE_NAME}
	if {[regexp "Error" $x]} {
		## Create the NDR if it is not present
		if {$CTS_NDR_RULE_NAME == "icc2rm_2w2s"} {
			create_routing_rule $CTS_NDR_RULE_NAME -default_reference_rule -multiplier_width 2 -multiplier_spacing 2
		} elseif {$CTS_NDR_RULE_NAME == "icc2rm_2w2s_shield_default"} {
			create_routing_rule $CTS_NDR_RULE_NAME -default_reference_rule -multiplier_width 2 -multiplier_spacing 2 -shield
		} elseif {$CTS_NDR_RULE_NAME == "icc2rm_2w2s_shield_list"} {
			if {$CTS_NDR_SHIELDING_LAYER_WIDTH_LIST != "" || $CTS_NDR_SHIELDING_LAYER_SPACING_LIST != ""} {
				set create_routing_rule_cmd "create_routing_rule $CTS_NDR_RULE_NAME -default_reference_rule -multiplier_width 2 -multiplier_spacing 2"
				if {$CTS_NDR_SHIELDING_LAYER_WIDTH_LIST != ""} {lappend create_routing_rule_cmd -shield_widths $CTS_NDR_SHIELDING_LAYER_WIDTH_LIST} 
				if {$CTS_NDR_SHIELDING_LAYER_SPACING_LIST != ""} {lappend create_routing_rule_cmd -shield_spacings $CTS_NDR_SHIELDING_LAYER_SPACING_LIST}
				puts "RM-info: $create_routing_rule_cmd"
			eval ${create_routing_rule_cmd}
			} else {
				puts "RM-error : CTS_NDR_SHIELDING_LAYER_WIDTH_LIST or CTS_NDR_SHIELDING_LAYER_SPACING_LIST not specified which is required by $CTS_NDR_RULE_NAME"
			}
		} else {
			if {[file exists $TCL_CTS_NDR_RULE_FILE]} {
				puts "RM-info: Sourcing [which $TCL_CTS_NDR_RULE_FILE]"
				source -e $TCL_CTS_NDR_RULE_FILE
			} elseif {$TCL_CTS_NDR_RULE_FILE != ""} {
				puts "RM-error: TCL_CTS_NDR_RULE_FILE($TCL_CTS_NDR_RULE_FILE) is invalid. Pls correct it!"
			} else {
				puts "RM-error: TCL_CTS_NDR_RULE_FILE is not specified to create CTS_NDR_RULE_NAME($CTS_NDR_RULE_NAME). Pls correct it!"
			}
		}
	} else {
		puts "RM-info: CTS_NDR_RULE_NAME($CTS_NDR_RULE_NAME) already exists. Rule creation skipped."
	}
}

## Rule association (set_clock_routing_rules) ##
if {$CTS_NDR_RULE_NAME != ""} {
	# Check if the rule has been created properly
	redirect -var x {report_routing_rules $CTS_NDR_RULE_NAME}
	if {![regexp "Error" $x]} {
		# set_clock_routing_rules on root nets
		set set_clock_routing_rules_cmd_root "set_clock_routing_rules -net_type root -rule $CTS_NDR_RULE_NAME"
		if {$CTS_NDR_MIN_ROUTING_LAYER != ""} {lappend set_clock_routing_rules_cmd_root -min_routing_layer $CTS_NDR_MIN_ROUTING_LAYER}
		if {$CTS_NDR_MAX_ROUTING_LAYER != ""} {lappend set_clock_routing_rules_cmd_root -max_routing_layer $CTS_NDR_MAX_ROUTING_LAYER}
		puts "RM-info: $set_clock_routing_rules_cmd_root"
			eval ${set_clock_routing_rules_cmd_root}
		
		# set_clock_routing_rules on internal nets
		set set_clock_routing_rules_cmd_internal "set_clock_routing_rules -net_type internal -rule $CTS_NDR_RULE_NAME"
		if {$CTS_NDR_MIN_ROUTING_LAYER != ""} {lappend set_clock_routing_rules_cmd_internal -min_routing_layer $CTS_NDR_MIN_ROUTING_LAYER}
		if {$CTS_NDR_MAX_ROUTING_LAYER != ""} {lappend set_clock_routing_rules_cmd_internal -max_routing_layer $CTS_NDR_MAX_ROUTING_LAYER}
		puts "RM-info: $set_clock_routing_rules_cmd_internal"
			eval ${set_clock_routing_rules_cmd_internal}
	} else {
		puts "RM-error: CTS_NDR_RULE_NAME($CTS_NDR_RULE_NAME) hasn't been created yet. Can not associate it with root and internal nets!"
	}
}

# ++++++++++++++++++++++++++++++++++
# NDR for leaf (sink) nets
# ++++++++++++++++++++++++++++++++++
# - specify icc2rm_leaf for CTS_LEAF_NDR_RULE_NAME to create a default reference rule for leaf nets

## Rule creation (create_routing_rule) ##
if {$CTS_LEAF_NDR_RULE_NAME != ""} {
	redirect -var x {report_routing_rules $CTS_LEAF_NDR_RULE_NAME}
	if {[regexp "Error" $x]} {
		## Create the NDR if it is not present
		if {$CTS_LEAF_NDR_RULE_NAME == "icc2rm_leaf"} {
			create_routing_rule $CTS_LEAF_NDR_RULE_NAME -default_reference_rule
		} else {
			if {[file exists $TCL_CTS_LEAF_NDR_RULE_FILE]} {
				puts "RM-info: Sourcing [which $TCL_CTS_LEAF_NDR_RULE_FILE]"
				source -e $TCL_CTS_LEAF_NDR_RULE_FILE
			} elseif {$TCL_CTS_LEAF_NDR_RULE_FILE != ""} {
				puts "RM-error: TCL_CTS_LEAF_NDR_RULE_FILE($TCL_CTS_LEAF_NDR_RULE_FILE) is invalid. Pls correct it!"
			} else {
				puts "RM-error: TCL_CTS_LEAF_NDR_RULE_FILE is not specified to create CTS_LEAF_NDR_RULE_NAME($CTS_LEAF_NDR_RULE_NAME). Pls correct it!"
			}
		}
	} else {
		puts "RM-info: CTS_LEAF_NDR_RULE_NAME($CTS_LEAF_NDR_RULE_NAME) already exists. Rule creation skipped"
	}
}

## Rule association (set_clock_routing_rules) ##
if {$CTS_LEAF_NDR_RULE_NAME != ""} {
	# Check if the rule has been created properly
	redirect -var x {report_routing_rules $CTS_LEAF_NDR_RULE_NAME}
	if {![regexp "Error" $x]} {
		set set_clock_routing_rules_cmd_leaf "set_clock_routing_rules -net_type sink -rule $CTS_LEAF_NDR_RULE_NAME"
		if {$CTS_LEAF_NDR_MIN_ROUTING_LAYER != ""} {lappend set_clock_routing_rules_cmd_leaf -min_routing_layer $CTS_LEAF_NDR_MIN_ROUTING_LAYER}
		if {$CTS_LEAF_NDR_MAX_ROUTING_LAYER != ""} {lappend set_clock_routing_rules_cmd_leaf -max_routing_layer $CTS_LEAF_NDR_MAX_ROUTING_LAYER}
		puts "RM-info: $set_clock_routing_rules_cmd_leaf"
		eval $set_clock_routing_rules_cmd_leaf
	} else {
		puts "RM-error: CTS_LEAF_NDR_RULE_NAME($CTS_LEAF_NDR_RULE_NAME) hasn't been created yet. Can not associate it with leaf nets!"
	}
}

# ++++++++++++++++++++++++++++++++++
# Report routing rules 
# ++++++++++++++++++++++++++++++++++
redirect -file ${REPORTS_DIR}/settings.common.cts.report_routing_rules.rpt {report_routing_rules -verbose}
redirect -file ${REPORTS_DIR}/settings.common.cts.report_clock_routing_rules.rpt {report_clock_routing_rules}

####################################
## CTS cells and restrictions 
####################################
## derive_clock_cell_references
#  Check non-repeater cells on clock trees and suggest logically equivalent cells for CTS to use
# 	derive_clock_cell_references -output refs.tcl
#  Edit refs.tcl and source it

## The following commands have been set in common_settings_for_all.tcl. If you haven't done so, pls uncomment them here.
## CTS cells 
#	Please make sure you include always-on cells for MV-CTS, clock gate cells (for sizing),
#	and equivalent gates for other types of pre-existing clock cells such as muxes (for sizing).
#	You should also include flops (CCD can size them for timing improvement) in the list.
#	Here's an example if you want to include flops that are already available to optimization :
#	set_lib_cell_purpose -include cts [get_lib_cells */SDFF* -filter "valid_purposes=~*optimization*"]		 
# if {$CTS_LIB_CELL_PATTERN_LIST != "" || $CTS_ONLY_LIB_CELL_PATTERN_LIST != ""} {
# 	set_lib_cell_purpose -exclude cts [get_lib_cells */*]
# }
# 
# if {$CTS_LIB_CELL_PATTERN_LIST != ""} {
# 	set_dont_touch [get_lib_cells $CTS_LIB_CELL_PATTERN_LIST] false ;# In ICC-II, CTS respects dont_touch
# 	set_lib_cell_purpose -include cts [get_lib_cells $CTS_LIB_CELL_PATTERN_LIST]
# } 

## CTS-exclusive cells
#	These are the lib cells to be used by CTS exclusively, such as CTS specific buffers and inverters.
#	Please be aware that these cells will be applied with only cts purpose and nothing else.
#	If you want to use these lib cells for other purposes, such as optimization and hold,
#	specify them in CTS_LIB_CELL_PATTERN_LIST instead.
# if {$CTS_ONLY_LIB_CELL_PATTERN_LIST != ""} {
# 	set_dont_touch [get_lib_cells $CTS_ONLY_LIB_CELL_PATTERN_LIST] false ;# In ICC-II, CTS respects dont_touch
# 	set_lib_cell_purpose -include none [get_lib_cells $CTS_ONLY_LIB_CELL_PATTERN_LIST]
# 	set_lib_cell_purpose -include cts [get_lib_cells $CTS_ONLY_LIB_CELL_PATTERN_LIST]
# }

redirect -file ${REPORTS_DIR}/settings.common.cts.report_lib_cell_purpose.rpt {report_lib_cell -objects [get_lib_cells] -column {full_name:20 valid_purposes}}

# Set CTS dont touch cells	
if {$CTS_DONT_TOUCH_CELL_LIST != ""} {set_dont_touch $CTS_DONT_TOUCH_CELL_LIST true}

# Set CTS dont buffer nets	
if {$CTS_DONT_BUFFER_NET_LIST != ""} {set_dont_touch [get_nets -segments $CTS_DONT_BUFFER_NET_LIST] true}

# set CTS size only cells
if {$CTS_SIZE_ONLY_CELL_LIST != ""} {set_size_only $CTS_SIZE_ONLY_CELL_LIST true}

####################################
## CTS cell spacing 
####################################
# Apply placement based cell to cell spacing rule to avoid EM problem on P/G rails.
# This rule will be applied to the clock buffers/inverters, the clock gating cells only.
#	Example : set_clock_cell_spacing -x_spacing 0.9 -y_spacing 0.4 -lib_cells mylib/BUFFD2BWP

####################################
## CTS hierarchy preservation 
####################################
# To prevent CTS from punching new logical ports for logical hierarchies
#	Example : set_freeze_ports -clocks [get_cells {block1}]

puts "RM-info : Completed script [info script]\n"
