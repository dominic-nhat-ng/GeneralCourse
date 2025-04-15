source -e -v scripts/dft_signals.tcl
set test_scan_enable_port_naming_style  "scan_enable%s"
set test_scan_in_port_naming_style "scan_in%s%s"
set test_scan_out_port_naming_style "scan_out%s%s"
set_dft_configuration -scan_compression enable
define_test_mode ScanCompression_mode -usage scan_compression
define_test_mode Internal_scan -usage scan
set_dft_insertion_configuration -preserve_design_name true
set_dft_insertion_configuration -synthesis_optimization none
set_dft_signal -view spec -type TestMode  -port test_mode
set_scan_configuration -clock_mixing no_mix -chain_count 4 -test_mode Internal_scan
set_scan_configuration -clock_mixing no_mix -test_mode ScanCompression_mode
set_scan_compression_configuration -xtolerance high -min_power true -test_mode ScanCompression_mode
set_scan_configuration -voltage_mixing false -power_domain_mixing true -reuse_mv_cells false -test_mode all
set_scan_compression_configuration -chain_count 32 -inputs 4 -outputs 4 -test_mode ScanCompression_mode 
#source scripts/manual_scan_bc.tcl
create_test_protocol
dft_drc -verbose                           > ${REPORTS_DIR}/${DESIGN_NAME}_dft_drc.rpt
report_scan_configuration                  > ${REPORTS_DIR}/${DESIGN_NAME}_scan_conf.rpt
report_dft_insertion_configuration         > ${REPORTS_DIR}/${DESIGN_NAME}_dft_conf.rpt
preview_dft                                > ${REPORTS_DIR}/${DESIGN_NAME}_preview_dft.rpt
preview_dft -show all -test_points all     > ${REPORTS_DIR}/${DESIGN_NAME}_preview_dft_all.rpt
insert_dft
current_test_mode Internal_scan
dft_drc
report_scan_path > ${REPORTS_DIR}/${DESIGN_NAME}_dft.scan_path
check_mv_design -verbose > ${REPORTS_DIR}/${DESIGN_NAME}_post_dft.cmv.rpt
#compile_ultra -incremental -scan -no_autoungroup
#optimize_netlist -area
change_names -rules verilog -hierarchy
write_scan_def -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.scan_def
check_scan_def > ${REPORTS_DIR}/${DESIGN_NAME}_dft.check_scan_def
write_test_model -format ctl -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.ctl
write_test_model -format ddc -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.ctl.ddc
report_dft_signal > ${REPORTS_DIR}/${DESIGN_NAME}_dft_signal.rpt
write -f verilog -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_dft.vg
write -f ddc -hier -o ${RESULTS_DIR}/${DESIGN_NAME}_dft.ddc
save_upf ${RESULTS_DIR}/${DESIGN_NAME}_dft.upf
write_sdc ${RESULTS_DIR}/${DESIGN_NAME}_dft.sdc
write_script -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.script
write_parasitics -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.spef
write_parasitics -script -output ${RESULTS_DIR}/${DESIGN_NAME}_rc_dft.tcl

write_sdf ${RESULTS_DIR}/${DESIGN_NAME}_dft.sdf
report_scan_path > ${REPORTS_DIR}/${DESIGN_NAME}_dft.scan_path
write_test_protocol -test_mode Internal_scan -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.internal_scan.spf
write_test_protocol -test_mode ScanCompression_mode -output ${RESULTS_DIR}/${DESIGN_NAME}_dft.compression.spf
