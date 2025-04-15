# PrimeTime, PrimeTime PX, PrimeTime ECO Script - bit_coin

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
lappend search_path .
echo $search_path

# REPORTS AND ECO DIRECTORIES
set DESIGN_NAME bit_coin
set PHASE pr_upf
set report_dir reports_${DESIGN_NAME}_${PHASE}
set result_dir results_${DESIGN_NAME}_${PHASE}
if {![file exists $report_dir]} {
  sh mkdir $report_dir
}
if {![file exists $result_dir]} {
  sh mkdir $result_dir
}

# MORE SETUP
set svr_keep_unconnected_nets true
echo $search_path
echo $link_library
set_app_var eco_enable_mim true
set_app_var read_parasitics_load_locations true

# READ AND LINK DESIGN
read_verilog [list signoff_data/bit_slice.v.gz signoff_data/bit_top.v.gz signoff_data/bit_coin.v.gz]
current_design $DESIGN_NAME
link

# DEFINE SCALING LIBRARIES FOR MULTIVOLTAGE
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

# ECO SETUP
set_eco_options -mim_group {bit_secure_0 bit_secure_1 bit_secure_2 bit_secure_3 bit_secure_4 bit_secure_5 bit_secure_6 bit_secure_7 bit_secure_8 bit_secure_9 bit_secure_10 bit_secure_11 bit_secure_12 bit_secure_13 bit_secure_14 bit_secure_15}
set_eco_options -mim_group {bit_secure*/slice_0 bit_secure*/slice_1 bit_secure*/slice_2 bit_secure*/slice_3 bit_secure*/slice_4 bit_secure*/slice_5 bit_secure*/slice_6 bit_secure*/slice_7 bit_secure*/slice_8 bit_secure*/slice_9 bit_secure*/slice_10 bit_secure*/slice_11 bit_secure*/slice_12 bit_secure*/slice_13 bit_secure*/slice_14 bit_secure*/slice_15 bit_secure*/slice_16 bit_secure*/slice_17 bit_secure*/slice_18 bit_secure*/slice_19 bit_secure*/slice_20 bit_secure*/slice_21 bit_secure*/slice_22 bit_secure*/slice_23 bit_secure*/slice_24 bit_secure*/slice_25 bit_secure*/slice_26 bit_secure*/slice_27 bit_secure*/slice_28 bit_secure*/slice_29 bit_secure*/slice_30 bit_secure*/slice_31}

set_eco_options -physical_design_path signoff_data/bit_coin.def.gz

set_eco_options -physical_design_path "signoff_data/bit_coin.def.gz signoff_data/bit_top.def.gz signoff_data/bit_slice.def.gz" -physical_lib_path "./lib/stdcell_hvt/lef/saed32nm_hvt_1p9m.lef ./lib/stdcell_rvt/lef/saed32nm_rvt_1p9m.lef ./lib/stdcell_lvt/lef/saed32nm_lvt_1p9m.lef ./lib/sram/lef/sram.lef signoff_data/bit_top.lef signoff_data/bit_slice.lef" -physical_tech_lib_path ./tech/milkyway/tech.lef

# RESET NETS
set all_nets [get_nets -hier *]
remove_capacitance          $all_nets
remove_resistance           $all_nets
remove_annotated_parasitics $all_nets
remove_annotated_delay -all
remove_annotated_check -all

# LOAD UPF
redirect logs/load_upf_bit_coin.log {load_upf signoff_data/wrap_bit_coin.upf}

# LOAD PARASITICS
read_parasitics signoff_data/bit_slice.maxTLU_125.spef -path bit_secure*/slice*
read_parasitics signoff_data/bit_top.maxTLU_125.spef -path bit_secure*
read_parasitics signoff_data/bit_coin.maxTLU_125.spef

# LOAD SDC
read_sdc signoff_data/bit_coin.sdc

# REMOVE DONT_USE, DONT_TOUCH
set_dont_use [get_lib_cells */*AO*] false
set_dont_touch [get_lib_cells */*AO*] false

# LOAD FSDB
set power_analysis_mode time_based
set_power_analysis_options -waveform_output fsdb
read_vcd -strip_path bitcoin_top/dut ../powerreplay/powrep_replayLog/wi_result.fsdb

# TIMING AND POWER REPORTS
update_timing
update_power
report_power > $report_dir/power_time_based_rtl_vectors.rpt
report_timing -delay max -tran -cap -path full_clock -crosstalk_delta -significant_digits 4 -max_paths 1000 -nosplit > $report_dir/pt_timing.rpt
report_qor -summary > $report_dir/qor.summary.rpt
report_global_timing > $report_dir/global_timing.rpt
report_constraint -all -max_capacitance -max_transition > $report_dir/global_cons.rpt

# ECO
report_eco_options
check_eco

fix_eco_timing -type setup -physical_mode open_site
write_changes -format icc2tcl -output ${result_dir}/pt_setup_eco_file.tcl

fix_eco_timing -type hold -physical_mode open_site -buffer_list [list NBUFFX16_HVT NBUFFX4_HVT NBUFFX2_HVT NBUFFX16_RVT NBUFFX4_RVT NBUFFX2_RVT NBUFFX16_LVT NBUFFX4_LVT NBUFFX2_LVT AOBUFX4_LVT AOINVX4_LVT AOBUFX4_RVT AOBUFX4_HVT AOINVX4_HVT]
write_changes -format icc2tcl -output ${result_dir}/pt_hold_eco_file.tcl

fix_eco_leakage -pattern_priority {HVT RVT LVT} 
write_changes -format icc2tcl -output ${result_dir}/pt_leakage_eco_file.tcl

# SAVE SESSION
save_session pt_sess/${DESIGN_NAME}_${PHASE}_sess

exit
