puts "RM-info: Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.common.opt.tcl
# Purpose: Common optimization related settings applicable to multiple steps across the flow. Only sourced in place_opt.tcl.
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## PPA - Performance focused features
####################################
## Controls the timing optimization effort in preroute flows
if {$PREROUTE_TIMING_OPTIMIZATION_EFFORT_HIGH == "qor" || $PREROUTE_TIMING_OPTIMIZATION_EFFORT_HIGH == "true"} {
	set_app_options -name opt.timing.effort -value high ;# default low
} elseif {$PREROUTE_TIMING_OPTIMIZATION_EFFORT_HIGH == "ttr" || $PREROUTE_TIMING_OPTIMIZATION_EFFORT_HIGH == "false"} {
	set_app_options -name opt.timing.effort -value low ;# default low
}

## Layer optimization : 
#  Preroute flows will run automatic layer optimization that assigns long timing critical nets to 
#  upper metal layers to improve timing; 
#  Supported in final_opt stage rebuffering of place_opt and final path_opt stage of refine_opt
if {$PREROUTE_LAYER_OPTIMIZATION == "qor" || $PREROUTE_LAYER_OPTIMIZATION == "true"} {
	set_app_options -name place_opt.flow.optimize_layers -value true ;# default false
	set_app_options -name refine_opt.flow.optimize_layers -value true ;# default false
	#set_app_options -name clock_opt.flow.optimize_layers -value auto ;# default is already auto
	if {$PREROUTE_LAYER_OPTIMIZATION_CRITICAL_RANGE != ""} {
		set_app_options -name place_opt.flow.optimize_layers_critical_range -value $PREROUTE_LAYER_OPTIMIZATION_CRITICAL_RANGE ;# default 0.7
		#set_app_options -name refine_opt.flow.optimize_layers_critical_range -value $PREROUTE_LAYER_OPTIMIZATION_CRITICAL_RANGE ;# default 0.9
		#set_app_options -name clock_opt.flow.optimize_layers_critical_range -value $PREROUTE_LAYER_OPTIMIZATION_CRITICAL_RANGE ;# default 0.5
	}
} elseif {$PREROUTE_LAYER_OPTIMIZATION == "ttr" || $PREROUTE_LAYER_OPTIMIZATION == "false"} {
	set_app_options -name place_opt.flow.optimize_layers -value false ;# default false
	#set_app_options -name refine_opt.flow.optimize_layers -value false ;# default false
	#set_app_options -name clock_opt.flow.optimize_layers -value auto ;# default is already auto
}

if {$PREROUTE_NDR_OPTIMIZATION} {
	set_app_options -name place_opt.flow.optimize_ndr -value true ;# default false 
	set_app_options -name refine_opt.flow.optimize_ndr -value true ;# default false 
	set_app_options -name clock_opt.flow.optimize_ndr -value true ;# default false 
}

if {$OPTIMIZATION_FLOW == "qor"} {
	## Set a soft fanout constraint for optimization of data path cells in place_opt and clock_opt. 
	#  Optimization will try to ensure that cells do not drive more than max_fanout cells.
	#  set_app_options -name opt.common.max_fanout -value 40 ;# default 40
}

####################################
## PPA - Power focused features
####################################
## Set your threshold_voltage_group attributes. For example:
#  	define_user_attribute -type string -class lib_cell threshold_voltage_group
#  	set_attribute -quiet [get_lib_cells -quiet */*LVT] threshold_voltage_group LVt
#  	set_attribute -quiet [get_lib_cells -quiet */*RVT] threshold_voltage_group RVt
#  	set_attribute -quiet [get_lib_cells -quiet */*HVT] threshold_voltage_group HVt

## set_threshold_voltage_group_type is not persistent and should be defined in settings.common.non_persistent.tcl.
#  Listed here for your reference:
#  	set_threshold_voltage_group_type -type low_vt LVt
#  	set_threshold_voltage_group_type -type normal_vt RVt
#  	set_threshold_voltage_group_type -type high_vt HVt

