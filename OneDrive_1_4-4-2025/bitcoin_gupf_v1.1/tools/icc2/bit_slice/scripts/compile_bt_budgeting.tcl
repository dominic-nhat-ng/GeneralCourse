source -e -v rm_setup/dc_setup.tcl
source scripts/procs.tcl
set check_design_allow_multiply_driven_nets_by_inputs_and_outputs true

set DESIGN_NAME bit_secure


sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/reports
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/results
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/logs
sh cp -r lib ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r tech ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_setup  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_dc_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_icc2_dp_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_icc2_pnr_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r Makefile  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r alib-52  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r sdc  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r upf  ${DESIGN_NAME}_HIER_IMPLEMENTATION

set hier_cells "bit_slice_1"

foreach hier_cell $hier_cells {
echo "Generating DIR struct for ${hier_cell}_dc"
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc/reports
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc/results
sh mkdir ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc/logs
sh cp -r lib ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r tech ${DESIGN_NAME}_HIER_IMPLEMENTATION
sh cp -r rm_setup  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_dc_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_icc2_dp_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r rm_icc2_pnr_scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r Makefile  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r alib-52  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r sdc  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r scripts  ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
sh cp -r upf ${DESIGN_NAME}_HIER_IMPLEMENTATION/${hier_cell}_dc
}


set compile_automatic_clock_phase_inference none
set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_allow_ls_on_leaf_pin_boundary true
#set _mv_allow_iss_update_to_ss_function true

read_ddc [glob results/*.ddc]
link
COMMAND_RUNTIME check_mv_design -verbose > reports/pre_compile.cmv.rpt

set design_name [current_design ]



set hier_cells [get_cells slice_*]

set slice_cells [get_cells slice_*]

foreach_in_collection slice_cell $slice_cells {
 set cell_name [get_object_name $slice_cell]
 set_level_shifter -domain [get_power_domains -of_object $cell_name] -elements [list [get_pins "$cell_name/clk $cell_name/reset $cell_name/data_valid "]] -no_shift LS_no_shift_top_${cell_name}
}

START_TIMER CHARACTERIZE "Starting Characterization"

foreach_in_collection cell $hier_cells {
set cell_name [get_object_name $cell]
echo "Characterizing hierarchical cell $cell_name"
characterize $cell_name -power
echo "Done Characterizing hierarchical cell $cell_name"
}
STOP_TIMER CHARACTERIZE "Completing Characterization"


set uniquified_cells [get_designs bit_slice_1]
foreach_in_collection ucell $uniquified_cells {
set cell_name [get_object_name $ucell]
echo "Generating constraints for hierarchical cell $cell_name"
current_design $cell_name
change_names -rule verilog -hier
save_upf ${DESIGN_NAME}_HIER_IMPLEMENTATION/${cell_name}_dc/$RESULTS_DIR/${cell_name}_unmapped.upf
write -f ddc -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/${cell_name}_dc/$RESULTS_DIR/${cell_name}_unmapped.ddc
write -f verilog -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/${cell_name}_dc/$RESULTS_DIR/${cell_name}_unmapped.v
current_design $design_name
echo "Done Generating constraints for hierarchical cell $cell_name"
}

set cell_list  [get_cells slice_*]
set upf_block_partition [get_object_name $cell_list]


echo "Generating Top Level Gtech DDC/UPF/SCRIPT files"
change_names -rule verilog -hier
write -f ddc -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.ddc
write -f verilog -h -o ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.v
save_upf ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.upf
write_script -out ${DESIGN_NAME}_HIER_IMPLEMENTATION/$RESULTS_DIR/top_gtech.script
