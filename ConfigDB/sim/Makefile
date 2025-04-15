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
RADIX = unsigned
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

run:
	vsim -debugDB -l $(TESTNAME).log -voptargs=+acc -assertdebug -c "testbench" -do "log -r /*;run -all;"

wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/testbench/*; radix -$(RADIX)" &


clean:
	@echo "Cleaning simulation files..."
	rm -rf work transcript vsim.wlf *.log dump.vcd *.dbg *.ini

