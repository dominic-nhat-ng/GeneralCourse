source -e -v rm_setup/dc_setup.tcl
read_verilog [list rtl/bit_top.v rtl/bit_slice.v rtl/piso.v rtl/sipo.v]
current_design bit_top
set compile_automatic_clock_phase_inference none
set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_no_main_power_violations  false
set mv_allow_ls_on_leaf_pin_boundary true

#source -e -v sdc/bit_coin.sdc
source -e -v upf_3.0_working/bit_top.upf > logs/bit_top_upf_3.0.log
source -e -v scripts/set_voltage_3.0.tcl
set_voltage -object_list slice_*/SS.power 0.85
set_voltage -object_list slice_*/SS.ground 0.0
set_voltage -object_list slice_*/SSL.power 0.78
check_mv_design
compile_ultra -gate_clock -no_autoungroup -no_seq_output_inversion -no_boundary_optimization
