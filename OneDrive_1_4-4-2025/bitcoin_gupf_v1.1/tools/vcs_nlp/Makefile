################################################################################
PROJECT_NAME = bitcoin
################################################################################

INCL      = +incdir+../../verification/include+../../verification/src+../../verification/env+../../verification/tests+../../verification/hdl

################################################################################

QSUB_CMD += qsub -cwd -P bnormal -b yes -j yes
DEFINES   = 
MIN_TRANS_CNT = 50
MAX_TRANS_CNT = 50
COMP_OPTS = 
RUN_OPTS  = +min_random_count=$(MIN_TRANS_CNT) +max_random_count=$(MAX_TRANS_CNT)
TEST = btcoin_test 
VCS_VERSION = $(shell vcs -id > vcs_version ; grep "Compiler version" vcs_version | awk -F " " '{print $$5}')
VERDI_VERSION = $(shell echo $(VERDI_HOME) | awk -F/ '{print $$NF}')
SEED      = 1# Default seed set to 1
MODE      = DEBUG
UVM_TEST  = btcoin_test
UVM_LP_TEST  = btcoin_lp_test
LP = UPF
PHASE = RTL
CHECKER = 0
PWR_ANALYSIS = 0
PWR_ANALYSIS_WINDOW = 1000000

ifeq ($(PHASE), PG) 
  LP = NOUPF
endif

ifeq ($(PWR_ANALYSIS), 1)
  RUN_OPTS =  +min_random_count=1000000 +max_random_count=1000000 +vcs+finish+$(PWR_ANALYSIS_WINDOW)
endif

ifeq ($(PHASE), RTL)
  UPF_FILE = ../../upf/snps_bit_coin.upf
else
  ifeq ($(PHASE), GLS)
    #UPF_FILE = ../icc2/outputs2icc2/wrap_bit_coin.upf
    UPF_FILE = ./scripts/wrap_bit_coin_gls.upf
  else
    UPF_FILE = ./scripts/wrap_bit_coin_pg.upf
  endif
endif

#### VCS,Verdi and UVM checking
ifdef VCS_HOME
 ifdef VERDI_HOME
  ifndef UVM_HOME
   UVM = +warn=noIWNF -ntb_opts uvm-1.2 +define+UVM_POST_VERSION_1_1
  else
   UVM = +warn=noIWNF +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm_pkg.sv ${UVM_HOME}/src/dpi/uvm_dpi.cc -CFLAGS -DVCS 
  endif
 else
  ERR_STATUS = 1 
 endif
endif
ifndef VERDI_HOME
 ERR_STATUS = 1
endif

COMP_OPTS +=  -partcomp -fastpartcomp=j4 -timescale=1ns/1ps -sverilog -l vcs.log $(UVM) $(INCL) $(DEFINES)
#LPA_OPTS = -lpa_bind lpa_custom_golden.tcl -power=ret_generic_output -power=upf_analyzed_queries
ifeq ($(CHECKER), 1)
  LPA_OPTS = -mvrpt=output/$(PHASE)_$(MODE)_$(LP)/mvsim_native_reports -lpa_bind   ./checker/checker.tcl ./checker/checker.v
else
  LPA_OPTS = -mvrpt=logs/$(PHASE)_$(MODE)_$(LP)/mvsim_native_reports
endif

ifneq ($(PHASE), RTL)
COMP_OPTS += +vcs+initreg+random
RUN_OPTS += +vcs+initreg+0
endif

UPF_OPTS = -power=pst_state_msg+dump_hvp  -power_top bit_coin  +define+UPF +warn=noUPF_CONYI,noIWNF,noTFIPC -upf $(UPF_FILE) $(LPA_OPTS)

ifeq ($(PWR_ANALYSIS), 1)
  UPF_OPTS += +define+PWR_ANALYSIS
endif

ifeq ($(PHASE), RTL)
  UPF_OPTS += -xprop -power=cov_pst_state -power_config ./scripts/config.tcl
else
  UPF_OPTS += -power=accurate -power_config ./scripts/config_gls.tcl
endif

ifeq ($(LP), UPF)
COMP_OPTS +=  $(UPF_OPTS)
UVM_TEST = $(UVM_LP_TEST)
RUN_OPTS  += -power ./scripts/lp.tcl 
endif


