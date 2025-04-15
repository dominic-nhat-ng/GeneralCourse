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

read_verilog [list rtl/bit_slice.v rtl/sipo.v rtl/piso.v]
current_design bit_slice

link

set DESIGN_NAME [get_object_name [current_design]]
set RESULTS_DIR ./results
set_svf ${DESIGN_NAME}.svf

set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE


source -e -v sdc/bit_coin.sdc
load_upf upf/snps_bit_slice.upf > logs/snps_bit_slice.upf.log
source -e -v scripts/snps_set_voltage.tcl
check_mv_design
extract_physical_constraints def/slice.def
set_isolation -domain PD_SIPO -source TOP.SSL_PISO_SW -sink TOP.SSL_SIPO_SW -clamp_value 1 -isolation_supply_set TOP.SSL ISO_PPP
set_isolation_control -domain PD_SIPO -isolation_sense high -isolation_signal isolation_signals[0] -location self ISO_PPP
COMMAND_RUNTIME compile_ultra -no_autoungroup -scan
change_names -rule verilog -hier
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}.script
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}_compiled.spef
write_sdf ${RESULTS_DIR}/${DESIGN_NAME}_compiled.sdf

#### Running DFT insertion and Incremental Compile ##############
COMMAND_RUNTIME source -e -v scripts/dft_bs.tcl

create_block_abstraction 
write -f ddc -h -o $RESULTS_DIR/${DESIGN_NAME}_bam.ddc
write -f verilog -h -o $RESULTS_DIR/${DESIGN_NAME}_bam.vg
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.test.ddc
save_upf $RESULTS_DIR/${DESIGN_NAME}_bam.upf
check_mv_design -verbose > reports/${DESIGN_NAME}_bam.cmv.rpt
report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.iso.rpt
report_upf_area > reports/${DESIGN_NAME}_bam.area.rpt

STOP_TIMER BIT_SLICE_OPT "Completing BIT_SLICE_OPTIMIZATION"

exit
