##########################################################################################
# Tool: IC Compiler II
# Script: placement.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_dp_setup.tcl 
source scripts/procs.tcl
START_TIMER BIT_COIN_PLACEMENT "Starting BIT_COIN ICC2 Placement "



####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_PLACEMENT}
exec cp -rp ${WORK_DIR_SHAPING} ${WORK_DIR_PLACEMENT}

puts "RM-info : Opening block ${WORK_DIR_PLACEMENT}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_PLACEMENT}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit

####################################
# Push rows and tracks into blocks if no site_arrays exist
####################################
if {[llength [get_site_array -quiet]] == 0} {
   puts "RM-info : pushing down site_rows into all blocks"
   push_down_objects [get_site_rows]
}

if [file exists [which $TCL_PLACEMENT_CONSTRAINTS_FILE]] {
   puts "RM-info : sourcing file TCL_PLACEMENT_CONSTRAINTS_FILE ($TCL_PLACEMENT_CONSTRAINTS_FILE)"
   source -echo $TCL_PLACEMENT_CONSTRAINTS_FILE
}

####################################
# place std cells and macros
# -floorplan enables macro placement
####################################
if [sizeof_collection [get_cells -hier -filter is_hard_macro==true -quiet]] {
   set all_macros [get_cells -hier -filter is_hard_macro==true]
   # Check top-level 
   report_macro_constraints -allowed_orientations -preferred_location -alignment_grid -align_pins_to_tracks $all_macros > $REPORTS_DIR_PLACEMENT/report_macro_constraints.rpt
}

# If pin-constraint aware placement is used then sourcing all pin constraint files before placement
if {$PLACEMENT_PIN_CONSTRAINT_AWARE == "true"} {
   puts "RM-info : pin aware pin placement enbaled (PLACEMENT_PIN_CONSTRAINT_AWARE == $PLACEMENT_PIN_CONSTRAINT_AWARE)"
   if {[file exists [which $TCL_PIN_CONSTRAINT_FILE]]} {
      puts "RM-info : sourcing TCL_PIN_CONSTRAINT_FILE $TCL_PIN_CONSTRAINT_FILE"
      source -echo $TCL_PIN_CONSTRAINT_FILE
   }
   if {[file exists [which $CUSTOM_PIN_CONSTRAINT_FILE]]} {
      puts "RM-info : sourcing CUSTOM_PIN_CONSTRAINT_FILE $CUSTOM_PIN_CONSTRAINT_FILE"
      read_pin_constraints -file_name $CUSTOM_PIN_CONSTRAINT_FILE
   }
}

# Designs with strong macro-to-macro DFF connections may benefit from DFF based macro placement 
if {$PLACEMENT_DFF_AWARE == "true"} {
   puts "RM-info : DFF aware placement enabled (PLACEMENT_DFF_AWARE == $PLACEMENT_DFF_AWARE) "
   set_app_options -list {plan.place.trace_mode dfa}
}

# To support incremental macro placement constraints, enable it and write out the preferred locations file
if {$USE_INCREMENTAL_DATA && [file exists $OUTPUTS_DIR/preferred_macro_locations.tcl]} {
   source $OUTPUTS_DIR/preferred_macro_locations.tcl
}

if {$DISTRIBUTED} {
   create_placement -floorplan -host_options block_script
} else {
   create_placement -floorplan 
}

report_placement \
   -physical_hierarchy_violations all \
   -wirelength all -hard_macro_overlap \
   -verbose high > $REPORTS_DIR_PLACEMENT/report_placement.rpt

# write out macro preferred locations based on latest placement
# If this file exists on subsequent runs it will be used to drive the macro placement
if [sizeof_collection [get_cells -hier -filter is_hard_macro==true -quiet]] {
   file delete -force $OUTPUTS_DIR/preferred_macro_locations.tcl
   set all_macros [get_cells -hier -filter is_hard_macro==true]
   derive_preferred_macro_locations $all_macros -file $OUTPUTS_DIR/preferred_macro_locations.tcl
}

####################################
# Fix all shaped blocks and macros
####################################
if [sizeof_collection [get_cells -hier -filter is_hard_macro==true -quiet]] {
   set_attribute -quiet [get_cells -hierarchical -filter is_hard_macro==true] status fixed
}

if {$DP_FLOW == "hier"} {
   # Derive block instances from block references if not already defined.
   set DP_BLOCK_INSTS ""
   foreach ref "$DP_BLOCK_REFS" {
      set DP_BLOCK_INSTS "$DP_BLOCK_INSTS [get_object_name [get_cells -hier -filter ref_name==$ref]]"
   }
   set_attribute -quiet [get_cells $DP_BLOCK_INSTS] status fixed
}

save_lib -all
STOP_TIMER BIT_COIN_PLACEMENT "Completing BIT_COIN ICC2 Placement "
echo [date] > placement

   exit 
