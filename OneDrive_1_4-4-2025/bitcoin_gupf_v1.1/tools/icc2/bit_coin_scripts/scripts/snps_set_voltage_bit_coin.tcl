set_operating_conditions tt0p85v125c

set_voltage 0.85 -object_list [get_supply_nets -hierarchical -filter "name =~ *SS.power"]
set_voltage 0.78 -object_list [get_supply_nets -hierarchical -filter "name =~ *SSL*power"]
set_voltage 0.0 -object_list [get_supply_nets -hierarchical -filter "name =~ *ground*"]
