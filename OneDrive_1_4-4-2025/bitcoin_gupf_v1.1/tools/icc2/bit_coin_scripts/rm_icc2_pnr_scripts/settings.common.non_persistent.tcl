puts "RM-info : Running script [info script]\n"

##########################################################################################
# Script: settings.common.non_persistent.tcl
# Description : Settings that need to be re-applied in each new ICC-II session are incldued below.
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

####################################
## Placement spacing labels and rules
####################################
#  Example : set_placement_spacing_label -name X -side both -lib_cells [get_lib_cells -of [get_cells]]
#  Example : set_placement_spacing_rule -labels {X SNPS_BOUNDARY} {0 1}
#  Note : Spacing labels and rules are not persistent and must be sourced in the subsequent ICC-II sessions.
if {[file exists [which $TCL_PLACEMENT_SPACING_LABEL_RULE_FILE]]} {
	puts "RM-info: Sourcing [which $TCL_PLACEMENT_SPACING_LABEL_RULE_FILE]"
	source $TCL_PLACEMENT_SPACING_LABEL_RULE_FILE
}

####################################
## read_saif 
####################################
## SAIF information is not persistent in the current release and must be writen out and read in the subsequent ICC-II sessions.
#  Please insert your write and read SAIF commands here.

#  Example for writing out SAIF from a SAIF loaded session :
#	current_scenario $your_power_scenario
#	write_saif -propagated temp.saif

#  Example for reading in a written-out SAIF in a new ICC-II session :
#	read_saif temp.saif -scenarios $your_power_scenario	  

####################################
## Keepout margin (lib cell based) 
####################################
## Lib cell based keepout margin is not persistent in the current release and must be re-applied in new ICC-II seccions.
#  Example : create_keepout_margin -outer {5 5 5 5} [get_lib_cells */lib_cell_name]

####################################
## set_threshold_voltage_group_type 
####################################
## Set your threshold_voltage_group attributes. These are persistent and can be simply defined in settings.common.opt.tcl. 
#  Listed here for your reference. For example:
#  	define_user_attribute -type string -class lib_cell threshold_voltage_group
#  	set_attribute -quiet [get_lib_cells -quiet */*LVT] threshold_voltage_group LVt
#  	set_attribute -quiet [get_lib_cells -quiet */*RVT] threshold_voltage_group RVt
#  	set_attribute -quiet [get_lib_cells -quiet */*HVT] threshold_voltage_group HVt

## set_threshold_voltage_group_type is not persistent and should be defined here:
#  	set_threshold_voltage_group_type -type low_vt LVt
#  	set_threshold_voltage_group_type -type normal_vt RVt
#  	set_threshold_voltage_group_type -type high_vt HVt

puts "RM-info : Completed script [info script]\n"
