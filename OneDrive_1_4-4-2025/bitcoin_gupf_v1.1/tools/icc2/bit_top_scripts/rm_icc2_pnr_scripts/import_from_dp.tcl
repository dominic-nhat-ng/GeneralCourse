##########################################################################################
# Tool: IC Compiler II
# Script: import_from_dp.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

## Copy design library from ICC2 DP RM release area

if {![file exists ./${DESIGN_NAME}.nlib]} {
	if {[file exists ${RELEASE_DIR_DP}/${DESIGN_NAME}.nlib]} {
		puts "RM-info: Copying ${RELEASE_DIR_DP}/${DESIGN_NAME}.nlib to ./"
		file copy ${RELEASE_DIR_DP}/${DESIGN_NAME}.nlib ./
	} else {
		puts "RM-error: Copying ${RELEASE_DIR_DP}/${DESIGN_NAME}.nlib to ./ but it doesn't exist. Exiting"
	}
} else {
	puts "RM-error: Copying ${DESIGN_NAME}.nlib to ./ but it already exists. Pls correct it. Exiting"
	exit 
}	
