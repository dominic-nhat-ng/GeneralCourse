#source -e -v scripts/library.tcl

source -echo -verbose ./rm_setup/dc_setup.tcl

set check_design_allow_multiply_driven_nets_by_inputs_and_outputs true


sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/reports
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/results
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/logs
sh cp -r lib ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_setup  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_dc_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_icc_dp_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_icc_zrt_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_icc_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r Makefile  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r alib-52  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r tech  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r sdc  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r def  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r upf  ${DESIGN_NAME}_HIER_IMPLEMENTATION

set hier_cells "b2v_inst0 b2v_inst1 b2v_inst2 b2v_inst3 b2v_inst4 b2v_inst5 b2v_inst6 b2v_inst7 b2v_inst8 b2v_inst9 b2v_inst10  b2v_inst11 b2v_inst12 b2v_inst13 b2v_inst14 b2v_inst15"

foreach hier_cell $hier_cells {
echo "Generating DIR struct for ${hier_cell}_dc"
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc/reports
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc/results
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc/logs
sh cp -r lib ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_setup  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_dc_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_icc_dp_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_icc_zrt_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_icc_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r Makefile  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r alib-52  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r tech  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r sdc  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r def  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r upf  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
}




sh rm -rf top_mw_design_lib
create_mw_lib -mw_reference_library $mw_reference_library -tech $mw_tech_file top_mw_design_lib -open

##search/hash/hash1 search/hash/hash2 search/hash spi search ####


define_design_lib WORK -path ./WORK
  
analyze -format verilog ${RTL_SOURCE_FILES}
elaborate ${DESIGN_NAME}

return


link



set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
#set mv_no_main_power_violations  false
set mv_allow_ls_on_leaf_pin_boundary true




set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE

set_svf ${RESULTS_DIR}/${DCRM_SVF_OUTPUT_FILE}


if {![load_upf ${DCRM_MV_UPF_INPUT_FILE}]} {
  puts "RM-Error: Unable to load UPF file ${DCRM_MV_UPF_INPUT_FILE}"
  exit 1
}

#source -e -v upf/iso.upf

if {[file exists [which ${DCRM_SDC_INPUT_FILE}]]} {
  puts "RM-Info: Reading SDC file [which ${DCRM_SDC_INPUT_FILE}]\n"
  read_sdc ${DCRM_SDC_INPUT_FILE}
}
if {[file exists [which ${DCRM_CONSTRAINTS_INPUT_FILE}]]} {
  puts "RM-Info: Sourcing script file [which ${DCRM_CONSTRAINTS_INPUT_FILE}]\n"
  source -echo -verbose ${DCRM_CONSTRAINTS_INPUT_FILE}
}

if {[file exists [which ${DCRM_MV_SET_VOLTAGE_INPUT_FILE}]]} {
  puts "RM-Info: Sourcing script file [which ${DCRM_MV_SET_VOLTAGE_INPUT_FILE}]\n"
  source -echo -verbose ${DCRM_MV_SET_VOLTAGE_INPUT_FILE}
}

# set_voltage commands will be written out in SDC version 1.8 and might
# be defined as a part of the SDC for your design.

# Check and exit if any supply nets are missing a defined voltage.
if {![check_mv_design -power_nets]} {
  puts "RM-Error: One or more supply nets are missing a defined voltage.  Use the set_voltage command to set the appropriate voltage upon the supply."
  puts "This script will now exit."
  exit 1
}



check_mv_design



set HIERARCHICAL_CELLS "b2v_inst0 b2v_inst1 b2v_inst2 b2v_inst3 b2v_inst4 b2v_inst5 b2v_inst6 b2v_inst7 b2v_inst8 b2v_inst9 b2v_inst10  b2v_inst11 b2v_inst12 b2v_inst13 b2v_inst14 b2v_inst15"

set hcells [get_cells $HIERARCHICAL_CELLS]
set results ./results

sizeof_collection [get_cells * -hier]

uniquify -base_name switch -cell b2v_inst0
uniquify -base_name switch -cell b2v_inst1
uniquify -base_name switch -cell b2v_inst2
uniquify -base_name switch -cell b2v_inst3
uniquify -base_name switch -cell b2v_inst4
uniquify -base_name switch -cell b2v_inst5
uniquify -base_name switch -cell b2v_inst6
uniquify -base_name switch -cell b2v_inst7
uniquify -base_name switch -cell b2v_inst8
uniquify -base_name switch -cell b2v_inst9
uniquify -base_name switch -cell b2v_inst10
uniquify -base_name switch -cell b2v_inst11
uniquify -base_name switch -cell b2v_inst12
uniquify -base_name switch -cell b2v_inst13
uniquify -base_name switch -cell b2v_inst14
uniquify -base_name switch -cell b2v_inst15


