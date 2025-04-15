puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.step.signoff_drc.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## signoff_check_drc settings
####################################
## Runset
set_app_options -name signoff.check_drc.runset -value $SIGNOFF_DRC_RUNSET

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
#  Note : this feature is only for non-CCD flow.
if {$ROUTE_OPT_CTO} {
	# set_app_options -name route_opt.flow.enable_cto -value true ;# default false; global-scoped and needs to be re-applied in a new session
}

puts "RM-info : Completed script [info script]\n"
