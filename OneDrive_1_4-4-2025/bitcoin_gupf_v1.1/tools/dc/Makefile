# Makefile for DC

# DC PATHS NEEDED
# PATH := /global/apps/syn_2016.12/bin:$(PATH)

SETUP = ./scripts/setup_dc.csh

all : bit_slice bit_top bit_coin extract_dc_data

bit_slice_quick: 
	$(SETUP)
	dc_shell-t -topo -f scripts/go_dc_bit_slice_quick.tcl | tee logs/log.dc.bit_slice_quick

bit_slice: 
	$(SETUP)
	dc_shell-t -topo -f scripts/go_dc_bit_slice.tcl | tee logs/log.dc.bit_slice

debug_bit_slice: 
	$(SETUP)
	dc_shell-t -topo -f scripts/debug_dc_bit_slice.tcl | tee logs/log.dc.debug.bit_slice

bit_top: 
	$(SETUP)
	dc_shell-t -topo -f scripts/go_dc_bit_top.tcl | tee logs/log.dc.bit_top

debug_bit_top: 
	$(SETUP)
	dc_shell-t -topo -f scripts/debug_dc_bit_top.tcl | tee logs/log.dc.debug.bit_top

bit_coin: 
	$(SETUP)
	dc_shell-t -topo -f scripts/go_dc_bit_coin.tcl | tee logs/log.dc.bit_coin
	dc_shell-t -topo -f scripts/save_upf.tcl | tee logs/log.save_upf

debug_bit_coin: 
	$(SETUP)
	dc_shell-t -topo -f scripts/debug_dc_bit_coin.tcl | tee logs/log.dc.debug.bit_coin

extract_dc_data: 

tmax: 
	tmax -shell -tcl scripts/go_tmax_bit_coin.tcl | tee logs/log.tmax

clean:
	rm -rf logs/* reports/* alib-52  *_PHY_LIB  command.log  default.svf filenames.log lc_shell_command.log results* work/* *.svf
