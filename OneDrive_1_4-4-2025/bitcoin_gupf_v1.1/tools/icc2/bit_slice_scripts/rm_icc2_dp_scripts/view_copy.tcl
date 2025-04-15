##########################################################################################
# Tool: IC Compiler II
# Script: view.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_dp_setup.tcl

set stage_list ""
foreach stage "init_design pre_shaping place_io shaping placement create_power place_pins pre_timing timing_estimation budgeting" {
   if {[file exists ./work/$stage]} {
      switch $stage {
         init_design       {echo "   1, init_design";       set stage_list [lappend stage_list  1]}
         pre_shaping       {echo "   2, pre_shaping";       set stage_list [lappend stage_list  2]}
         place_io          {echo "   3, place_io";          set stage_list [lappend stage_list  3]}
         shaping           {echo "   4, shaping";           set stage_list [lappend stage_list  4]}
         placement         {echo "   5, placement";         set stage_list [lappend stage_list  5]}
         create_power      {echo "   6, create_power";      set stage_list [lappend stage_list  6]}
         place_pins        {echo "   7, place_pins";        set stage_list [lappend stage_list  7]}
         pre_timing        {echo "   8, pre_timing";        set stage_list [lappend stage_list  8]}
         timing_estimation {echo "   9, timing_estimation"; set stage_list [lappend stage_list  9]}
         budgeting         {echo "  10, budgeting";         set stage_list [lappend stage_list 10]}
      }
   }
}

while 1 {
   echo "Please enter a number to select an exisiting design library:"
   set answer [gets stdin]
   if {[lsearch -all $stage_list $answer] >= 0} {
      break
   } else {
      echo "The number you extered does not exisit."
   }
}

switch $answer {
   1 {set work_dir $WORK_DIR_INIT_DESIGN}
   2 {set work_dir $WORK_DIR_PRE_SHAPING}
   3 {set work_dir $WORK_DIR_PLACE_IO}
   4 {set work_dir $WORK_DIR_SHAPING}
   5 {set work_dir $WORK_DIR_PLACEMENT}
   6 {set work_dir $WORK_DIR_CREATE_POWER}
   7 {set work_dir $WORK_DIR_PLACE_PINS}
   8 {set work_dir $WORK_DIR_PRE_TIMING}
   9 {set work_dir $WORK_DIR_TIMING_ESTIMATION}
  10 {set work_dir $WORK_DIR_BUDGETING}
}

puts "RM-info : Copy library [file dir ${work_dir}]"
file delete -force -- ${work_dir}_copy
file copy -- ${work_dir} ${work_dir}_copy

open_lib ${work_dir}_copy/${DESIGN_LIBRARY} -ref
if {[sizeof_collection [get_blocks -quiet ${DESIGN_NAME}.design -all]]} {
   open_block ${DESIGN_NAME} -ref_libs_for_edit
} else {
   open_block ${DESIGN_NAME}.outline
}
# execute a couple commands to make the GUI work without delay
link_block





