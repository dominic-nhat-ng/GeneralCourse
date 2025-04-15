# PrimeTime and PrimeTime PX Script - bit_slice

# GLOBAL VARIABLES AND SETUP
set power_enable_analysis TRUE
source rm_setup/dc_setup.tcl
set sh_continue_on_error true
source -e -v scripts/pt_setup.tcl
suppress_message UITE-130
suppress_message PARA-007
set wd [pwd]

# SEARCH_PATH
lappend search_path bc_outputs_icc2
lappend search_path bt_outputs_icc2
lappend search_path bs_outputs_icc2
lappend search_path results
lappend search_path .
echo $search_path

# MORE SETUP
set DESIGN_NAME bit_slice
set svr_keep_unconnected_nets true
echo $search_path
echo $link_library
set_app_var eco_enable_mim true
set_app_var read_parasitics_load_locations true

set_app_var enable_golden_upf true

# READ AND LINK DESIGN
read_verilog [list ../icc2/bit_slice/outputs_icc2/chip_finish.v.gz]
current_design $DESIGN_NAME
link

# SCALING LIBRARIES FOR MULTIVOLTAGE
define_scaling_lib_group {saed32hvt_tt0p78v125c.db saed32hvt_tt0p85v125c.db saed32hvt_tt1p05v125c.db}
define_scaling_lib_group {saed32hvt_ulvl_tt0p78v125c_i0p78v.db saed32hvt_ulvl_tt0p85v125c_i0p85v.db saed32hvt_ulvl_tt1p05v125c_i0p78v.db }
define_scaling_lib_group {saed32hvt_dlvl_tt0p78v125c_i0p78v.db saed32hvt_dlvl_tt0p85v125c_i0p85v.db }
define_scaling_lib_group {saed32hvt_pg_tt0p78v125c.db saed32hvt_pg_tt0p85v125c.db saed32hvt_pg_tt1p05v125c.db}

define_scaling_lib_group {saed32rvt_tt0p78v125c.db saed32rvt_tt0p85v125c.db saed32rvt_tt1p05v125c.db}
define_scaling_lib_group {saed32rvt_ulvl_tt0p78v125c_i0p78v.db saed32rvt_ulvl_tt0p85v125c_i0p85v.db saed32rvt_ulvl_tt1p05v125c_i0p78v.db}
define_scaling_lib_group {saed32rvt_dlvl_tt0p78v125c_i0p78v.db saed32rvt_dlvl_tt0p85v125c_i0p85v.db}
define_scaling_lib_group {saed32rvt_pg_tt0p78v125c.db saed32rvt_pg_tt0p85v125c.db saed32rvt_pg_tt1p05v125c.db}

define_scaling_lib_group {saed32lvt_tt0p78v125c.db saed32lvt_tt0p85v125c.db saed32lvt_tt1p05v125c.db}
define_scaling_lib_group {saed32lvt_ulvl_tt0p78v125c_i0p78v.db saed32lvt_ulvl_tt0p85v125c_i0p85v.db saed32lvt_ulvl_tt1p05v125c_i0p78v.db }
define_scaling_lib_group {saed32lvt_dlvl_tt0p78v125c_i0p78v.db saed32lvt_dlvl_tt0p85v125c_i0p85v.db }
define_scaling_lib_group {saed32lvt_pg_tt0p78v125c.db saed32lvt_pg_tt0p85v125c.db saed32lvt_pg_tt1p05v125c.db}

define_scaling_lib_group {sram2rw16x4_tt1p78v125c.db sram2rw16x4_tt1p85v125c.db}

set power_enable_multi_rail_analysis true

# RESET NETS
set all_nets [get_nets -hier *]
remove_capacitance          $all_nets
remove_resistance           $all_nets
remove_annotated_parasitics $all_nets
remove_annotated_delay -all
remove_annotated_check -all

# LOAD UPF
#nsgk load_upf ../icc2/bit_slice/outputs_icc2/chip_finish.v.SNPS.upf
#load_upf ../../upf/comb_for_pp.upf -supplemental ../icc2/bit_slice/outputs_icc2/chip_finish.sup.upf
load_upf ../../upf/comb.upf -supplemental ../icc2/bit_slice/outputs_icc2/chip_finish.sup.upf


# LOAD PARASITICS
read_parasitics ../icc2/bit_slice/outputs_icc2/chip_finish.maxTLU_125.spef

# LOAD SDC
read_sdc ../icc2/bit_slice/outputs_icc2/chip_finish.sdc

# LOAD FSDB
#read_vcd -strip_path bitslice_top/dut ../verdi_paa/whatIf_bit_slice_gate_upf/wi_result.fsdb
read_vcd -strip_path bitslice_top/dut  ../vcs_nlp/outputsfromvcs/bit_slice_PG_NOUPF.fsdb


# REMOVE DONT_USE, DONT_TOUCH
set_dont_use [get_lib_cells */*AO*] false
set_dont_touch [get_lib_cells */*AO*] false

# TIMING AND POWER REPORTS
update_timing
update_power
set report_dir $wd/reports_bit_slice
if {![file exists $report_dir]} {
  sh mkdir $report_dir
}

report_power > $report_dir/${DESIGN_NAME}_power_average.rpt
report_timing -delay max -tran -cap -path full_clock -crosstalk_delta -significant_digits 4 -max_paths 1000 -nosplit > $report_dir/${DESIGN_NAME}_timing.rpt
report_qor -summary > $report_dir/${DESIGN_NAME}_qor.summary.rpt
report_global_timing > $report_dir/${DESIGN_NAME}_global_timing.rpt
report_constraint -all -max_capacitance -max_transition > $report_dir/${DESIGN_NAME}_global_cons.rpt

exit
