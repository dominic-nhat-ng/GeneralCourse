##########################################################################################
# Tool: IC Compiler II
# Script: write_data.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_dp_setup.tcl 
source scripts/procs.tcl
START_TIMER BIT_COIN_DATA_WRITE "Starting BIT_COIN ICC2 Writing out Data "


################################################################################
## Open Design
################################################################################
if {$DP_FLOW == "hier"} {
   exec rm -rf $WORK_DIR_WRITE_DATA
   exec cp -rp ${WORK_DIR_BUDGETING} ${WORK_DIR_WRITE_DATA}
} else {
   exec rm -rf $WORK_DIR_WRITE_DATA
   exec cp -rp ${WORK_DIR_PRE_TIMING} ${WORK_DIR_WRITE_DATA}
}

puts "RM-info : Opening block ${WORK_DIR_WRITE_DATA}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_WRITE_DATA}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

if {$DP_FLOW == "hier"} {
   if {$DISTRIBUTED} {
      set HOST_OPTIONS "-host_options block_script"
   } else {
      set HOST_OPTIONS ""
   }
   eval merge_abstract -all_blocks ${HOST_OPTIONS}
}

# Save as init_design label for the start of implementation
save_block -hierarchical -label init_design
close_block

open_block ${WORK_DIR_WRITE_DATA}/${DESIGN_LIBRARY}:${DESIGN_NAME}/init_design


if {[info exists DP_BLOCK_REFS]} {
  # Add top level to blocks
  set DP_BLOCK_REFS "$DP_BLOCK_REFS $DESIGN_NAME"
} else {
  set DP_BLOCK_REFS $DESIGN_NAME
}
    
# Remove old label, as it isn't needed for implementation
foreach block $DP_BLOCK_REFS {
  puts $block
  remove_blocks  -force ${block}.nlib:${block}.design
  if {[sizeof_collection [get_blocks -quiet ${block}.nlib:${block}.outline]]} {
    remove_blocks  -force ${block}.nlib:${block}.outline
  }
  if {[sizeof_collection [get_blocks -quiet ${block}.nlib:${block}.abstract]]} {
    remove_abstract ${block}.nlib:${block}.abstract
  }
}

# Dump top
set path_dir [file normalize ${WORK_DIR_WRITE_DATA}]
source ./rm_icc2_dp_scripts/write_block_data.tcl

if {$DP_FLOW == "hier"} {
   if {$DISTRIBUTED} {
      run_block_script -script ./rm_icc2_dp_scripts/write_block_data.tcl \
         -blocks ${DP_BLOCK_REFS} \
         -work_dir ./work_dir/write_data \
         -var_list "path_dir [file normalize ${WORK_DIR_WRITE_DATA}]" \
         -host_options block_script
   } else {
      run_block_script -script ./rm_icc2_dp_scripts/write_block_data.tcl \
         -blocks ${DP_BLOCK_REFS} \
         -work_dir ./work_dir/write_data \
         -var_list "path_dir [file normalize ${WORK_DIR_WRITE_DATA}]"
   }

   # Write out hierarchy configuration file that can be used by unpack script to setup block directories
   set all_blocks [get_cells -hier -physical -filter hierarchy_type==block]

   set blocks($DESIGN_NAME) [get_attribute [get_cells -physical -filter hierarchy_type==block] ref_name]

   set top_block [current_block]
   foreach_in_collection block $all_blocks {
      current_block [get_attribute [get_cells -physical_context $block] ref_full_name]
      set idx [get_attribute [get_cells -physical_context $block] ref_name]
      set blocks($idx) [get_attribute [get_cells -quiet -physical -filter hierarchy_type==block] ref_name]
   }
   current_block $top_block

   proc print_hier {child_blocks depth} {
      incr depth
      if {[llength $child_blocks] != 0} {
         foreach child_block $child_blocks {
            # Indent line
            for { set i 1 } { $i <= $depth } { incr i } {
               puts -nonewline $::fout " "
            }
            puts $::fout $child_block
            print_hier $::blocks($child_block) $depth
        }
     } else {
        return
     }
   }
   set fout [open ${WORK_DIR_WRITE_DATA}/design_hier.cfg w]
   print_hier $DESIGN_NAME -1
   close $fout
}
STOP_TIMER BIT_COIN_DATA_WRITE "Starting BIT_COIN ICC2 Writing out Data "
echo [date] > write_data

   exit 
