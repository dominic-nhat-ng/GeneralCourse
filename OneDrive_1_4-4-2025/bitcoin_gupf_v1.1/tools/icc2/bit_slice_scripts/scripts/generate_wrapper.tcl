sh rm -rf results/top_wrapper.upf
echo "# Auto Generated Wrapper UPF for VG tools" > results/top_wrapper.upf
echo "for {set j 0} {\$j < 16} {incr j} {" >> results/top_wrapper.upf
echo "for {set i 0} {\$i < 32} {incr i} {" >> results/top_wrapper.upf
echo "load_upf -scope bit_secure_\${j}/slice_\${i} synthesis/bit_slice/results/bit_slice_dft.upf" >> results/top_wrapper.upf
echo "}" >> results/top_wrapper.upf 
echo "}" >> results/top_wrapper.upf 
echo "for {set k 0} {\$k < 16} {incr k} {" >> results/top_wrapper.upf 
echo "load_upf -scope bit_secure_\${k} synthesis/bit_top/results/bit_top_dft.upf" >> results/top_wrapper.upf  
echo "}" >> results/top_wrapper.upf 
echo "load_upf ./synthesis/results/bit_coin_dft.upf" >> results/top_wrapper.upf 

