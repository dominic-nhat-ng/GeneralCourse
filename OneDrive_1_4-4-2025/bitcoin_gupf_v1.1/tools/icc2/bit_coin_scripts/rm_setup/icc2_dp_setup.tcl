puts "RM-info : Running script [info script]\n"
##########################################################################################
# Tool: IC Compiler II
# Script: icc2_dp_setup.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_common_setup.tcl


##########################################################################################
# 				Flow Setup
##########################################################################################
set DP_FLOW "hier" ;# hier or flat

set DISTRIBUTED 0  ;# Use distributed runs
### It is required to include the set_host_options command to enable distributed mode tasks. For example,
#set_host_options -name block_script -submit_command [list qsub -P bnormal -l mem_free=6G,qsc=i -cwd]

set BLOCK_DIST_JOB_FILE             ""     ;# File to set block specific resource requests for distributed jobs
# For example:
#   set_host_options -name block_script  -submit_command "bsub -q normal"
#   set_host_options -name large_block   -submit_command "bsub -q huge"
#   set_host_options -name special_block -submit_command "rsh" local_machine
#   set_app_options -block [get_block block4] -list {plan.distributed_run.block_host large_block}
#   set_app_options -block [get_block block5] -list {plan.distributed_run.block_host large_block}
#   set_app_options -block [get_block block2] -list {plan.distributed_run.block_host special_block}
#  
#   All the jobs associated with blocks that do not have the plan.distributed_run.block_host app option specified
#   will run using the block_script host option. The jobs for blocks block4 and block5 will use the large_block 
#   host option. The job form  block2  will  use  the  special_block host option.


##########################################################################################
# If the design is run with MIBS then change the block list appropriately
##########################################################################################
#set DP_BLOCK_REFS                     [list bit_top ]
set DP_BLOCK_REFS                     [list bit_top bit_slice]
                                             ;# block in the design
set DP_INTERMEDIATE_LEVEL_BLOCK_REFS  [list ]
set DP_BB_BLOCK_REFS                  [list] ;# 

# Provide blackbox instanace: target area, BB UPF file, BB Timing file, boundary
#set DP_BB_BLOCK_REFS "leon3s_bb"
#set DP_BB_BLOCKS(leon3s_bb,area)        [list 1346051] ;
#set DP_BB_BLOCKS(leon3s_bb,upf)         [list ${des_dir}/leon3s_bb.upf] ;
#set DP_BB_BLOCKS(leon3s_bb,timing)      [list ${des_dir}/leon3s_bbt.tcl] ;
#set DP_BB_BLOCKS(leon3s_bb,boundary)    { {x1 y1} {x2 y1} {x2 y2} {x1 y2} {x1 y1} } ;
#set DP_BB_SPLIT    "true"


##########################################################################################
# 				CONSTRAINTS / UPF INTENT
##########################################################################################
set TCL_TIMING_RULER_SETUP_FILE     "" ;# file sourced to define parasitic constraints for use with timing ruler 
                                        # before full extraction environment is defined
                                        # Example setup file:
                                        #       set_parasitic_parameters \
                                        #         -early_spec para_WORST \
                                        #         -late_spec para_WORST
set CONSTRAINT_MAPPING_FILE         "" ;# Constraint Mapping File. Default is "split/mapfile"
set TCL_UPF_FILE                    "" ;# Optional power intent TCL script
set TLU_PLUS_FILE                   "scripts/read_para_setup.tcl" ;# File to read TLU plus files using read_parastic_tech command
                                       ;# If a parastic library containg TLU+ data is created and referenced in 
                                       ;# the REFERENCE_LIBRARY, this file can be ignored 


##########################################################################################
# 				TOP LEVEL FLOORPLAN CREATION (die, pad, RDL) / PLACE IO
##########################################################################################

set TCL_PHYSICAL_CONSTRAINTS_FILE   "" ;# TCL script for primary die area creation
set TCL_PAD_CONSTRAINTS_FILE        "" ;# file sourced to create everything needed by place_io to complete IO placement
                                       ;# including flip chip bumps, and io constraints
set TCL_RDL_FILE                    "" ;# file sourced to create RDL routes
set TCL_PRE_COMMIT_FILE             "" ;# file sourced to set attributes, lib cell purposes, .. etc on specific cells,
				       ;# prior to running commit_block


