source -e -v rm_setup/dc_setup.tcl
set link_library [list * sc9_cmos28lpp_base_lvt_ss_nominal_max_0p900v_125c_sadhm.db]
set target_library [list sc9_cmos28lpp_base_lvt_ss_nominal_max_0p900v_125c_sadhm.db]
lappend search_path ./results
lappend search_path /global/gtsna_benchmark3/gmaben/top_level_project/bit_map_ss_28_lvt_rtl_2/bit_top_HIER_IMPLEMENTATION/arm2_top_dc/lib/primitive/lvt/db

open_mw_lib arm2_top_PHY_LIB
import_designs -format verilog -top arm2_top -cell arm2_top_place results/arm2_top.mapped.v
link -f

set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE                        -min_tluplus $TLUPLUS_MIN_FILE                        -tech2itf_map $MAP_FILE

#create_floorplan -start_first_row -flip_first_row -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10

read_def results/arm2_top.icc.def
read_def results/arm2_top.mapped.scandef

set_port_location -coordinate {2 340} IRQ_in
set_port_location -coordinate {2 360} OE_in
set_port_location -coordinate {2 380} MOSI
set_port_location -coordinate {2 400} SCK_in
set_port_location -coordinate {2 420} SSEL_in
set_port_location -coordinate {2 440} clk
set_port_location -coordinate {2 460} test_si
set_port_location -coordinate {2 480} test_mode

set_port_location -coordinate {2 500} test_se
set_port_location -coordinate {700 340} IRQ_out
set_port_location -coordinate {700 360} OE_out
set_port_location -coordinate {700 380} MISO
set_port_location -coordinate {700 400} SCK_out
set_port_location -coordinate {700 420} SSEL_out
set_port_location -coordinate {700 440} test_so

read_sdc results/arm2_top.mapped.sdc

set_ignored_layers -min_routing_layer ${MIN_ROUTING_LAYER}
set_ignored_layers -max_routing_layer ${MAX_ROUTING_LAYER}

read_saif -input /global/gtsna_benchmark3/gmaben/top_level_project/bit_map_28nm_rtl_1/simulation/verilog.saif  -instance arm2_tb/dut0

set_optimize_pre_cts_power_options -low_power_placement true

create_placement -effort medium -congestion -congestion_effort medium -consider_scan

save_mw_cel -as cp_done

place_opt  -skip_initial_placement -congestion -area_recovery -power -effort medium -optimize_dft

save_mw_cel -as place_done

report_qor -physical -summary > reports/arm2_top.icc_place.qor
report_power > reports/arm2_top.icc_place.power
