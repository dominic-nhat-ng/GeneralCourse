##########################################################################################
# Tool: IC Compiler II
# Script: budgeting.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

################################################################################
# Open design
################################################################################
exec rm -rf ${WORK_DIR_BUDGETING}
exec cp -rp ${WORK_DIR_TIMING_ESTIMATION} ${WORK_DIR_BUDGETING}


puts "RM-info : Opening block ${WORK_DIR_BUDGETING}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_BUDGETING}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

################################################################################
# Load budgeting user setup file if defined
################################################################################
if [file exists [which $TCL_BUDGETING_SETUP_FILE]] {
   puts "RM-info : Sourcing TCL_BUDGETING_SETUP_FILE ($TCL_BUDGETING_SETUP_FILE)"
   source -echo $TCL_BUDGETING_SETUP_FILE
}

################################################################################
# Budgeting
################################################################################
# Derive block instances from block references if not already defined.
set DP_BLOCK_INSTS ""
foreach ref "$DP_BLOCK_REFS" {
   set DP_BLOCK_INSTS "$DP_BLOCK_INSTS [get_object_name [get_cells -hier -filter ref_name==$ref]]"
}

set_budget_options -add_blocks $DP_BLOCK_INSTS
compute_budget_constraints -setup_delay -boundary -latency_targets actual -balance true

###############################################################################
# Write Out Budgets
################################################################################
write_budgets -output block_budgets -all_blocks -force

################################################################################
# Generate Budget Reports
################################################################################
report_budget -latency > $REPORTS_DIR_BUDGETING/report_budget.latency
report_budget -html_dir $REPORTS_DIR_BUDGETING/${DESIGN_NAME}.budget.html

################################################################################
# Write Out Budget Constraints
################################################################################
write_script -include budget -force -output $REPORTS_DIR_BUDGETING/${DESIGN_NAME}.budget_constraints
save_lib -all

################################################################################
# Load Block Budget Constraints
################################################################################
if {$DISTRIBUTED} {
   set HOST_OPTIONS "-host_options block_script"
} else {
   set HOST_OPTIONS ""
}

eval run_block_script -script ./rm_icc2_dp_scripts/load_block_budgets.tcl \
        -blocks [list "${DP_BLOCK_REFS}"] \
        -work_dir ./work_dir/load_block_budgets ${HOST_OPTIONS}

echo [date] > budgeting
 
   exit 