ifeq ($(PHASE), RTL)
  FILELIST = -F ../../verification/hdl/filelist.f
else
  ifeq ($(PHASE), GLS)
    FILELIST = -F ../../verification/hdl/filelist_gls.f +define+NO_SAIF +nospecify
  else
    FILELIST = -F ../../verification/hdl/filelist_pggates.f +define+NO_SAIF +nospecify
  endif
endif

ifeq ($(MODE), DEBUG)
RUN_OPTS += +fsdbfile+./logs/$(PHASE)_$(MODE)_$(LP)/dump.fsdb +SAIF_REPORT=./logs/$(PHASE)_$(MODE)_$(LP)/bitcoin.saif
#RUN_OPTS += +fsdbfile+./logs/$(PHASE)_$(MODE)_$(LP)/dump.fsdb
endif


all default: check clean comp run


check:
	mkdir -p logs
	mkdir -p output
	mkdir -p outputsfromvcs
	mkdir -p output/$(PHASE)_$(MODE)_$(LP)
	mkdir -p logs/$(PHASE)_$(MODE)_$(LP)
ifndef ERR_STATUS
	@echo ""
	@echo "VCS version is ${VCS_VERSION}"
	@echo "Verdi version is ${VERDI_VERSION}"
else
 ifndef VCS_HOME
	@echo "VCS_HOME not set!!"
	@echo "Please do 'module addlatest vcsmx'"
	@echo '\n\n'
 else
	@echo "VERDI_HOME not set!!"
	@echo "Please do 'module addlatest verdi'"
	@echo '\n\n'
 endif
endif			 

comp: check
ifndef ERR_STATUS
ifeq ($(MODE), RECORD)
		vcs $(COMP_OPTS)  -debug_region=lib+cell -debug_access+all -lca -kdb +define+DUMP \
        	../../verification/tests/tb_top.sv ../../verification/hdl/bitcoin_top.sv \
		$(FILELIST) -Mdir=output/$(PHASE)_$(MODE)_$(LP)/csrc -o output/$(PHASE)_$(MODE)_$(LP)/simv \
		-l logs/$(PHASE)_$(MODE)_$(LP)/compile.log \
		-partcomp_dir=output/$(PHASE)_$(MODE)_$(LP)/partitionlib
		cp -R output/$(PHASE)_$(MODE)_$(LP)/simv.daidir outputsfromvcs/simv_$(PHASE)_$(LP).daidir
else		 
ifeq ($(MODE), DEBUG)
		vcs $(COMP_OPTS)  -debug_region=lib+cell -debug_access+pp -lca -kdb +define+DUMP \
        	 ../../verification/tests/tb_top.sv ../../verification/hdl/bitcoin_top.sv \
		$(FILELIST) -Mdir=output/$(PHASE)_$(MODE)_$(LP)/csrc -o output/$(PHASE)_$(MODE)_$(LP)/simv \
		-l logs/$(PHASE)_$(MODE)_$(LP)/compile.log \
		-partcomp_dir=output/$(PHASE)_$(MODE)_$(LP)/partitionlib
		cp -R output/$(PHASE)_$(MODE)_$(LP)/simv.daidir outputsfromvcs/simv_$(PHASE)_$(LP).daidir
else			 
		vcs $(COMP_OPTS)  \
        	 ../../verification/tests/tb_top.sv ../../verification/hdl/bitcoin_top.sv \
		$(FILELIST) -Mdir=output/$(PHASE)_$(MODE)_$(LP)/csrc -o output/$(PHASE)_$(MODE)_$(LP)/simv \
		-l logs/$(PHASE)_$(MODE)_$(LP)/compile.log \
		-partcomp_dir=output/$(PHASE)_$(MODE)_$(LP)/partitionlib
endif			 
endif		 
endif