lint


if {[file exists [which ${DCRM_DCT_DEF_INPUT_FILE}]]} {
    puts "RM-Info: Reading in DEF file [which ${DCRM_DCT_DEF_INPUT_FILE}]\n"
    extract_physical_constraints ./def/SYN_TOP_WRAPPER_flat.def
  }

if {[file exists [which ${DCRM_MV_DCT_VOLTAGE_AREA_INPUT_FILE}]]} {
      puts "RM-Info: Reading in file [which ${DCRM_MV_DCT_VOLTAGE_AREA_INPUT_FILE}]\n"
      read_floorplan ${DCRM_MV_DCT_VOLTAGE_AREA_INPUT_FILE}
    }
  

foreach_in_collection cell $hcells {
set cell_name [get_object_name $cell]
echo "Characterizing hierarchical cell $cell_name"
characterize $cell_name -power
echo "Done Characterizing hierarchical cell $cell_name"
}


return



set ucells "switch_0 switch_1 switch_2 switch_3 switch_4 switch_5 switch_6 switch_7 switch_8 switch_9 switch_10 switch_11 switch_12 switch_13 switch_14 switch_15"

set uniquified_cells [get_designs $ucells]
foreach_in_collection ucell $uniquified_cells {
set cell_name [get_object_name $ucell]
echo "Generating constraints for hierarchical cell $cell_name"
current_design $cell_name
change_names -rule verilog -hier
save_upf ${DESIGN_NAME}_HIER_IMPLEMENTATION/${DESIGN_NAME}_dc/$RESULTS_DIR/${cell_name}_unmapped.upf
write -f ddc -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/${DESIGN_NAME}_dc/$RESULTS_DIR/${cell_name}_unmapped.ddc
write -f verilog -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/${DESIGN_NAME}_dc/$RESULTS_DIR/${cell_name}_unmapped.v
set fid_r [open rm_setup/common_setup.tcl r]
set fid_w [open ${DESIGN_NAME}_HIER_IMPLEMENTATION/${DESIGN_NAME}_dc/rm_setup/common_setup.tcl w]
        while {[gets $fid_r line] >= 0} {
                if { [regexp "set MW_DESIGN_LIBRARY" $line]} {
                        puts $fid_w "set MW_DESIGN_LIBRARY lib_$cell_name"
                }  elseif { [regexp "set DESIGN_NAME" $line]} {
                        puts $fid_w "set DESIGN_NAME $cell_name" } elseif { [regexp "set INPUT_FORMAT" $line]} { 
                       puts $fid_w "set INPUT_FORMAT DDC"
                } else {
                        puts $fid_w $line
                }
        }
close $fid_w
close $fid_r
current_design DSM
echo "Done Generating constraints for hierarchical cell $cell_name"
}





sizeof_collection [get_cells * -hier]


set uniquified_cells [get_designs $ucells]

echo $uniquified_cells > .src
query_object $uniquified_cells >> .src

#set upf_block_partition "block1 block2"


echo "Generating Top Level Gtech DDC/UPF/SCRIPT files"
change_names -rule verilog -hier
write -f ddc -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.ddc
write -f verilog -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.v
save_upf ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.upf
write_script -out ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.script
set fid_r [open rm_setup/common_setup.tcl r]
set fid_w [open ${DESIGN_NAME}_HIER_IMPLEMENTATION/rm_setup/common_setup.tcl w]
        while {[gets $fid_r line] >= 0} {
                if { [regexp "set MW_DESIGN_LIBRARY" $line]} {
                        puts $fid_w "set MW_DESIGN_LIBRARY lib_$cell_name"
                }  elseif { [regexp "set DESIGN_NAME" $line]} {
                        puts $fid_w "set DESIGN_NAME $DESIGN_NAME" } elseif { [regexp "set INPUT_FORMAT" $line]} { 
                        puts $fid_w "set INPUT_FORMAT DDC"
                } else {
                        puts $fid_w $line
                }
        }
close $fid_w
close $fid_r
exit
