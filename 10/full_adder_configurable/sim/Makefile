# Compiler and Simulator Settings
QUESTA_BIN  = $(QUESTA_HOME)/bin
VLOG        = $(QUESTA_BIN)/vlog
VSIM        = $(QUESTA_BIN)/vsim

# Project Directories
RTL_DIR     = ../rtl
TB_DIR      = ../tb
SIM_DIR     = .

# File Lists
RTL_FILES   = $(shell [ -f $(SIM_DIR)/rtl.f ] && cat $(SIM_DIR)/rtl.f || echo "")
TB_FILES    = $(shell [ -f $(SIM_DIR)/tb.f ] && cat $(SIM_DIR)/tb.f || echo "")
COMPILE_FLAGS = -sv +incdir+$(TB_DIR)
RADIX = unsigned
TESTNAME = "testbench"

# Targets
all: build run

build:
	@echo "Compiling design and testbench files..."
	@if [ -z "$(RTL_FILES)" ] || [ -z "$(TB_FILES)" ]; then \
		echo "Error: rtl.f or tb.f is missing or empty."; \
		exit 1; \
	fi
	vlib work
	vmap work work
	vlog $(COMPILE_FLAGS) -f $(SIM_DIR)/compile.f | tee compile.log

run:
	@echo "Running simulation..."
	vsim -debugDB -l $(TESTNAME).log -voptargs=+acc -c $(TESTNAME) -do "log -r /*;run -all;"

wave:
	@echo "Opening wave viewer..."
	vsim -i -view vsim.wlf -do "add wave vsim:/$(TESTNAME)/*; radix -$(RADIX)" &

clean:
	@echo "Cleaning simulation files..."
	rm -rf work transcript vsim.wlf *.log dump.vcd

