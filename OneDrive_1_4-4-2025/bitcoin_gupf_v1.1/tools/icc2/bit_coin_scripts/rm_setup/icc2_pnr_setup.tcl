puts "RM-info : Running script [info script]\n"
##########################################################################################
# Tool: IC Compiler II
# Script: icc2_flat_setup.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_common_setup.tcl 

########################################################################################## 
## Variables for design inputs (used by init_design.tcl)
##########################################################################################
set INIT_DESIGN_INPUT "DP_RM_NDM"	;# Specify one of the 3 available options: ASCII | DC_ASCII | DP_RM_NDM; default is ASCII.
				;# 1.ASCII: assumes all design input files are ASCII and will read them in individually.
				;# 2.DC_ASCII: should be used when transferring a design from DC using the write_icc2_files command;
				;#   sources ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl;
			      	;#   you can change the default of DC_RESULTS_DIR and DCRM_FINAL_DESIGN_ICC2 below.  
			      	;# 3.DP_RM_NDM: if ICC2-DP-RM is completed, you can take its NDM outputs and skip the design creation steps;
				;#   for PNR flat (DESIGN_STYLE set to flat), script copies the design library from ICC2-DP-RM release 
				;#   area (specified by RELEASE_DIR_DP) and opens design;    
				;#   for PNR hier flow (DESIGN_STYLE set to hier), script will either copy design library 
				;#   from ICC2-DP-RM release area or in addtion to that, copy design library of the child blocks from PNR
				;#   release area (specified by RELEASE_DIR_PNR), and then open design.    
set DCRM_RESULTS_DIR  "./results" 	;# Used by DC_ASCII to specify DC-RM output directory. Default is results.   
set DCRM_FINAL_DESIGN_ICC2 "ICC2_files" ;# Used by DC_ASCII to specify the output directory generated from DC-RM's write_icc2_files command.
                                        ;# The directory contains verilog, floorplan, scenario settings, and constraints from DC
                                        ;# in a format that IC Compiler II can source.

set OCVM_CORNER_TABLE_MAPPING_LIST ""	;# Specify a list of corners and their associated AOCV tables, as AOCV is corner dependant.
					;# Example : "corner1 table1 corner2 table2 corner3 table3" (specify a corner first followed by its table)
					;# In the example, table1 is for corner1, table2 is for corner2, and vice versa.

set TCL_PAD_CONSTRAINTS_FILE	""	;# A Tcl script for your pad constraint commands used by place_io of 
					;# init_design_flat_design_planning_example.tcl sourced by init_design.tcl

set TCL_MV_SETUP_FILE		""	;# A Tcl script placeholder for your MV setup commands,such as create_voltage_area, 
					;# placement bound, power switch creation and level shifter insertion, etc   
set TCL_PG_CREATION_FILE	""	;# A Tcl script placeholder for your power ground network creation commands, 
					;# such as create_pg*, set_pg_strategy, compile_pg, etc
set CREATE_IO_PATH_GROUPS	true	;# Set enable_io_path_groups to true to create input to reg, reg to output, and input to output path groups 

set TCL_FLOORPLAN_FILE		""	;# A supplementary TCl floorplan constraint file; for example, if DEF_FLOORPLAN_FILES is provided
					;# but can not cover certain floorplan constraints, then they can be included here, 
					;# such as bounds, pin guides, or route guides, etc  
set TCL_USER_INIT_DESIGN_POST_SCRIPT "" 	;# An optional Tcl file to be sourced at the very end of init_design.tcl before save_block.

########################################################################################## 
## Variables for ICC2 settings used across stages (such as but not limited to settings.common.opt.tcl)
##########################################################################################
set OPTIMIZATION_FLOW "ttr"		;# Default qor; choose between qor and ttr (lower case);
					;# qor enables additional performance oriented features across the scripts for QOR improvement 
					;# and is  more run time intensive than ttr, while ttr can be used for initial pipe-cleaning.
					;# Pls refer to release note or app note for full list of QOR specific features.

set PREROUTE_POWER_OPTIMIZATION_MODE	"none"
					;# Default leakage; leakage|total|none; sets opt.power.mode to the specified type
set PREROUTE_POWER_OPTIMIZATION_EFFORT	"medium"
					;# Default medium; low|medium|high; sets opt.power.effort to the specified effort
set PREROUTE_LOW_POWER_PLACEMENT false	;# Default false; enables low power placement in preroute flows;
					;# if true, sets place.coarse.low_power_placement to true.

set PREROUTE_TIMING_OPTIMIZATION_EFFORT_HIGH $OPTIMIZATION_FLOW 
				;# If enabled, set timing opto effort to high in preroute. Allowed values : $OPTIMIZATION_FLOW | true | false;
				;# RM Default value is determined by value of $OPTIMIZATION_FLOW;
				;# If OPTIMIZATION_FLOW is set to qor, it is enabled;
				;# if OPTIMIZATION_FLOW is set to ttr, it is disabled;
				;# You can also manually overwrite it by setting it to true or false
set PREROUTE_LAYER_OPTIMIZATION $OPTIMIZATION_FLOW
				;# If enabled, set place_opt/refine_opt/clock_opt.flow.optimize_layers to true. 
				;# Allowed values : $OPTIMIZATION_FLOW | true | false;
				;# RM Default is determined by value of $OPTIMIZATION_FLOW;
				;# If OPTIMIZATION_FLOW is set to qor, it is enabled;
				;# if OPTIMIZATION_FLOW is set to ttr, it is disabled;
				;# You can also manually overwrite it by setting it to true or false
