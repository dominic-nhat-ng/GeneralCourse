puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.step.clock_opt_cts.tcl
# Purpose: Settings recommended to be enabled at the start of clock_opt_cts
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## PPA - Performance focused features
####################################
# CCD flow
if {$CCD_FLOW == "qor" || $CCD_FLOW == "true"} {
	set_app_options -name clock_opt.flow.enable_ccd -value true ;# default false
# Non-CCD flow
} elseif {$CCD_FLOW == "ttr" || $CCD_FLOW == "false"} {
	set_app_options -name clock_opt.flow.enable_ccd -value false ;# default false

	## CCD flow by default enables local skew CTS/CTO under the hood.
	## For non-CCD flow, to improve local skew of timing critical register pairs,
	#  uncomment the following to enable local skew optimization during CTS and CTO:
	#	set_app_options -name cts.compile.enable_local_skew -value true
	#	set_app_options -name cts.optimize.enable_local_skew -value true
}

####################################
## Congestion
####################################
## CTS global route for congestion estimation and congestion-aware path finder; 
#  applies to clock_opt build_clock phase
if {$CTS_ENABLE_GLOBAL_ROUTE} {
	set_app_options -name cts.compile.enable_global_route -value true ;# default false
}

## Congestion effort high for clock_opt final_opto phase
if {$CLOCK_OPT_OPTO_CONGESTION_EFFORT_HIGH} { 
	set_app_options -name clock_opt.congestion.effort -value high ;# default medium
}

## Coarse placement effort high for clock_opt final_opto phase
if {$CLOCK_OPT_OPTO_PLACE_EFFORT_HIGH} {
	set_app_options -name clock_opt.place.effort -value high ;# default medium 
}

puts "RM-info : Completed script [info script]\n"
