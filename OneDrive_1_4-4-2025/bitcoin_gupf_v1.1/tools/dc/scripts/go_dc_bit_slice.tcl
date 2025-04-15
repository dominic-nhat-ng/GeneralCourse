source rm_setup/dc_setup.tcl
source scripts/procs.tcl
START_TIMER BIT_SLICE_OPT "Starting BIT_SLICE Optimization"

suppress_message TFCHK-014
suppress_message TLUP-005
suppress_message PSYN-025
suppress_message PWR-536
suppress_message PSYN-058
suppress_message OPT-1209

source scripts/dc_variables.tcl

define_design_lib -path ./work work
set DESIGN_NAME bit_slice
saif_map -start

read_sverilog [list ../../rtl/sync.v ../../rtl/reset_sync.v ../../rtl/sync_wrapper.v ../../rtl/bit_slice.v ../../rtl/sipo.v ../../rtl/piso.v]
analyze -format verilog [list ../../rtl/sync.v ../../rtl/sync_wrapper.v ]
elaborate sync_wrapper
current_design bit_slice

link

set DESIGN_NAME [get_object_name [current_design]]
set RESULTS_DIR ./results_bit_slice
set_svf ${RESULTS_DIR}/${DESIGN_NAME}.svf

set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE


source -e -v ../../sdc/bit_slice.sdc
load_upf ../../upf/snps_bit_slice.upf > logs/snps_bit_slice.upf.log
read_saif -instance_name bitcoin_top/dut/bit_secure_0/slice_0 -input ../vcs_nlp/outputsfromvcs/RTL_UPF.saif -auto_map_names
source -e -v scripts/snps_set_voltage.tcl
check_mv_design
extract_physical_constraints ../../def/bs.def
source -e -v ../../def/bs_va.tcl
#set_dont_touch [get_nets isolation_sig*]
set_leakage_optimization true
set_dynamic_optimization true

COMMAND_RUNTIME compile_ultra -no_autoungroup -scan
change_names -rule verilog -hier
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_compiled.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_compiled.ddc
save_upf -supplemental ${RESULTS_DIR}/${DESIGN_NAME}_compiled.sup.upf -include_supply_exceptions
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}_compiled.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}_compiled.script
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}_compiled.spef

set enable_slew_degradation false
set disable_library_transition_degradation true
set write_sdc_output_lumped_net_capacitance false
set write_sdc_output_net_resistance false
write_parasitics -script -output ${RESULTS_DIR}/${DESIGN_NAME}_rc_compiled.tcl

write_sdf ${RESULTS_DIR}/${DESIGN_NAME}_compiled.sdf

#### Running DFT insertion and Incremental Compile ##############
COMMAND_RUNTIME source -e -v scripts/dft_bs.tcl

######### WA to get LS inserted Properly ##########
#set_dont_touch [get_nets *isolation_sign*] false
#insert_mv_cells -verbose
#check_mv_design
compile_ultra -incremental -scan
check_mv_design
change_names -rule verilog -hier
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}.report.scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}.test.ddc
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.ddc
save_upf -supplemental ${RESULTS_DIR}/${DESIGN_NAME}.sup.upf -include_supply_exceptions
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}.script
extract_rc -estimate
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}.spef
write_parasitics -script -output ${RESULTS_DIR}/${DESIGN_NAME}_rc.tcl
write_sdf ${RESULTS_DIR}/${DESIGN_NAME}.sdf
######################
create_block_abstraction 
write -f ddc -h -o $RESULTS_DIR/${DESIGN_NAME}_bam.ddc
write -f verilog -h -o $RESULTS_DIR/${DESIGN_NAME}_bam.vg
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.test.ddc
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}_bam.report.scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.test.ddc
save_upf -supplemental $RESULTS_DIR/${DESIGN_NAME}_bam.sup.upf -include_supply_exceptions
check_mv_design -verbose > reports/${DESIGN_NAME}_bam.cmv.rpt
report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.iso.rpt
report_retention_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.ret.rpt
report_level_shifter -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.ls.rpt
report_upf_area > reports/${DESIGN_NAME}_bam.area.rpt

report_qor -summary > ${REPORTS_DIR}/${DESIGN_NAME}.qor.rpt
report_timing -transition_time -capacitance  -physical -attributes > ${REPORTS_DIR}/${DESIGN_NAME}.tim.rpt
report_power > ${REPORTS_DIR}/${DESIGN_NAME}.power.rpt
check_mv_design -verbose > ${REPORTS_DIR}/${DESIGN_NAME}.cmv.rpt
saif_map -type ptpx -write_map ${RESULTS_DIR}/${DESIGN_NAME}.name_map
saif_map -end

STOP_TIMER BIT_SLICE_OPT "Completing BIT_SLICE_OPTIMIZATION"
exit
