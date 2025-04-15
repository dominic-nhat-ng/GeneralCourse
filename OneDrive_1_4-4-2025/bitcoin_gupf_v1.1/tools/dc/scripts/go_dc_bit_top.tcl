source scripts/dc_variables.tcl
source scripts/procs.tcl
START_TIMER BIT_TOP_OPT "Starting BIT_TOP_OPTIMIZATION"

suppress_message TFCHK-014
suppress_message TLUP-005
suppress_message PSYN-025
suppress_message PWR-536
suppress_message PSYN-058
suppress_message OPT-1209

define_design_lib -path ./work work
set DESIGN_NAME bit_top
saif_map -start

source -e -v rm_setup/dc_setup.tcl
set_top_implementation_options -block_references "bit_slice"
read_ddc results_bit_slice/bit_slice_bam.ddc
read_sverilog [list ../../rtl/reset_sync.v ../../rtl/sync.v ../../rtl/sync_wrapper.v ../../rtl/bit_top.v ../../rtl/sipo.v ../../rtl/piso.v]
current_design bit_top
link

set DESIGN_NAME [get_object_name [current_design]]
set RESULTS_DIR ./results_bit_top
set_svf ${RESULTS_DIR}/${DESIGN_NAME}.svf
source -e -v ../../sdc/bit_top.sdc
report_top_implementation_options
COMMAND_RUNTIME propagate_constraints -power_supply_data -verbose

load_upf ../../upf/snps_bit_top.upf > logs/snps_bit_top.upf.log
source -e -v scripts/snps_set_voltage.tcl
read_saif -instance_name bitcoin_top/dut/bit_secure_0 -input ../vcs_nlp/outputsfromvcs/RTL_UPF.saif -auto_map_names

extract_physical_constraints ../../def/bt.def
source -e -v ../../def/bt_va.tcl
check_mv_design
#set_boundary_optimization [get_cells * -hierarchical -filter "ref_name=~bit_slice"] false
#set_ungroup [get_cells * -hierarchical -filter "ref_name=~bit_slice"] false
#set_dont_touch [get_cells * -hierarchical -filter "ref_name=~bit_slice"]

set_dont_touch_network [get_ports "data_valid retent* shut_down*"]
set_dont_touch [get_ports "data_valid retent* shut_down*"]
#set_dont_touch [get_nets "isolation*"]
set_ideal_network -no_propagate [get_nets *isolation*]
set_leakage_optimization true
set_dynamic_optimization true
COMMAND_RUNTIME compile_ultra -no_autoungroup -scan
change_names -rule verilog -hier
write -f verilog -hier -o $RESULTS_DIR/${DESIGN_NAME}_compiled.vg
write -f ddc -hier -o $RESULTS_DIR/${DESIGN_NAME}_compiled.ddc
save_upf $RESULTS_DIR/${DESIGN_NAME}_compiled.upf
write_sdc $RESULTS_DIR/${DESIGN_NAME}_compiled.sdc
write_script -output $RESULTS_DIR/${DESIGN_NAME}_compiled.script
write_parasitics -output $RESULTS_DIR/${DESIGN_NAME}_compiled.spef

set enable_slew_degradation false
set disable_library_transition_degradation true
set write_sdc_output_lumped_net_capacitance false
set write_sdc_output_net_resistance false
write_parasitics -script -output ${RESULTS_DIR}/${DESIGN_NAME}_rc_compiled.tcl

write_sdf $RESULTS_DIR/${DESIGN_NAME}_compiled.sdf


#### Running DFT insertion and Incremental Compile ##############
COMMAND_RUNTIME source -e -v scripts/dft_bt.tcl

######### WA to get LS inserted Properly ##########
#set_port_attributes -ports isolation_signals -driver_supply SSL
#set_dont_touch [get_nets *isolation_sign*] false
#check_mv_design -verbose
#insert_mv_cells -verbose
check_mv_design -verbose
remove_ideal_network [get_nets *isolation*]

compile_ultra -incremental -scan
check_mv_design
change_names -rule verilog -hier
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}.ddc
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}.check_scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}.ctl.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}.script
extract_rc -estimate
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}.spef
write_parasitics -script -output ${RESULTS_DIR}/${DESIGN_NAME}_rc.tcl

write_sdf ${RESULTS_DIR}/${DESIGN_NAME}.sdf

######################

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
report_retention_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.ret.rpt
report_level_shifter -domain [get_power_domains -hier] > reports/${DESIGN_NAME}_bam.ls.rpt
report_upf_area >  reports/${DESIGN_NAME}_bam.area.rpt

report_isolation_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.iso.rpt
report_retention_cell -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.ret.rpt
report_level_shifter -domain [get_power_domains -hier] > reports/${DESIGN_NAME}.ls.rpt
report_upf_area > reports/${DESIGN_NAME}.area.rpt
report_qor -summary > ${REPORTS_DIR}/${DESIGN_NAME}.qor.rpt
report_timing -transition_time -capacitance  -physical -attributes > ${REPORTS_DIR}/${DESIGN_NAME}.tim.rpt
report_power > ${REPORTS_DIR}/${DESIGN_NAME}.power.rpt
check_mv_design -verbose > ${REPORTS_DIR}/${DESIGN_NAME}.cmv.rpt
saif_map -type ptpx -write_map ${RESULTS_DIR}/${DESIGN_NAME}.name_map
saif_map -end

set MSG720 [get_message_info -occurrences UPF-720]
set MSG722 [get_message_info -occurrences UPF-722]

STOP_TIMER BIT_TOP_OPT "Completing BIT_TOP_OPTIMIZATION"

exit
