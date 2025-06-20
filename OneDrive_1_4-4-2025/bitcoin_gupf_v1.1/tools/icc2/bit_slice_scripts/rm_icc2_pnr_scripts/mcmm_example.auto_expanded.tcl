puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: mcmm_example.auto_expanded.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

## Note :
#  1. To see the full list of mode / corner / scenario specific commands, 
#      refer to SolvNet 1777585 : "Multicorner-multimode constraint classification" 
#
#  2. Corner operating conditions are recommended to be specified directly through 
#     set_process_number, set_voltage and set_temperature
#
#	The PVT resolution function always finds the closest PVT match between the operating conditions and 
#      	the library pane.
#	A Corner operating condition may be specified directly with the set_process_number, set_voltage and 
#	set_temperature commands or indirectly with the set_operating_conditions command.
#	The set_process_label command may be used to distinguish between library panes with the same PVT 
#	values but different process labels.

##############################################################################################
# The following is a sample script to create two scenarios with scenario constraints provided,
# and let the constraints auto expanded to associated modes and scenarios. At the end of script,
# remove_duplicate_timing_contexts is used to improve runtime and capacity without loss of constraints
##############################################################################################

########################################
## Variables
########################################
## Parasitic tech files for read_parasitic_tech command; expand the section as needed
set parasitic1				"" ;# name of parasitic tech model 1
set tluplus_file($parasitic1)           "" ;# TLU+ files to read for parasitic 1
set layer_map_file($parasitic1)         "" ;# layer mapping file between ITF and tech for parasitic 1

set parasitic2				"" ;# name of parasitic tech model 2
set tluplus_file($parasitic2)           "" ;# TLU+ files to read for parasitic 2
set layer_map_file($parasitic2)         "" ;# layer mapping file between ITF and tech for parasitic 2

## Scenario constraints; expand the section as needed
set scenario1 				"" ;# name of scenario1
set scenario_constraints($scenario1)    "" ;# for all scenario1 specific constraints

set scenario2 				"" ;# name of scenario2
set scenario_constraints($scenario2)    "" ;# for all scenario2 specific constraints

########################################
## Read parasitic tech files
########################################
## Read in the TLUPlus files first.
#  Later on in the scenario constraints, you can then refer to these parasitic models.
foreach p [array name tluplus_file] {  
	puts "RM-info : read_parasitic_tech -tlup $tluplus_file($p) -layermap $layer_map_file($p) -name $p"
	read_parasitic_tech -tlup $tluplus_file($p) -layermap $layer_map_file($p) -name $p
}

########################################
## Create modes, corners, and scenarios
########################################
remove_modes -all; remove_corners -all; remove_scenarios -all

foreach s [array name scenario_constraints] {
	create_mode $s
	create_corner $s
	create_scenario -name $s -mode $s -corner $s
}

########################################
## Populate constraints 
########################################
## Populate scenario constraints which will then be automatically expanded to its associated modes and corners
foreach s [array name scenario_constraints] {
	current_scenario $s
	puts "RM-info : current_scenario $s"
	puts "RM-info : source $scenario_constraints($s)"
	source $scenario_constraints($s)
}

########################################
## Configure analysis settings for scenarios
########################################
# Below are just examples to show usage of set_scenario_status (actual usage shold depend on your objective)
# scenario1 is a setup scenario and scenario2 is a hold scenario
set_scenario_status $scenario1 -none -setup true -hold false -leakage_power true -dynamic_power true -max_transition true -max_capacitance true -min_capacitance false -active true
set_scenario_status $scenario2 -none -setup false -hold true -leakage_power true -dynamic_power false -max_transition true -max_capacitance false -min_capacitance true -active true

redirect -file ${REPORTS_DIR}/${INIT_DESIGN_BLOCK_NAME}.report_scenarios.rpt {report_scenarios} 

## To remove duplicate modes, corners, scenarios, and to improve runtime and capacity without loss of constraints :
remove_duplicate_timing_contexts

puts "RM-info : Completed script [info script]\n"

