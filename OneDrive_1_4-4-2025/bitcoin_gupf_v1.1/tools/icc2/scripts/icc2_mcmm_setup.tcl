source -e -v scripts/read_para_setup.tcl
remove_mode -all
remove_scenario -all
remove_corner -all
set design_lib_name [current_lib]
create_corner FUNC_0.78V_SETUP
create_mode FUNC_078
create_scenario -mode FUNC_078 -corner FUNC_0.78V_SETUP -name FUNC_0.78V_SETUP
set_scenario_status -none -setup true -max_transition true -max_capacitance true -dynamic true -leakage true -active true FUNC_0.78V_SETUP
set_process_number 1.00
set_voltage 0.78
set_temperature 125
set_parasitics_parameters -corner FUNC_0.78V_SETUP -library ${DESIGN_NAME}.nlib -early_spec maxTLU -late_spec minTLU
current_scenario FUNC_0.78V_SETUP
read_sdc outputs2icc2/bit_coin.sdc
set_operating_conditions tt0p78v125c -library saed32hvt_tt0p78v125c
set_voltage -object_list VDDL 0.78
set_voltage -object_list {VDDH VDDM} 0.85
set_voltage -object_list VSS 0.0

create_corner FUNC_0.85V_SETUP
create_mode FUNC_085
create_scenario -mode FUNC_085 -corner FUNC_0.85V_SETUP -name FUNC_0.85V_SETUP
set_scenario_status -none -setup true -max_transition true -max_capacitance true -dynamic true -active true FUNC_0.85V_SETUP
set_process_number 1.00
set_voltage 0.85
set_temperature 125
set_parasitics_parameters -corner FUNC_0.85V_SETUP -library ${DESIGN_NAME}.nlib -early_spec maxTLU -late_spec minTLU
current_scenario FUNC_0.85V_SETUP
read_sdc outputs2icc2/bit_coin.sdc
set_operating_conditions tt0p85v125c -library saed32hvt_tt0p85v125c
set_voltage -object_list VDDL 0.78
set_voltage -object_list {VDDH VDDM} 0.85
set_voltage -object_list VSS 0.0

create_corner FUNC_0.85V_HOLD
create_mode FUNC_085_HOLD
create_scenario -mode FUNC_085_HOLD -corner FUNC_0.85V_HOLD -name FUNC_0.85V_HOLD
set_scenario_status -none -setup false -hold true -max_transition true -max_capacitance true -active true FUNC_0.85V_HOLD
set_process_number 1.00
set_voltage 0.85
set_temperature 125
set_parasitics_parameters -corner FUNC_0.85V_HOLD -library ${DESIGN_NAME}.nlib -early_spec maxTLU -late_spec minTLU
current_scenario FUNC_0.85V_HOLD
read_sdc outputs2icc2/bit_coin.sdc
set_operating_conditions ff0p85v125c -library saed32hvt_ff0p85v125c
set_voltage -object_list VDDL 0.78
set_voltage -object_list {VDDH VDDM} 0.85
set_voltage -object_list VSS 0.0



current_scenario FUNC_0.78V_SETUP
set_voltage -object_list {VDDL piso_sw_out sipo_sw_out} 0.78
set_voltage -object_list {VDDH VDDM} 0.85
set_voltage -object_list VSS 0.0
current_scenario FUNC_0.85V_SETUP
set_voltage -object_list {VDDL piso_sw_out sipo_sw_out} 0.78
set_voltage -object_list {VDDH VDDM} 0.85
set_voltage -object_list VSS 0.0
