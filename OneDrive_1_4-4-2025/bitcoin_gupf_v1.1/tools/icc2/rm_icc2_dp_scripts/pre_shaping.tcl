##########################################################################################
# Tool: IC Compiler II
# Script: pre_shaping.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

source scripts/procs.tcl
START_TIMER BIT_COIN_PRE_SHAPING "Starting BIT_COIN ICC2 Preshaping"


####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_PRE_SHAPING}
exec cp -rp ${WORK_DIR_INIT_DESIGN} ${WORK_DIR_PRE_SHAPING}

puts "RM-info : Opening library ${WORK_DIR_PRE_SHAPING}/${DESIGN_LIBRARY}"
open_lib ${WORK_DIR_PRE_SHAPING}/${DESIGN_LIBRARY} -ref_libs_for_edit

if {$DP_FLOW == "hier"} {
   puts "RM-info : Opening block ${DESIGN_NAME}.outline"
   open_block ${DESIGN_NAME}.outline -ref_libs_for_edit
} else {
   puts "RM-info : Opening block ${DESIGN_NAME}"
   open_block ${DESIGN_NAME} -ref_libs_for_edit
}
source scripts/icc2_upf_vars.tcl

if {$DP_FLOW == "hier"} {
   if {$CONSTRAINT_MAPPING_FILE != ""} {
      set_constraint_mapping_file $CONSTRAINT_MAPPING_FILE
   } else {
      if {![file exists "./split/mapfile"]} {
         puts "RM-error : Cannot find default mapping file ./split/mapfile. Please create or specify the mapping file using the CONSTRAINT_MAPPING_FILE variable in setup.tcl "
         error
      } else {
         puts "RM-warning : No CONSTRAINT_MAPPING_FILE set, setting the constraint mapping file to the deafult ./split/mapfile"
         set_constraint_mapping_file ./split/mapfile
      }
   }

   ################################################################################
   # read in full verilog for the current DESIGN_NAME
   # only the top level will be read in, as we have already commited the blocks
   # This will create a top level DESIGN_NAME with black boxes for the blocks
   ################################################################################
   puts "RM-info : Expanding top level outline"
   expand_outline

   ################################################################################
   # Create block placement abstracts in preparation for shaping
   #  load and commit the block UPF (based upon the UPF specified in the mapfile)
   #  load and commit the top UPF (based upon the UPF specified in the mapfile)
   #  load and commit the top UPF (based upon the UPF specified in the mapfile)
   #
   ################################################################################

   if {$DISTRIBUTED} {
      puts "RM-info : Creating Placement Abstracts (distributed) for all bllocks"
      create_abstract -placement -host_options block_script -all_blocks
   } else {
      puts "RM-info : Creating Placement Abstracts (non-distributed) for all bllocks"
      create_abstract -placement -all_blocks
   }

   if {[file exists [which $TCL_UPF_FILE]]} {
      source -echo $TCL_UPF_FILE
      commit_upf
   }
} else {
   ####################################
   # If flat flow, load UPF
   ####################################
   if {[file exists $UPF_FILE]} {
      load_upf $UPF_FILE
   }

   if {[file exists $TCL_UPF_FILE]} {
      source -echo $TCL_UPF_FILE
   }

   commit_upf  
}


puts "RM-info : Running connect_pg_net -automatic on all blocks"
connect_pg_net -automatic -all_blocks




if {[file exists [which $TCL_TIMING_RULER_SETUP_FILE]]} {
   puts "RM-info : Sourcing [which $TCL_TIMING_RULER_SETUP_FILE]"
   source -echo $TCL_TIMING_RULER_SETUP_FILE
} else {
   puts "RM-warning : TCL_TIMING_RULER_SETUP_FILE not found or not specified. Timing ruler will not work accurately if it is not defined"
}

save_lib -all
report_abstracts > $REPORTS_DIR_PRE_SHAPING/report_abstracts.rpt
report_mibs >  $REPORTS_DIR_PRE_SHAPING/report_mibs.rpt
report_design >  $REPORTS_DIR_PRE_SHAPING/report_design.rpt
echo [date] > pre_shaping
STOP_TIMER BIT_COIN_PRE_SHAPING "Completing BIT_COIN ICC2 Preshaping"

   exit 

