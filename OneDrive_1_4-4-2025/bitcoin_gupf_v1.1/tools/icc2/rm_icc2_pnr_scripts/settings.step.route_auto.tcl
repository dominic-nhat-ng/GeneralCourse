puts "RM-info : Running script [info script]\n"

##########################################################################################
# Script: settings.step.route_auto.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## Router
####################################
set_app_options -name route.global.timing_driven -value true
set_app_options -name route.track.timing_driven -value true
set_app_options -name route.detail.timing_driven -value true
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.crosstalk_driven -value true


## set_app_options -name route.common.threshold_noise_ratio -value 0.25
#  This threshold is for the router to identity the criticality of xtalk impact of the nets.
#  Specify a lower number for the router to pick up more nets as xtalk critical nets.
#  For these nets, the router will try to reduce parallel routing as much as possible.

####################################
## Antenna analysis and fixing	
####################################
if {$ROUTE_AUTO_ANTENNA_FIXING} {
	## Enable antenna analysis and fix
	set_app_options -name route.detail.antenna -value true ;# default true

	## Enable router to performs layer hopping to fix antenna violations
	set_app_options -name route.detail.hop_layers_to_fix_antenna -value true ;# default true
} else {
	#  Note: there's no need to set it to false if there are no antenna properties annotated.
	#  It only takes effect if there are antenna properties annotated. 
	#  set_app_options -name route.detail.antenna -value false ;# default true
}

####################################
## Redundant via insertion 
####################################
if {$REDUNDANT_VIA_INSERTION} {
## Source ICC-II via mapping file for redundant via insertion	
	if {[file exists [which $TCL_USER_REDUNDANT_VIA_MAPPING_FILE]]} {
		puts "RM-info: Sourcing [which $TCL_USER_REDUNDANT_VIA_MAPPING_FILE]"
		source $TCL_USER_REDUNDANT_VIA_MAPPING_FILE
		report_via_mapping
## Source ICC via mapping file that containts define_zrt_redundant_vias commands
	} elseif {[file exists [which $TCL_USER_ICC_REDUNDANT_VIA_MAPPING_FILE]]} {
		puts "RM-info: Sourcing [which $TCL_USER_ICC_REDUNDANT_VIA_MAPPING_FILE]"
		add_via_mapping -from_icc_file $TCL_USER_ICC_REDUNDANT_VIA_MAPPING_FILE
		report_via_mapping
	} else {
		puts "RM-warning: No valid redundant via mapping file has been specified."
	}

## Enable redundant via insertion 
#  For established nodes, run concurrent redundant via insertion during route_auto and route_opt.
	set_app_options -name route.common.post_detail_route_redundant_via_insertion -value medium ;# default off
}

####################################
## Timing
####################################
## Enable crosstalk analysis and the extraction of the routed nets along with their coupling caps
set_app_options -name time.si_enable_analysis -value true ;# default false

puts "RM-info : Completed script [info script]\n"
