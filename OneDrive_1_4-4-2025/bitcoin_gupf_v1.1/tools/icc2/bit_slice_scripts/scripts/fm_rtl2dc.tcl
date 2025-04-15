source -echo -verbose ./rm_setup/dc_setup.tcl

#################################################################################
# Formality Verification Script for
# Design Compiler Block-Level Reference Methodology Script for Hierarchical Flow
# Script: fm.tcl
# Version: G-2012.06 (July 2, 2012)
# Copyright (C) 2007-2012 Synopsys, Inc. All rights reserved.
#################################################################################

#################################################################################
# Synopsys Auto Setup Mode
#################################################################################

set_app_var synopsys_auto_setup true
set compile_automatic_clock_phase_inference none
set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_allow_ls_on_leaf_pin_boundary true
set _mv_allow_iss_update_to_ss_function true



set verification_failing_point_limit 1000000
set verification_verify_unread_bbox_inputs false
set verification_verify_unread_tech_cell_pins false




#set_svf ${RESULTS_DIR}/${DCRM_SVF_OUTPUT_FILE}



#################################################################################
# Read in the libraries
#################################################################################

foreach tech_lib "${TARGET_LIBRARY_FILES} ${ADDITIONAL_LINK_LIB_FILES}" {
  read_db -technology_library $tech_lib
}

#################################################################################
# Read in the Reference Design as verilog/vhdl source code
#################################################################################

read_verilog -r ${RTL_SOURCE_FILES} -work_library WORK

# Note: If retention registers are instantiated in the RTL then replace the
#       technology retention register models here.  See the implementation read
#       section below for details.  This should be done before set_top.
#       Most designs do not have retention registers until after mapping so
#       this is not needed.

# The following setting is needed to exclude instantiated ICG cells from being
# retained inside retention domains (same behavior as Design Compiler)

set_app_var upf_use_additional_db_attributes true

set_top r:/WORK/${DESIGN_NAME}

#################################################################################
# For a UPF MV flow, read in the UPF file for the Reference Design
#################################################################################
set DCRM_MV_UPF_INPUT_FILE upf/snps_bit_coin.upf
load_upf -r $DCRM_MV_UPF_INPUT_FILE

#################################################################################
# Read in the Implementation Design from DC-RM results
#
# Choose the format that is used in your flow.
#################################################################################

# For Verilog
#read_verilog -i ${RESULTS_DIR}/${DCRM_FINAL_VERILOG_OUTPUT_FILE}

# OR

# For .ddc


set RESULTS_DIR results

set ICC_IN_PG_FILE             "${DESIGN_NAME}.vg"

read_verilog -i ${ICC_IN_PG_FILE}
set_top i:/WORK/${DESIGN_NAME}
load_upf -i results/${DESIGN_NAME}.upf

# Note: Milkyway design format is not supported with UPF flow in Formality.


#################################################################################
# Read in Retention Register Simulation Models
#################################################################################

# If you are mapping to retention registers in your design, you need to replace the
# technology library models of those cells with Verilog simulation models for
# Formality verification.  Please see the following SolvNet article for details:

# https://solvnet.synopsys.com/retrieve/024106.html

# set_top should be run only after the retention register models have been replaced. 


#################################################################################
# For a UPF MV flow, read in the UPF file for the Implementation Design
#################################################################################

#load_upf -i ${RESULTS_DIR}/${DCRM_MV_FINAL_UPF_OUTPUT_FILE}


#################################################################################
# Configure constant ports
#
# When using the Synopsys Auto Setup mode, the SVF file will convey information
# automatically to Formality about how to disable scan.
#
# Otherwise, manually define those ports whose inputs should be assumed constant
# during verification.
#
# Example command format:
#
#   set_constant -type port i:/WORK/${DESIGN_NAME}/<port_name> <constant_value> 
#
#################################################################################

#################################################################################
# Report design statistics, design read warning messages, and user specified setup
#################################################################################

# report_setup_status will create a report showing all design statistics,
# design read warning messages, and all user specified setup.  This will allow
# the user to check all setup before proceeding to run the more time consuming
# commands "match" and "verify".

# report_setup_status

#################################################################################
# Note in using the UPF MV flow with Formality:
#
# By default Formality verifies low power designs with all UPF supplies 
# constrained to their ON state.  This is only a partial verification result.
# To cover all operational power states, uncomment the following variable setting:
#
      # set_app_var verification_force_upf_supplies_on false
#
#################################################################################

#################################################################################
# Match compare points and report unmatched points 
#################################################################################
set verification_clock_gate_hold_mode any

match

report_unmatched_points > ${REPORTS_DIR}/${FMRM_UNMATCHED_POINTS_REPORT}


#################################################################################
# Verify and Report
#
# If the verification is not successful, the session will be saved and reports
# will be generated to help debug the failed or inconclusive verification.
#################################################################################

if { ![verify] }  {  
  save_session -replace ${REPORTS_DIR}/${FMRM_FAILING_SESSION_NAME}
  report_failing_points > ${REPORTS_DIR}/${FMRM_FAILING_POINTS_REPORT}
  report_aborted > ${REPORTS_DIR}/${FMRM_ABORTED_POINTS_REPORT}
  # Use analyze_points to help determine the next step in resolving verification
  # issues. It runs heuristic analysis to determine if there are potential causes
  # other than logical differences for failing or hard verification points. 
  analyze_points -all > ${REPORTS_DIR}/${FMRM_ANALYZE_POINTS_REPORT}
}
