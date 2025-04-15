connect_pg_net
place_pins -ports [get_ports *]
get_shapes -of_objects [get_nets VDDL]
create_power_switch_array -power_switch PD2_SW -voltage_area PD_PISO -x_pitch 180 -y_pitch 1.6  -pg_straps [get_shapes -of_objects [get_nets VDDL]]
create_power_switch_array -power_switch PD1_SW -voltage_area PD_SIPO -x_pitch 180 -y_pitch 1.6  -pg_straps [get_shapes -of_objects [get_nets VDDL]]

connect_power_switch -source piso_bit/shut_down_signals \
-ack_out PG_ack_signals[1] \
-ring_direction clockwise \
-mode daisy \
-port_name PG_ack_signals[1] \
-voltage_area PD_PISO \
-ack_port_name PG_ack_signals[1] \
-direction horizontal

connect_power_switch -source sipo_bit/shut_down_signals \
-ack_out PG_ack_signals[0] \
-ring_direction clockwise \
-mode daisy \
-port_name PG_ack_signals[0] \
-voltage_area PD_SIPO \
-ack_port_name PG_ack_signals[0] \
-direction horizontal

connect_pg_net

create_pg_vias -nets VDDL -within_bbox [get_attribute [get_voltage_areas PD_PISO] bbox]
create_pg_vias -nets VDDL -within_bbox [get_attribute [get_voltage_areas PD_SIPO] bbox]
