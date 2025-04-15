puts "RM-info : Running script [info script]\n"

##########################################################################################
# Tool: IC Compiler II
# Script: icc2_common_setup.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################
set wd [pwd]
set LIB_PATH $wd
##########################################################################################
## Required variables
## These variables must be correctly filled in for the flow to run properly
##########################################################################################
set DESIGN_NAME 		"bit_coin"	;# Name of the design to be worked on
set DESIGN_LIBRARY 		"${DESIGN_NAME}.nlib" ;# Name of the design library, default is ${DESIGN_NAME}.nlib

set REFERENCE_LIBRARY 		[list $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_dlvl_tt0p_v.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_pg_tt_v125c.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_tt_v125c.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_pg_v125c.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_dlvl_v.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_ulvl_tt_v.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_v125c.ndm \
                                      $LIB_PATH/lib/stdcell_hvt/ndms/saed32hvt_tt0p_v125c.ndm \
                                      $LIB_PATH/lib/stdcell_lvt/ndms/saed32lvt_pg_c.ndm \
                                      $LIB_PATH/lib/stdcell_lvt/ndms/saed32lvt_c.ndm \
                                      $LIB_PATH/lib/stdcell_lvt/ndms/saed32lvt_dlvl_v.ndm \
                                      $LIB_PATH/lib/stdcell_lvt/ndms/saed32lvt_ulvl_v.ndm \
                                      $LIB_PATH/lib/stdcell_rvt/ndms/saed32rvt_pg_c.ndm \
                                      $LIB_PATH/lib/stdcell_rvt/ndms/saed32rvt_c.ndm \
                                      $LIB_PATH/lib/stdcell_rvt/ndms/saed32rvt_dlvl_v.ndm \
                                      $LIB_PATH/lib/stdcell_rvt/ndms/saed32rvt_ulvl_v.ndm \
                                      $LIB_PATH/lib/sram/ndms/sram2rw16x4_tt1p_v125c.ndm ]	;# A list of reference libraries for the design library.	
				       	;# For hierarchical designs using bottom-up flows, include subblock design libraries in the list;
					;# for hierarchical designs using ETMs, include the ETM library in the list.
					;# If unpack_rm_dirs.pl is used to create dir structures for hierarchical designs, in order to transition between
					;# hierarchical DP and hiearchical PNR flows properly, absolute paths are a requirement.

set VERILOG_NETLIST_FILES	"$wd/outputs2icc2/bit_coin.vg $wd/outputs2icc2/bit_top.vg $wd/outputs2icc2/bit_slice.vg"	;# Verilog netlist files;
					;# 	for DP: required
					;# 	for PNR: required if INIT_DESIGN_INPUT is ASCII in icc2_pnr_setup.tcl; not required for DC_ASCII or DP_RM_NDM

set UPF_FILE 			"$wd/outputs2icc2/wrap_bit_coin.upf"	;# A UPF file
#set UPF_FILE 			"top_wrapper.upf"	;# A UPF file

set TCL_MCMM_SETUP_FILE		"$wd/scripts/icc2_mcmm_setup.tcl"	;# Specify a Tcl script to create your corners, modes, scenarios and load respective constraints;
					;# two examples are provided in rm_icc2_pnr_scripts: 
					;# mcmm_example.explicit.tcl: provide mode, corner, and scenario constraints; create modes, corners, 
					;# and scenarios; source mode, corner, and scenario constraints, respectively 
					;# mcmm_example.auto_expanded.tcl: provide constraints for the scenarios; create modes, corners, 
					;# and scenarios; source scenario constraints which are then expanded to associated modes and corners

set TECH_FILE 			"$LIB_PATH/tech/milkyway/saed32nm_1p9m_mw.tf" 	;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 
					;# TECH_FILE is recommended, although TECH_LIB is also supported in ICC2 RM. 
set TECH_LIB			""	;# Specify the reference library to be used as a dedicated technology library;
                        		;# as a best practice, please list it as the first library in the REFERENCE_LIBRARY list 
set TECH_LIB_INCLUDES_TECH_SETUP_INFO true 
					;# Indicate whether TECH_LIB contains technology setup information such as routing layer direction, offset, 
					;# site default, and site symmetry, etc. TECH_LIB may contain this information if loaded during library prep.
					;# true|false; this variable is associated with TECH_LIB. 
set TCL_TECH_SETUP_FILE		"tech_setup.tcl"
					;# Specify a TCL script for setting routing layer direction, offset, site default, and site symmetry list, etc.
					;# tech_setup.tcl is the default. Use it as a template or provide your own script.
					;# This script will only get sourced if the following conditions are met: 
					;# (1) TECH_FILE is specified (2) TECH_LIB is specified && TECH_LIB_INCLUDES_TECH_SETUP_INFO is false 