run: check
ifndef ERR_STATUS
ifeq ($(MODE), RECORD)
	./output/$(PHASE)_$(MODE)_$(LP)/simv  $(RUN_OPTS) -l logs/$(PHASE)_$(MODE)_$(LP)/run.log \
        +ntb_random_seed=$(SEED) +timeout=20000000 +UVM_TESTNAME=$(UVM_TEST) +fsdb+all \
	+UVM_TR_RECORD +UVM_LOG_RECORD +fsdb+power
	cp logs/$(PHASE)_$(MODE)_$(LP)/dump.fsdb outputsfromvcs/$(PHASE)_$(LP).fsdb 
ifeq ($(PHASE), RTL)
  ifneq ($(PWR_ANALYSIS), 1)
	cp logs/$(PHASE)_$(MODE)_$(LP)/bitcoin.saif outputsfromvcs/$(PHASE)_$(LP).saif 
  endif
endif
else	
ifeq ($(MODE), DEBUG)
	./output/$(PHASE)_$(MODE)_$(LP)/simv $(RUN_OPTS) -l logs/$(PHASE)_$(MODE)_$(LP)/run.log \
        +ntb_random_seed=$(SEED) +timeout=200000 +UVM_TESTNAME=$(UVM_TEST) +fsdb+all
	cp logs/$(PHASE)_$(MODE)_$(LP)/dump.fsdb outputsfromvcs/$(PHASE)_$(LP).fsdb 
ifeq ($(PHASE), RTL)
  ifneq ($(PWR_ANALYSIS), 1)
	cp logs/$(PHASE)_$(MODE)_$(LP)/bitcoin.saif outputsfromvcs/$(PHASE)_$(LP).saif 
  endif
endif
else	
	./output/$(PHASE)_$(MODE)_$(LP)/simv  $(RUN_OPTS) -l logs/$(PHASE)_$(MODE)_$(LP)/run.log \
        +ntb_random_seed=$(SEED) +timeout=200000 +UVM_TESTNAME=$(UVM_TEST)
endif	
endif	
endif

verdi_gui: check
ifndef ERR_STATUS
	verdi -nologo -ssf logs/$(PHASE)_$(MODE)_$(LP)/dump.fsdb -sswr ./scripts/rtl.rc
endif

verdi_cov: check
ifndef ERR_STATUS
	verdi -nologo -cov -covdir  output/$(PHASE)_$(MODE)_$(LP)/simv.vdb
endif
reallyclean: clean
	rm -rf output/* logs/* outputsfromvcs/*
clean:
	rm -rf *.log inter.fsdb inter.vpd mvsim* vdCovLog
	rm -rf vc_hdrs.h .vcsmx_rebuild *.log DVEfiles novas.* debug.*
	rm -rf verdiLog DVEfiles vhdl_objs_dir ucli.key vcs_version 

help:
	@echo "******************************************************************************"
	@echo "***   Makefile Help for bitcoin :			                  ***"
	@echo "******************************************************************************"
	@echo "*  Usage:                                                                    *"
	@echo "*  ------                                                                    *"
	@echo "*  make       [Compile and Run the testcase with UPF and dumping]            *"
	@echo "*                                                                            *"
	@echo "*  Available targets:                                                        *"
	@echo "*  make help  [To see the Help]                                              *"
	@echo "*  make clean [Remove VCS generated log files && simv/csrc]                  *"
	@echo "*  make reallyclean [Remove everything - simv, fsdb, logs]                   *"
	@echo "*  make comp  [Compile the base testcase]                                    *"
	@echo "*  make run  [Run the base testcase]                                         *"
	@echo "*                                                                            *"
	@echo "*  Available arguments to above targets:                                     *"
	@echo "*  UVM_TEST=<name> [name of the UVM test, default is btcoin_lp_test]         *"
	@echo "*  MAX_TRANS_CNT=<int> [max number of sequence items, default is 50]         *"
	@echo "*  LP=NOUPF [disable Power Aware Sim(NLP), defaults is with UPF (NLP run)]   *"
	@echo "*  PHASE=RTL/GLS [ Run at RTL OR GLS, default is RTL]                        *"
	@echo "*  UPF_FILE=<location of UPF file> [Override the UPF file path]              *"
	@echo "*                                                                            *"
	@echo "*  Optional Arguments                                                        *"
	@echo "*  MODE=NODEBUG [Default MODE=DEBUG, FSDBs dumped]                           *"
	@echo "******************************************************************************"

include Makefile.bitslice