set PREROUTE_LAYER_OPTIMIZATION_CRITICAL_RANGE	"" ;# Specify a float between 0 and 1; default is not specified and tool default remains;
						   ;# sets place_opt.flow.optimize_layers_critical_range to the specified value
set PREROUTE_NDR_OPTIMIZATION false	;# Default false; enables NDR optimization
					;# if true, sets place_opt/clock_opt/refine_opt.flow.optimize_ndrs to true	

set PREROUTE_AREA_RECOVERY_EFFORT $OPTIMIZATION_FLOW
				;# Sets app option opt.area.effort to desired value. 
				;# Allowed values : $OPTIMIZATION_FLOW | low | medium | high | ultra;
				;# RM Default is determined by value of $OPTIMIZATION_FLOW;
				;# If OPTIMIZATION_FLOW is set to qor, it is set to medium; if set to ttr, it is set to low
				;# You can also manually overwrite it by setting it to low | medium | high | ultra
set PREROUTE_BUFFER_AREA_EFFORT ""	;# Default is not specified and tool default (low) remains; 
					;# specify low|medium|high|ultra to set app option opt.common.buffer_area_effort accordingly.
set PREROUTE_PLACEMENT_PIN_DENSITY_AWARE false	;# Default false; enables pin density aware placement by setting place.coarse.pin_density_aware to true
set PREROUTE_PLACEMENT_DETECT_CHANNEL false	;# Default false; enables channel detect mode by setting place.coarse.channel_detect_mode to true 
set PREROUTE_PLACEMENT_DETECT_DETOUR false	;# Default false; enables detour detection by setting place.coarse.detect_detours to true 
set PREROUTE_PLACEMENT_MAX_DENSITY ""		;# Default empty; sets max density by setting place.coarse.max_density to specified value
						;# if not set, RM won't apply the setting and ICC2 default remains, which is 0 
set PREROUTE_PLACEMENT_TARGET_ROUTING_DENSITY "" 
						;# Default empty; sets target routing density by setting place.coarse.target_routing_density to specified value
						;# if not set, RM won't apply the setting and ICC2 default remains, which is 0.8

set TIE_LIB_CELL_PATTERN_LIST ""	;# A list of TIE lib cell patterns to be included for optimization;
					;# Example : set TIE_LIB_CELL_PATTERN_LIST "*/TIE* */ttt*"
set HOLD_FIX_LIB_CELL_PATTERN_LIST ""	;# A list of hold time fixing lib cell patterns to be included only for hold
set TCL_PLACEMENT_SPACING_LABEL_RULE_FILE ""
					;# A file to specify your placement spacing label and rules.
					;# Spacing labels and rules are not persistent and must be sourced in each ICC-II session.
					;# This file will be sourced in each stage of the flat RM flow.
set TCL_NON_CLOCK_NDR_RULES_FILE ""	;# Specify a NDR rules file for signal nets; sourced in settings.common.opt.tcl

set TCL_USER_CONNECT_PG_NET_SCRIPT ""	;# An optional Tcl file for customized connect_pg_net command and options, such as for bias pins of cells added by opto;
					;# sourced by all the main scripts prior to the save_block command

########################################################################################## 
## Variables for placement and place_opt related settings (used by place_opt.tcl and settings.step.place_opt.tcl)
##########################################################################################
set PLACE_OPT_ACTIVE_SCENARIO_LIST	"" ;# A subset of scenarios to be made active during place_opt step.
set PLACE_OPT_USER_INSTANCE_NAME_PREFIX "" ;# Specify the prefix for new cells created by place_opt; default "" which means no user prefix 
set TCL_USER_PLACE_OPT_PRE_SCRIPT 	"" ;# An optional Tcl file for place_opt.tcl to be sourced before place_opt.
set TCL_USER_PLACE_OPT_SCRIPT 		"" ;# An optional Tcl file for place_opt.tcl to replace pre-existing place_opt commands.
set TCL_USER_PLACE_OPT_POST_SCRIPT 	"" ;# An optional Tcl file for place_opt.tcl to be sourced after place_opt.

set PLACE_OPT_SPG_FLOW		false	;# Default false; enable SPG input handling in place_opt.tcl
set PLACE_OPT_REFINE_OPT	"none"	;# Default none; set it to refine_opt to run refine_opt;
					;# set it to path_opt to run only "refine_opt -from final_path_opt";
					;# set it to power to run refine_opt with refine_opt.flow.exclusive set to power;
					;# set it to area to run refine_opt with refine_opt.flow.exclusive set to area;
set PLACE_OPT_REFINE_OPT_USER_INSTANCE_NAME_PREFIX "" ;# Specify the prefix for new cells created by refine_opt; default "" which means no user prefix

