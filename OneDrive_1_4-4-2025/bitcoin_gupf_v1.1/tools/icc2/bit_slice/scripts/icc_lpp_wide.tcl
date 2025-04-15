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

read_def def/wider.def
read_def results/arm2_top.mapped.scandef

source -e -v scripts/port_location.tcl

read_sdc results/arm2_top.mapped.sdc

set_ignored_layers -min_routing_layer ${MIN_ROUTING_LAYER}
set_ignored_layers -max_routing_layer ${MAX_ROUTING_LAYER}

#read_saif -input /global/gtsna_benchmark3/gmaben/top_level_project/bit_map_28nm_rtl_1/simulation/verilog.saif  -instance arm2_tb/dut0

#set_switching_activity -toggle_rate 0.3 -static_probability 0.5 -type registers
#set_switching_activity -toggle_rate 0.3 -static_probability 0.5 -type input

set_optimize_pre_cts_power_options -low_power_placement true
source -e -v scripts/rgrp.tcl

create_placement -effort medium -congestion -congestion_effort medium -consider_scan

save_mw_cel -as cp_done

place_opt  -skip_initial_placement -congestion -area_recovery -power -effort medium -optimize_dft
save_mw_cel -as place_done
report_qor -physical -summary > reports/arm2_top.icc_place.qor
report_power > reports/arm2_top.icc_place.power
psynopt -only_area_recovery -effort high
psynopt -only_power -effort high
save_mw_cel -as place_area_power_done
report_qor -physical -summary > reports/arm2_top.icc_psyn.qor
report_power > reports/arm2_top.icc_psyn.power

clock_opt -power 

save_mw_cel -as clock_opt_done
report_qor -physical -summary > reports/arm2_top.icc_clock_opt.qor
report_power > reports/arm2_top.icc_clock_opt.power
report_clock_tree -summary > reports/arm2_top.icc_clock_opt.skew


route_opt -power

save_mw_cel -as route_opt_done
report_qor -physical -summary > reports/arm2_top.icc_route_opt.qor
report_power > reports/arm2_top.icc_route_opt.power
report_clock_tree -summary > reports/arm2_top.icc_route_opt.skew
