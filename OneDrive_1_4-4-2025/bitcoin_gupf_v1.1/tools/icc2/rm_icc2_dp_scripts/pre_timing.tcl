##########################################################################################
# Tool: IC Compiler II
# Script: pre_timing.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_dp_setup.tcl 
source scripts/procs.tcl
START_TIMER BIT_COIN_PRE_TIMING "Starting BIT_COIN ICC2 Pretiming "

####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_PRE_TIMING}
exec cp -rp ${WORK_DIR_PLACE_PINS} ${WORK_DIR_PRE_TIMING}

puts "RM-info : Opening block ${WORK_DIR_PRE_TIMING}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_PRE_TIMING}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

if {[file exists $TCL_TIMING_ESTIMATION_SETUP_FILE]} {
   puts "RM-info : Sourcing  TCL_TIMING_ESTIMATION_SETUP_FILE ($TCL_TIMING_ESTIMATION_SETUP_FILE)"
   source -echo $TCL_TIMING_ESTIMATION_SETUP_FILE
}

################################################################################
# Create Block Timing Abstracts
# This will:
#   load internal constraints via the mapping file: report_mapping_file
#   Run estimate_timing on the block and create an optimized abstract used for top level optimized
################################################################################

##  To ensure that estimated clock latency correlates with post-CTS latency, source the block CTS setup file
if {[file exists $BLOCK_CTS_CONSTRAINT_MAPPING_FILE ]} {
   puts "RM-info : Sourcing BLOCK_CTS_CONSTRAINT_MAPPING_FILE ($BLOCK_CTS_CONSTRAINT_MAPPING_FILE)"
   set_constraint_mapping_file $BLOCK_CTS_CONSTRAINT_MAPPING_FILE
}

if {$DP_FLOW == "hier"} {
   # Setup host options if running distriubted
   if {$DISTRIBUTED} {
     set HOST_OPTIONS "-host_options block_script"
   } else {
     set HOST_OPTIONS ""
   }

   if {$DP_BB_BLOCK_REFS != ""} {
      # Get list of all non blackbox references
      set non_bb_blocks $DP_BLOCK_REFS
      foreach bb $DP_BB_BLOCK_REFS {
         set idx [lsearch -exact $non_bb_blocks $bb]
         set non_bb_blocks [lreplace $non_bb_blocks $idx $idx]
      }

      # Get list of all non blackbox instances
      set non_bb_insts ""
      foreach ref $non_bb_blocks {
         set non_bb_insts "$non_bb_insts [get_object_name [get_cells -hier -filter ref_name==$ref]]"
      }

      # Find all non black boxes instances at lowest hierachy levels
      set non_bb_for_abs [get_attribute -objects [filter_collection [get_cells $non_bb_insts] "!has_child_physical_hierarchy"] -name ref_name]

      # Create abstracts for all non black boxes at lowest hierachy levels
      set CMD_OPTIONS "-estimate_timing $HOST_OPTIONS -blocks [list $non_bb_for_abs]"
      eval create_abstract $CMD_OPTIONS

      # Load constraints and create abstracts for BB blocks
      set CMD_OPTIONS "-blocks [list $DP_BB_BLOCK_REFS] -type SDC $HOST_OPTIONS"
      eval load_block_constraints $CMD_OPTIONS

      set CMD_OPTIONS "-blocks [list $DP_BB_BLOCK_REFS] $HOST_OPTIONS"
      eval create_abstract $CMD_OPTIONS

   } elseif {$DP_BLOCK_REFS != ""} {
      set CMD_OPTIONS "-estimate_timing $HOST_OPTIONS -all_blocks"
      eval create_abstract $CMD_OPTIONS
   }

   # Load constraints for intermediate level blocks
   if {$DP_INTERMEDIATE_LEVEL_BLOCK_REFS != ""} {
      set CMD_OPTIONS "-blocks [list $DP_INTERMEDIATE_LEVEL_BLOCK_REFS] -type SDC $HOST_OPTIONS"
      eval load_block_constraints $CMD_OPTIONS
   }

} else {
   if {[file exists $TCL_MCMM_SETUP_FILE]} {
      puts "RM-info : Loading TCL_MCMM_SETUP_FILE ($TCL_MCMM_SETUP_FILE)"
      source -echo $TCL_MCMM_SETUP_FILE 
   } else {
      puts "RM-error : Cannot find TCL_MCMM_SETUP_FILE ($TCL_MCMM_SETUP_FILE)"
     error
   }
}

save_lib -all
echo [date] > pre_timing
STOP_TIMER BIT_COIN_PRE_TIMING "Completing BIT_COIN ICC2 Pretiming "
   exit 
