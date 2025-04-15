set_messages -log ./tmax_run.log -replace

set search_path [ list . lib lib/verilog synthesis/results]


read_netlist ./lib/verilog/saed32nm_hvt.v -library
read_netlist ./lib/verilog/saed32nm_lvt.v -library 
read_netlist ./lib/verilog/saed32nm.v -library
read_netlist ./lib/verilog/SRAM2RW16x4.v  -library
read_netlist synthesis/results/bit_coin_dft.vg 
read_netlist synthesis/bit_top/results/bit_top_dft.vg 
read_netlist synthesis/bit_slice/results/bit_slice_dft.vg


run_build bit_coin

#run_drc "/synthesis/results/bit_coin.internal_scan.spf"
run_drc ./synthesis/results/bit_coin.compression.spf

add_faults -all
run_atpg -auto

write_patterns ./results/patterns.stil -format stil -unified_stil_flow -replace
write_testbench -input  ./results/patterns.stil -output results/tb_tmax.v -replace
exut

