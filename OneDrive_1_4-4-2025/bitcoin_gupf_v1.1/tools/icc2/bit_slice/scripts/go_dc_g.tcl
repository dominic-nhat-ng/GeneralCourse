set DESIGN_TOP bit_top
set OUTPUTS_DIR ./outputs/dc
set REPORTS_DIR ./reports/dc

if !{[file exists $OUTPUTS_DIR]} {
  sh mkdir -p $OUTPUTS_DIR
}
if !{[file exists $REPORTS_DIR]} {
  sh mkdir -p $REPORTS_DIR
}

source ./.tony_bit_coin/scripts/synopsys_dc.setup

set_svf ${OUTPUTS_DIR}/$DESIGN_TOP.svf

analyze -f verilog -vcs "-f ./rtl/files_${DESIGN_TOP}.f"
elaborate $DESIGN_TOP
link

set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_no_main_power_violations  false
set mv_allow_ls_on_leaf_pin_boundary true
set compile_automatic_clock_phase_inference none

remove_attribute [get_lib_cells */*ISO*] dont_use
remove_attribute [get_lib_cells */*ISO*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_touch
remove_attribute [get_lib_cells */*HEAD*] dont_use
remove_attribute [get_lib_cells */*LS*] dont_touch
remove_attribute [get_lib_cells */*LS*] dont_use
remove_attribute [get_lib_cells */*AO*] dont_touch
remove_attribute [get_lib_cells */*AO*] dont_use

load_upf ./upf_3.0/${DESIGN_TOP}.upf



set_voltage 0.85 -object_list {SS.power}
set_voltage 0.0  -object_list {SS.ground}
set_voltage 0.78 -object_list {SSL.power}
set_voltage 0.0  -object_list {SSL.ground}
set_voltage 0.78 -object_list {SS_PD_1_SW.power}
set_voltage 0.78 -object_list {SS_PD_2_SW.power}

source -e -v ./scripts/set_voltage.tcl

set_operating_conditions tt0p85v125c

check_mv_design

compile_ultra

check_mv_design -verbose > ${REPORTS_DIR}/check_mv_design_${DESIGN_TOP}.rpt
change_names -hier -rule verilog
write -hier -f verilog -o ${OUTPUTS_DIR}/${DESIGN_TOP}.vg
write -hier -f verilog -pg -o ${OUTPUTS_DIR}/${DESIGN_TOP}_pg.vg
save_upf ${OUTPUTS_DIR}/${DESIGN_TOP}_dc.upf

