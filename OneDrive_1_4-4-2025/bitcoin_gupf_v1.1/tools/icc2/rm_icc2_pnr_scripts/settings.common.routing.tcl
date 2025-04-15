puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: settings.common.routing.tcl
# Purpose: Common routing (and extraction) related settings
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################
if {$MIN_ROUTING_LAYER != ""} {set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER}
if {$MAX_ROUTING_LAYER != ""} {set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER}

####################################
## Non-Clock NDR
####################################
if {[file exists [which $TCL_NON_CLOCK_NDR_RULES_FILE]]} {
	puts "RM-info: Sourcing [which $TCL_NON_CLOCK_NDR_RULES_FILE]"
	source $TCL_NON_CLOCK_NDR_RULES_FILE
} elseif {$TCL_NON_CLOCK_NDR_RULES_FILE != ""} {
  puts "RM-error: TCL_NON_CLOCK_NDR_RULES_FILE ($TCL_NON_CLOCK_NDR_RULES_FILE) is specified but doesn't exist"
}


puts "RM-info : Completed script [info script]\n"