##########################################################################################
# 				SHAPING
##########################################################################################
set SHAPING_CMD_OPTIONS             "-channels true" ;# Shape blocks command line options
set TCL_SHAPING_CONSTRAINTS_FILE    "" ;# Specify any constraints prior to shaping i.e. set_shaping_options
#set SHAPING_CONSTRAINTS_FILE        "./bitcoin_shaping.tcl" ;# Will be included as the -constraint_file option for shape_blocks
set SHAPING_CONSTRAINTS_FILE        "./scripts/abut_top_cons_shaping.tcl" ;# Will be included as the -constraint_file option for shape_blocks
set TCL_SHAPING_PNS_STRATEGY_FILE   "" ;# file sourced to create PG strategies for block grid creation
set TCL_MANUAL_SHAPING_FILE         "" ;# File sourced to re-create all block shapes.
                                        # If this file exists, automatic shaping will be by-passed.
                                        # Existing auto or manual block shapes can be written out using the following:
                                        #    write_floorplan -objects <BLOCK_INSTS>


##########################################################################################
# 				PLACEMENT
##########################################################################################
set TCL_PLACEMENT_CONSTRAINTS_FILE      "";# Placeholder for any macro or standard cell placement constraints & options.
                                           # File is sourced prior to DP placement
set PLACEMENT_PIN_CONSTRAINT_AWARE      "false" ;# tells create_placement to consider pin constraints during placement
set PLACEMENT_DFF_AWARE                 "false" ;# If set to true, tells create_placement to use DFF during placement 
                                                 # When set to false (default value), normal placement will be done
set USE_INCREMENTAL_DATA                "0" ;# Use floorplan constraints that were written out on a previous run


##########################################################################################
#				GLOBAL PLANNING
##########################################################################################
set TCL_GLOBAL_PLANNING_FILE       "" ;#Global planning for bus/critical nets


##########################################################################################
# 				PNS
##########################################################################################
set TCL_PNS_FILE                   "" ;# File sourced to define all power structures. 
                                       # This file will include the following types of PG commands:
                                       #   PG Regions
                                       #   PG Patterns
                                       #   PG Strategies
                                       # Note: The file should not contain compile_pg statements
                                       # An example is in rm_icc2_dp_scripts/pns_example.tcl
set PNS_CHARACTERIZE_FLOW          "true"  ;# Perform PG characterization and implementation
set TCL_COMPILE_PG_FILE            "scripts/pg_g.tcl" ;# File should contain all the compile_pg_* commands to create the power networks 
                                       # specified in the strategies in the TCL_PNS_FILE. 
                                       # An example is in rm_icc2_dp_scripts/compile_pg_example.tcl
set TCL_PG_PUSHDOWN_FILE           "" ;# Create this file to facilitate manual pushdown and bypass auto pushdown in the flow.
set TCL_POST_PNS_FILE              "" ;# If it exists, this file will be sourced after PG creation.

##########################################################################################
# 				PLACE PINS
##########################################################################################
##Note:Feedthroughs are disabled by default. Enable feedthroughs either through set_*_pin_constraints  Tcl commands or through Pin constraints file
set TCL_PIN_CONSTRAINT_FILE        "./scripts/pin_constraints.tcl" ;# file sourced to apply set_*_pin_constraints to the design
set CUSTOM_PIN_CONSTRAINT_FILE     "" ;# will be loaded via read_pin_constraints -file
                                      ;# used for more complex pin constraints, 
                                      ;# or in constraint replay
set PLACE_PINS_SELF                "true" ;# Set to true if the block's top level pins are not all connected to IO drivers.
#set PLACE_PINS_SELF                "false" ;# Set to true if the block's top level pins are not all connected to IO drivers.


##########################################################################################
# 				PRE-TIMING
##########################################################################################
set BLOCK_CTS_CONSTRAINT_MAPPING_FILE "" ;# Specify CTS constraints mapping file. When CTS constraints are sourced in the subblocks prior to estimating the clock latency


##########################################################################################
# 				TIMING ESTIMATION
##########################################################################################
set TCL_TIMING_ESTIMATION_SETUP_FILE  "" ;# Specify any constraints prior to timing estimation


##########################################################################################
# 				BUDGETING
##########################################################################################
set TCL_BUDGETING_SETUP_FILE          "" ;# Specify any constraints prior to budgeting


