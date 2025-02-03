##########################################################################################
#																						 #
#				This file created by Nhat Nguyen as know as Dominic						 #
#																						 #
#																						 #
##########################################################################################

# Compiler and Simulator Settings
QUESTA_BIN = $(QUESTA_HOME)/bin
VLOG       = $(QUESTA_BIN)/vlog
VSIM       = $(QUESTA_BIN)/vsim

# Project Directories
RTL_DIR    = ../rtl
TB_DIR     = ../tb
SIM_DIR    = .

# File Lists
RTL_FILES  = $(shell cat $(SIM_DIR)/rtl.f)
TB_FILES   = $(shell cat $(SIM_DIR)/tb.f)
COMPILE_FLAGS = -sv +incdir+$(TB_DIR)
RADIX = heximal
TESTNAME = "testbench"

# UVM Settings
UVM_HOME   = $(QUESTA_HOME)/uvm-1.2
UVM_FLAGS  = -uvm

# Targets
all: build run

build:
	vlib work
	vmap work work
	vlog -sv -f compile.f | tee compile.log

build_cov:
	vlib work
	vmap work work
	vlog +cover=bcesft -f compile.f

run:
	vsim -debugDB -l $(TESTNAME).log -voptargs=+acc -assertdebug -c  "testbench" -do "log -r /*;run -all;"

run_cov:
	vsim -coverage -l $(TESTNAME).log -c -voptargs="+cover=bcesft" -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r /*; run -all" $(TESTNAME)

gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -output coverage/summary_report.txt
	vcover report -zeros -details -code bcesft -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt
gen_html:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report -zeros -details -code bcesft -annotate -testhitdataAll -html IP.ucdb
wave:
	vsim -i -view vsim.wlf -do "add wave -r /testbench/intf/*; radix -$(RADIX)" &

clean:
	@echo "Cleaning simulation files..."
	rm -rf work transcript vsim.wlf *.log dump.vcd *.ucdb *.dbg *.vstf

help:
	@echo "make help: Show this instruction"
	@echo "make build: Build project"
	@echo "make run: Compile code"
	@echo "make wave: Show waveform on QuestaSim"

