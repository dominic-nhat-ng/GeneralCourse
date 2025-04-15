source -echo -verbose ./rm_setup/common_setup.tcl
source -echo -verbose ./rm_setup/dc_setup_filenames.tcl

puts "RM-Info: Running script [info script]\n"

#################################################################################
# Design Compiler Reference Methodology Setup for Hierarchical Flow
# Script: dc_setup.tcl
# Version: H-2013.03-SP2 (August 5, 2013)
# Copyright (C) 2007-2013 Synopsys, Inc. All rights reserved.
#################################################################################

##########################################################################################
# Hierarchical Flow Blocks
#
# If you are performing a hierarchical flow, define the hierarchical designs here.
# List the reference names of the hierarchical blocks.  Cell instance names will
# be automatically derived from the design names provided.
#
# Note: These designs are expected to be unique. There should not be multiple
#       instantiations of physical hierarchical blocks.
#
#       IC Compiler ILMs must be included in ${MW_REFERENCE_LIB_DIRS} and require
#       a Milkyway library setup even if you are using Design Compiler in WLM 
#       (non-topographical) mode.
##########################################################################################

# Each of the hierarchical designs specified in ${HIERARCHICAL_DESIGNS} in the common_setup.tcl file
# should be added to only one of the lists below:

set DDC_HIER_DESIGNS                    "bit_coin"  ;# List of Design Compiler hierarchical design names (.ddc will be read)
set DC_ILM_HIER_DESIGNS                 ""  ;# List of Design Compiler ILM hierarchical design names (.ddc will be read)
set DC_BLOCK_ABSTRACTION_DESIGNS        "bit_coin"  ;# List of Design Compiler block abstraction hierarchical designs (.ddc will be read)
                                             # without transparent interface optimization
set DC_BLOCK_ABSTRACTION_DESIGNS_TIO    "bit_coin"  ;# List of Design Compiler block abstraction hierarchical designs
                                             # with transparent interface optimization
set ICC_ILM_HIER_DESIGNS                ""  ;# List of IC Compiler ILM hierarchical design names (Milkyway will be read)
set ICC_BLOCK_ABSTRACTION_DESIGNS       ""  ;# List of IC Compiler block abstraction hierarchical design names (Milkyway will be read)

# Block abstractions cannot be combined ILMs
if {(${ICC_BLOCK_ABSTRACTION_DESIGNS} != "") || (${DC_BLOCK_ABSTRACTION_DESIGNS} != "") || (${DC_BLOCK_ABSTRACTION_DESIGNS_TIO} != "")} {
  if {(${DC_ILM_HIER_DESIGNS} != "") || (${ICC_ILM_HIER_DESIGNS} != "")} {
    puts "RM-Error: Using block abstraction with ILM is not supported."
    exit 1
  }
}

#################################################################################
# Setup Variables
#
# Modify settings in this section to customize your Design Compiler Reference 
# Methodology run.
# Portions of dc_setup.tcl may be used by other tools so program name checks
# are performed where necessary.
#################################################################################

if {$synopsys_program_name != "mvrc"}  {

  # The following setting removes new variable info messages from the end of the log file
  set_app_var sh_new_variable_message false

}

if {$synopsys_program_name == "dc_shell"}  {

  #################################################################################
  # Design Compiler Specific Setup Variables
  #################################################################################

  # Use the set_host_options command to enable multicore optimization to improve runtime.
  # This feature has special usage and license requirements.  Refer to the 
  # "Support for Multicore Technology" section in the Design Compiler User Guide
  # for multicore usage guidelines.
  # Note: This is a DC Ultra feature and is not supported in DC Expert.

  # set_host_options -max_cores 4

  # Change alib_library_analysis_path to point to a central cache of analyzed libraries
  # to save runtime and disk space.  The following setting only reflects the
  # default value and should be changed to a central location for best results.

  set_app_var alib_library_analysis_path .

  # By default the tool will create supply set handles. If your UPF has domain dependent
  # supply nets, please uncomment the following line:

  # set_app_var upf_create_implicit_supply_sets false
  
  # Add any additional Design Compiler variables needed here
}


#set RTL_SOURCE_FILES  "arm2_search.v bit_top.v sha256_ff_afff.v arm2_spi.v arm2_top.v sha256_ff_00ff.v sha256x2_ff_afff.v"
set RTL_SOURCE_FILES  "bit_coin.v bit_top.v bit_slice.v secure_data.v piso.v sipo.v"


# The following variables are used by scripts in the rm_dc_scripts folder to direct 
# the location of the output files.

set REPORTS_DIR "reports"
set RESULTS_DIR "results"

file mkdir ${REPORTS_DIR}
file mkdir ${RESULTS_DIR}

#################################################################################
# Search Path Setup
#
# Set up the search path to find the libraries and design files.
#################################################################################

  set_app_var search_path ". rtl upf_2.1_ss_handle scripts ${ADDITIONAL_SEARCH_PATH} $search_path"

  # For a hierarchical flow, add the block-level results directories to the
  # search path to find the block-level design files.

  set HIER_DESIGNS "${DDC_HIER_DESIGNS} ${DC_ILM_HIER_DESIGNS} ${DC_BLOCK_ABSTRACTION_DESIGNS} ${DC_BLOCK_ABSTRACTION_DESIGNS_TIO}"
  foreach design $HIER_DESIGNS {
#    lappend search_path ../${design}/results
  }

  # For a hierarchical UPF flow, add the results directory to the search path for
  # Formality to find the output UPF files.

