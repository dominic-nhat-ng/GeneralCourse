source ./scripts/synopsys_vcst.setup

analyze -f verilog -vcs "-f ./rtl/files_bit_slice.f"
elaborate bit_slice

load_upf ./upf_vc_lp/snps_bit_slice.upf

check_lp -stage upf

report_lp -list
