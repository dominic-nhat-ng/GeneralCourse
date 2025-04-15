##########################################################################################
# Tool: IC Compiler II
# Script: init_design.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_pnr_setup.tcl 
source scripts/procs.tcl
set stage init
set report_dir ${REPORTS_DIR}
set_svf ${DESIGN_NAME}_svf
START_TIMER bs_timer "Starting Bit Slice ICC2 Init"


########################################################################
## Design creation (depends on value of INIT_DESIGN_INPUT)
#  For ASCII and DC_ASCII : create design library and create block from input files
#  For DP_RM_NDM : Copy, open design library and open block	
########################################################################
if {$INIT_DESIGN_INPUT == "DP_RM_NDM"} {

	## Copy designs from ICC2-DP-RM release area
	puts "RM-info: Sourcing [which import_from_dp.tcl]"
	source -e import_from_dp.tcl

        if {$DESIGN_STYLE == "flat"} {
                ## For totally flat designs, open the design copied from ICC2 DP RM release area
                open_lib ${DESIGN_NAME}.nlib
                open_block ${DESIGN_NAME}/init_design
        
        } elseif {$DESIGN_STYLE == "hier"} {
                if {$PHYSICAL_HIERARCHY_LEVEL == "bottom"} {
                	## For bottom level of hier designs, open the design copied from ICC2 DP RM release area
                	open_lib ${DESIGN_NAME}.nlib
                	open_block ${DESIGN_NAME}/init_design
                } elseif {$PHYSICAL_HIERARCHY_LEVEL == "top" || $PHYSICAL_HIERARCHY_LEVEL == "intermediate"} {
			## For top or intermediate level of hier designs, link to sub-blocks in PNR RM release area
			puts "RM-info: Sourcing [which create_softlinks_to_subblocks.tcl]"
			source -e create_softlinks_to_subblocks.tcl

                	## For top or intermediate level of hier designs, open the copied design and do change_abstract
                	open_lib ${DESIGN_NAME}.nlib
                	open_block ${DESIGN_NAME}/init_design
                	## Swap abstracts created after DesignPlanning to abstracts specified for place_opt
                	if {$DESIGN_STYLE == "hier" && $USE_ABSTRACTS_FOR_BLOCKS != ""} {
                	      puts "RM-info: Swap abstracts created after ICC2-DP-RM with $BLOCK_ABSTRACT_FOR_PLACE_OPT abstracts for all blocks."
                	      change_abstract -view abstract -references $USE_ABSTRACTS_FOR_BLOCKS -label $BLOCK_ABSTRACT_FOR_PLACE_OPT
                	      report_abstracts
                	}
                }
        }

} elseif {$INIT_DESIGN_INPUT == "ASCII" || $INIT_DESIGN_INPUT == "DC_ASCII"} {

	if {[file exists $DESIGN_LIBRARY]} {
		file delete -force $DESIGN_LIBRARY
	}
	
	set create_lib_cmd "create_lib $DESIGN_LIBRARY"
	if {[file exists [which $TECH_FILE]]} {
		lappend create_lib_cmd -tech $TECH_FILE ;# recommended
	} elseif {$TECH_LIB != ""} {
		lappend create_lib_cmd -use_technology_lib $TECH_LIB ;# optional
	}
	if {$DESIGN_LIBRARY_SCALE_FACTOR != ""} {
		lappend create_lib_cmd -scale_factor $DESIGN_LIBRARY_SCALE_FACTOR
	}
	lappend create_lib_cmd -ref_libs $REFERENCE_LIBRARY
	puts "RM-info : $create_lib_cmd"
	eval $create_lib_cmd
}

redirect -file ${REPORTS_DIR}/${INIT_DESIGN_BLOCK_NAME}.report_ref_libs {report_ref_libs}