set PLACE_OPT_CONGESTION_EFFORT_HIGH	false	;# Default false; sets place_opt.congestion.effort to high (ICC2 default medium)
set PLACE_OPT_GR_BASED_HFSDRC		false	;# Default false; enables GR based HFS DRC fix by setting place_opt.initial_drc.global_route_based to true
set PLACE_OPT_DO_PATH_OPT		false   ;# Default false; if true, sets place_opt.flow.do_path_opt to true 
set PLACE_OPT_FINAL_PLACE_EFFORT_HIGH	false	;# Default false; sets place_opt.final_place.effort to high
set PLACE_OPT_OPTIMIZE_ICGS		false	;# Default false; enables ICG opto in place_opt which sets place_opt.flow.optimize_icgs to true;
						;# place_opt will run automatic ICG optimization that performs trial CTS, timing-aware ICG splitting 
						;# and clock-aware placement for critical enable paths.
						;# settings.common.cts.tcl will be sourced before place_opt, instead of clock_opt, in order to
						;# benefit most from trial CTS with as much CTS-related settings applied as possible. 
						;# The aggressiveness of splitting can be controlled by the PLACE_OPT_OPTIMIZE_ICGS_CRITICAL_RANGE variable. 
set PLACE_OPT_OPTIMIZE_ICGS_CRITICAL_RANGE ""   ;# Default empty; specify a value between 0 and 1; 
						;# sets place_opt.flow.optimize_icgs_critical_range to the value specified; tool default is 0.75.
						;# When set to X, only ICGs enable slack within {EN_WNS, EN_WNS*(1-X)} will be considererd for splitting;
						;# for examplem, 0.75 means only ICG with enable pin violations between 1*EN_WNS and 0.25*EN_WNS will be split,
						;# while the ICG enable slack below 0.25*EN_WNS will be skipped. Larger value means more splitting. 

set PLACE_OPT_ICG_AUTO_BOUND		false	;# Default false; enables placement to use automatic group bounds created for ICGs and sequentials during 
						;# the placement stages; sets place.coarse.icg_auto_bound to true. 
						;# This is an optional feature to be enabled in addition to PLACE_OPT_OPTIMIZE_ICGS.
set PLACE_OPT_TRIAL_CTS			false	;# Default false; enables early clock tree synthesis; sets place_opt.flow.trial_clock_tree to true.
						;# useful for low power placement (PREROUTE_LOW_POWER_PLACEMENT) and ICG optimization flow (PLACE_OPT_OPTIMIZE_ICGS). 
						;# Propagated clocks will be used through-out place_opt flow.
						;# settings.common.cts.tcl will be sourced before place_opt, instead of clock_opt, in order to
						;# benefit most from trial CTS with as much CTS-related settings applied as possible.
						;# Note: when PLACE_OPT_OPTIMIZE_ICGS is set to true, trial CTS will be automatically enabled, 
						;# regardless of the setting of PLACE_OPT_TRIAL_CTS. So you don't have to manually enable it.
set PLACE_OPT_CLOCK_AWARE_PLACEMENT	false	;# Default false; enables placement guided by ICG's enable timing criticality; 
						;# sets place_opt.flow.clock_aware_placement to true. place_opt will try to improve ICG enable timing by placing the 
						;# timing critical ICGs and their fanout cells at better locations for ICG enable paths.
						;# Note: when PLACE_OPT_OPTIMIZE_ICGS is set to true, clock-aware placement will be automatically enabled, 
						;# regardless of the setting of PLACE_OPT_CLOCK_AWARE_PLACEMENT. So you don't have to manually enable it.

set PLACE_OPT_CLOCK_NDR_RULE_NAME	""	;# Clock NDR rule name for place_opt congestion modeling.
						;# If you specify your own rule name, rule needs to be created in a prior step, or specify a script to create it,
						;# through variable TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE. The file will be sourced, and rule gets associated.
						;# If you specify an RM predefined rule, rule will be auto created and then associated.
						;# Below are the 3 predefined rules wich you can use:  
						;# icc2rm_2w2s : double width double spacing 
						;# icc2rm_2w2s_shield_default : double width double spacing + shielding with default width and spacing
						;# icc2rm_2w2s_shield_list : double width double spacing + shielding with customized per layer width and 
						;# spacing which requires PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_WIDTH_LIST or PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_SPACING_LIST
set PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_WIDTH_LIST ""
						;# A list of {layer_name shield_width ...} for $PLACE_OPT_CLOCK_NDR_RULE_NAME; 
						;# required if you specify icc2rm_2w2s_shield_list for for $PLACE_OPT_CLOCK_NDR_RULE_NAME.
set PLACE_OPT_CLOCK_NDR_SHIELDING_LAYER_SPACING_LIST ""
						;# A list of {layer_name shield_spacing ...} for $PLACE_OPT_CLOCK_NDR_RULE_NAME; 
						;# required if you specify icc2rm_2w2s_shield_list for $PLACE_OPT_CLOCK_NDR_RULE_NAME.
set PLACE_OPT_CLOCK_NDR_NET_LIST	""	;# A list of nets for set_routing_rule command which $PLACE_OPT_CLOCK_NDR_RULE_NAME will be applied to.
						;# If not specified, by default, all clock nets will be specified. 
set TCL_PLACE_OPT_CLOCK_NDR_RULE_FILE ""	;# Optionally provide a script for NDR creation if you specify your own NDR rule name for PLACE_OPT_CLOCK_NDR_RULE_NAME
set PLACE_OPT_CLOCK_NDR_MIN_ROUTING_LAYER ""	;# Min clock routing layer for set_routing_rule command which $PLACE_OPT_CLOCK_NDR_RULE_NAME will be applied to. 
set PLACE_OPT_CLOCK_NDR_MAX_ROUTING_LAYER ""	;# Max clock routing layer for set_routing_rule command which $PLACE_OPT_CLOCK_NDR_RULE_NAME will be applied to.