## Enable power optimization for the specified mode
if {$PREROUTE_POWER_OPTIMIZATION_MODE == "leakage"} {
	####################################
	## Leakage Power Optimization
	####################################
	reset_app_options opt.leakage.effort
	set_app_option -name opt.power.mode -value leakage
	if {[regexp {low|medium|high} $PREROUTE_POWER_OPTIMIZATION_EFFORT]} {
	set_app_option -name opt.power.effort -value $PREROUTE_POWER_OPTIMIZATION_EFFORT
	}
	
	## By default, leakage optimization is mW-based. To enable percentage lvth flow, do the following:
	# 	Specifies the maximum percentage of low-threshold-voltage cells.
	# 		set_max_lvth_percentage %
	#	Enable percentage_lvt leakage type
	#		set_app_option -name opt.power.leakage_type -value percentage_lvt ;# default conventional
} elseif {$PREROUTE_POWER_OPTIMIZATION_MODE == "total"} {
	####################################
	## Total Power Optimization
	####################################
	reset_app_options opt.leakage.effort
	set_app_option -name opt.power.mode -value total
	if {[regexp {low|medium|high} $PREROUTE_POWER_OPTIMIZATION_EFFORT]} {
	set_app_option -name opt.power.effort -value $PREROUTE_POWER_OPTIMIZATION_EFFORT
	}
} elseif {$PREROUTE_POWER_OPTIMIZATION_MODE == "none"} {
	reset_app_options opt.leakage.effort
	#set_app_option -name opt.power.mode -value none ;# default is none
}

## Enable Low power placement for place_opt, clock_opt, and refine_opt
if {$PREROUTE_LOW_POWER_PLACEMENT} {
	set_app_options -name place.coarse.low_power_placement -value true ;# default false
}

####################################
## PPA - Area focused features
####################################
## Pin density aware placement for designs with pin access and local density hot spot issues. 
#  Applied to place_opt, refine_opt, and clock_opt.
if {$PREROUTE_PLACEMENT_PIN_DENSITY_AWARE} {
	set_app_options -name place.coarse.pin_density_aware -value true
}

## Control area recovery effort for place_opt, refine_opt, and clock_opt.
if {$PREROUTE_AREA_RECOVERY_EFFORT == "qor"} {
	set_app_options -name opt.area.effort -value medium
} elseif {$PREROUTE_AREA_RECOVERY_EFFORT == "ttr"} {
	set_app_options -name opt.area.effort -value low ;# tool default
} elseif {[regexp {low|medium|high|ultra} $PREROUTE_AREA_RECOVERY_EFFORT]} {
	set_app_options -name opt.area.effort -value $PREROUTE_AREA_RECOVERY_EFFORT
}

## Sets the effort level for reducing buffer area usage in data path optimization.
#  Note that QoR degradation can occur when you set it to higher levels.
if {[regexp {low|medium|high|ultra} $PREROUTE_BUFFER_AREA_EFFORT]} {
	set_app_options -name opt.common.buffer_area_effort -value $PREROUTE_BUFFER_AREA_EFFORT
}


## Enable channel detect mode in coarse placement
if {$PREROUTE_PLACEMENT_DETECT_CHANNEL} {
	set_app_options -name place.coarse.channel_detect_mode -value true ;# default false
}

## Enable detour detection during coarse placement 
if {$PREROUTE_PLACEMENT_DETECT_DETOUR} {
	set_app_options -name place.coarse.detect_detours -value true ;# default false
}

## Change the maximum density for the coarse placement engine
#  The coarse placer attempts to limit local density to less than this setting. 
#  Default value of 0 indicates that the placer will try to spread cells evenly.
if {$PREROUTE_PLACEMENT_MAX_DENSITY != ""} {
	set_app_options -name place.coarse.max_density -value $PREROUTE_PLACEMENT_MAX_DENSITY ;# default 0
}

## Controls the target routing density for congestion-driven placement
if {$PREROUTE_PLACEMENT_TARGET_ROUTING_DENSITY != ""} {
	set_app_options -name place.coarse.target_routing_density -value $PREROUTE_PLACEMENT_TARGET_ROUTING_DENSITY ;# default 0.8
}

####################################
## Lib cell usage restrictions (set_lib_cell_purpose)
####################################
suppress_message ATTR-11

## Excluded lib cells
#  Pls provide your excluded lib cell constraints through "set_lib_cell_purpose -exclude <purpose>" commands

