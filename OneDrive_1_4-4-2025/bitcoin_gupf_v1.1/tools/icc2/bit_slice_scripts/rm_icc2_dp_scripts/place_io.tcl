##########################################################################################
# Tool: IC Compiler II
# Script: place_io.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_PLACE_IO}
exec cp -rp ${WORK_DIR_PRE_SHAPING} ${WORK_DIR_PLACE_IO}

puts "RM-info : Opening block ${WORK_DIR_PLACE_IO}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_PLACE_IO}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit


##################################################
# load IO placement constraints
# at the very minimum you have to create IO guides
##################################################
if {[file exists [which $TCL_PAD_CONSTRAINTS_FILE]]} {
   puts "RM-info : Loading TCL_PAD_CONSTRAINTS_FILE file ($TCL_PAD_CONSTRAINTS_FILE)"
   source -echo $TCL_PAD_CONSTRAINTS_FILE

   puts "RM-info : running place_io"
   place_io
}

if {[file exists [which $TCL_RDL_FILE]]} {
   puts "RM-info : Loading TCL_RDL_FILE file ($TCL_RDL_FILE)"
   source -echo $TCL_RDL_FILE
}

set_attribute -objects [get_cells -quiet -filter is_io==true -hier]    -name status -value fixed
set_attribute -objects [get_cells -quiet -filter pad_cell==true -hier] -name status -value fixed

save_lib -all
echo [date] > place_io

   exit 















