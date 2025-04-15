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

#set hier_cells "b2v_inst0 b2v_inst1 b2v_inst2 b2v_inst3 b2v_inst4 b2v_inst5 b2v_inst6 b2v_inst7 b2v_inst8 b2v_inst9 b2v_inst10  b2v_inst11 b2v_inst12 b2v_inst13 b2v_inst14 b2v_inst15"
set hier_cells "switch"

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




#sh rm -rf top_mw_design_lib
#create_mw_lib -mw_reference_library $mw_reference_library -tech $mw_tech_file top_mw_design_lib -open



define_design_lib WORK -path ./WORK
  
analyze -format verilog ${RTL_SOURCE_FILES}
elaborate ${DESIGN_NAME}


link

