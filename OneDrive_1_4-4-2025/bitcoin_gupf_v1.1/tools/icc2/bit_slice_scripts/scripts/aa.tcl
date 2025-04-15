set  enable_page_mode false
set sh_enable_page_mode false
define_design_lib -path ./work work



set mv_default_level_shifter_voltage_range_infinity true
set auto_insert_level_shifters_on_clocks all
set auto_insert_level_shifters_on_ideal_networks all
set mv_insert_level_shifters_on_ideal_nets all
set mv_insert_level_shifter_verbose true
set mv_verbose_isolation_insertion true
set mv_verbose_isolation_insertion true
set mv_level_shifter_ignore_ibt true
set mv_no_main_power_violations  false
set mv_allow_ls_on_leaf_pin_boundary true



open_mw_lib $mw_design_library

set upf_charz_allow_port_punch true
set_message_info -id VER-130 -limit 1


read_ddc [glob $results/*_ilm.ddc]
read_ddc $results/top_gtech.ddc

current_design $DESIGN_NAME

set_tlu_plus_files  -max_tluplus  $TLUPLUS_MAX_FILE   -tech2itf_map    $MAP_FILE

#set_svf top.svf

set uniquify_naming_style "[current_design_name]_%s_%d"

uniquify

set compile_preserve_subdesign_interfaces true
set_operating_conditions  -max tt0p85v125c

propagate_constraints -power

source -e -v ./sdc/top.sdc


if ($upf_2) {
set_voltage -object_list "c5_VDD_SW c3_VDD_SW c1_VDD_SW" 0.78
set_voltage -object_list "top_VDD_SW VDD TOP.primary.power" 0.85
set_voltage -object_list "VSS TOP.primary.ground" 0.0
} else {
set_voltage -object_list "c5/c5_VDD_SW c3/c3_VDD_SW c1/c1_VDD_SW VDD" 1.08
set_voltage -object_list VSS 0.0
}




#set_fix_multiple_port_nets -all -buffer_constants


#### Formal Verification will be easy ###############
#set_register_merging [all_registers ] false

#name_format  -isolation_prefix "UPF_ISO_top_"  -level_shift_prefix "UPF_LS_top_" -isolation_suffix "" -level_shift_suffix ""



#set_isolation -domain TOP -elements "power_good test_so1" -no_isolation top_no_iso

compile_ultra  -scan -no_seq -no_autoungroup -no_boundary_optimization
