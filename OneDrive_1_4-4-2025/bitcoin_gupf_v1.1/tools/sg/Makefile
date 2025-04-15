.SILENT:

help:
	@echo "##################################### Make Targets ##################################################" 
	@echo "OPTIONS --> clean (to clean database)" 
	@echo "OPTIONS --> all (to run lint, constraint, cdc, power @ bit_slice and bit_coin)" 
	@echo "OPTIONS --> bit_slice, bit_coin (to run lint, constraint, cdc, power @ bit_slice and bit_coin)" 
	@echo "OPTIONS --> bit_slice_lint, bit_coin_lint (to run lint @bit_slice and bit_coin)" 
	@echo "OPTIONS --> bit_slice_constraint, bit_coin_constraint (to run SDC checking @bit_slice and bit_coin)" 
	@echo "OPTIONS --> bit_slice_cdc, bit_coin_cdc (to run CDC checking @bit_slice and bit_coin)" 
	@echo "OPTIONS --> bit_slice_power, bit_coin_power (to run RTL Power Profiling @bit_slice and bit_coin)" 
	@echo "OPTIONS --> bit_slice_debug, bit_coin_debug (to open GUI for debug and results review)" 
	@echo "" 
	@echo "CAUTION!  'clean' will remove the following directories!"
	@echo "             ./bit_slice/outputs"
	@echo "             ./bit_slice/reports"
	@echo "             ./bit_slice/WORK"
	@echo "             ./*.log"
	@echo "             ./bit_coin/outputs"
	@echo "             ./bit_coin/reports"
	@echo "             ./bit_coin/WORK"

clean:
	\rm -rf ./bit_slice/outputs ./bit_slice/reports ./bit_slice/WORK ./WORK ./*.log
	\rm -rf ./bit_coin/outputs ./bit_coin/reports ./WORK ./*.log ./bit_coin/WORK
 

all : bit_slice bit_coin

########################## Section1: Bit_Slice #######################################################

bit_slice: bit_slice_lint bit_slice_constraint bit_slice_cdc bit_slice_power bit_slice_debug

bit_slice_lint_sdc_cdc: bit_slice_lint bit_slice_constraint bit_slice_cdc 

bit_slice_lint:
	./bit_slice/scripts/run_lint -batch
 
bit_slice_constraint:
	./bit_slice/scripts/run_constraints -batch

bit_slice_cdc:
	./bit_slice/scripts/run_cdc -batch

bit_slice_power:
	./bit_slice/scripts/run_power -batch

bit_slice_debug:
	./bit_slice/scripts/run_gui &

