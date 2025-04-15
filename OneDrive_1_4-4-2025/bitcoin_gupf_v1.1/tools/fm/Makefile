# Makefile for FM

SETUP = ./scripts/setup_fm.csh

bit_slice_quick_rtl2gate: 
	$(SETUP)
	fm_shell -f scripts/go_fm_bit_slice_quick_rtl2gate.tcl | tee logs/log.fm.bit_slice_quick_rtl2gate

bit_slice_rtl2gate: 
	$(SETUP)
	fm_shell -f scripts/go_fm_bit_slice_rtl2gate.tcl | tee logs/log.fm.bit_slice_rtl2gate

bit_coin_rtl2gate: 
	$(SETUP)
	fm_shell -f scripts/go_fm_bit_coin_rtl2gate.tcl | tee logs/log.fm.bit_coin_rtl2gate

bit_coin_gate2pg: 
	$(SETUP)
	fm_shell -f scripts/go_fm_bit_coin_gate2pg.tcl | tee logs/log.fm.bit_coin_gate2pg

bit_slice_rtl2pg: 
	$(SETUP)
	fm_shell -f scripts/go_fm_bit_slice_rtl2pg.tcl | tee logs/log.fm.bit_slice_rtl2pg

bit_coin_rtl2pg: 
	$(SETUP)
	fm_shell -f scripts/go_fm_bit_coin_rtl2pg.tcl | tee logs/log.fm.bit_coin_rtl2pg

clean:
	rm -rf logs/* reports/* fm_shell_command*.log formality*.log formality*_svf *.lck FM_WORK*
