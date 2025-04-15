# GLOBAL VARIABLES
set DESIGN_TOP bit_slice
set REPORTS_DIR ./reports

# REPORTS
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

# SETUP
source ./scripts/synopsys_vcst.setup

# HETEROGENEOUS FANOUT
set upf_hetero_fanout_isolation true

# READ RTL
analyze -f verilog -vcs "-f ../../rtl/files_${DESIGN_TOP}.f"
elaborate ${DESIGN_TOP}

# LOAD UPF, use report_read to simplify messaging
redirect -file /dev/null {load_upf ../../upf/snps_${DESIGN_TOP}.upf}
report_read

# CHECK/REPORT
redirect -file $REPORTS_DIR/check_lp.${DESIGN_TOP}.upf.rpt {check_lp -stage upf}

redirect -file $REPORTS_DIR/report_lp.${DESIGN_TOP}.list.rpt {report_lp -list}

save_session

exit
