source ./scripts/synopsys_vcst.setup

analyze -f verilog -vcs "-f ./rtl/files_bit_coin.f"
elaborate bit_coin

configure_lp_tag -enable -tag PSW_ACK_DRIVEN

load_upf ./upf/snps_bit_coin.upf

check_lp -stage upf

report_lp -list
