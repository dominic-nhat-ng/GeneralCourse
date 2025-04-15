# GLOBAL VARIABLES
set DESIGN_TOP bit_coin
set REPORTS_DIR ./reports

set verification_failing_point_limit 0
set synopsys_auto_setup true
# Variable to get around ERROR for parallel VDUMMY
# set upf_warn_on_failed_parallel_resolved_check true

# TRY VERIFY ALL STATES
set verification_force_upf_supplies_on false

# set upf_use_additional_db_attributes false

# FM_UPF-124 
set upf_warn_on_failed_port_attribute_check true

set upf_allow_supply_port_reconnection true
set mv_allow_supply_port_reconnection true

# CREATE REPORTS DIR
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

# SETUP FILE
source ./scripts/synopsys_fm.setup

# LIBRARIES
read_db -tech $link_library

# FM RETENTION REGISTER MODELS
lappend search_path ../../verification
remove_design -shared r:/*/R*DFF*
remove_design -shared i:/*/R*DFF*

# READ REFERENCE (RTL)
read_verilog -r -tech -libname TECH_RET_IMP [list ../../verification/FM/FM_TECH_RET_MODELS.v]
read_verilog -r ../icc2/outputs2icc2/bit_slice.vg
read_verilog -r ../icc2/outputs2icc2/bit_top.vg
read_verilog -r ../icc2/outputs2icc2/${DESIGN_TOP}.vg

set_top r:/WORK/${DESIGN_TOP}
load_upf ../icc2/outputs2icc2/wrap_${DESIGN_TOP}.upf

# READ IMPLEMENTATION (DC GATES)
read_verilog -i -tech -libname TECH_RET_IMP [list ../../verification/FM/FM_TECH_RET_MODELS.v]
read_verilog -i  ../pt/signoff_data/bit_slice.fm.v.gz
read_verilog -i  ../pt/signoff_data/bit_top.fm.v.gz
read_verilog -i  ../pt/signoff_data/bit_coin.fm.v.gz

set_top i:/WORK/${DESIGN_TOP}

# CONSTANTS TO DISABLE DFT
set_constant $impl/scan_enable 0
set_constant $ref/scan_enable 0

# MATCH/VERIFY/REPORT
match
verify

redirect -file ${REPORTS_DIR}/${DESIGN_TOP}.fm.gate2pg.rpt {report_status}

exit