########################################################################
## INIT_DESIGN_INPUT = ASCII : 
## reads ASCII verilog, UPF, MCMM constraints, floorplan, and scandef  
########################################################################
if {$INIT_DESIGN_INPUT == "ASCII"} {
	read_verilog -top $DESIGN_NAME $VERILOG_NETLIST_FILES
	current_block $DESIGN_NAME
	link_block
	save_lib

	## For hierarchical designs using ETMs, pls specify ETM UPF constraint mapping file 
	if {$DESIGN_STYLE == "hier" && $USE_ETM_FOR_BLOCKS != ""} {
		## Specify mapping of blocks and ETM UPFs
		if {[file exists $ETM_UPF_MAPPING_FILE]} {
			puts "RM-info: Sourcing [which $ETM_UPF_MAPPING_FILE]"
			set_constraint_mapping_file $ETM_UPF_MAPPING_FILE
		} elseif {$ETM_UPF_MAPPING_FILE != ""}{
			puts "RM-error: ETM_UPF_MAPPING_FILE($ETM_UPF_MAPPING_FILE) is invalid. Please correct it."
		}
	}
	
	####################################
	## Load and commit UPF file
	####################################
	if {[file exists [which $UPF_FILE]]} {
		load_upf $UPF_FILE
		if {[file exists [which $UPF_UPDATE_SUPPLY_SET_FILE]]} {
			load_upf $UPF_UPDATE_SUPPLY_SET_FILE
		} elseif {$UPF_UPDATE_SUPPLY_SET_FILE != ""} {
			puts "RM-error: UPF_UPDATE_SUPPLY_SET_FILE($UPF_UPDATE_SUPPLY_SET_FILE) is invalid. Please correct it."
		}
		commit_upf
		associate_mv_cells -all
	} elseif {$UPF_FILE != ""} {
		puts "RM-error : UPF file($UPF_FILE) is invalid. Please correct it."
	}
	
	####################################
	## Timing constraints
	####################################
	## Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
	#  Two examples are provided in rm_icc2_pnr_scripts: 
	# 	- mcmm_example.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
	# 	  and scenarios; source mode, corner, and scenario constraints, respectively 
	# 	- mcmm_example.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
	# 	  and scenarios; source scenario constraints which are then expanded to associated modes and corners
	if {[file exists [which $TCL_MCMM_SETUP_FILE]]} {
		puts "RM-info : Sourcing [which $TCL_MCMM_SETUP_FILE]"
		source -echo $TCL_MCMM_SETUP_FILE
	} elseif {$TCL_MCMM_SETUP_FILE != ""} {
		puts "RM-error : TCL_MCMM_SETUP_FILE($TCL_MCMM_SETUP_FILE) is invalid. Please correct it."
	}
	
	####################################
	## Floorplanning 
	####################################

	## Technology setup for routing layer direction, offset, site default, and site symmetry.
	#  If TECH_FILE is specified, they should be properly set. 
	#  If TECH_LIB is used and it does not contain such information, then they should be set here as well.
	if {$TECH_FILE != "" || ($TECH_LIB != "" && !$TECH_LIB_INCLUDES_TECH_SETUP_INFO)} {
		if {[file exists [which $TCL_TECH_SETUP_FILE]]} {
			puts "RM-info : Sourcing [which $TCL_TECH_SETUP_FILE]"
			source -e $TCL_TECH_SETUP_FILE
		} elseif {$TCL_TECH_SETUP_FILE != ""} {
			puts "RM-error : TCL_TECH_SETUP_FILE($TCL_TECH_SETUP_FILE) is invalid. Please correct it."
		}
	}
	
	## Create floorplan by read_def or initialize_floorplan
	if {$DEF_FLOORPLAN_FILES != ""} {
		set DEF_FLOORPLAN_FILE_is_not_found FALSE
		foreach def_file $DEF_FLOORPLAN_FILES {
	      		if {![file exists [which $def_file]]} {
	      			puts "RM-error : DEF floorplan file ($def_file) is invalid."
	      			set DEF_FLOORPLAN_FILE_is_not_found TRUE
	      		}
		}
	
	      	if {!$DEF_FLOORPLAN_FILE_is_not_found} {
	      		set read_def_cmd "read_def -allow_cell_creation [list $DEF_FLOORPLAN_FILES]"
	      		if {$DEF_SITE_NAME_PAIRS != ""} {lappend read_def_cmd -convert $DEF_SITE_NAME_PAIRS}
	      		puts "RM-info : Creating floorplan from DEF file DEF_FLOORPLAN_FILES ($DEF_FLOORPLAN_FILES)"
	      		eval $read_def_cmd
	      		
	      		      resolve_pg_nets  
	      	} else {
	      		puts "RM-error : At least one of the DEF_FLOORPLAN_FILES specified is invalid. Pls correct it."
	      		puts "RM-info : Skipped reading of DEF_FLOORPLAN_FILES"
	      	}
	}
	
	if {$DEF_FLOORPLAN_FILES == "" || $DEF_FLOORPLAN_FILE_is_not_found} {
	      	puts "RM-info : Invalid DEF floorplan files provided, running initialize_floorplan instead"
	
	
		initialize_floorplan
		# place_pins -self ;# to place unplaced pins if needed
	}
	
	## Additional floorplan constriants 
	#  If DEF_FLOORPLAN_FILES is provided but can not cover certain floorplan constraint types, then they can be provided here.
	#  If initialize_floorplan is used, additional floorplan constraints can be provided here. 
	#  For example, bounds, pin guides, or route guides, etc
	if {[file exists [which $TCL_FLOORPLAN_FILE]]} {
		puts "RM-info : Adding additional floorplan information from TCL_FLOORPLAN_FILE ($TCL_FLOORPLAN_FILE)"
		source $TCL_FLOORPLAN_FILE
	} elseif {$TCL_FLOORPLAN_FILE != ""} {
		puts "RM-error : TCL_FLOORPLAN_FILE($TCL_FLOORPLAN_FILE) is invalid. Please correct it."
	}
	
	## For IO, and macro cell placement, you can refer to the following example : 
	#  rm_icc2_flat_scripts/init_design_flat_design_planning_example.tcl
	
	####################################
	## SCANDEF 
	####################################
	if {[file exists [which $DEF_SCAN_FILE]]} {
		read_def $DEF_SCAN_FILE
	} elseif {$DEF_SCAN_FILE != ""} {
		puts "RM-error : DEF_SCAN_FILE($DEF_SCAN_FILE) is invalid. Please correct it."
	}

########################################################################
## INIT_DESIGN_INPUT = DC_ASCII : 
## sources specified write_icc2_files output from DC and commit UPF  
########################################################################
} elseif {$INIT_DESIGN_INPUT == "DC_ASCII"} {

	if {[file exists ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl]} {
		## Read in design output files from Design Compiler's write_icc2_files command
		source ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl
		commit_upf
		associate_mv_cells -all
	} else {
		puts "RM-error : ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl is not found." 
		puts "RM-warning : ${DCRM_RESULTS_DIR}/${DCRM_FINAL_DESIGN_ICC2}/${DESIGN_NAME}.icc2_script.tcl is required for DC_ASCII flow." 
	}

}