set ROUTING_LAYER_DIRECTION_OFFSET_LIST "" 
					;# Specify the routing layers as well as their direction and offset in a list of space delimited pairs;
					;# This variable should be defined for all metal routing layers in technology file;
					;# Syntax is "{metal_layer_1 direction offset} {metal_layer_2 direction offset} ...";
					;# It is required to at least specify metal layers and directions. Offsets are optional. 
					;# Example1 is with offsets specified: "{M1 vertical 0.2} {M2 horizontal 0.0} {M3 vertical 0.2}"
					;# Example2 is without offsets specified: "{M1 vertical} {M2 horizontal} {M3 vertical}"

##########################################################################################
## Optional variables
## Specify these variables if the corresponding functions are desired 
##########################################################################################
set DESIGN_LIBRARY_SCALE_FACTOR	""	;# Specify the length precision for the library. Length precision for the design
					;# library and its ref libraries must be identical. Tool default is 10000, which
					;# implies one unit is one Angstrrom or 0.1nm.

set UPF_UPDATE_SUPPLY_SET_FILE 	""	;# A UPF file to resolve UPF supply sets

set DEF_FLOORPLAN_FILES		""	;# DEF files which contains the floorplan information;
					;# 	for DP: not required
					;# 	for PNR: required if INIT_DESIGN_INPUT = ASCII in icc2_pnr_setup.tcl and initialize_floorplan is not used;
					;# 	not required if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM

set DEF_SCAN_FILE		""	;# A scan DEF file for scan chain information;
					;# 	for PNR: not required if INIT_DESIGN_INPUT = DC_ASCII or DP_RM_NDM, as SCANDEF is expected to be loaded already

set DEF_SITE_NAME_PAIRS		{}	;# A list of site name pairs for read_def -convert; 
					;# specify site name pairs with from_site first followed by to_site;
					;# Example: set DEF_SITE_NAME_PAIRS {{from_site_1 to_site_1} {from_site_2 to_site_2}} 	

set SITE_DEFAULT	""		;# Specify the default site name if there are multiple site defs in the technology file;
					;# this is to be used by initialize_floorplan command; example: set SITE_DEFAULT "unit";
					;# this is appied in the tech_setup.tcl script 
set SITE_SYMMETRY_LIST	""		;# Specify a list of site def and its symmetry value; 
					;# this is to be used by read_def or initialize_floorplan command to control the site symmetry;
					;# example: set SITE_SYMMETRY_LIST "{unit Y} {unit1 Y}"; this is applied in the tech_setup.tcl script 

set MIN_ROUTING_LAYER		"M1"	;# Min routing layer name; normally should be specified; otherwise tool can use all metal layers  
set MAX_ROUTING_LAYER		"M6"	;# Max routing layer name; normally should be specified; otherwise tool can use all metal layers

set LINK_LIBRARY		""	;# Specify logical link libraries, ie, db files;
					;# required only if you run VC-LP (vc_lp.tcl) and Formality (fm.tcl)

##########################################################################################
## Variables related to flow controls of flat PNR, hierarchical PNR and transition with DP
##########################################################################################
set DESIGN_STYLE		"hier"	;# Specify the design style; flat|hier; default is flat; 
					;# specify flat for a totally flat flow (flat PNR for short) and 
					;# specify hier for a hierarchical flow (hier PNR for short);
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR: this should set to flat (default)
					;#	for DP: not used 

set PHYSICAL_HIERARCHY_LEVEL	"top" 	;# Specify the current level of hierarchy for the hierarchical PNR flow; top|intermediate|bottom;
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR and for DP: not used.

set RELEASE_DIR_DP		"./flat_place_and_route" 	;# Specify the release directory of DP RM; 
					;# this is where init_design.tcl of PNR flow gets DP RM released libraries; 
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR: required if INIT_DESIGN_INPUT = DP_RM_NDM, as init_design.tcl needs to know where DP RM libraries are
					;#	for DP: not used 

set RELEASE_DIR_PNR		"./rm_icc2_pnr_scripts" 	;# Specify the release directory of PNR RM; 
					;# this is where the init_design.tcl of hierchical PNR flow gets the sub-block libraries;	
					;# 	for hier PNR: required and auto set if unpack_rm_dirs.pl is used; (see README.unpack_rm_dirs.txt for details)
					;# 	for flat PNR and for DP: not used.

puts "RM-info : Completed script [info script]\n"

