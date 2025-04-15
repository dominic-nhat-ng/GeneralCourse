RTL_DIR    = ../rtl
TB_DIR     = ../tb
SIM_DIR    = .

# File Lists
RTL_FILES  = $(shell cat $(SIM_DIR)/rtl.f)
TB_FILES   = $(shell cat $(SIM_DIR)/tb.f)
COMPILE_FLAGS = -sv +incdir+$(TB_DIR)
RADIX = unsigned

TESTNAME ?= test_example

UVM_HOME   = $(QUESTA_HOME)/uvm-1.2
UVM_FLAGS  = -uvm

# Targets
all: build run

build:
	vlib work
	vmap work work
	vlog -sv -f compile.f | tee compile.log

run:
	vsim -debugDB -voptargs=+acc -assertdebug -c testbench -do "log -r /*; run -all;" +UVM_TESTNAME=$(TESTNAME)

wave:
	vsim -i -view vsim.wlf -do "add wave vsim:/testbench/*; radix -$(RADIX)" &

clean:
	@echo "Cleaning simulation files..."
	rm -rf work transcript logs vsim.wlf *.log  *.dbg dump.vcd *.ini

