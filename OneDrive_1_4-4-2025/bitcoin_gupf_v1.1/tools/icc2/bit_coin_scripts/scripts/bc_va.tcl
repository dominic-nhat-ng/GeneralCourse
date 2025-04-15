#create_voltage_area -power_domain PD_PISO_SECURE -region { {2670 871} {3070 889} } -is_fixed
remove_voltage_areas -all
create_voltage_area -power_domain PD_PISO_SECURE -region {{1985.5680 1208.6960} {5069.9520 1385.9280}}
#create_voltage_area -power_domain PD_PISO_SECURE -region {{1985.5680 1207.0240} {5069.9520 1385.9280}}
#create_voltage_area -power_domain PD_PISO_SECURE -region { {2470 873} {3270 887} } 
#set_attribute [get_voltage_areas PD_PISO_SECURE] physical_status locked
