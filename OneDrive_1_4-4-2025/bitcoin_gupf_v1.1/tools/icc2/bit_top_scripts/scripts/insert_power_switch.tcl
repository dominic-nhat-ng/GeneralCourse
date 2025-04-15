connect_pg_net
place_pins -ports [get_ports *]
get_shapes -of_objects [get_nets VDDL]
create_power_switch_array -power_switch SW_PISO_SLICE -voltage_area PD_PISO_SLICE -x_pitch 180 -y_pitch 1.6  -pg_straps [get_shapes -of_objects [get_nets VDDL]]
create_power_switch_array -power_switch SW_SIPO_SLICE -voltage_area PD_SIPO_SLICE -x_pitch 180 -y_pitch 1.6  -pg_straps [get_shapes -of_objects [get_nets VDDL]]

connect_power_switch -source  shut_down_signals[1] \
-ack_out PG_ack_signals[3] \
-ring_direction clockwise \
-mode daisy \
-port_name PG_ack_signals[3] \
-voltage_area PD_PISO_SLICE \
-ack_port_name PG_ack_signals[3] \
-direction horizontal

connect_power_switch -source shut_down_signals[0] \
-ack_out PG_ack_signals[2] \
-ring_direction clockwise \
-mode daisy \
-port_name PG_ack_signals[2] \
-voltage_area PD_SIPO_SLICE \
-ack_port_name PG_ack_signals[2] \
-direction horizontal

connect_pg_net

create_pg_vias -nets VDDL -within_bbox [get_attribute [get_voltage_areas PD_PISO_SLICE] bbox]
create_pg_vias -nets VDDL -within_bbox [get_attribute [get_voltage_areas PD_SIPO_SLICE] bbox]
