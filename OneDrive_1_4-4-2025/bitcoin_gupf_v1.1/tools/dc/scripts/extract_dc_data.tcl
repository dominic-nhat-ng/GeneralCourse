source rm_setup/dc_setup.tcl
set_top_implementation_options -block_references "bit_slice bit_top"
set RESULTS_DIR ./results_bit_coin
read_ddc ${RESULTS_DIR}/bit_coin.ddc
read_ddc results_bit_top/bit_top_bam.ddc
read_ddc results_bit_slice/bit_slice_bam.ddc
current_design bit_coin
link

source scripts/upf_block_part.tcl

save_upf ${RESULTS_DIR}/bit_coin.upf
source scripts/generate_wrapper.tcl
exit
