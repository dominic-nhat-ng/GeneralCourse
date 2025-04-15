# Makefile for bit_coin + bit_slice - Synopsys Low Power Flow and Methodology

### bit_slice

bit_slice : bs_static1 bs_dynamic bs_static2 bs_syn bs_syn_signoff bs_pr bs_signoff
bit_slice_cont : bs_static2 bs_syn bs_syn_signoff bs_pr bs_signoff

bs_static1 :
	# SpyGlass Lint/SDC/CDC @RTL
	cd sg; make bit_slice_lint_sdc_cdc

bs_dynamic :
	# VCS NLP @RTL
	cd vcs_nlp; gmake reallyclean
	cd vcs_nlp; gmake bit_slice
	cd vcs_nlp; gmake bit_slice LP=NOUPF

bs_static2 :
	# SpyGlass PE @RTL
	cd sg; make bit_slice_power
	# VCLP @RTL
	cd vclp; make bit_slice

bs_syn :
	# DC
	cd dc; make bit_slice_quick

bs_syn_signoff :
	# FM @RTL2Gate
	cd fm; make bit_slice_quick_rtl2gate
	# VCLP @Gate
	cd vclp; make bit_slice_quick_gate
	# VCS NLP @GLS
	cd vcs_nlp; gmake bit_slice PHASE=GLS
	cd vcs_nlp; gmake bit_slice LP=NOUPF PHASE=GLS
	# PowerReplay
	cd powerreplay; make bit_slice_upf

bs_pr :
	# ICC2
	cd icc2/bit_slice; make all 

bs_signoff :
	# VCLP @PG
	cd vclp; make bit_slice_pg
	# VCS_NLP @PG
	cd vcs_nlp; gmake bit_slice PHASE=PG
	# FM @RTL2PG
	cd fm; make bit_slice_rtl2pg
	# PT
	cd pt; make bit_slice

clean:
	cd sg; make clean
	cd vcs_nlp; gmake reallyclean
	cd vclp; make clean
	cd dc; make clean
	cd icc2/bit_slice; make clean
	cd icc2; make clean
	cd fm; make clean
	cd pt; make clean
	cd powerreplay; make clean