set SAIF_FILE                           ""      ;# Specify a SAIF file for accurate power computation for features such as
                                                ;# PREROUTE_POWER_OPTIMIZATION_MODE total and PREROUTE_LOW_POWER_PLACEMENT.
set SAIF_FILE_POWER_SCENARIO		""	;# SAIF_FILE related; specify a power scenario where the SAIF is to be applied
set SAIF_FILE_SOURCE_INSTANCE		""	;# SAIF_FILE related; name of the instance of the current design as it appears in SAIF file.
set SAIF_FILE_TARGET_INSTANCE		""	;# SAIF_FILE related; name of the target instance on which activity is to be annotated.

########################################################################################## 
## Variables for common CTS related settings (used by settings.common.cts.tcl)
##########################################################################################
set CTS_LIB_CELL_PATTERN_LIST 	"" 	;# List of CTS lib cell patterns to be used by CTS;
					;# Please include repeaters, always-on repeaters (for MV-CTS), 
					;# and gates (for sizing pre-existing gates)/always-on buffers;
					;# Please also include flops as CCD can size flops to improve timing.
				   	;# example : set CTS_LIB_CELL_PATTERN_LIST "*/NBUF* */AOBUF* */AOINV* */SDFF*".

set CTS_ONLY_LIB_CELL_PATTERN_LIST "" 	;# List of CTS lib cell patterns to be used by CTS "exclusively", such as clock specific
					;# buffers and inverters. Please be aware that these cells will be applied with only cts 
					;# purpose and nothing else. If you want to use these lib cells for other purposes, 
					;# such as optimization and hold, specify them in CTS_LIB_CELL_PATTERN_LIST instead.
					
set CTS_DONT_TOUCH_CELL_LIST	""	;# List of clock cell instances that should not be optimized by CTS.
                                  	;# example : set CTS_DONT_TOUCH_CELL_LIST "cellx celly ..."
set CTS_DONT_BUFFER_NET_LIST	""	;# List of clock nets that should not be buffered by CTS.
                                  	;# example : set CTS_DONT_BUFFER_NET_LIST "net1 net2 net3 ..."
set CTS_SIZE_ONLY_CELL_LIST	""	;# List of clock cell instances to be set as size_only for CTS (sizing only).
                                	;# example : set CTS_SIZE_ONLY_CELL_LIST "cellx celly ..."

## The following *CTS_NDR* variables are related to CTS_NDR_RULE_NAME to be applied on root/internal nets
#  They are only effective if CTS_NDR_RULE_NAME is specified

set CTS_NDR_RULE_NAME	"icc2rm_2w2s"	;# Clock NDR rule name for root and internal nets. Specify your own rule name, or the RM predefined rules.
				;# If you specify your own rule name, rule needs to be created in a prior step, or specify a script to create it,
				;# through variable TCL_CTS_NDR_RULE_FILE. The file will be sourced, and rule applied to root and internal nets.
				;# If you specify an RM predefined rule, rule will be auto created and then applied to root and internal nets.
				;# Below are the 3 predefined rules wich you can use:  
				;# icc2rm_2w2s : double width double spacing 
				;# icc2rm_2w2s_shield_default : double width double spacing + shielding with default width and spacing
				;# icc2rm_2w2s_shield_list : double width double spacing + shielding with customized per layer width and 
				;# 			     spacing which requires CTS_NDR_SHIELDING_LAYER_WIDTH_LIST
 
set CTS_NDR_SHIELDING_LAYER_WIDTH_LIST "" ;# A list of {layer_name shield_width ...} for $CTS_NDR_RULE_NAME; 
					;# required if you specify icc2rm_2w2s_shield_list for for $CTS_NDR_RULE_NAME.
set CTS_NDR_SHIELDING_LAYER_SPACING_LIST "" ;# A list of {layer_name shield_spacing ...} for $CTS_NDR_RULE_NAME; 
					;# required if you specify icc2rm_2w2s_shield_list for $CTS_NDR_RULE_NAME.
set TCL_CTS_NDR_RULE_FILE ""	;# Optionally provide a script for NDR creation if you specify your own NDR rule name for CTS_NDR_RULE_NAME
set CTS_NDR_MIN_ROUTING_LAYER	""	;# Min clock routing layer for set_clock_routing_rules command which $CTS_NDR_RULE_NAME will be applied to. 
set CTS_NDR_MAX_ROUTING_LAYER	""	;# Max clock routing layer for set_clock_routing_rules command which $CTS_NDR_RULE_NAME will be applied to.


## The following *CTS_LEAF_NDR* variables are related to CTS_LEAF_NDR_RULE_NAME to be applied to sink nets 
#  They are only effective if CTS_LEAF_NDR_RULE_NAME is specified

set CTS_LEAF_NDR_RULE_NAME ""	;# CLock NDR rule name for leaf nets.
				;# If you specify your own rule name, rule needs to be created in a prior step, or specify a script to create it,
				;# through variable TCL_CTS_LEAF_NDR_RULE_FILE. The file will be sourced, and rule applied to leaf nets.
				;# If you specify an RM predefined rule, rule will be auto created and then applied to root and internal nets. 
				;# icc2rm_leaf is the predefined rule with default reference rule