####################################
## Additional timer related setups : 
## AOCV	
####################################
## Read Advanced on-chip variation (AOCV) derate factor table to reduce pessimism
if {$OCVM_CORNER_TABLE_MAPPING_LIST != ""} {
	unset -nocomplain OCVM_CORNER_TABLE_MAPPING; array unset OCVM_CORNER_TABLE_MAPPING
	array set OCVM_CORNER_TABLE_MAPPING_ARRAY $OCVM_CORNER_TABLE_MAPPING_LIST 
	# Above creates the array OCVM_CORNER_TABLE_MAPPING_ARRAY from user specified OCVM_CORNER_TABLE_MAPPING_LIST
	# For ex, if OCVM_CORNER_TABLE_MAPPING_LIST is specified as "corner1 table1 corner2 table2",
	# with OCVM_CORNER_TABLE_MAPPING_ARRAY, array keys would be corner1 and corner2 while respective values would be table1 and table2 
	# Then table1 will be read for corner1, while table2 will be read for corner2 below.
	
	## Set user-specified instance based random coefficient for the AOCV analysis 
	#  Example : set_aocvm_coefficient <value> [get_lib_cells <lib_cell>]
	
	foreach corner [array name OCVM_CORNER_TABLE_MAPPING_ARRAY] {
		if {[file exists [which $OCVM_CORNER_TABLE_MAPPING_ARRAY($corner)]]} {
			puts "RM-info : Reading AOCV table $OCVM_CORNER_TABLE_MAPPING_ARRAY($corner) for corner $corner"
	        	read_ocvm -corners $corner $OCVM_CORNER_TABLE_MAPPING_ARRAY($corner)
		} else {
	        	puts "RM-error: For corner $corner, AOCV table file $OCVM_CORNER_TABLE_MAPPING_ARRAY($corner) is not found"
	      	}
	}
}

