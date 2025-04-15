##########################################################################################
# Tool: IC Compiler II
# Script: split_constraints.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

 source -echo ./rm_setup/icc2_dp_setup.tcl 

################################################################################
# Create and read the design	
################################################################################

set_app_option -as_user_default -list {mv.hierarchical.allow_voltage_violation true}
set_app_option -as_user_default -list {mv.hierarchical.ignore_mib_checking_error true}

if {[file exists $WORK_DIR_SPLIT_CONSTRAINTS]} {
   file delete -force $WORK_DIR_SPLIT_CONSTRAINTS
   exec mkdir $WORK_DIR_SPLIT_CONSTRAINTS
}


set create_lib_cmd "create_lib ${WORK_DIR_SPLIT_CONSTRAINTS}/$DESIGN_LIBRARY"
if {[file exists [which $TECH_FILE]]} {
   lappend create_lib_cmd -tech $TECH_FILE ;# recommended
} elseif {$TECH_LIB != ""} {
   lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
}
lappend create_lib_cmd -ref_libs $REFERENCE_LIBRARY
puts "RM-info : $create_lib_cmd"
eval $create_lib_cmd


puts "RM-info : Reading verilog file(s) $VERILOG_NETLIST_FILES"
read_verilog -top ${DESIGN_NAME} ${VERILOG_NETLIST_FILES}

if {[file exists [which $UPF_FILE]]} {
   puts "RM-info : Loading UPF file $UPF_FILE"
   load_upf $UPF_FILE
   if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
   	load_upf $UPF_UPDATE_SUPPLY_SET_FILE
   }
   commit_upf
} else {
   puts "RM-warning : UPF file not found or not specified."
}

source -e -v scripts/direction.tcl
source scripts/icc2_upf_vars.tcl



# Read TLU+
if {[file exists [which $TLU_PLUS_FILE]]} {
   puts "RM-info : Sourcing [which $TLU_PLUS_FILE]"
   source -echo $TLU_PLUS_FILE
} else {
   puts "RM-info : No TLU plus files sourced, Parastic library containing TLU+ must be included in library reference list"
}

if {[file exists [which $TCL_MCMM_SETUP_FILE]]} {
   puts "RM-info : Sourcing [which $TCL_MCMM_SETUP_FILE]"
   source -echo $TCL_MCMM_SETUP_FILE
} else {
   puts "RM-error : TCL_MCMM_SETUP_FILE not found or not specified."
} 




file delete -force split

# Derive block instances from block references if not already defined.
set DP_BLOCK_INSTS ""
foreach ref "$DP_BLOCK_REFS" {
   set DP_BLOCK_INSTS "$DP_BLOCK_INSTS [get_object_name [get_cells -hier -filter ref_name==$ref]]"
}

set_budget_options -add_blocks $DP_BLOCK_INSTS



set slice_cells [get_cells bit_secure_*]

source -e -v scripts/icc2_mcmm_setup.tcl
#connect_pg_net
#check_mv_design

#foreach_in_collection slice_cell $slice_cells {
# set cell_name [get_object_name $slice_cell]
# set_level_shifter -domain [get_power_domains -of_object $cell_name] -elements [list [get_pins "$cell_name/isolation_signals[1]"]] -no_shift LS_no_shift_top_${cell_name}
#}

#commit_upf
#connect_pg_net
#check_mv_design




if {$DP_INTERMEDIATE_LEVEL_BLOCK_REFS != ""} {
   puts "RM-info : splitting constraints using -design_subblocks"
   split_constraints -design_subblocks $DP_INTERMEDIATE_LEVEL_BLOCK_REFS -nosplit 
} else {
   puts "RM-info : splitting constraints"
   split_constraints -nosplit
}

if {[info exists $DP_BB_BLOCK_REFS] && $DP_BB_BLOCK_REFS != ""} {
   set DP_BB_BLOCK_INSTS ""
   foreach ref $DP_BB_BLOCK_REFS {
     set DP_BB_BLOCK_INSTS "$DP_BB_BLOCK_INSTS [get_object_name [get_cells -hier -filter ref_name==$ref]]"
   }
   set cb [current_block]
   foreach bb $DP_BB_BLOCK_INSTS { create_blackbox $bb }
   foreach bb $DP_BB_BLOCK_REFS {
      # If BB UPF provided, load it
      if {[info exists DP_BB_BLOCKS(${bb},upf)] && [file exists $DP_BB_BLOCKS(${bb},upf)]} {
         current_block ${bb}.design
         load_upf $DP_BB_BLOCKS(${bb},upf)
         commit_upf
         save_upf -for_empty_blackbox ./split/$bb/top.upf
         current_block $DESIGN_NAME
      }
      # if BB timing exists put it in split directory as well
      if {[info exists DP_BB_BLOCKS(${bb},timing)] && [file exists $DP_BB_BLOCKS(${bb},timing)]} {
         exec cat $DP_BB_BLOCKS(${bb},timing) >> ./split/$bb/top.tcl
      }
   }
}
#return
close_lib

file delete -force $WORK_DIR_SPLIT_CONSTRAINTS/${DESIGN_LIBRARY}

echo [date] > split_constraints

   exit 
