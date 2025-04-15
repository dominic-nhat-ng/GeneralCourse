# GLOBAL VARIABLES
set DESIGN_TOP bit_top
set REPORTS_DIR ./reports
set ICC_RESULTS_DIR ../pt/signoff_data

set upf_hetero_fanout_isolation true
set enable_local_policy_match true

# REPORTS
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

# SETUP
source ./scripts/synopsys_vcst.setup

# READ NETLIST
read_verilog -netlist ${ICC_RESULTS_DIR}/bit_slice.vc_lp.v.gz
read_verilog -netlist ${ICC_RESULTS_DIR}/bit_top.vc_lp.v.gz
current_design $DESIGN_TOP
link

# LOAD UPF, use report_read to simplify messaging
redirect -file /dev/null {load_upf ${ICC_RESULTS_DIR}/wrap_bit_top.vclp.upf}
report_read

# CHECK/REPORT
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.pg.upf.rpt {check_lp -stage upf}
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.pg.upf.rpt {check_lp -stage design}
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.pg.upf.rpt {check_lp -stage pg}

redirect -file $REPORTS_DIR/report_lp.${DESIGN_TOP}.pg.list.rpt {report_lp -list}

save_session

exit
