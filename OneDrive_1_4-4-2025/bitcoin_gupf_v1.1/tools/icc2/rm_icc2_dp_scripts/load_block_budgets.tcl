##########################################################################################
# Tool: IC Compiler II
# Script: load_block_budgets.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

#Send jobID back to parent for tracking purposes
if {[info exist env(JOB_ID)]} {
   puts "Block: $block_refname JobID: $env(JOB_ID) - START"
}

open_block $block_libfilename:$block_refname
reopen_block -edit
# This is necessary to protect against unexpected closing of the block prior to saving
save_block

if {[file exists ./block_budgets/$block_refname/top.tcl]} {
   puts "Block: $block_refname - Loading budgets"
   source -echo ./block_budgets/$block_refname/top.tcl
}

save_lib
close_lib
puts "Block: $block_refname - FINISHED"
