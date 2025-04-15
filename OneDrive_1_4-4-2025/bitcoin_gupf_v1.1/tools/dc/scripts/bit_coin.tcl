source scripts/dc_variables.tcl
source scripts/procs.tcl

START_TIMER BIT_COIN_OPT "Starting BIT_COIN_OPTIMIZATION"


suppress_message TFCHK-014
suppress_message TLUP-005
suppress_message PSYN-025
suppress_message PWR-536
suppress_message PSYN-058
suppress_message OPT-1209

define_design_lib -path ./work work
set DESIGN_NAME bit_coin
saif_map -start

source -e -v rm_setup/dc_setup.tcl
set_top_implementation_options -block_references "bit_top bit_slice"
read_ddc results_bit_top/bit_top_bam.ddc
read_ddc results_bit_slice/bit_slice_bam.ddc
read_verilog [list ../../rtl/reset_sync.v ../../rtl/bit_coin.v ../../rtl/secure_data.v  ../../rtl/sipo.v ../../rtl/piso.v]
analyze -format verilog [list ../../rtl/sync.v ../../rtl/sync_wrapper.v ]
elaborate sync_wrapper
current_design bit_coin
link

set DESIGN_NAME [get_object_name [current_design]]
set RESULTS_DIR ./results_bit_coin
set_svf ${RESULTS_DIR}/${DESIGN_NAME}.svf
source -e -v ../../sdc/bit_coin.sdc
report_top_implementation_options
load_upf ../../upf/snps_bit_coin.upf > logs/snps_bit_coin.upf.log
source -e -v scripts/snps_set_voltage.tcl
read_saif -instance_name bitcoin_top/dut -input ../vcs_nlp/outputsfromvcs/RTL_UPF.saif -auto_map_names
COMMAND_RUNTIME propagate_constraints -power_supply_data
extract_physical_constraints ../../def/bc.def
source -e -v ../../def/bc_va.tcl

set_dont_touch_network [get_ports "data_valid retent* "]
set_dont_touch [get_ports "data_valid retent* "]
set_dont_touch [get_nets "isolation*"]

set_leakage_optimization true
set_dynamic_optimization true

COMMAND_RUNTIME compile_ultra -no_autoungroup -scan -gate_clock

change_names -rule verilog -hier
write -f verilog -hier -o $RESULTS_DIR/${DESIGN_NAME}.vg
write -f ddc -hier -o $RESULTS_DIR/${DESIGN_NAME}.ddc
save_upf $RESULTS_DIR/${DESIGN_NAME}.upf
write_sdc $RESULTS_DIR/${DESIGN_NAME}.sdc
write_script -output $RESULTS_DIR/${DESIGN_NAME}.script
write_parasitics -output $RESULTS_DIR/${DESIGN_NAME}.spef
write_sdf $RESULTS_DIR/${DESIGN_NAME}.sdf

#### Running DFT insertion and Incremental Compile ##############
COMMAND_RUNTIME source -e -v scripts/dft_bc.tcl

######### WA to get LS inserted Properly ##########
set_port_attributes -ports isolation_signals -driver_supply SSL
set_dont_touch [get_nets *isolation_sign*] false

extract_rc -estimate

change_names -rules verilog -hierarchy
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}.check_scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl.ddc
report_dft_signal > ${REPORTS_DIR}/${DESIGN_NAME}_dft_signal.rpt
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}.script
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}.spef
write_sdf ${RESULTS_DIR}/${DESIGN_NAME}.sdf
report_scan_path > ${REPORTS_DIR}/${DESIGN_NAME}.scan_path
write_test_protocol -test_mode Internal_scan -output ${RESULTS_DIR}/${DESIGN_NAME}.internal_scan.spf
write_test_protocol -test_mode ScanCompression_mode -output ${RESULTS_DIR}/${DESIGN_NAME}.compression.spf

report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.iso.rpt
report_retention_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.ret.rpt
report_level_shifter -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.ls.rpt
report_upf_area > reports/${DESIGN_NAME}.area.rpt
report_qor -summary > ${REPORTS_DIR}/${DESIGN_NAME}.qor.rpt
report_timing -transition_time -capacitance  -physical -attributes > ${REPORTS_DIR}/${DESIGN_NAME}.tim.rpt
report_power > ${REPORTS_DIR}/${DESIGN_NAME}.power.rpt
check_mv_design -verbose > ${REPORTS_DIR}/${DESIGN_NAME}.cmv.rpt

compile_ultra -incremental -scan -no_autoungroup -gate_clock
optimize_netlist -area
change_names -rules verilog -hierarchy
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}_dft_compiled.check_scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.ctl.ddc
report_dft_signal > ${REPORTS_DIR}/${DESIGN_NAME}_dft_signal.rpt
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.script
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.spef
write_sdf ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.sdf
report_scan_path > ${REPORTS_DIR}/${DESIGN_NAME}_dft_compiled.scan_path
write_test_protocol -test_mode Internal_scan -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.internal_scan.spf
write_test_protocol -test_mode ScanCompression_mode -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_compiled.compression.spf

######### WA to get LS inserted Properly ##########
set_port_attributes -ports isolation_signals -driver_supply SSL
set_dont_touch [get_nets *isolation_sign*] false

insert_mv_cells
check_mv_design
compile_ultra -incremental -scan -gate_clock
check_mv_design
change_names -rule verilog -hier
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}.check_scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl.ddc
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}.script
extract_rc -estimate
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}.spef
write_sdf ${RESULTS_DIR}/${DESIGN_NAME}.sdf
save_upf -full_upf ${RESULTS_DIR}/${DESIGN_NAME}.upf_full
######################

report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.iso.rpt
report_retention_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.ret.rpt
report_level_shifter -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.ls.rpt
report_upf_area > reports/${DESIGN_NAME}.area.rpt
report_qor -summary > ${REPORTS_DIR}/${DESIGN_NAME}.qor.rpt
report_timing -transition_time -capacitance  -physical -attributes > ${REPORTS_DIR}/${DESIGN_NAME}.tim.rpt
report_power > ${REPORTS_DIR}/${DESIGN_NAME}.power.rpt
check_mv_design -verbose > ${REPORTS_DIR}/${DESIGN_NAME}.cmv.rpt
set MSG720 [get_message_info -occurrences UPF-720]
set MSG722 [get_message_info -occurrences UPF-722]

source scripts/upf_block_part.tcl

save_upf ${RESULTS_DIR}/bit_coin.upf
save_upf results_bit_coin/bit_coin.upf
save_upf ../icc2/outputs2icc2/bit_coin.upf
saif_map -type ptpx -write_map ${RESULTS_DIR}/${DESIGN_NAME}.name_map
saif_map -end
set_svf -off
source -e -v scripts/generate_wrapper.tcl

STOP_TIMER BIT_COIN_OPT "Completing BIT_COIN_OPTIMIZATION"
exit
