set_messages -log ./logs/tmax_run.log -replace

set search_path [ list . ../../lib ../../lib/verilog results_bit_coin ../pt/signoff_data]


read_netlist ../../lib/verilog/saed32nm_hvt.v -library
read_netlist ../../lib/verilog/saed32nm_lvt.v -library 
read_netlist ../../lib/verilog/saed32nm.v -library
read_netlist ../../lib/verilog/SRAM2RW16x4.v  -library
read_netlist ../pt/signoff_data/bit_coin.v.gz 
read_netlist ../pt/signoff_data/bit_top.v.gz 
read_netlist ../pt/signoff_data/bit_slice.v.gz


run_build bit_coin

set_drc -allow_unstable_set_resets
add_pi_constraints 0 scan_enable

run_drc results_bit_coin/bit_coin.compression.spf

report_clocks -gating

set_atpg -power_budget 75
set_atpg -power_effort low
set_atpg -shift_power_budget 75
set_atpg -shift_power_effort low
set_atpg -quiet_chain_test
set_atpg -fill adjacent

add_faults -all
run_atpg -auto

report_power
analyze_faults -class AN

write_patterns ./results_bit_coin/patterns.stil -format stil -unified_stil_flow -replace
write_testbench -input  ./results_bit_coin/patterns.stil -output results_bit_coin/tb_tmax.v -replace

exit

