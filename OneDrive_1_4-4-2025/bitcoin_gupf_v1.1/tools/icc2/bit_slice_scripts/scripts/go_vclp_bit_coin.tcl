source ./scripts/synopsys_vcst.setup

analyze -f verilog -vcs "-f ./rtl/files_bit_coin.f"
elaborate bit_coin

load_upf ./upf/bit_coin.upf

check_lp -stage upf

report_lp -list
