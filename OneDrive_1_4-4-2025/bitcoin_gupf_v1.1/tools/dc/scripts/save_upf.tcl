source rm_setup/dc_setup.tcl
read_ddc results_bit_slice/bit_slice_bam.ddc
read_ddc results_bit_top/bit_top_bam.ddc
read_ddc results_bit_coin/bit_coin.ddc
save_upf results_bit_coin/bit_coin.upf
save_upf ../icc2/outputs2icc2/bit_coin.upf
exit