set TCL_CTS_LEAF_NDR_RULE_FILE "" ;# Optionally specify a script for NDR creation if you specify your own NDR rule name for CTS_LEAF_NDR_RULE_NAME
set CTS_LEAF_NDR_MIN_ROUTING_LAYER $CTS_NDR_MIN_ROUTING_LAYER 
					;# Min routing layer for set_clock_routing_rules command which icc2rm_leaf will be applied to.
set CTS_LEAF_NDR_MAX_ROUTING_LAYER $CTS_NDR_MAX_ROUTING_LAYER 
					;# Max routing layer for set_clock_routing_rules command which icc2rm_leaf will be applied to.

########################################################################################## 
## Variables for clock_opt related settings (used by settings.step.clock_opt_cts.tcl, clock_opt_cts.tcl, and clock_opt_opto.tcl)
##########################################################################################
set CCD_FLOW				$OPTIMIZATION_FLOW
					;# Enables CCD (concurrent clock and data opto) flow in both pre-route (clock_opt_cts and clock_opt_opto steps) and 
					;# post-route (route_opt step);
					;# Allowed values : $OPTIMIZATION_FLOW | true | false;
					;# RM Default is determined by value of $OPTIMIZATION_FLOW;
					;# If OPTIMIZATION_FLOW is set to qor, it is enabled;
					;# if OPTIMIZATION_FLOW is set to ttr, it is disabled;
					;# You can also manually overwrite it by setting it to true or false

set CLOCK_OPT_CTS_ACTIVE_SCENARIO_LIST  "" ;# A subset of scenarios to be made active during clock_opt_cts step.
set CLOCK_OPT_CTS_USER_INSTANCE_NAME_PREFIX "" ;# Specify the prefix for new cells created by clock_opt build_clock; default "" which means no user prefix
set TCL_USER_CLOCK_OPT_CTS_PRE_SCRIPT 	"" ;# An optional Tcl file for clock_opt_cts.tcl to be sourced before clock_opt.
set TCL_USER_CLOCK_OPT_CTS_POST_SCRIPT 	"" ;# An optional Tcl file for clock_opt_cts.tcl to be sourced after clock_opt.
set CTS_ENABLE_GLOBAL_ROUTE false	;# Default false; enables global router in CTS to avoid congestion

set CLOCK_OPT_OPTO_ACTIVE_SCENARIO_LIST "" ;# A subset of scenarios to be made active during clock_opt_opto step.
set CLOCK_OPT_OPTO_USER_INSTANCE_NAME_PREFIX "" ;# Specify the prefix for new cells created by clock_opt final_opto; default "" which means no user prefix
set TCL_USER_CLOCK_OPT_OPTO_PRE_SCRIPT 	"" ;# An optional Tcl file for clock_opt_opto.tcl to be sourced before clock_opt. 
set TCL_USER_CLOCK_OPT_OPTO_POST_SCRIPT "" ;# An optional Tcl file for clock_opt_opto.tcl to be sourced after clock_opt. 

set CLOCK_OPT_OPTO_CONGESTION_EFFORT_HIGH false ;# Default false; enables high congestion effort during clock_opt final_opto phase,
						;# by setting clock_opt.congestion.effort to high
set CLOCK_OPT_OPTO_PLACE_EFFORT_HIGH false 	;# Default false; enables high coarse placement effort during clock_opt final_opto phase,
						;# by setting clock_opt.place.effort to high
set CLOCK_OPT_OPTO_CTO false		;# Default false; enables post-route clock tree optimization in clock_opt_opto.tcl
set CLOCK_OPT_OPTO_CTO_USER_INSTANCE_NAME_PREFIX "" ;# Specify the prefix for new cells created by CTO; default "" which means no user prefix

########################################################################################## 
## Variables for route_auto and route_opt related settings (used by settings.step.route_opt.tcl)
##########################################################################################
set ROUTE_AUTO_ACTIVE_SCENARIO_LIST "" 	;# A subset of scenarios to be made active during route_auto step.
set ROUTE_OPT_ACTIVE_SCENARIO_LIST "" 	;# A subset of scenarios to be made active during route_opt step.
set ROUTE_OPT_USER_INSTANCE_NAME_PREFIX "" 	;# Specify the prefix for new cells created by route_opt; default "" which means no user prefix
set TCL_USER_ROUTE_AUTO_PRE_SCRIPT ""	;# An optional Tcl file for route_auto.tcl to be sourced before route_auto.
set TCL_USER_ROUTE_AUTO_POST_SCRIPT ""	;# An optional Tcl file for route_auto.tcl to be sourced after route_auto.
set TCL_USER_ROUTE_OPT_PRE_SCRIPT ""	;# An optional Tcl file for route_opt.tcl to be sourced before route_opt.
set TCL_USER_ROUTE_OPT_SCRIPT "" 	;# An optional Tcl file for route_opt.tcl to replace pre-existing route_opt commands.
set TCL_USER_ROUTE_OPT_POST_SCRIPT ""	;# An optional Tcl file for route_opt.tcl to be sourced after route_opt.

set ROUTE_AUTO_ANTENNA_FIXING	false	;# Default false; set true to enable route.detail.hop_layers_to_fix_antenna
					;# and to source TCL_ANTENNA_RULE_FILE in route_auto.tcl to fix Antenna violations.
set TCL_ANTENNA_RULE_FILE	""	;# Antenna rule file; required if ROUTE_AUTO_ANTENNA_FIXING is set to true.

