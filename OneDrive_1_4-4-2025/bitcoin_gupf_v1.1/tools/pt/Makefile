# Makefile for PT

SETUP = ./scripts/setup_pt.csh

bit_coin:
	$(SETUP)
	pt_shell -f scripts/go_pt_bit_coin.tcl | tee logs/log.pt.bit_coin

bit_coin_pr:
	$(SETUP)
	pt_shell -f scripts/go_pt_bit_coin_pr.tcl | tee logs/log.pt.bit_coin_pr

bit_coin_debug: 
	$(SETUP)
	pt_shell -f scripts/go_pt_bit_coin_debug.tcl | tee logs/log.pt.bit_coin_debug

bit_slice:
	$(SETUP)
	pt_shell -f scripts/go_pt_bit_slice.tcl | tee logs/log.pt.bit_slice

clean:
	rm -rf sess fsdb* results* reports* logs *.log
