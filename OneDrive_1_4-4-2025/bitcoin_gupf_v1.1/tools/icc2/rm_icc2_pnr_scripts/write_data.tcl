##########################################################################################
# Tool: IC Compiler II
# Script: write_data.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -e ./rm_setup/icc2_pnr_setup.tcl 

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	open_block ${DESIGN_NAME}/${WRITE_DATA_BLOCK_NAME}
	current_block ${DESIGN_NAME}/${WRITE_DATA_BLOCK_NAME}
} else {
	open_block ${WRITE_DATA_BLOCK_NAME}
	current_block ${WRITE_DATA_BLOCK_NAME}
}
link_block

####################################################################################################
## For current block, write out ASCII Data (verilog, UPF, DEF, scripts/SDC, parasitics, and GDS)  
####################################################################################################

## change_names : changes the names of ports, cells, and nets in a design to conform to specified name rules
#  	change_names -rules verilog -hierarchy

## Set to write out a UPF file compatible for other Synopsys tools
set_app_option -name mv.upf.write_crosstool_wrappers -value true

## write_verilog (no pg, and no physical only cells)
write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations pg_objects end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.v

## write_verilog for comparison with a DC netlist (no pg, no physical only cells, and no diodes)
write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations pg_objects end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells diode_cells} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.dc.v

## write_verilog for PT (no pg, no physical only cells but with diodes and DCAP for leakage power analysis)
set write_verilog_pt_cmd "write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations pg_objects end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.pt.v"
if {$CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST != ""} {lappend write_verilog_pt_cmd -force_reference $CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST}
puts "RM-info: $write_verilog_pt_cmd"
eval $write_verilog_pt_cmd

## write_verilog for LVS (with pg, and with physical only cells)
write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations empty_modules} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.lvs.v

## write_verilog for Formality (with pg, no physical only cells, and no supply statements)
write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells supply_statements} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.fm.v

## write_verilog for VC LP (with pg, no physical_only cells, no diodes, and no supply statements)
write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations end_cap_cells well_tap_cells filler_cells pad_spacer_cells physical_only_cells cover_cells diode_cells supply_statements} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.vc_lp.v

## write_upf
save_upf ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.upf

## write_def - for ASCII flow to StarRC, no special option is needed
write_def -compress gzip -version 5.8 ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.def

## write_script
#  writes multiple files to the specified directory. 
#  It writes mode_{mode_name}.tcl for mode specific info, corner_{corner_name}.tcl for corner specific info, 
#  design.tcl for non-mode or corner specific info, cts.tcl for cts options and top.tcl that sources all scripts. 
write_script -compress gzip -output ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}_wscript

## write_parasitics
update_timing
write_parasitics -output ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}

set write_gds_cmd "write_gds -hierarchy all -output_pin all -long_names ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.gds"
if {[file exists $WRITE_GDS_LAYER_MAP_FILE]} {lappend write_gds_cmd -layer_map $WRITE_GDS_LAYER_MAP_FILE}


## If there's any design mismatches found, write_gds will not write out GDS, since GDS will be used for tape-out.
#  If you still want to write out GDS despite of mismatches, append the -force option to the write_gds command.

puts "RM-info : $write_gds_cmd"
eval $write_gds_cmd


echo [date] > $WRITE_DATA_BLOCK_NAME

exit 

