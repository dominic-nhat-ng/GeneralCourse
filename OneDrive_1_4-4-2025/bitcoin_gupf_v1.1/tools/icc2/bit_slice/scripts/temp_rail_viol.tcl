source -e -v rm_setup/dc_setup.tcl
source scripts/procs.tcl
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
set mv_no_main_power_violations  false
#set _mv_allow_iss_update_to_ss_function true

set_svf $DESIGN_NAME.svf

read_verilog [list rtl/bit_coin.v rtl/bit_top.v rtl/bit_slice.v rtl/secure_data.v rtl/piso.v rtl/sipo.v ]
link
COMMAND_RUNTIME source -e -v upf/snps_bit_coin.upf > logs/snps_bit_coin.upf.log
source -e -v scripts/snps_set_voltage.tcl
saif_map -start
read_saif -input vectors/vcdplus.saif -instance_name tb/dut
COMMAND_RUNTIME check_mv_design -verbose > reports/pre_compile.cmv.rpt
COMMAND_RUNTIME uniquify
COMMAND_RUNTIME insert_mv_cells -verbose > reports/imv.rpt
COMMAND_RUNTIME compile_ultra -gate_clock
COMMAND_RUNTIME check_mv_design > reports/post_compile.cmv.rpt
change_names -rule verilog -hier 
saif_map -write_map results/bit_coin_flat.map
write -f verilog -hier -o results/bit_coin_flat.vg
write -f ddc -hier -o results/bit_coin_flat.ddc
write_parasitics -outut results/bit_coin_flat.spef
save_upf results/bit_coin_flat.upf
reset_switching_activity
saif_map -read_map results/bit_coin_flat.map 
read_saif -input vectors/vcdplus.saif -instance_name tb/dut -auto_map_names
report_power
