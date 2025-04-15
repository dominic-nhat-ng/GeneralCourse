# GLOBAL VARIABLES
set DESIGN_TOP bit_coin
set REPORTS_DIR ./reports
set ICC_RESULTS_DIR ../pt/signoff_data

# VAR
set_app_var upf_hetero_fanout_isolation true
set_app_var enable_local_policy_match true

# PDOI issue, need this variable (Fixed in bitcoin_v1.1)
set_app_var allow_upf_lrm_extension true

# REPORTS
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

# SETUP
source ./scripts/synopsys_vcst.setup

# READ NETLIST
read_verilog -netlist ${ICC_RESULTS_DIR}/bit_slice.vclp.v.gz
read_verilog -netlist ${ICC_RESULTS_DIR}/bit_top.vclp.v.gz
read_verilog -netlist ${ICC_RESULTS_DIR}/bit_coin.vclp.v.gz
current_design $DESIGN_TOP
link

# LOAD UPF, use report_read to simplify messaging
redirect -file /dev/null {load_upf ${ICC_RESULTS_DIR}/wrap_bit_coin.vclp.upf}
report_read

# WAIVERS
source ./scripts/waivers_rtl.tcl

# CHECK/REPORT
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.upf.rpt {check_lp -stage upf}
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.design.rpt {check_lp -stage design}
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.pg.rpt {check_lp -stage pg}

redirect -file $REPORTS_DIR/report_lp.${DESIGN_TOP}.pg.list.rpt {report_lp -list}

save_session

exit