##########################################################################################
## System Variables (there's no need to change the following)
##########################################################################################
set WORK_DIR ${DESIGN_NAME}_SPLIT_DIR 
set WORK_DIR_SPLIT_CONSTRAINTS $WORK_DIR/split_constraints
set WORK_DIR_INIT_DESIGN $WORK_DIR/init_design
set WORK_DIR_PRE_SHAPING $WORK_DIR/pre_shaping
set WORK_DIR_PLACE_IO $WORK_DIR/place_io
set WORK_DIR_SHAPING $WORK_DIR/shaping
set WORK_DIR_PLACEMENT $WORK_DIR/placement
set WORK_DIR_CREATE_POWER $WORK_DIR/create_power
set WORK_DIR_PLACE_PINS $WORK_DIR/place_pins
set WORK_DIR_PRE_TIMING $WORK_DIR/pre_timing
set WORK_DIR_TIMING_ESTIMATION $WORK_DIR/timing_estimation
set WORK_DIR_BUDGETING $WORK_DIR/budgeting
set WORK_DIR_WRITE_DATA $WORK_DIR/write_data
if !{[file exists $WORK_DIR_SPLIT_CONSTRAINTS]} {file mkdir $WORK_DIR_SPLIT_CONSTRAINTS}
if !{[file exists $WORK_DIR_INIT_DESIGN]} {file mkdir $WORK_DIR_INIT_DESIGN}

## Directories
set OUTPUTS_DIR	"./outputs"	;# Directory to write output data files; mainly used by write_data.tcl
set REPORTS_DIR	"./reports"		;# Directory to write reports; mainly used by report_qor.tcl

set REPORTS_DIR_SPLIT_CONSTRAINTS $REPORTS_DIR/split_constraints
set REPORTS_DIR_INIT_DESIGN $REPORTS_DIR/init_design
set REPORTS_DIR_PRE_SHAPING $REPORTS_DIR/pre_shaping
set REPORTS_DIR_PLACE_IO $REPORTS_DIR/place_io
set REPORTS_DIR_SHAPING $REPORTS_DIR/shaping
set REPORTS_DIR_PLACEMENT $REPORTS_DIR/placement
set REPORTS_DIR_CREATE_POWER $REPORTS_DIR/create_power
set REPORTS_DIR_PLACE_PINS $REPORTS_DIR/place_pins
set REPORTS_DIR_PRE_TIMING $REPORTS_DIR/pre_timing
set REPORTS_DIR_TIMING_ESTIMATION $REPORTS_DIR/timing_estimation
set REPORTS_DIR_BUDGETING $REPORTS_DIR/budgeting

if !{[file exists $REPORTS_DIR]} {file mkdir $REPORTS_DIR}
if !{[file exists $OUTPUTS_DIR]} {file mkdir $OUTPUTS_DIR}
if !{[file exists $REPORTS_DIR_SPLIT_CONSTRAINTS]} {file mkdir $REPORTS_DIR_SPLIT_CONSTRAINTS}
if !{[file exists $REPORTS_DIR_INIT_DESIGN]} {file mkdir $REPORTS_DIR_INIT_DESIGN}
if !{[file exists $REPORTS_DIR_PRE_SHAPING]} {file mkdir $REPORTS_DIR_PRE_SHAPING}
if !{[file exists $REPORTS_DIR_PLACE_IO]} {file mkdir $REPORTS_DIR_PLACE_IO}
if !{[file exists $REPORTS_DIR_SHAPING]} {file mkdir $REPORTS_DIR_SHAPING}
if !{[file exists $REPORTS_DIR_PLACEMENT]} {file mkdir $REPORTS_DIR_PLACEMENT}
if !{[file exists $REPORTS_DIR_CREATE_POWER]} {file mkdir $REPORTS_DIR_CREATE_POWER}
if !{[file exists $REPORTS_DIR_PLACE_PINS]} {file mkdir $REPORTS_DIR_PLACE_PINS}
if !{[file exists $REPORTS_DIR_PRE_TIMING]} {file mkdir $REPORTS_DIR_PRE_TIMING}
if !{[file exists $REPORTS_DIR_TIMING_ESTIMATION]} {file mkdir $REPORTS_DIR_TIMING_ESTIMATION}
if !{[file exists $REPORTS_DIR_BUDGETING]} {file mkdir $REPORTS_DIR_BUDGETING}

if {[info exists env(LOGS_DIR)]} {
   set log_dir $env(LOGS_DIR)
} else {
   set log_dir ./logs
}


##########################################################################################
# 				Enable Design Metrics Reporting
##########################################################################################
#source ./rm_icc2_hier_scripts/design_metrics/setup.tcl
#source ./rm_icc2_hier_scripts/design_metrics/process_reports.tcl
#source ./rm_icc2_hier_scripts/design_metrics/report_design_metrics.tcl
##########################################################################################


   set search_path [list ./rm_icc2_dp_scripts $WORK_DIR] 
lappend search_path .
lappend search_path outputs2icc2
lappend search_path results


##########################################################################################
# 				Optional Settings
##########################################################################################
set_message_info -id PVT-012 -limit 1
set_message_info -id PVT-013 -limit 1

#source scripts/icc2_upf_vars.tcl
#suppress_message UPF-076


puts "RM-info : Completed script [info script]\n"
