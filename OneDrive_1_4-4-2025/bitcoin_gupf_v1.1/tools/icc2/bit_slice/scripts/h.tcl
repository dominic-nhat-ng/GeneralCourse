source -e -v rm_setup/dc_setup.tcl
open_mw_lib
open_mw_lib arm2_top_PHY_LIB
list_mw_cels
open_mw_cel place_done
start_gui
clock_opt -power
source -e -v rm_setup/dc_setup.tcl
echo $link_library
pwd
set link_library [list * sc9_cmos28lpp_base_lvt_ss_nominal_max_0p900v_125c_sadhm.db]
set target_library [list sc9_cmos28lpp_base_lvt_ss_nominal_max_0p900v_125c_sadhm.db]
lappend search_path ./results
lappend search_path /global/gtsna_benchmark3/gmaben/top_level_project/bit_map_ss_28_lvt_rtl_2/bit_top_HIER_IMPLEMENTATION/arm2_top_dc/lib/primitive/lvt/db
clock_opt -power
save_mw_cel -as clock_opt_done
report_power
reset_switching_activity
report_power
report_clocks
close_mw_cel
list_mw_cels
open_mw_cel cp_done
create_floorplan -core_aspect_ratio 2
create_floorplan -core_utilization 0.700459 -core_aspect_ratio 0.5 -start_first_row -flip_first_row -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10
create_floorplan -core_utilization 0.700652 -core_aspect_ratio 0.3 -start_first_row -flip_first_row -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10
move_objects -delta {-306.800 61.025} [get_selection]
move_objects -delta {-309.400 40.700} [get_selection]
move_objects -delta {-678.340 -306.550} [get_selection]
move_objects -delta {-619.060 117.600} [get_selection]
move_objects -delta {-924.495 158.200} [get_selection]
move_objects -delta {-928.495 -129.200} [get_selection]
move_objects -delta {-1233.700 -101.625} [get_selection]
move_objects -delta {-1232.140 314.925} [get_selection]
move_objects -delta {1235.125 129.200} [get_selection]
move_objects -delta {1233.625 -225.000} [get_selection]
move_objects -delta {986.960 -195.925} [get_selection]
move_objects -delta {1234.350 -165.425} [get_selection]
move_objects -delta {740.220 -143.725} [get_selection]
move_objects -delta {490.490 -121.925} [get_selection]
move_objects -delta {0.000 339.625} [get_selection]
set_optimize_pre_cts_power_options -low_power_placement true
create_placement -effort medium -congestion -congestion_effort medium -consider_scan
change_selection [all_registers -edge_triggered ]
create_floorplan -core_utilization 0.700652 -core_aspect_ratio 0.2 -start_first_row -flip_first_row -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -start RulerTool
gui_mouse_tool -window [gui_get_current_window -types Layout -mru] -reset
create_floorplan -core_utilization 0.700652 -core_aspect_ratio 0.1 -start_first_row -flip_first_row -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10
move_objects -delta {1073.725 -108.800} [get_selection]
set_port_location -coordinate {1.7 30} IRQ_in
move_objects -delta {-1.764 -0.176} [get_selection]
set_port_location -coordinate {0 30} IRQ_in
set_port_location -coordinate {0 30} IRQ_in
set_port_location -coordinate {0 50} OE_in
set_port_location -coordinate {0 70} MOSI
set_port_location -coordinate {0 90} SCK_in
set_port_location -coordinate {0 110} SSEL_in
set_port_location -coordinate {0 130} clk
set_port_location -coordinate {0 150} test_si
set_port_location -coordinate {0 170} test_mode
set_port_location -coordinate {0 190} test_se
set_port_location -coordinate {2100 30} IRQ_out
set_port_location -coordinate {2200 30} IRQ_out
set_port_location -coordinate {2150 30} IRQ_out
set_port_location -coordinate {2120 30} IRQ_out
set_port_location -coordinate {2125 30} IRQ_out
set_port_location -coordinate {2125 30} IRQ_out
set_port_location -coordinate {2125 50} OE_out
set_port_location -coordinate {2125 70} MISO
set_port_location -coordinate {2125 90} SCK_out
set_port_location -coordinate {2125 110} SSEL_out
set_port_location -coordinate {2125 130} test_so
set_port_location -coordinate {2125 60} IRQ_out
set_port_location -coordinate {2125 80} OE_out
set_port_location -coordinate {2125 100} MISO
set_port_location -coordinate {2125 120} SCK_out
set_port_location -coordinate {2125 130} SSEL_out
set_port_location -coordinate {2125 150} test_so
create_placement -effort medium -congestion -congestion_effort medium -consider_scan
history
set_max_transition 0.08 [current_design]
save_mw_cel -as cp_done
place_opt  -skip_initial_placement -congestion -area_recovery -power -effort medium -optimize_dft
save_mw_cel -as place_done
write_def -verbose -rows_tracks_gcells -pins -output def/wider.def
write_def -verbose -rows_tracks_gcells -pins -output ../../def/wider.def
start_gui
stop_gui
start_gui
change_selection [all_registers -edge_triggered ]
change_selection [get_cells * -hierarchical -filter "ref_name=~ADD*"]
gui_set_highlight_options -current_color red
report_power
reset_switching_activity
report_power
report_clocks
set_switching_activity -toggle_rate 0.3 -static_probability 0.5 -type registers
set_switching_activity -toggle_rate 0.3 -static_probability 0.5 -type input
report_power -analysis_effort high
history -h
history -h
history -h > scripts/h.tcl
