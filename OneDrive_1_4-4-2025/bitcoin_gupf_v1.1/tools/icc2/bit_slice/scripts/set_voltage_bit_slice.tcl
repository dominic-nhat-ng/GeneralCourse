set_operating_conditions tt0p85v125c
set_voltage -object_list  SS.power 0.85
set_voltage -object_list  SSL.power 0.78
set_voltage -object_list SS.ground 0.0
set_voltage -object_list SSL_SIPO_SW.power 0.78
set_voltage -object_list SSL_PISO_SW.power 0.78
check_mv_design
associate_supply_set SS -handle TOP.primary