####################################
## Additional timer related setups : 
## create path groups 	
####################################
if {$CREATE_IO_PATH_GROUPS} {
	## Tool auto creates 3 IO path groups : in2reg_default, reg2out_default, and in2out_default
	set_app_options -name time.enable_io_path_groups -value true  
}
	## Optionally create a register to register group
	#  set cur_mode [current_mode]
	#  foreach_in_collection mode [all_modes] {
	#  	current_mode $mode;
	#  	group_path -name reg2reg -from [all_clocks] -to [all_clocks] ;# creates register to register path group   
	#  }
	#  current_mode $cur_mode

	## Optionally increase path group weight on critical path groups, for ex:
	#	group_path -name xyz -weight 15

	redirect -file ${REPORTS_DIR}/${INIT_DESIGN_BLOCK_NAME}.report_path_groups {report_path_groups -nosplit -modes [all_modes]}

####################################
## Additional timing setups : 
## remove propagated clocks	
####################################
## Remove all propagated clocks
set cur_mode [current_mode]
foreach_in_collection mode [all_modes] {
	current_mode $mode
	remove_propagated_clocks [all_clocks]
	remove_propagated_clocks [get_ports]
	remove_propagated_clocks [get_pins -hierarchical]
}
current_mode $cur_mode

# To set clock gating check :
# set cur_mode [current_mode]
# foreach_in_collection mode [all_modes] {
#	current_mode $mode
#	set_clock_gating_check -setup 0 [current_design]
#	set_clock_gating_check -hold  0 [current_design]
# }
# current_mode $cur_mode


if {$TCL_USER_CONNECT_PG_NET_SCRIPT != ""} {
	if {[file exists [which $TCL_USER_CONNECT_PG_NET_SCRIPT]]} {
		puts "RM-info: Sourcing [which $TCL_USER_CONNECT_PG_NET_SCRIPT]"
  		source $TCL_USER_CONNECT_PG_NET_SCRIPT
	} elseif {$TCL_USER_CONNECT_PG_NET_SCRIPT != ""} {
		puts "RM-error: TCL_USER_CONNECT_PG_NET_SCRIPT($TCL_USER_CONNECT_PG_NET_SCRIPT) is invalid. Pls correct it."
	}
} else {
	connect_pg_net
	# For non-MV designs with more than one PG, you should use connect_pg_net in manual mode.
}

