set RESULTS_BITTOP_DIR results_bit_top
set WRAP_BITTOP_UPF ${RESULTS_BITTOP_DIR}/wrap_bit_top.upf

sh rm -rf $WRAP_BITTOP_UPF
echo "# Auto Generated Wrapper UPF for VG tools" > $WRAP_BITTOP_UPF
echo "for {set i 0} {\$i < 32} {incr i} {" >> $WRAP_BITTOP_UPF
echo "  load_upf -scope slice_\${i} ../icc2/outputs2icc2/bit_slice.upf" >> $WRAP_BITTOP_UPF
echo "}" >> $WRAP_BITTOP_UPF
echo "load_upf ../icc2/outputs2icc2/bit_top.upf" >> $WRAP_BITTOP_UPF

set RESULTS_BITCOIN_DIR results_bit_coin
set WRAP_BITCOIN_UPF ${RESULTS_BITCOIN_DIR}/wrap_bit_coin.upf

sh rm -rf $WRAP_BITCOIN_UPF
echo "# Auto Generated Wrapper UPF for VG tools" > $WRAP_BITCOIN_UPF
echo "for {set j 0} {\$j < 16} {incr j} {" >> $WRAP_BITCOIN_UPF
echo "for {set i 0} {\$i < 32} {incr i} {" >> $WRAP_BITCOIN_UPF
echo "load_upf -scope bit_secure_\${j}/slice_\${i} ../icc2/outputs2icc2/bit_slice.upf" >> $WRAP_BITCOIN_UPF
echo "}" >> $WRAP_BITCOIN_UPF 
echo "}" >> $WRAP_BITCOIN_UPF 
echo "for {set k 0} {\$k < 16} {incr k} {" >> $WRAP_BITCOIN_UPF 
echo "load_upf -scope bit_secure_\${k} ../icc2/outputs2icc2/bit_top.upf" >> $WRAP_BITCOIN_UPF  
echo "}" >> $WRAP_BITCOIN_UPF 
echo "load_upf ../icc2/outputs2icc2/bit_coin.upf" >> $WRAP_BITCOIN_UPF 

set ICC2_DIR ../icc2
set OUTPUTS2ICC_DIR ${ICC2_DIR}/outputs2icc2

if {[file exists $OUTPUTS2ICC_DIR]} {
  sh rm -rf $OUTPUTS2ICC_DIR
  sh mkdir $OUTPUTS2ICC_DIR
} else {
  sh mkdir $OUTPUTS2ICC_DIR
}

sh cp scripts/Makefile_dp $ICC2_DIR
sh cp results_bit_slice/bit_slice.vg $OUTPUTS2ICC_DIR
sh cp results_bit_slice/bit_slice.svf $OUTPUTS2ICC_DIR
sh cp results_bit_slice/bit_slice.upf $OUTPUTS2ICC_DIR
sh cp results_bit_slice/bit_slice.ddc $OUTPUTS2ICC_DIR
sh cp results_bit_slice/bit_slice.sdc $OUTPUTS2ICC_DIR
sh cp results_bit_slice/bit_slice.spef $OUTPUTS2ICC_DIR
sh cp results_bit_slice/bit_slice.scan_def $OUTPUTS2ICC_DIR

sh cp results_bit_top/bit_top.vg $OUTPUTS2ICC_DIR
sh cp results_bit_top/bit_top.svf $OUTPUTS2ICC_DIR
sh cp results_bit_top/bit_top.upf $OUTPUTS2ICC_DIR
sh cp results_bit_top/bit_top.ddc $OUTPUTS2ICC_DIR
sh cp results_bit_top/bit_top.sdc $OUTPUTS2ICC_DIR
sh cp results_bit_top/bit_top.spef $OUTPUTS2ICC_DIR
sh cp results_bit_top/bit_top.scan_def $OUTPUTS2ICC_DIR
sh cp $WRAP_BITTOP_UPF $OUTPUTS2ICC_DIR

sh cp results_bit_coin/bit_coin.vg $OUTPUTS2ICC_DIR
sh cp results_bit_coin/bit_coin.svf $OUTPUTS2ICC_DIR
sh cp results_bit_coin/bit_coin.upf $OUTPUTS2ICC_DIR
sh cp results_bit_coin/bit_coin.ddc $OUTPUTS2ICC_DIR
sh cp results_bit_coin/bit_coin.sdc $OUTPUTS2ICC_DIR
sh cp results_bit_coin/bit_coin.spef $OUTPUTS2ICC_DIR
sh cp results_bit_coin/bit_coin.scan_def $OUTPUTS2ICC_DIR
sh cp $WRAP_BITCOIN_UPF $OUTPUTS2ICC_DIR
