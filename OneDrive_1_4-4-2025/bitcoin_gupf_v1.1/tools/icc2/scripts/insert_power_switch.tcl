connect_pg_net
place_pins -ports [get_ports *]
get_shapes -of_objects [get_nets piso_secure_0/VDDL]
create_power_switch_array -power_switch SW_PISO_SECURE -voltage_area PD_PISO_SECURE -x_pitch 10 -y_pitch 1.6  -pg_straps [get_shapes -of_objects [get_nets piso_secure_0/VDDL]]

connect_power_switch -source sleep_signals[17]  \
-ack_out power_ack_signals[20] \
-ring_direction clockwise \
-mode daisy \
-port_name power_ack_signals[20] \
-voltage_area PD_PISO_SECURE \
-ack_port_name power_ack_signals[20] \
-direction horizontal

connect_pg_net

create_pg_vias -nets VDDL -within_bbox {{1985.5680 1207.0240} {5069.9520 1385.9280}}