set REDUNDANT_VIA_INSERTION	false	;# Default false; enables redundant via insertion for post-route;
					;# if you choose ESTABLISHED for TECHNOLOGY_NODE on RMgen download page,
					;# the scripts are set up to run concurrent redundant via insertion during route_auto and route_opt
					;# otherwise, the scripts are set up to reserve space and run standalone add_redundant_vias command 
					;# after route_auto and route_opt  
set TCL_USER_REDUNDANT_VIA_MAPPING_FILE "" ;# ICC-II via mapping file required for redundant via insertion; 
					;# the file should include add_via_mapping commands.   
set TCL_USER_ICC_REDUNDANT_VIA_MAPPING_FILE "" ;# ICC style via mapping file required for redundant via insertion; 
					;# the file should include define_zrt_redundant_vias commands.
					;# This variable is mutually exclusive with TCL_USER_REDUNDANT_VIA_MAPPING_FILE
set ROUTE_AUTO_CREATE_SHIELDS NONE	;# NONE | before_route_auto | after_route_auto: Default is NONE; you can choose to create shields before
					;# or after route_auto; all nets with shielding rules will be shielded	
set ROUTE_OPT_RESHIELD after_route_opt	;# NONE | after_route_opt | incremental; default is after_route_opt; 
					;# set after_route_opt to reshield nets after route_opt is done with create_shield command; 
					;# set incremental to trigger reshield during all route_opt eco route sessions with an app option; 
					;# note that ROUTE_OPT_RESHIELD only works if ROUTE_AUTO_CREATE_SHIELDS is set to a value other than NONE  

set ROUTE_OPT_LEAKAGE_POWER_OPTIMIZATION true
					;# Default true; enables leakage optimization during route_opt;
					;# if true, sets route_opt.flow.enable_power to true.

set ROUTE_OPT_CTO false			;# Default false; enables post-route clock tree optimization in route_opt.tcl
set ROUTE_OPT_CTO_USER_INSTANCE_NAME_PREFIX "" ;# Specify the prefix for new cells created by CTO; default "" which means no user prefix

########################################################################################## 
## Variables for signoff DRC related settings (used by signoff_drc.tcl and settings.step.signoff_drc.tcl)
##########################################################################################
set SIGNOFF_DRC_ACTIVE_SCENARIO_LIST ""	;# A subset of scenarios to be made active during chip_finish step.
set TCL_USER_SIGNOFF_DRC_PRE_SCRIPT ""	;# An optional Tcl file for chip_finish.tcl to be sourced before signoff_check_drc.
set TCL_USER_SIGNOFF_DRC_POST_SCRIPT ""	;# An optional Tcl file for chip_finish.tcl to be sourced after second signoff_check_drc.

set SIGNOFF_DRC_RUNSET ""		;# The foundry runset for ICV used by signoff_check_drc and signoff_fix_drc.
set SIGNOFF_DRC_ADR true		;# true|false; true enables signoff_fix_drc in addition to signoff_check_drc; default is true
set SIGNOFF_DRC_DPT_RULES ""		;# Specifcy your DPT rules for signoff_fix_drc fixing; only takes effect if SIGNOFF_DRC_ADR is true
					;# if specified, signoff_fix_drc -select_rules $SIGNOFF_DRC_DPT_RULES is used instead of signoff_fix_drc 

## Working directories for signoff_check_drc and signoff_fix_drc
set SIGNOFF_DRC_RUNDIR_BEFORE_ADR "z_ADR_before" 
					;# The working directory for signoff_check_drc before signoff_fix_drc;
					;# The directory that contains the initial DRC error database for signoff_fix_drc. 
set SIGNOFF_DRC_RUNDIR_ADR "z_ADR"	;# The working directory for signoff_fix_drc; only takes effect if SIGNOFF_DRC_ADR is true
set SIGNOFF_DRC_RUNDIR_AFTER_ADR "z_ADR_after"	
					;# The working directory for signoff_check_drc after signoff_fix_drc is done; 
					;# only takes effect if SIGNOFF_DRC_ADR is true 

########################################################################################## 
## Variables for chip finishing related settings (used by chip_finish.tcl and settings.step.chip_finish.tcl)
##########################################################################################
set CHIP_FINISH_ACTIVE_SCENARIO_LIST ""	;# A subset of scenarios to be made active during chip_finish step.
set TCL_USER_CHIP_FINISH_PRE_SCRIPT ""	;# An optional Tcl file for chip_finish.tcl to be sourced before filler cell insertion.
set TCL_USER_CHIP_FINISH_POST_SCRIPT ""	;# An optional Tcl file for chip_finish.tcl to be sourced after metal fill insertion.

# Std cell filler and decap cells
set CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST ""	;# A list of metal filler (decap) lib cells, including the library name, for ex, 
						;# Example: "hvt/DCAP_HVT lvt/DCAP_LVT". Recommended to specify decaps from large to small.
set CHIP_FINISH_METAL_FILLER_PREFIX ""	;# Optional prefix for metal filler (decap) cells.

set CHIP_FINISH_NON_METAL_FILLER_LIB_CELL_LIST "" ;# A list of non-metal filler lib cells, including the library name, for ex,
                                                  ;# Example: hvt/FILL_HVT lvt/FILL_LVT
						  ;# Recommanded to specify them from the largest to smallest especially with advanced rules
set CHIP_FINISH_NON_METAL_FILLER_PREFIX $CHIP_FINISH_METAL_FILLER_PREFIX ;# Optional prefix for non-metal fillers.

