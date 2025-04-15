 source -echo -verbose ./rm_setup/dc_setup.tcl


set DCRM_FINAL_VERILOG_OUTPUT_FILE ./SYN_TOP_WRAPPER_HIER_IMPLEMENTATION/SYN_TOP_WRAPPER/results/$DESIGN_NAME.output.pg.v
set DCRM_MV_FINAL_UPF_OUTPUT_FILE ./SYN_TOP_WRAPPER_HIER_IMPLEMENTATION/SYN_TOP_WRAPPER/results/$DESIGN_NAME.output.upf

 read_file $DCRM_FINAL_VERILOG_OUTPUT_FILE -top SYN_TOP_WRAPPER -netlist
 load_upf $DCRM_MV_FINAL_UPF_OUTPUT_FILE
 compress_lp -enable_all
 check_upf
 check_design
 check_pg
report_lp -verbose -file reports/report_lp_uncompress.log
compress_lp -enable_all
report_lp -verbose -file reports/report_lp_compress.log
