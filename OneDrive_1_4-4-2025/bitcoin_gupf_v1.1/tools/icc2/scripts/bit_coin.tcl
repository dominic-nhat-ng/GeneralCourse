source scripts/dc_variables.tcl
source scripts/procs.tcl

START_TIMER BIT_COIN_OPT "Starting BIT_COIN_OPTIMIZATION"


suppress_message TFCHK-014
suppress_message TLUP-005
suppress_message PSYN-025
suppress_message PWR-536
suppress_message PSYN-058
suppress_message OPT-1209

set DESIGN_NAME bit_coin

source -e -v rm_setup/dc_setup.tcl
set_top_implementation_options -block_references "bit_top bit_slice"
read_ddc bit_top/$RESULTS_DIR/bit_top_bam.ddc
read_ddc bit_slice/$RESULTS_DIR/bit_slice_bam.ddc
read_verilog [list rtl/bit_coin.v rtl/secure_data.v  rtl/sipo.v rtl/piso.v]
current_design bit_coin
link

set DESIGN_NAME [get_object_name [current_design]]
set RESULTS_DIR ./results
set_svf ${DESIGN_NAME}.svf
source -e -v sdc/bit_coin.sdc
report_top_implementation_options
load_upf upf/snps_bit_coin.upf > logs/snps_bit_coin.upf.log
source -e -v scripts/snps_set_voltage.tcl
COMMAND_RUNTIME propagate_constraints -power_supply_data
check_mv_design
set_boundary_optimization [get_cells * -hierarchical -filter "ref_name=~bit_slice"] false
set_boundary_optimization [get_cells * -hierarchical -filter "ref_name=~bit_top"] false
set_ungroup [get_cells * -hierarchical -filter "ref_name=~bit_slice"] false
set_ungroup [get_cells * -hierarchical -filter "ref_name=~bit_top"] false
set_dont_touch [get_cells * -hierarchical -filter "ref_name=~bit_slice"]
set_dont_touch [get_cells * -hierarchical -filter "ref_name=~bit_top"]
set_dont_touch_network [get_ports "data_valid retent* shut_down*"]
set_dont_touch [get_ports "data_valid retent* shut_down*"]
write -f verilog -hier -o $RESULTS_DIR/${DESIGN_NAME}_pre_compile.vg
write -f ddc -hier -o $RESULTS_DIR/${DESIGN_NAME}_pre_compile.ddc
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
COMMAND_RUNTIME source -e -v scripts/dft_bc.tcl

report_power_domain
check_mv_design
check_mv_design -verbose > reports/${DESIGN_NAME}_bam.cmv.rpt
report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.iso.rpt
report_upf_area >  reports/${DESIGN_NAME}_bam.area.rpt
set MSG720 [get_message_info -occurrences UPF-720]
set MSG722 [get_message_info -occurrences UPF-722]
source scripts/generate_wrapper.tcl
STOP_TIMER BIT_COIN_OPT "Completing BIT_COIN_OPTIMIZATION"
exit
