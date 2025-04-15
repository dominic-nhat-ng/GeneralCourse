puts "RM-info : Running script [info script]\n"

##########################################################################################
# Script: settings.step.route_opt.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## Timing
####################################
## Enable delay calculation using CCS receiver model during timing analysis
set_app_options -name time.enable_ccs_rcv_cap -value true

####################################
## PPA - Performance focused features
####################################
if {$CCD_FLOW == "qor" || $CCD_FLOW == "true"} {
## Enable route_opt CCD
	set_app_options -name route_opt.flow.enable_ccd -value true ;# default false; global-scoped and needs to be re-applied in a new session
}

####################################
## PPA - Power focused features
####################################
## Enable leakage optimization during route_opt
if {$ROUTE_OPT_LEAKAGE_POWER_OPTIMIZATION} {
	set_app_options -name route_opt.flow.enable_power -value true ;# default false; global-scoped and needs to be re-applied in a new session
}

####################################
## route_opt CTO 
####################################
if {$ROUTE_OPT_CTO} {
	set_app_options -name route_opt.flow.enable_cto -value true ;# default false; global-scoped and needs to be re-applied in a new session
}


####################################
## Incremental reshielding 
####################################
if {$ROUTE_AUTO_CREATE_SHIELDS != "NONE" && $ROUTE_OPT_RESHIELD == "incremental"} {
	set_app_options -name route.common.reshield_modified_nets -value reshield
}

puts "RM-info : Completed script [info script]\n"
