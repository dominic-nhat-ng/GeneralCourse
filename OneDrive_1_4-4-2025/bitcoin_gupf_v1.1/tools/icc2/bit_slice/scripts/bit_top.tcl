source scripts/dc_variables.tcl
source scripts/procs.tcl
START_TIMER BIT_TOP_OPT "Starting BIT_TOP_OPTIMIZATION"

suppress_message TFCHK-014
suppress_message TLUP-005
suppress_message PSYN-025
suppress_message PWR-536
suppress_message PSYN-058
suppress_message OPT-1209

set DESIGN_NAME bit_top

source -e -v rm_setup/dc_setup.tcl
set_top_implementation_options -block_references "bit_slice"
read_ddc ../bit_slice/results/bit_slice_bam.ddc
read_verilog [list rtl/bit_top.v rtl/sipo.v rtl/piso.v]
current_design bit_top
link

set DESIGN_NAME [get_object_name [current_design]]
set RESULTS_DIR ./results
set_svf ${DESIGN_NAME}.svf
source -e -v sdc/bit_coin.sdc
report_top_implementation_options
load_upf upf/snps_bit_top.upf > logs/snps_bit_top.upf.log
source -e -v scripts/snps_set_voltage.tcl

COMMAND_RUNTIME propagate_constraints -power_supply_data -verbose
extract_physical_constraints def/bit_top.def
check_mv_design
set_boundary_optimization [get_cells * -hierarchical -filter "ref_name=~bit_slice"] false
set_ungroup [get_cells * -hierarchical -filter "ref_name=~bit_slice"] false
set_dont_touch [get_cells * -hierarchical -filter "ref_name=~bit_slice"]
set_dont_touch_network [get_ports "data_valid retent* shut_down*"]
set_dont_touch [get_ports "data_valid retent* shut_down*"]
COMMAND_RUNTIME compile_ultra -no_autoungroup -scan
change_names -rule verilog -hier
write -f verilog -hier -o $RESULTS_DIR/${DESIGN_NAME}.vg
write -f ddc -hier -o $RESULTS_DIR/${DESIGN_NAME}.ddc
save_upf $RESULTS_DIR/${DESIGN_NAME}.upf
write_sdc $RESULTS_DIR/${DESIGN_NAME}.sdc
write_script -output $RESULTS_DIR/${DESIGN_NAME}.script
write_parasitics -output $RESULTS_DIR/${DESIGN_NAME}_compiled.spef
write_sdf $RESULTS_DIR/${DESIGN_NAME}_compiled.sdf

#### Running DFT insertion and Incremental Compile ##############
COMMAND_RUNTIME source -e -v scripts/dft_bt.tcl

COMMAND_RUNTIME create_block_abstraction
write -f ddc -h -o $RESULTS_DIR/${DESIGN_NAME}_bam.ddc
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}_bam.ctl.ddc
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.script
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.spef
write_sdf ${RESULTS_DIR}/${DESIGN_NAME}_dft_bam.sdf
report_block_abstraction
check_block_abstraction
report_power_domain
check_mv_design
check_mv_design -verbose > reports/${DESIGN_NAME}_bam.cmv.rpt
report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.iso.rpt
report_upf_area >  reports/${DESIGN_NAME}_bam.area.rpt

set MSG720 [get_message_info -occurrences UPF-720]
set MSG722 [get_message_info -occurrences UPF-722]

STOP_TIMER BIT_TOP_OPT "Completing BIT_TOP_OPTIMIZATION"

exit
