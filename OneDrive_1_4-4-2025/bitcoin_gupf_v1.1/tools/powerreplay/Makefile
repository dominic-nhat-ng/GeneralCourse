# Makefile for PowerReplay

SETUP = ./scripts/setup_powerreplay.csh

# GLOBAL TARGETS
bit_slice_upf : bit_slice_rtl_noupf_kdb bit_slice_gate_upf_kdb bit_slice_rtl2gate_upf_crdb bit_slice_gate_upf_replay
bit_slice_noupf : bit_slice_rtl_noupf_kdb bit_slice_gate_noupf_kdb bit_slice_rtl2gate_noupf_crdb bit_slice_gate_noupf_replay


### bit_slice (DC Netlist) ###

# BIT SLICE - UPF
bit_slice_rtl_noupf_kdb: 
	$(SETUP)
	# RTL NOUPF KDB
	vcs -kdb=keep_unresolved_db -lca -timescale=1ns/1ns -sverilog -v ../../lib/verilog/SRAM2RW16x4.v -f ../../rtl/files_bit_slice.f -l logs/1_bit_slice_rtl_noupf_kdb.log -o rtl_bit_slice_noupf_simv

bit_slice_gate_upf_kdb: 
	# GATE UPF KDB
	vcs -kdb=keep_unresolved_db -lca -timescale=1ns/1ns -sverilog +define+UPF +warn=noTCL_OPT_NYI,noUPF_CONYI,noIWNF,noTFIPC -f scripts/files_bit_slice.vg.f -gupf_config scripts/vcs_config.tcl  -l logs/2_bit_slice_gate_upf_kdb.log -o gate_bit_slice_upf_simv

bit_slice_rtl2gate_upf_crdb: 
	# CRDB
	powrep -map -RTL "-lib rtl_bit_slice_noupf_simv.daidir/work -vtop bit_slice.vtop" -GATE "-lib gate_bit_slice_upf_simv.daidir/work -vtop bit_slice.vtop" -target_scope bitslice_top.dut -impSVF "../icc2/outputs2icc2/bit_slice.svf"

bit_slice_gate_upf_replay:
	# REPLAY BIT COIN GATE UPF
	powrep -extract -lib gate_bit_slice_upf_simv.daidir/work -vtop bit_slice.vtop -config ./scripts/bit_slice.rtl2gate_upf.wi_config
	powrep -compile -config ./scripts/bit_slice.rtl2gate_upf.wi_config
	powrep -sim -config ./scripts/bit_slice.rtl2gate_upf.wi_config

# BIT SLICE - DC Netlist with NO UPF (USES RTL NOUPF KDB)

bit_slice_gate_noupf_kdb: 
	# GATE NOUPF KDB
	vcs -kdb=keep_unresolved_db -lca -timescale=1ns/1ns -sverilog +define+UPF -f scripts/files_bit_slice.vg.f -l logs/2_bit_slice_gate_noupf_kdb.log -o gate_bit_slice_noupf_simv

bit_slice_rtl2gate_noupf_crdb: 
	# CRDB
	powrep -map -RTL "-lib rtl_bit_slice_noupf_simv.daidir/work -vtop bit_slice.vtop" -GATE "-lib gate_bit_slice_noupf_simv.daidir/work -vtop bit_slice.vtop" -target_scope bitslice_top.dut -impSVF "../icc2/outputs2icc2/bit_slice.svf"

bit_slice_gate_noupf_replay:
	# REPLAY BIT COIN GATE UPF
	powrep -extract -lib gate_bit_slice_noupf_simv.daidir/work -vtop bit_slice.vtop -config ./scripts/bit_slice.rtl2gate_noupf.wi_config
	powrep -compile -config ./scripts/bit_slice.rtl2gate_noupf.wi_config
	powrep -sim -config ./scripts/bit_slice.rtl2gate_noupf.wi_config

clean:
	rm -rf logs/* *.log bit_*map* csrc *gate_*_simv* mvsim_native_reports novas* novas.rc rtl_*noupf_simv* vc_hdrs.h powrep*
