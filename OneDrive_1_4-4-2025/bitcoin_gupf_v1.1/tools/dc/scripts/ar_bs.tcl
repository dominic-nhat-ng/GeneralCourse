set_app_options -name rail.pr_shell_path -value  /remote/sweifs/PE/products/pr/main/image/nightly/pr_develop/M-2016.12/latest/Testing/linux64/syn/bin

set_app_options -name rail.enable_advanced_features -value true

set_attribute [get_lib_cell */*HEAD*] on_state_resistance 12.0

create_taps -top_pg
report_taps

analyze_rail  \
        -nets {VDDL VDDH piso_sw_out sipo_sw_out VSS} \
        -voltage_drop static \
        -db_link scripts/ptpx_links.tcl

set effr_list [get_cells -hie * -f "is_isolation == true || is_retention == true || is_power_switch == true || ref_name =~ *AOBUF* || ref_name =~ *AOINV*"]

calculate_effective_resistance -cells $effr_list  -nets {VDDL VDDH piso_sw_out sipo_sw_out VSS}


open_rail_result RAIL_RESULT_1
sh rm gat.tcl

set path_root                   /global/gtsna_benchmark3/gmaben/LP_TRAINING_NEW_DESIGN/taps_scripts_1606
set annotate_taps_path          $path_root/annotate_taps
set check_taps_path             $path_root/check_taps
set write_taps_path             $path_root/write_taps

set annotate_taps_scr           annotate_taps.icc2.1606.tcl
set check_taps_scr              check_taps.icc2.1606.tcl
set write_taps_scr              write_taps.icc2.1606.tcl

source $annotate_taps_path/$annotate_taps_scr
source $check_taps_path/$check_taps_scr
source $write_taps_path/$write_taps_scr

gui_annotate_taps -file_name gat.tcl
start_gui
source ./gat.tcl



