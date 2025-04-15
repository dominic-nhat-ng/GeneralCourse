##########################################################################################
# Tool: IC Compiler II
# Script: init_design.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

 source scripts/procs.tcl
START_TIMER BIT_COIN_INIT_DESIGN "Starting BIT_COIN ICC2 Initialization"



####################################
# Create and read the design	
####################################
if {[file exists ${WORK_DIR_INIT_DESIGN}/$DESIGN_LIBRARY]} {
   file delete -force ${WORK_DIR_INIT_DESIGN}/${DESIGN_LIBRARY}
}

# NOTE: The library will not appear on disk until you save
set create_lib_cmd "create_lib ${WORK_DIR_INIT_DESIGN}/$DESIGN_LIBRARY"
if {[file exists [which $TECH_FILE]]} {
   lappend create_lib_cmd -tech $TECH_FILE ;# recommended
} elseif {$TECH_LIB != ""} {
   lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
}
lappend create_lib_cmd -ref_libs $REFERENCE_LIBRARY
puts "RM-info : $create_lib_cmd"
eval $create_lib_cmd


if {$DP_FLOW == "hier"} {
   # Read in the DESIGN_NAME outline.  This will create the outline 
   puts "RM-info : Reading verilog outline (${VERILOG_NETLIST_FILES})"
   read_verilog_outline -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}
} else {
   # Read in the full DESIGN_NAME.  This will create the DESIGN_NAME view in the database
   puts "RM-info : Reading full chip verilog (${VERILOG_NETLIST_FILES})"
   read_verilog -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}
}

####################################################
# Here we use add ICC2 only tech information.
# ICC2 needs to have the routing direction specified, 
# track offset, and default site defs.
####################################################

## Technology setup for routing layer direction, offset, site default, and site symmetry.
#  If TECH_FILE is specified, they should be properly set.
#  If TECH_LIB is used and it does not contain such information, then they should be set here as well.
if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
   if {[file exists [which $TCL_TECH_SETUP_FILE]]} {
      puts "RM-info : Sourcing [which $TCL_TECH_SETUP_FILE]"
      source -echo $TCL_TECH_SETUP_FILE
   } elseif {$TCL_TECH_SETUP_FILE != ""} {
      puts "RM-error : TCL_TECH_SETUP_FILE($TCL_TECH_SETUP_FILE) is invalid. Please correct it."
   }
}

# Read TLU+
if {[file exists [which $TLU_PLUS_FILE]]} {
   puts "RM-info : Sourcing [which $TLU_PLUS_FILE]"
   source -echo $TLU_PLUS_FILE
} else {
   puts "RM-info : No TLU plus files sourced, Parasitic library containing TLU+ must be included in library reference list"
}

# Define the ignored layers (if specified)
if {$MIN_ROUTING_LAYER != ""} {
   set_ignored_layers -min_routing_layer $MIN_ROUTING_LAYER
}
if {$MAX_ROUTING_LAYER != ""} {
   set_ignored_layers -max_routing_layer $MAX_ROUTING_LAYER
}

####################################
# Floorplanning
####################################
source scripts/direction.tcl
source scripts/icc2_upf_vars.tcl

if {[file exists [which $TCL_PHYSICAL_CONSTRAINTS_FILE]]} {
   puts "RM-info : Creating floorplan from TCL file TCL_PHYSICAL_CONSTRAINTS_FILE ($TCL_PHYSICAL_CONSTRAINTS_FILE)"
   source -echo -verbose $TCL_PHYSICAL_CONSTRAINTS_FILE
} elseif {[file exists [which $DEF_FLOORPLAN_FILES]]} {
   puts "RM-info : Creating floorplan from DEF file DEF_FLOORPLAN_FILES ($DEF_FLOORPLAN_FILES)"
   read_def $DEF_FLOORPLAN_FILES
} else {
   puts "RM-info : No floorplan setup provided, creating fallback initilization"
   #initialize_floorplan
initialize_floorplan -side_length {7000 2400} -core_offset 50
}

if {[file exists [which $TCL_PHYSICAL_CONSTRAINTS_FILE]] && [file exists [which $DEF_FLOORPLAN_FILES]]} {
   puts "RM-warning : Updating floorplan from DEF file DEF_FLOORPLAN_FILES ($DEF_FLOORPLAN_FILES)"
   read_def $DEF_FLOORPLAN_FILES
}

