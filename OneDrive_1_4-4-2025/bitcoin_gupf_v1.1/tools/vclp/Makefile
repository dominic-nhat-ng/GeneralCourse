# Makefile for VCLP

SETUP = ./scripts/setup_vclp.csh

all_rtl: bit_slice bit_top bit_coin

all_gate: bit_slice_gate bit_top_gate bit_coin_gate

all_pg: bit_slice_pg bit_top_pg bit_coin_pg

all : all_rtl all_gate all_pg

bit_slice: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_slice.tcl -session vclp_sess/vclp_sess_bit_slice | tee logs/log.vclp.bit_slice

bit_top: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_top.tcl -session vclp_sess/vclp_sess_bit_top | tee logs/log.vclp.bit_top

bit_coin: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_coin.tcl -session vclp_sess/vclp_sess_bit_coin | tee logs/log.vclp.bit_coin

bit_slice_gate: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_slice_gate.tcl -session vclp_sess/vclp_sess_bit_slice_gate | tee logs/log.vclp.bit_slice_gate

bit_slice_quick_gate: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_slice_quick_gate.tcl -session vclp_sess/vclp_sess_bit_slice_quick_gate | tee logs/log.vclp.bit_slice_quick_gate

bit_top_gate: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_top_gate.tcl -session vclp_sess/vclp_sess_bit_top_gate | tee logs/log.vclp.bit_top_gate

bit_coin_gate: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_coin_gate.tcl -session vclp_sess/vclp_sess_bit_coin_gate | tee logs/log.vclp.bit_coin_gate

bit_slice_pg: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_slice_pg.tcl -session vclp_sess/vclp_sess_bit_slice_pg | tee logs/log.vclp.bit_slice_pg

bit_top_pg: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_top_pg.tcl -session vclp_sess/vclp_sess_bit_top_pg | tee logs/log.vclp.bit_top_pg

bit_coin_pg: 
	$(SETUP)
	vc_static_shell -f scripts/go_vclp_bit_coin_pg.tcl -session vclp_sess/vclp_sess_bit_coin_pg | tee logs/log.vclp.bit_coin_pg

debug_bit_slice_gate: 
	$(SETUP)
	vc_static_shell -restore -session vclp_sess/vclp_sess_bit_slice_gate_rtdb | tee logs/log.vclp.bit_slice_gate_debug

debug_bit_slice_pg: 
	$(SETUP)
	vc_static_shell -restore -session vclp_sess/vclp_sess_bit_slice_pg_rtdb | tee logs/log.vclp.bit_slice_pg_debug

debug_bit_coin: 
	$(SETUP)
	vc_static_shell -restore -session vclp_sess/vclp_sess_bit_coin_rtdb | tee logs/log.vclp.bit_coin_debug

debug_bit_coin_gate: 
	$(SETUP)
	vc_static_shell -restore -session vclp_sess/vclp_sess_bit_coin_gate_rtdb | tee logs/log.vclp.bit_coin_gate_debug

debug_bit_coin_pg: 
	$(SETUP)
	vc_static_shell -restore -session vclp_sess/vclp_sess_bit_coin_pg_rtdb | tee logs/log.vclp.bit_coin_pg_debug

clean:
	rm -rf logs/* reports/* vclp_sess vcst_* novas*