# Metal fill
set CHIP_FINISH_CREATE_METAL_FILL false		;# Default false; set it to true to enable the metal fill creation feature.
set CHIP_FINISH_CREATE_METAL_FILL_RUNDIR "z_icvFill" ;# The working directory for signoff_create_metal_fill. Optional. Default is z_icvFill.
set CHIP_FINISH_CREATE_METAL_FILL_TIMING_DRIVEN_THRESHOLD "" ;# Specify the threshold for timing-driven metal fill.
						     ;# If not specified, timing-driven is not enabled.
						     ;# If specified, "-timing_preserve_setup_slack_threshold" option is added.

set CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED "off"  ;# off | <a technology node> | generic; used for -track_fill option of signoff_create_metal_fill
						     ;# for non-track-based : specify off 
						     ;# for track-based : specify either a node (refer to man page) or generic 
set CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED_PARAMETER_FILE "auto" ;# auto | <a parameter file>; default is auto;
						     ;# this variable is only for track-based metal fill;
						     ;# specify auto to use ICC-II auto generated track_fill_params.rh file or your own paramter file.
set CHIP_FINISH_CREATE_METAL_FILL_RUNSET ""	;# Specify the foundry runset for signoff_create_metal_fill command.
						;# required only for non-track-based (CHIP_FINISH_CREATE_METAL_FILL_TRACK_BASED set to off).
set CHIP_FINISH_SIGNOFF_DRC_RUNDIR_AFTER_METAL_FILL "z_MFILL_after" 
						;# The working directory for signoff_check_drc after signoff_create_metal_fill is completed;
						;# only takes effect if CHIP_FINISH_CREATE_METAL_FILL is true
# Signal EM
set CHIP_FINISH_EM_ITF_CONSTRAINT_FILE "" 	;# An ITF file which contains only signal electromigration constraints.
						;# If specified, the signal EM analysis is enabled.
set CHIP_FINISH_EM_SAIF "" 			;# An optional SAIF file for the signal EM analysis. 

########################################################################################## 
## Variables for PT ECO related settings (used by pt_eco.tcl)
##########################################################################################
set PT_ECO_ACTIVE_SCENARIO_LIST "" 	;# A subset of scenarios to be made active during pt_eco step.
set TCL_USER_PT_ECO_PRE_SCRIPT 0  	;# An optional Tcl file for pt_eco.tcl to be sourced before sourcing of PT_ECO_CHANGE_LIST.
set TCL_USER_PT_ECO_POST_SCRIPT "" 	;# An optional Tcl file for pt_eco.tcl to be sourced after route_eco.

set PT_ECO_CHANGE_FILE "../signoff_data/results/pt_eco_file.tcl"		;# ECO guidance file produced by PT-SI write_changes -format icc2tcl or icctcl.
set PT_ECO_DISPLACEMENT_THRESHOLD "10"	;# Float. Specify the maximum displacement threshold value for 
					;# place_eco_cells -legalize_mode minimum_physical_impact -displacement_threshold    	

########################################################################################## 
## Variables for settings related to write data (used by write_data.tcl)
##########################################################################################
set WRITE_GDS_LAYER_MAP_FILE ""				;# A layer map file provides a mapping between the tool and GDS layers;

##########################################################################################
## Miscellaneous Variables
##########################################################################################
set search_path [list . ./scripts ./rm_icc2_pnr_scripts ./rm_setup ../bit_slice ../signoff_data/results ]
lappend search_path .

set_host_options -max_cores 8 

set sh_continue_on_error true

##########################################################################################
## System Variables (there's no need to change the following)
##########################################################################################
set USE_RM_BLOCK_NAME_AS_LABEL true	;# Specify whether to use RM block name variable as label;
					;# If true, saved name for place_opt.tcl would be ${DESIGN_NAME}/${PLACE_OPT_BLOCK_NAME},
					;# where $PLACE_OPT_BLOCK_NAME becomes the label name of the design while $DESIGN_NAME is
					;# the block name; If false, block name is $PLACE_OPT_BLOCK_NAME without label name.
					;# Note: Hierarchical PNR implementation flow (DESIGN_STYLE set to hier in icc2_common_setup.tcl) 
					;# will not work without user labels being used.
