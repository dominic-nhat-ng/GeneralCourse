mkdir synthesis
mkdir synthesis/bit_slice
mkdir synthesis/bit_top
mkdir synthesis/logs
mkdir synthesis/bit_slice/logs
mkdir synthesis/bit_top/logs
mkdir synthesis/reports
mkdir synthesis/bit_slice/reports
mkdir synthesis/bit_top/reports
mkdir synthesis/results
mkdir synthesis/bit_slice/results
mkdir synthesis/bit_top/results
cp rtl  synthesis -r
cp rtl  synthesis/bit_slice -r
cp rtl  synthesis/bit_top -r
cp sdc  synthesis -r
cp sdc  synthesis/bit_slice -r
cp sdc  synthesis/bit_top -r
cp upf  synthesis -r
cp upf  synthesis/bit_slice -r
cp upf  synthesis/bit_top -r
cp scripts  synthesis -r
cp scripts  synthesis/bit_slice -r
cp scripts  synthesis/bit_top -r
cp lib  synthesis -r
cp lib  synthesis/bit_slice -r
cp lib  synthesis/bit_top -r
cp tech  synthesis -r
cp tech  synthesis/bit_slice -r
cp tech  synthesis/bit_top -r
cp rm_setup  synthesis -r
cp rm_setup  synthesis/bit_slice -r
cp rm_setup  synthesis/bit_top -r
cp alib-52  synthesis -r
cp alib-52  synthesis/bit_slice -r
cp alib-52  synthesis/bit_top -r
cp def  synthesis -r
cp def  synthesis/bit_slice -r
cp def  synthesis/bit_top -r
cd synthesis
cd bit_slice
dc_shell-t -topo -f scripts/bit_slice.tcl | tee logs/bit_slice.tcl.log
cd ../bit_top
dc_shell-t -topo -f scripts/bit_top.tcl | tee logs/bit_top.tcl.log
cd ../
/u/re/spf_l2016.03_sp_dev/image_NIGHTLY/D20161023_17_30/bin/dc_shell-t -topo -f scripts/bit_coin.tcl | tee logs/bit_coin.tcl.log
/u/re/spf_l2016.03_sp_dev/image_NIGHTLY/D20161023_17_30/bin/dc_shell-t -topo -f scripts/bit_coin_incr.tcl | tee logs/bit_coin_incr.tcl.log
/u/re/spf_l2016.03_sp_dev/image_NIGHTLY/D20161023_17_30/bin/dc_shell-t -topo -f scripts/extract_dc_data.tcl | tee logs/extract_dc_data.tcl.log
cd ../