####################################
## MV setup :
## provide a customized MV script	
####################################
## A Tcl script placeholder for your MV setup commands,such as create_voltage_area, placement bound, 
#  power switch creation and level shifter insertion, etc
if {[file exists [which $TCL_MV_SETUP_FILE]]} {
	puts "RM-info : Sourcing [which $TCL_MV_SETUP_FILE]"
	source -echo $TCL_MV_SETUP_FILE
} elseif {$TCL_MV_SETUP_FILE != ""} {
	puts "RM-error: TCL_MV_SETUP_FILE($TCL_MV_SETUP_FILE) is invalid. Pls correct it."
}

## For a sample script to insert, assign, and connect power switches, 
#  refer to power_switch_example.tcl

####################################
## Power and ground network 	
####################################
## A Tcl script placeholder for your power ground network creation commands, such as create_pg*, 
#  set_pg_strategy, compile_pg, etc
if {[file exists [which $TCL_PG_CREATION_FILE]]} {
	puts "RM-info : Sourcing [which $TCL_PG_CREATION_FILE]"
	source -echo $TCL_PG_CREATION_FILE
} elseif {$TCL_PG_CREATION_FILE != ""} {
	puts "RM-error: TCL_PG_CREATION_FILE($TCL_PG_CREATION_FILE) is invalid. Pls correct it."
}

## Create standard cell PG rail
#  Example : rm_icc2_flat_scripts/init_design_std_cell_rail_example.tcl

## Verify technology routing DRC and illegal overlaps of PG net objects.
#	check_pg_drc

####################################
## Boundary cells, tap cells, etc 	
####################################
## Boundary cells 
#  Add boundary cells around the boundaries of objects, such as voltage areas, macros, blockages, and the core area
#	create_boundary_cells

## Tap cells 
#  Example : create_tap_cells -lib_cell myLib/Cell1 -distance 30 -pattern every_row

####################################
## Post-init_design customizations
####################################
if {[file exists [which $TCL_USER_INIT_DESIGN_POST_SCRIPT]]} {
        puts "RM-info: Sourcing [which $TCL_USER_INIT_DESIGN_POST_SCRIPT]"
        source $TCL_USER_INIT_DESIGN_POST_SCRIPT
} elseif {$TCL_USER_INIT_DESIGN_POST_SCRIPT != ""} {
        puts "RM-error: TCL_USER_INIT_DESIGN_POST_SCRIPT($TCL_USER_INIT_DESIGN_POST_SCRIPT) is invalid. Please correct it."
}

#set_app_options -name route.common.number_of_secondary_pg_pin_connections -value 8

set_app_options -name opt.dft.clock_aware_scan -value true
set_app_options -name opt.dft.optimize_scan_chain -value true
set_app_options -name opt.power.mode -value total



read_def def/bs.def
source -e -v scripts/bs_va.tcl
#source -e -v scripts/bs_pb.tcl
read_def $DEF_SCAN_FILE
save_upf ${REPORTS_DIR}/${INIT_DESIGN_BLOCK_NAME}.save_upf

remove_pin_blockages -all


source -e -v scripts/insert_power_switch.tcl
source -e -v scripts/preroute_bs.tcl

if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	save_block -as ${DESIGN_NAME}/$INIT_DESIGN_BLOCK_NAME
} else {
	save_block -as $INIT_DESIGN_BLOCK_NAME
}
set_app_options -name {time.delay_calculation_style} -value auto
save_block
save_lib

####################################
## Sanity checks and QoR Report	
####################################
if {$REPORT_QOR} {
	set REPORT_PREFIX $INIT_DESIGN_BLOCK_NAME
	puts "RM-info: Sourcing [which $REPORT_QOR_SCRIPT]"
	source $REPORT_QOR_SCRIPT ;# reports with zero interconnect delay

	## Check the technology file before starting place and route flow
	write_tech_file ${REPORTS_DIR}/${REPORT_PREFIX}.tech_file.dump
}


GENERATE_REPORTS_SUMMARY
print_message_info -ids * -summary
echo [date] > init_design
STOP_TIMER bs_timer "Completing Bit Slice ICC2 Init"

exit 

