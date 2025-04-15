# GLOBAL VARIABLES
set DESIGN_TOP bit_coin
set REPORTS_DIR ./reports

set upf_hetero_fanout_isolation true
set enable_local_policy_match true
set_app_var enable_iso_nor true

# REPORTS
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

# SETUP
source ./scripts/synopsys_vcst.setup

# READ NETLISTS
read_verilog -netlist ../icc2/outputs2icc2/bit_slice.vg 
read_verilog -netlist ../icc2/outputs2icc2/bit_top.vg 
read_verilog -netlist ../icc2/outputs2icc2/bit_coin.vg 
current_design $DESIGN_TOP
link

# LOAD UPF, use report_read to simplify messaging
redirect -file /dev/null {load_upf ../icc2/outputs2icc2/wrap_${DESIGN_TOP}.upf}
report_read

# WAIVERS
source ./scripts/waivers_rtl.tcl
source ./scripts/waivers_gate.tcl

# CHECK/REPORT
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.gate.upf.rpt {check_lp -stage upf}
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.gate.upf.rpt {check_lp -stage design}

redirect -file $REPORTS_DIR/report_lp.${DESIGN_TOP}.gate.list.rpt {report_lp -list}

save_session

exit