## Block names used by save_block in each of the step
if {$USE_RM_BLOCK_NAME_AS_LABEL} {

# If label is used, the following will be used as label name while $DESIGN_NAME is the block name
set INIT_DESIGN_BLOCK_NAME init_design		;# Name of the block to be saved for init_design.tcl
set PLACE_OPT_BLOCK_NAME place_opt		;# Name of the block to be saved for place_opt.tcl
set CLOCK_OPT_CTS_BLOCK_NAME clock_opt_cts	;# Name of the block to be saved for clock_opt_cts.tcl
set CLOCK_OPT_OPTO_BLOCK_NAME clock_opt_opto	;# Name of the block to be saved for clock_opt_opto.tcl
set ROUTE_AUTO_BLOCK_NAME route_auto		;# Name of the block to be saved for route_auto.tcl
set ROUTE_OPT_BLOCK_NAME route_opt		;# Name of the block to be saved for route_opt.tcl
set SIGNOFF_DRC_BLOCK_NAME signoff_drc 		;# Name of the block to be saved for signoff_drc.tcl
set CHIP_FINISH_BLOCK_NAME chip_finish		;# Name of the block to be saved for chip_finish.tcl
set PT_ECO_BLOCK_NAME pt_eco			;# Name of the block to be saved for pt_eco.tcl

} else {

# If label is not used, $DESIGN_NAME is added as prefix of the block name; 
# this helps avoid duplicate names among different blocks   
set INIT_DESIGN_BLOCK_NAME ${DESIGN_NAME}_init_design		;# Name of the block to be saved for init_design.tcl
set PLACE_OPT_BLOCK_NAME ${DESIGN_NAME}_place_opt		;# Name of the block to be saved for place_opt.tcl
set CLOCK_OPT_CTS_BLOCK_NAME ${DESIGN_NAME}_clock_opt_cts	;# Name of the block to be saved for clock_opt_cts.tcl
set CLOCK_OPT_OPTO_BLOCK_NAME ${DESIGN_NAME}_clock_opt_opto	;# Name of the block to be saved for clock_opt_opto.tcl
set ROUTE_AUTO_BLOCK_NAME ${DESIGN_NAME}_route_auto		;# Name of the block to be saved for route_auto.tcl
set ROUTE_OPT_BLOCK_NAME ${DESIGN_NAME}_route_opt		;# Name of the block to be saved for route_opt.tcl
set SIGNOFF_DRC_BLOCK_NAME ${DESIGN_NAME}_signoff_drc 		;# Name of the block to be saved for signoff_drc.tcl
set CHIP_FINISH_BLOCK_NAME ${DESIGN_NAME}_chip_finish		;# Name of the block to be saved for chip_finish.tcl
set PT_ECO_BLOCK_NAME ${DESIGN_NAME}_pt_eco			;# Name of the block to be saved for pt_eco.tcl

}
set PT_ECO_FROM_BLOCK_NAME $ROUTE_OPT_BLOCK_NAME 		;# Name of the starting block name for the pt_eco step
set WRITE_DATA_BLOCK_NAME $CHIP_FINISH_BLOCK_NAME 		;# Name of the starting block for the write_data step

set REPORT_QOR			true	;# Default true; set to false to skip QoR reporting at end of each step
set REPORT_QOR_SCRIPT "report_qor.tcl" 	;# Default is report_qor.tcl; report_qor.tcl | report_qor.nosplit.tcl;
					;# specify report_qor.nosplit.tcl to use reporting commands with -nosplit options.
set REPORT_QOR_REPORT_POWER	false	;# Default false; set to true to enable report_power during QoR reporting

## Directories
set OUTPUTS_DIR	"./outputs_icc2"	;# Directory to write output data files; mainly used by write_data.tcl
set REPORTS_DIR	"./rpts_icc2"		;# Directory to write reports; mainly used by report_qor.tcl

if !{[file exists $OUTPUTS_DIR]} {file mkdir $OUTPUTS_DIR}
if !{[file exists $REPORTS_DIR]} {file mkdir $REPORTS_DIR}

##########################################################################################
## Hierarchical PNR Variables (used by hierarchical PNR implementation)
##########################################################################################
# For designs where the blocks are bound to abstracts
set SUB_BLOCK_REFS                   	[list bit_top bit_slice] ;# Design names of the physical blocks in all levels of physical hierarchy
                                                ;# Include the blocks that will be bound to abstracts
set USE_ABSTRACTS_FOR_BLOCKS        	[list bit_top] ;# design names of the physical blocks in the next lower level that will be bound to abstracts

## By default, abstracts created after chip_finish step of lower-level are used to implement the current level
## Update the following variables if you want to use abstracts created after any other step 
set BLOCK_ABSTRACT_FOR_PLACE_OPT 	"$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_PLACE_OPT label for place_opt
set BLOCK_ABSTRACT_FOR_CLOCK_OPT_CTS    "$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_CLOCK_OPT_CTS label for clock_opt_cts
set BLOCK_ABSTRACT_FOR_CLOCK_OPT_OPTO   "$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_CLOCK_OPT_OPTO label for clock_opt_opto
set BLOCK_ABSTRACT_FOR_ROUTE_AUTO       "$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_ROUTE_AUTO label for route_auto
set BLOCK_ABSTRACT_FOR_ROUTE_OPT        "$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_ROUTE_OPT label for route_opt
set BLOCK_ABSTRACT_FOR_SIGNOFF_DRC      "$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_SIGNOFF_DRC label for signoff_drc
set BLOCK_ABSTRACT_FOR_CHIP_FINISH      "$CHIP_FINISH_BLOCK_NAME" ;# Use blocks with $BLOCK_ABSTRACT_FOR_CHIP_FINISH for chip_finish

# For designs, where some of the blocks are bound to ETMs
set USE_ETM_FOR_BLOCKS                  [list ] ;# design names for each physical block that will be bound to ETMs
set ETM_UPF_MAPPING_FILE "" 		;# Specify ETMs UPF mapping file



puts "RM-info: Completed script [info script]\n"

if {$DESIGN_STYLE == "hier" && $USE_RM_BLOCK_NAME_AS_LABEL == "false"} {
	puts "RM-error: DESIGN_STYLE is set to hier in icc2_common_setup.tcl but USE_RM_BLOCK_NAME_AS_LABEL is set to false. Pls correct it!"
	puts "RM-error: DESIGN_STYLE hier implies hierarchical PNR implementation is intended which requires user labels to be used."
	puts "RM-error: Hierarchical PNR implementation flow does not work without user labels."
}
suppress_message {ABS-409 OPT-007 OPT-019}

