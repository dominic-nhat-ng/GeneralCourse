##########################################################################################
# Tool: IC Compiler II
# Script: create_power.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

####################################
# Open design
####################################
exec rm -rf ${WORK_DIR_CREATE_POWER}
exec cp -rp ${WORK_DIR_PLACEMENT} ${WORK_DIR_CREATE_POWER}

puts "RM-info : Opening block ${WORK_DIR_CREATE_POWER}/${DESIGN_LIBRARY}:${DESIGN_NAME}"
open_block ${WORK_DIR_CREATE_POWER}/${DESIGN_LIBRARY}:${DESIGN_NAME} -ref_libs_for_edit
####################################
# GLOBAL PLANNING
####################################
if [file exists $TCL_GLOBAL_PLANNING_FILE] {
   puts "RM-info : Sourcing TCL_GLOBAL_PLANNING_FILE ($TCL_GLOBAL_PLANNING_FILE)"
   source -echo $TCL_GLOBAL_PLANNING_FILE
}
####################################
# PNS/PNA 
####################################

if {[file exists $TCL_PNS_FILE]} {
   puts "RM-info : Sourcing TCL_PNS_FILE ($TCL_PNS_FILE)"
   source -echo $TCL_PNS_FILE
}

legalize_placement

if {$PNS_CHARACTERIZE_FLOW == "true" && $TCL_COMPILE_PG_FILE != ""} {
   puts "RM-info : RUNNING PNS CHARACTERIZATION FLOW becuase \$PNS_CHARACTERIZE_FLOW == true"
   characterize_block_pg -output block_pg -compile_pg_script $TCL_COMPILE_PG_FILE
   set_constraint_mapping_file ./block_pg/pg_mapfile
   # run_block_compile_pg will honor the set_hierarchy_options settings by default
   if {$DISTRIBUTED} {
      set HOST_OPTIONS "-host_options block_script"
   } else {
      set HOST_OPTIONS ""
   }
   eval run_block_compile_pg ${HOST_OPTIONS}
   source -e -v scripts/insert_power_switch.tcl

} else {
   if {$TCL_COMPILE_PG_FILE != ""} {
      source $TCL_COMPILE_PG_FILE
      source -e -v scripts/insert_power_switch.tcl
   } else {
      puts "RM-info : No Power Networks Implemented as TCL_COMPILE_PG_FILE does not exist"
   }
   if {[file exists $TCL_PG_PUSHDOWN_FILE]} {
      puts "RM-info : Souring TCL_PG_PUSHDOWN_FILE ($TCL_PG_PUSHDOWN_FILE)"
      source $TCL_PG_PUSHDOWN_FILE
   } else {
      puts "RM-info : Automatic pushdown of PG geometries enabled. Pushing down into all blcoks"
      set pg [get_nets * -filter "net_type == power || net_type == ground" -quiet]

      if {[sizeof_collection $pg] > 0} {
         set_push_down_object_options \
            -object_type           {pg_routing} \
            -top_action            remove \
            -block_action          {copy create_pin_shape}
         push_down_objects $pg
      }
   }
}

# Check phyiscal connectivity
check_pg_connectivity

# Create error report for PG ignoring std cells because they are not legalized
check_pg_drc -ignore_std_cells

if {[file exists $TCL_POST_PNS_FILE]} {
   puts "RM-info : Sourcing TCL_POST_PNS_FILE ($TCL_POST_PNS_FILE)"
   source -echo $TCL_POST_PNS_FILE
}

save_lib -all
echo [date] > create_power

   exit 


