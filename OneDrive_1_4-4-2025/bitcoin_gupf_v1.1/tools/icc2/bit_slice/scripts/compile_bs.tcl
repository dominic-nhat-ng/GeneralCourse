source -e -v rm_setup/dc_setup.tcl
read_verilog [list rtl/bit_slice.v rtl/piso.v rtl/sipo.v]
current_design bit_slice
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

source -e -v sdc/bit_coin.sdc
source -e -v upf_2.1/bit_slice.upf > bit_slice_upf.log
source -e -v scripts/set_voltage_bit_slice.tcl
check_mv_design
compile_ultra -gate_clock -no_autoungroup -no_seq_output_inversion -no_boundary_optimization
