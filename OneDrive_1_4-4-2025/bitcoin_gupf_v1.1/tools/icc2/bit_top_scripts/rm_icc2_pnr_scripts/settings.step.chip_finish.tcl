puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.step.chip_finish.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## signoff_create_metal_fill settings
####################################
if {$CHIP_FINISH_CREATE_METAL_FILL} {

## Optionally set run directory
if {$CHIP_FINISH_CREATE_METAL_FILL_RUNDIR != ""} {set_app_options -name signoff.create_metal_fill.run_dir -value $CHIP_FINISH_CREATE_METAL_FILL_RUNDIR}

## Runset (not required for track-based metal fill)
if {[file exists $CHIP_FINISH_CREATE_METAL_FILL_RUNSET]} {set_app_options -name signoff.create_metal_fill.runset -value $CHIP_FINISH_CREATE_METAL_FILL_RUNSET}

set_app_options -name signoff.create_metal_fill.flat -value true ;# default false

## Timing driven metal fill related settings
if {$CHIP_FINISH_CREATE_METAL_FILL_TIMING_DRIVEN_THRESHOLD != ""} {
# Extraction options
set_extraction_options -real_metalfill_extraction none

# Optional app options to block fill creation on critical nets. Below are examples.
# 	set_app_options -name signoff.create_metal_fill.space_to_nets -value {{M1 4x} {M2 4x} ...}
# 	set_app_options -name signoff.create_metal_fill.space_to_clock_nets -value {{M1 5x} {M2 5x} ...}
# 	set_app_options -name signoff.create_metal_fill.space_to_nets_on_adjacent_layer -value {{M1 3x} {M2 3x} ...}
# 	set_app_options -name signoff.create_metal_fill.fix_density_error -value true
# 	set_app_options -name signoff.create_metal_fill.apply_nondefault_rules -value true
}

}

####################################
## PPA - Performance focused features
####################################
if {$CCD_FLOW == "qor" || $CCD_FLOW == "true"} {
## Uncomment to enable route_opt CCD
	# set_app_options -name route_opt.flow.enable_ccd -value true ;# default false; global-scoped and needs to be re-applied in a new session
}

####################################
## PPA - Power focused features
####################################
## Uncomment to enable leakage optimization during route_opt
if {$ROUTE_OPT_LEAKAGE_POWER_OPTIMIZATION} {
	# set_app_options -name route_opt.flow.enable_power -value true ;# default false; global-scoped and needs to be re-applied in a new session
}

####################################
## CTO
####################################
## Uncomment to enable route_opt CTO
if {$ROUTE_OPT_CTO} {
	# set_app_options -name route_opt.flow.enable_cto -value true ;# default false; global-scoped and needs to be re-applied in a new session
}

puts "RM-info : Completed script [info script]\n"
