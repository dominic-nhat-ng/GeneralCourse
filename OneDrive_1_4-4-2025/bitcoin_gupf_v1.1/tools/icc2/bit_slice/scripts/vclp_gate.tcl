source ./scripts/synopsys_vcst.setup

read_verilog -netlist [list synthesis/results/bit_coin_dft.vg synthesis/bit_slice/results/bit_slice_dft.vg synthesis/bit_top/results/bit_top_dft.vg]
current_design bit_coin
link

configure_lp_tag -enable -tag PSW_ACK_DRIVEN

load_upf results/top_wrapper.upf

check_lp -stage upf
check_lp -stage design

report_lp -list