## Tie cells 
if {$TIE_LIB_CELL_PATTERN_LIST != ""} {
	set_dont_touch [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST] false
	set_lib_cell_purpose -include optimization [get_lib_cells $TIE_LIB_CELL_PATTERN_LIST]
}

## Hold time fixing cells 
if {$HOLD_FIX_LIB_CELL_PATTERN_LIST != ""} {
	set_dont_touch [get_lib_cells $HOLD_FIX_LIB_CELL_PATTERN_LIST] false
	set_lib_cell_purpose -exclude hold [get_lib_cells */*]
	set_lib_cell_purpose -include hold [get_lib_cells $HOLD_FIX_LIB_CELL_PATTERN_LIST]
}

## CTS cells 
#	Please make sure you include always-on cells for MV-CTS, clock gate cells (for sizing),
#	and equivalent gates for other types of pre-existing clock cells such as muxes (for sizing).
#	You should also include flops (CCD can size them for timing improvement) in the list.
#	Here's an example if you want to include flops that are already available to optimization :
#	set_lib_cell_purpose -include cts [get_lib_cells */SDFF* -filter "valid_purposes=~*optimization*"]		 
if {$CTS_LIB_CELL_PATTERN_LIST != "" || $CTS_ONLY_LIB_CELL_PATTERN_LIST != ""} {
	set_lib_cell_purpose -exclude cts [get_lib_cells */*]
}

if {$CTS_LIB_CELL_PATTERN_LIST != ""} {
	set_dont_touch [get_lib_cells $CTS_LIB_CELL_PATTERN_LIST] false ;# In ICC-II, CTS respects dont_touch
	set_lib_cell_purpose -include cts [get_lib_cells $CTS_LIB_CELL_PATTERN_LIST]
} 

## CTS-exclusive cells
#	These are the lib cells to be used by CTS exclusively, such as CTS specific buffers and inverters.
#	Please be aware that these cells will be applied with only cts purpose and nothing else.
#	If you want to use these lib cells for other purposes, such as optimization and hold,
#	specify them in CTS_LIB_CELL_PATTERN_LIST instead.
if {$CTS_ONLY_LIB_CELL_PATTERN_LIST != ""} {
	set_dont_touch [get_lib_cells $CTS_ONLY_LIB_CELL_PATTERN_LIST] false ;# In ICC-II, CTS respects dont_touch
	set_lib_cell_purpose -include none [get_lib_cells $CTS_ONLY_LIB_CELL_PATTERN_LIST]
	set_lib_cell_purpose -include cts [get_lib_cells $CTS_ONLY_LIB_CELL_PATTERN_LIST]
}

redirect -file ${REPORTS_DIR}/report_lib_cell_purpose.rpt {report_lib_cell -objects [get_lib_cells] -column {full_name:20 valid_purposes}}

####################################
## Other settings which impact pre-route optimizations
####################################
## Ensures no Verilog assigns in the output netlist of place_opt by buffering such nets
#  if they exist in the input Verilog and avoiding punching ports during optimization
set_app_options -name opt.port.eliminate_verilog_assign -value true ;# default false

## Disable DFT optimization
# 	set_app_options -name opt.dft.optimize_scan_chain -value false ;# default true


## Specify how densely the tool can pack cells in uncongested regions to remove congestion incongested regions.
#  Set this variable based on how much placeable area is needed.
#	set_app_options -name place.coarse.congestion_driven_max_util -value <value> ;# default 0.93

## Soft blockage enhancement : prevent incremental coarse placer from moving cells out of soft blockages
#	set_app_options -name place.coarse.enable_enhanced_soft_blockages -value true

## Non-Clock NDR is defined in settings.common.routing.tcl; commented out here for reference
#  if {[file exists [which $TCL_NON_CLOCK_NDR_RULES_FILE]]} {
#  	puts "RM-info: Sourcing [which $TCL_NON_CLOCK_NDR_RULES_FILE]"
#  	source $TCL_NON_CLOCK_NDR_RULES_FILE
#  } elseif {$TCL_NON_CLOCK_NDR_RULES_FILE != ""} {
#    puts "RM-error: TCL_NON_CLOCK_NDR_RULES_FILE ($TCL_NON_CLOCK_NDR_RULES_FILE) is specified but doesn't exist"
#  }

puts "RM-info: Completed script [info script]\n"
