puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: multibit_example.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

## Below is an example that runs banking in ICC-II

place_opt -from initial_place

identify_multibit -register -output_file $OUTPUTS_DIR/${PLACE_OPT_BLOCK_NAME}.mbit.tcl

source $OUTPUTS_DIR/${PLACE_OPT_BLOCK_NAME}.mbit.tcl

place_opt -from initial_drc

## If debanking is needed, use the following :
#	split_multibit 

puts "RM-info : Completed script [info script]\n"