#  lappend search_path ${RESULTS_DIR}

#################################################################################
# Library Setup
#
# This section is designed to work with the settings from common_setup.tcl
# without any additional modification.
#################################################################################

if {$synopsys_program_name != "mvrc"}  {

  # Milkyway variable settings

  # Make sure to define the Milkyway library variable
  # mw_design_library, it is needed by write_milkyway command

  set mw_reference_library ${MW_REFERENCE_LIB_DIRS}
  set mw_design_library ${DCRM_MW_LIBRARY_NAME}

  set mw_site_name_mapping { {CORE unit} {Core unit} {core unit} }

}

if {$synopsys_program_name == "mvrc"}  {
  set_app_var link_library "$TARGET_LIBRARY_FILES $ADDITIONAL_LINK_LIB_FILES"
}

# The remainder of the setup below should only be performed in Design Compiler
if {$synopsys_program_name == "dc_shell"}  {

  set_app_var target_library ${TARGET_LIBRARY_FILES}

set_app_var target_library "saed32hvt_tt0p78v125c.db saed32hvt_tt0p85v125c.db saed32hvt_tt1p05v125c.db saed32hvt_ulvl_tt0p78v125c_i0p78v.db saed32hvt_ulvl_tt0p85v125c_i0p85v.db saed32hvt_ulvl_tt1p05v125c_i0p78v.db saed32hvt_dlvl_tt0p78v125c_i0p78v.db saed32hvt_dlvl_tt0p85v125c_i0p85v.db saed32hvt_pg_tt0p78v125c.db saed32hvt_pg_tt0p85v125c.db saed32hvt_pg_tt1p05v125c.db   saed32rvt_tt0p78v125c.db saed32rvt_tt0p85v125c.db saed32rvt_tt1p05v125c.db saed32rvt_ulvl_tt0p78v125c_i0p78v.db saed32rvt_ulvl_tt0p85v125c_i0p85v.db saed32rvt_ulvl_tt1p05v125c_i0p78v.db saed32rvt_dlvl_tt0p78v125c_i0p78v.db saed32rvt_dlvl_tt0p85v125c_i0p85v.db saed32rvt_pg_tt0p78v125c.db saed32rvt_pg_tt0p85v125c.db saed32rvt_pg_tt1p05v125c.db saed32lvt_tt0p78v125c.db saed32lvt_tt0p85v125c.db saed32lvt_tt1p05v125c.db saed32lvt_ulvl_tt0p78v125c_i0p78v.db saed32lvt_ulvl_tt0p85v125c_i0p85v.db saed32lvt_ulvl_tt1p05v125c_i0p78v.db saed32lvt_dlvl_tt0p78v125c_i0p78v.db saed32lvt_dlvl_tt0p85v125c_i0p85v.db saed32lvt_pg_tt0p78v125c.db saed32lvt_pg_tt0p85v125c.db saed32lvt_pg_tt1p05v125c.db"

  set_app_var synthetic_library dw_foundation.sldb
  set_app_var link_library "* $target_library $ADDITIONAL_LINK_LIB_FILES $synthetic_library"

  # Set min libraries if they exist
  foreach {max_library min_library} $MIN_LIBRARY_FILES {
    set_min_library $max_library -min_version $min_library
  }

  # Set the variable to use Verilog libraries for Test Design Rule Checking
  # (See dc.tcl for details)

  # set_app_var test_simulation_library <list of Verilog library files>

  if {[shell_is_in_topographical_mode]} {

    # Only create new Milkyway design library if it doesn't already exist
    extend_mw_layers
    if {![file isdirectory $mw_design_library ]} {
      create_mw_lib   -technology $TECH_FILE \
                      -mw_reference_library $mw_reference_library \
                      $mw_design_library
    } else {
      # If Milkyway design library already exists, ensure that it is consistent with specified Milkyway reference libraries
      set_mw_lib_reference $mw_design_library -mw_reference_library $mw_reference_library
    }

    open_mw_lib     $mw_design_library

    set_check_library_options -upf
    check_library > ${REPORTS_DIR}/${DCRM_CHECK_LIBRARY_REPORT}

    set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE \
                       -min_tluplus $TLUPLUS_MIN_FILE \
                       -tech2itf_map $MAP_FILE

    check_tlu_plus_files
  }

  #################################################################################
  # Library Modifications
  #
  # Apply library modifications after the libraries are loaded.
  #################################################################################

  if {[file exists [which ${LIBRARY_DONT_USE_FILE}]]} {
    puts "RM-Info: Sourcing script file [which ${LIBRARY_DONT_USE_FILE}]\n"
    source -echo -verbose ${LIBRARY_DONT_USE_FILE}
  }
}

puts "RM-Info: Completed script [info script]\n"

