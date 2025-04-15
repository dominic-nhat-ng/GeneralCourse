##########################################################################################
# Tool: IC Compiler II
# Script: create_softlinks_to_subblocks.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

	## For top or intermediate level of hier designs, create soft-links to sub-blocks present in ICC2 PNR release area,

	foreach BLOCK $SUB_BLOCK_REFS {
		if {![file exists ./${BLOCK}.nlib]} {
			if {[file exists ${RELEASE_DIR_PNR}/${SUB_BLOCK_REFS}/${BLOCK}.nlib]} {
				puts "RM-info: Creating soft-link to ${RELEASE_DIR_PNR}/${BLOCK}.nlib in ./"
				sh ln -s ${RELEASE_DIR_PNR}/${SUB_BLOCK_REFS}/${BLOCK}.nlib
			} else {
				puts "RM-error: Creating soft-link to ${RELEASE_DIR_PNR}/${BLOCK}.nlib in ./ but it doesn't exist. Exiting"
				exit
			}
		} else {
			puts "RM-error: Creating soft-link to ${BLOCK}.nlib in ./ but it already exists. Pls correct it. Exiting"
			exit				
		}
	}
