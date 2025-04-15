#source -e -v scripts/library.tcl

source -echo -verbose ./rm_setup/dc_setup.tcl

source -e -v local_config/design.info

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
sh cp -r rtl  ${DESIGN_NAME}_HIER_IMPLEMENTATION


set hier_cells "arm2_top"

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
sh cp -r rtl  ${DESIGN_NAME}_HIER_IMPLEMENTATION
}




#sh rm -rf top_mw_design_lib
#create_mw_lib -mw_reference_library $mw_reference_library -tech $mw_tech_file top_mw_design_lib -open



define_design_lib WORK -path ./WORK
  
analyze -format verilog ${RTL_SOURCE_FILES}
elaborate ${DESIGN_NAME}


link




set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE

set_svf ${RESULTS_DIR}/${DCRM_SVF_OUTPUT_FILE}




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

report_clocks


set_dont_touch arm2_top 

set hcells [get_cells $HIERARCHICAL_CELLS]
set results ./results

sizeof_collection [get_cells * -hier]

set instance_name arm2_top

uniquify -cell $instance_name
echo "Characterizing hierarchical cell $instance_name"
characterize $instance_name -verbose


lint


if {[file exists [which ${DCRM_DCT_DEF_INPUT_FILE}]]} {
    puts "RM-Info: Reading in DEF file [which ${DCRM_DCT_DEF_INPUT_FILE}]\n"
    extract_physical_constraints ./def/SYN_TOP_WRAPPER_flat.def
  }

if {[file exists [which ${DCRM_MV_DCT_VOLTAGE_AREA_INPUT_FILE}]]} {
      puts "RM-Info: Reading in file [which ${DCRM_MV_DCT_VOLTAGE_AREA_INPUT_FILE}]\n"
      read_floorplan ${DCRM_MV_DCT_VOLTAGE_AREA_INPUT_FILE}
    }
  



set ucells arm2_top
set uniquified_cells [get_designs $ucells]
foreach_in_collection ucell $uniquified_cells {
set cell_name [get_object_name $ucell]
echo "Generating constraints for hierarchical cell $cell_name"
current_design $cell_name
change_names -rule verilog -hier
write -f ddc -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/${cell_name}_dc/$RESULTS_DIR/${cell_name}_unmapped.ddc
write -f verilog -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/${cell_name}_dc/$RESULTS_DIR/${cell_name}_unmapped.v
set fid_r [open rm_setup/common_setup.tcl r]
set fid_w [open ${DESIGN_NAME}_HIER_IMPLEMENTATION/${cell_name}_dc/rm_setup/common_setup.tcl w]
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
current_design ${DESIGN_NAME}
echo "Done Generating constraints for hierarchical cell $cell_name"
}




current_design ${DESIGN_NAME}

sizeof_collection [get_cells * -hier]


set uniquified_cells [get_designs $ucells]

echo $uniquified_cells > .src
query_object $uniquified_cells >> .src

foreach_in_collection rcell $uniquified_cells {
set cell_name [get_object_name $rcell]
echo "Removing cell $cell_name"
remove_design -h  $cell_name
echo "Done Removing cell $cell_name"
}

sizeof_collection [get_cells * -hier]



echo "Generating Top Level Gtech DDC/UPF/SCRIPT files"
change_names -rule verilog -hier
write -f ddc -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.ddc
write -f verilog -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.v
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
