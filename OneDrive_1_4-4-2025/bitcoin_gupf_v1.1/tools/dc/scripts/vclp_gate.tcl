source ./scripts/synopsys_vcst.setup

read_verilog -netlist [list outputs2icc2/bit_slice.vg outputs2icc2/bit_top.vg outputs2icc2/bit_coin.vg]
current_design bit_coin
link

configure_lp_tag -enable -tag PSW_ACK_DRIVEN

load_upf outputs2icc2/top_wrapper.upf

check_lp -stage upf
check_lp -stage design

report_lp -list
