#set upf_create_implicit_supply_sets false

puts "RM-Info: Running script [info script]\n"

##########################################################################################
# Variables common to all reference methodology scripts
# Script: common_setup.tcl
# Version: G-2012.06 (July 2, 2012)
# Copyright (C) 2007-2012 Synopsys, Inc. All rights reserved.
##########################################################################################

set wd [pwd]

set DESIGN_NAME                   "bit_coin"  ;#  The name of the top-level design

set DESIGN_REF_DATA_PATH          "$wd/${DESIGN_NAME}_lib"  ;#  Absolute path prefix variable for library/design data.
                                       #  Use this variable to prefix the common absolute path  
                                       #  to the common variables defined below.
                                       #  Absolute paths are mandatory for hierarchical 
                                       #  reference methodology flow.
set INPUT_FORMAT "VERILOG"

##########################################################################################
# Hierarchical Flow Design Variables
##########################################################################################


set HIERARCHICAL_DESIGNS           "bit_top bit_slice" ;# List of hierarchical block design names "DesignA DesignB" ...
set HIERARCHICAL_CELLS             "bit_top bit_slice"
##########################################################################################
# Library Setup Variables
##########################################################################################

# For the following variables, use a blank space to separate multiple entries.
# Example: set TARGET_LIBRARY_FILES "lib1.db lib2.db lib3.db"

set skip_local_link_library true


set ADDITIONAL_SEARCH_PATH        ". ../../rtl ../../upf ../../verification ../../lib ../../lib/sram/ndms/lib_dbs ../../lib/stdcell_hvt/db_nldm_gm ../../lib/stdcell_lvt/db_nldm ../../lib/stdcell_rvt/db_nldm"



set hvt_libs " \
saed32hvt_tt0p78v125c.db \
saed32hvt_tt0p85v125c.db \
saed32hvt_tt1p05v125c.db \
saed32hvt_ulvl_tt0p78v125c_i0p78v.db \
saed32hvt_ulvl_tt0p85v125c_i0p85v.db \
saed32hvt_ulvl_tt1p05v125c_i0p78v.db \
saed32hvt_dlvl_tt0p78v125c_i0p78v.db \
saed32hvt_dlvl_tt0p85v125c_i0p85v.db \
saed32hvt_pg_tt0p78v125c.db \
saed32hvt_pg_tt0p85v125c.db \
saed32hvt_pg_tt1p05v125c.db \
"
set rvt_libs " \
saed32rvt_tt0p78v125c.db \
saed32rvt_tt0p85v125c.db \
saed32rvt_tt1p05v125c.db \
saed32rvt_ulvl_tt0p78v125c_i0p78v.db \
saed32rvt_ulvl_tt0p85v125c_i0p85v.db \
saed32rvt_ulvl_tt1p05v125c_i0p78v.db \
saed32rvt_dlvl_tt0p78v125c_i0p78v.db \
saed32rvt_dlvl_tt0p85v125c_i0p85v.db \
saed32rvt_pg_tt0p78v125c.db \
saed32rvt_pg_tt0p85v125c.db \
saed32rvt_pg_tt1p05v125c.db \

"
set lvt_libs " \
saed32lvt_tt0p78v125c.db \
saed32lvt_tt0p85v125c.db \
saed32lvt_tt1p05v125c.db \
saed32lvt_ulvl_tt0p78v125c_i0p78v.db \
saed32lvt_ulvl_tt0p85v125c_i0p85v.db \
saed32lvt_ulvl_tt1p05v125c_i0p78v.db \
saed32lvt_dlvl_tt0p78v125c_i0p78v.db \
saed32lvt_dlvl_tt0p85v125c_i0p85v.db \
saed32lvt_pg_tt0p78v125c.db \
saed32lvt_pg_tt0p85v125c.db \
saed32lvt_pg_tt1p05v125c.db \
"

set mem_libs " sram2rw16x4_tt1p78v125c.db  sram2rw16x4_tt1p85v125c.db"



set TARGET_LIBRARY_FILES          "$hvt_libs $rvt_libs $lvt_libs"  ;#  Target technology logical libraries
set ADDITIONAL_LINK_LIB_FILES     "$mem_libs"  ;#  Extra link logical libraries not included in TARGET_LIBRARY_FILES

set MIN_LIBRARY_FILES             ""  ;#  List of max min library pairs "max1 min1 max2 min2 max3 min3"...

set MW_REFERENCE_LIB_DIRS         "../../lib/stdcell_hvt/milkyway/saed32nm_hvt_1p9m ../../lib/stdcell_rvt/milkyway/saed32nm_rvt_1p9m ../../lib/stdcell_lvt/milkyway/saed32nm_lvt_1p9m ../../lib/sram/milkyway_gmaben/SRAM32NM "  ;#  Milkyway reference libraries (include IC Compiler ILMs here)

set MW_REFERENCE_CONTROL_FILE     ""  ;#  Reference Control file to define the Milkyway reference libs

set TECH_FILE                     "../../tech/milkyway/saed32nm_1p9m_mw.tf.gold"  ;#  Milkyway technology file
set MAP_FILE                      "../../tech/milkyway/saed32nm_tf_itf_tluplus.map"  ;#  Mapping file for TLUplus
set TLUPLUS_MAX_FILE              "../../tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus"  ;#  Max TLUplus file
set TLUPLUS_MIN_FILE              "../../tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus"  ;#  Min TLUplus file


set MW_POWER_NET                "VDD" ;#
set MW_POWER_PORT               "VDD" ;#
set MW_GROUND_NET               "VSS" ;#
set MW_GROUND_PORT              "VSS" ;#

set MIN_ROUTING_LAYER            "M1"   ;# Min routing layer
set MAX_ROUTING_LAYER            "M6"   ;# Max routing layer

set LIBRARY_DONT_USE_FILE        "$wd/scripts/dont_use.tcl"   ;# Tcl file with library modifications for dont_use

##########################################################################################
# Multivoltage Common Variables
#
# Define the following multivoltage common variables for the reference methodology scripts 
# for multivoltage flows. 
# Use as few or as many of the following definitions as needed by your design.
##########################################################################################

set PD1                          ""           ;# Name of power domain/voltage area  1
set VA1_COORDINATES              {}           ;# Coordinates for voltage area 1
set MW_POWER_NET1                "VDD1"       ;# Power net for voltage area 1

set PD2                          ""           ;# Name of power domain/voltage area  2
set VA2_COORDINATES              {}           ;# Coordinates for voltage area 2
set MW_POWER_NET2                "VDD2"       ;# Power net for voltage area 2

set PD3                          ""           ;# Name of power domain/voltage area  3
set VA3_COORDINATES              {}           ;# Coordinates for voltage area 3
set MW_POWER_NET3                "VDD3"       ;# Power net for voltage area 3

set PD4                          ""           ;# Name of power domain/voltage area  4
set VA4_COORDINATES              {}           ;# Coordinates for voltage area 4
set MW_POWER_NET4                "VDD4"       ;# Power net for voltage area 4

puts "RM-Info: Completed script [info script]\n"

