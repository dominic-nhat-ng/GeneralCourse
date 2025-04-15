source -e -v rm_setup/dc_setup.tcl
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
set _mv_allow_iss_update_to_ss_function true

read_verilog [list rtl/bit_coin.v rtl/bit_top.v rtl/bit_slice.v rtl/secure_data.v rtl/piso.v rtl/sipo.v ]
link
COMMAND_RUNTIME source -e -v upf_2.1_ss_handle/snps_bit_coin.upf > logs/snps_bit_coin.upf.log1
source -e -v scripts/snps_set_voltage.tcl
COMMAND_RUNTIME check_mv_design
COMMAND_RUNTIME compile_ultra -gate_clock -no_autoungroup -no_seq_output_inversion -no_boundary_optimization
COMMAND_RUNTIME check_mv_design 
