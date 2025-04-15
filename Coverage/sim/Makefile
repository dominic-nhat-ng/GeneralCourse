
RTL_FILES  		= 		$(shell cat $(SIM_DIR)/rtl.f)
TB_FILES   		= 		$(shell cat $(SIM_DIR)/tb.f)

TESTNAME 		= 		"testbench"



all: build run



build:
	vlib work
	vmap work work
	vlog -sv -f compile.f | tee compile.log

build_cov:
	vlib work
	vmap work work
	vlog +cover=sbceft -f compile.f


run:
	vsim -debugdb -l $(TESTNAME).log -voptargs=+acc -assertdebug -c "testbench" -do "log -r /*;run -all"



run_cov:
	vsim -coverage -l $(TESTNAME).log -c -voptargs="+cover=bcesft" -assertdebug -do "coverage save -onexit $(TESTNAME).ucdb; log -r /*; run -all" $(TESTNAME)

gen_cov:
	mkdir -p coverage
	vcover merge IP.ucdb *.ucdb
	vcover report IP.ucdb -output coverage/summary_report.txt
	vcover report -zeros -details -code bcesft -annotate -All -codeAll IP.ucdb -output coverage/detail_report.txt

wave:
	vsim -i -view vsim.wlf -do "add wave -r /testbench/intf/*; radix -$(RADIX)" &

clean:
	rm -rf work *.ini *.log *.dbg *.wlf transcript