if {[file exists [which $TCL_PRE_COMMIT_FILE]]} {
   puts "RM-info : Loading TCL_PRE_COMMIT_FILE file ($TCL_PRE_COMMIT_FILE)"
   source -echo $TCL_PRE_COMMIT_FILE
} elseif {$TCL_PRE_COMMIT_FILE != ""} {
   puts "RM-error: TCL_PRE_COMMIT_FILE file ($TCL_PRE_COMMIT_FILE)" is invalid. Please correct it.
}


############################################################################
# Commit each block to its own library and add the block library as 
# a reference library
############################################################################
if {$DP_FLOW == "hier"} {
   set cl [current_lib]
   set cd [current_design]

   # Derive block instances from block references if not already defined.
   set DP_BLOCK_INSTS ""
   foreach ref "$DP_BLOCK_REFS" {
      set DP_BLOCK_INSTS "$DP_BLOCK_INSTS [get_object_name [get_cells -hier -filter ref_name==$ref]]"
   }

   # copy_lib -from_lib -to_lib does not support paths to the libraries
   set pwd [pwd]
   cd ${WORK_DIR_INIT_DESIGN}
   foreach ref ${DP_BLOCK_REFS} {
      puts "RM-info : Creating ${ref}.nlib"
      file delete -force -- ${ref}.nlib
      copy_lib -to_lib ${ref}.nlib -no_designs
   }
   cd $pwd

   save_lib -all

   # Determine reference libraries for each block
   foreach block $DP_BLOCK_INSTS {
      set elems [lsearch -all $DP_BLOCK_INSTS $block/*]
      set ref [get_attribute [get_cell $block] ref_full_name]
      set ref_libs($ref) ""
      foreach elem $elems {
         set ref_name [get_attribute [get_cell [lindex $DP_BLOCK_INSTS $elem]] ref_full_name]
         set ref_libs($ref) [lappend ref_libs($ref) ${ref_name}]
      }
# Reduce to a unique list of ref_libs
   set ref_libs($ref) [lsort -unique $ref_libs($ref)]
   }

   # As blocks are commited add the block as a reference to the top library
   foreach ref ${DP_BLOCK_REFS} {
      puts "RM-info : Adding ./${ref}.nlib as a reference of [get_object_name [current_lib]]"
      set_ref_libs -add ./${ref}.nlib
      puts "RM-info : Commiting block $ref into library $ref.nlib"
      commit_block -library ${ref}.nlib $ref

      # Add a reference to any child blocks
      foreach ref_lib $ref_libs($ref) {
         puts "RM-info : Adding ./${ref}.nlib as a reference of ${ref}.nlib"
         set_ref_libs -library ${ref}.nlib -add ./${ref_lib}.nlib
      }
   }

   # All blocks must be linked in order to create a blackbox
   foreach_in_collection block [get_blocks -hier] {
      link_block $block
   }
   current_block $cd

   # Create the black boxes, and set the area if defined, otherwise
   foreach ref $DP_BB_BLOCK_REFS {
      set inst [filter_collection [get_cells $DP_BLOCK_INSTS] ref_name==$ref]
      if {[info exists DP_BB_BLOCKS($ref,area)]} {
         create_blackbox -target_boundary_area $DP_BB_BLOCKS($ref,area) $inst
      } elseif {[info exists DP_BB_BLOCKS($ref,boundary)]} {
         create_blackbox -boundary $DP_BB_BLOCKS($ref,boundary) $inst
      } else {
         puts "RM-error : Black boxes are defined as $DP_BB_BLOCK_REFS, but have no area or boundary, assign an area in setup.tcl"
         error 
      }
   }

   # Setup distributed host options for blocks
   if {[file exist $BLOCK_DIST_JOB_FILE]} {
      source -echo $BLOCK_DIST_JOB_FILE
   }
}

save_lib -all
report_design > $REPORTS_DIR_INIT_DESIGN/report_design.rpt


echo [date] > init_design
STOP_TIMER BIT_COIN_INIT_DESIGN "Completing BIT_COIN ICC2 Initialization"


   exit 



