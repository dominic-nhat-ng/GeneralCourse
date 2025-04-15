# GLOBAL VARIABLES
set DESIGN_TOP bit_slice
set REPORTS_DIR ./reports

set verification_failing_point_limit 0
set synopsys_auto_setup true
#kk set_svf ../dc/results_bit_slice
set_svf ../dc/results_bit_slice_quick

# TRY VERIFY ALL STATES
# set verification_force_upf_supplies_on false

# SET THIS VAR
# set verification_verify_unread_tech_cell_pins false

# REPORTS
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

# SETUP
source ./scripts/synopsys_fm.setup

# LIBRARIES
read_db -tech $link_library

# FM RETENTION REGISTER MODELS
lappend search_path ../../verification/FM
remove_design -shared i:/*/R*DFF*

# READ REFERENCE (RTL)
read_verilog -r -f ../../rtl/files_${DESIGN_TOP}.f
set_top r:/WORK/${DESIGN_TOP}
load_upf ../../upf/snps_${DESIGN_TOP}.upf

# READ IMPLEMENTATION (PG Gates)
read_verilog -i -tech -libname TECH_RET_IMP [list ../../verification/FM/FM_TECH_RET_MODELS.v]
read_verilog -i  ../icc2/bit_slice/outputs_icc2/chip_finish.fm.v.gz
set_top i:/WORK/${DESIGN_TOP}

# CONSTANTS, DONT_VERIFY
set_constant $impl/scan_enable 0

set_dont_verify_point $ref/VDDM

# MATCH/VERIFY/REPORT/SESSION
match

verify
save_session -replace ./fm_sess/fm_sess_${DESIGN_TOP}_rtl2pg.fss

redirect -file ${REPORTS_DIR}/${DESIGN_TOP}.fm.rtl2pg.rpt {report_status}

exit
