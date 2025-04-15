if {[file exists ../../../pt/signoff_data]} {
 echo "Deleting Previous Data ../../../pt/signoff_data"
sh rm -rf ../../../pt/signoff_data
}
sh mkdir ../../../pt/signoff_data
sh cp bc_outputs_icc2/chip_finish.v.gz  ../../../pt/signoff_data/bit_coin.v.gz
sh cp bt_outputs_icc2/chip_finish.v.gz  ../../../pt/signoff_data/bit_top.v.gz
sh cp bs_outputs_icc2/chip_finish.v.gz  ../../../pt/signoff_data/bit_slice.v.gz
sh cp bc_outputs_icc2/chip_finish.sdc   ../../../pt/signoff_data/bit_coin.sdc

sh cp bc_outputs_icc2/chip_finish.vc_lp.v.gz ../../../pt/signoff_data/bit_coin.fm.v.gz
sh cp bt_outputs_icc2/chip_finish.vc_lp.v.gz ../../../pt/signoff_data/bit_top.fm.v.gz
sh cp bs_outputs_icc2/chip_finish.vc_lp.v.gz ../../../pt/signoff_data/bit_slice.fm.v.gz

sh cp bc_outputs_icc2/chip_finish.v_vclp ../../../pt/signoff_data/bit_coin.vclp.v
sh cp bt_outputs_icc2/chip_finish.v_vclp ../../../pt/signoff_data/bit_top.vclp.v
sh cp bs_outputs_icc2/chip_finish.v_vclp ../../../pt/signoff_data/bit_slice.vclp.v

sh gzip ../../../pt/signoff_data/bit_coin.vclp.v
sh gzip ../../../pt/signoff_data/bit_top.vclp.v
sh gzip ../../../pt/signoff_data/bit_slice.vclp.v

sh cp bc_outputs_icc2/chip_finish.upf  ../../../pt/signoff_data/bit_coin.upf
sh cp bt_outputs_icc2/chip_finish.upf  ../../../pt/signoff_data/bit_top.upf
sh cp bs_outputs_icc2/chip_finish.upf  ../../../pt/signoff_data/bit_slice.upf

sh cp bc_outputs_icc2/chip_finish.v_vclp.SNPS.upf ../../../pt/signoff_data/bit_coin.vclp.SNPS.upf
sh cp bt_outputs_icc2/chip_finish.v_vclp.SNPS.upf ../../../pt/signoff_data/bit_top.vclp.SNPS.upf
sh cp bs_outputs_icc2/chip_finish.v_vclp.SNPS.upf ../../../pt/signoff_data/bit_slice.vclp.SNPS.upf

sh cp bc_outputs_icc2/chip_finish.vc_lp.v.SNPS.upf ../../../pt/signoff_data/bit_coin.fm.SNPS.upf
sh cp bt_outputs_icc2/chip_finish.vc_lp.v.SNPS.upf ../../../pt/signoff_data/bit_top.fm.SNPS.upf
sh cp bs_outputs_icc2/chip_finish.vc_lp.v.SNPS.upf ../../../pt/signoff_data/bit_slice.fm.SNPS.upf

sh cp bs_outputs_icc2/chip_finish.maxTLU_125.spef ../../../pt/signoff_data/bit_slice.maxTLU_125.spef
sh cp bt_outputs_icc2/chip_finish.maxTLU_125.spef ../../../pt/signoff_data/bit_top.maxTLU_125.spef
sh cp bc_outputs_icc2/chip_finish.maxTLU_125.spef ../../../pt/signoff_data/bit_coin.maxTLU_125.spef

sh cp bs_outputs_icc2/chip_finish.def.gz ../../../pt/signoff_data/bit_slice.def.gz
sh cp bt_outputs_icc2/chip_finish.def.gz ../../../pt/signoff_data/bit_top.def.gz
sh cp bc_outputs_icc2/chip_finish.def.gz ../../../pt/signoff_data/bit_coin.def.gz

sh cp bt_outputs_icc2/chip_finish.lef  ../../../pt/signoff_data/bit_top.lef
sh cp bs_outputs_icc2/chip_finish.lef ../../../pt/signoff_data/bit_slice.lef

sh rm -rf ../../../pt/signoff_data/wrap_bit_coin.upf
echo "# Auto Generated Wrapper UPF for VG tools" > ../../../pt/signoff_data/wrap_bit_coin.upf
echo "for {set j 0} {\$j < 16} {incr j} {" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "for {set i 0} {\$i < 32} {incr i} {" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "load_upf -scope bit_secure_\${j}/slice_\${i} ../pt/signoff_data/bit_slice.upf" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "for {set k 0} {\$k < 16} {incr k} {" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "load_upf -scope bit_secure_\${k} ../pt/signoff_data/bit_top.upf" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_coin.upf
echo "load_upf ../pt/signoff_data/bit_coin.upf" >> ../../../pt/signoff_data/wrap_bit_coin.upf

sh rm -rf ../../../pt/signoff_data/wrap_bit_top.upf
echo "# Auto Generated Wrapper UPF for VG tools" > ../../../pt/signoff_data/wrap_bit_top.upf
echo "for {set i 0} {\$i < 32} {incr i} {" >> ../../../pt/signoff_data/wrap_bit_top.upf
echo "load_upf -scope bit_secure_\${j}/slice_\${i} ../pt/signoff_data/bit_slice.upf" >> ../../../pt/signoff_data/wrap_bit_top.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_top.upf
echo "load_upf ../pt/signoff_data/bit_top.upf" >> ../../../pt/signoff_data/wrap_bit_top.upf

# HACKS FOR VCLP - PDOI ISSUE (fixed in bitcoin_v1.1)
sh rm -rf ../../../pt/signoff_data/bit_coin.vclp.upf
sh ./scripts/change_vclp_upf.pl ../../../pt/signoff_data/bit_coin.upf > ../../../pt/signoff_data/bit_coin.vclp.upf

sh rm -rf ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "# Auto Generated Wrapper UPF for VG tools" > ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "for {set j 0} {\$j < 16} {incr j} {" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "for {set i 0} {\$i < 32} {incr i} {" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "load_upf -scope bit_secure_\${j}/slice_\${i} ../pt/signoff_data/bit_slice.upf" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "for {set k 0} {\$k < 16} {incr k} {" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "load_upf -scope bit_secure_\${k} ../pt/signoff_data/bit_top.upf" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "}" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
echo "load_upf ../pt/signoff_data/bit_coin.vclp.upf" >> ../../../pt/signoff_data/wrap_bit_coin.vclp.upf
