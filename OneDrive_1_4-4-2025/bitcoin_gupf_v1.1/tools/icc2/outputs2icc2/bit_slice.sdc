###################################################################

# Created by write_sdc on Mon Oct  2 10:28:51 2017

###################################################################
set sdc_version 2.0

set_units -time ns -resistance MOhm -capacitance fF -voltage V -current uA
set_operating_conditions tt0p85v125c -library saed32hvt_tt0p85v125c
create_voltage_area -name PD_SIPO  -coordinate {3.8 3.344 45.144 60.192}  -guard_band_x 0  -guard_band_y 0  [get_cells sipo_bit]
create_voltage_area -name PD_PISO  -coordinate {155.952 3.344 195.624 56.848}  -guard_band_x 0  -guard_band_y 0  [get_cells piso_bit]
create_clock [get_ports hclk]  -period 1  -waveform {0 0.5}
create_clock [get_ports lclk]  -period 1  -waveform {0 0.5}
set_false_path -setup   -to [list [get_ports sipo_scan_out] [get_ports piso_scan_out] [get_ports      \
hv_scan_out] [get_ports lv_scan_out]]
set_false_path -setup   -from [list [get_ports sipo_scan_in] [get_ports piso_scan_in] [get_ports      \
hv_scan_in] [get_ports lv_scan_in]]
set_multicycle_path 2 -hold -to [get_ports sout]
set_multicycle_path 2 -setup -to [get_ports sout]
set_multicycle_path 4 -hold -through [list [get_pins {nibble_0/A1[0]}]         \
[get_pins {nibble_0/A1[1]}] [get_pins {nibble_0/A1[2]}] [get_pins              \
{nibble_0/A1[3]}] [get_pins {nibble_0/A2[0]}] [get_pins {nibble_0/A2[1]}]      \
[get_pins {nibble_0/A2[2]}] [get_pins {nibble_0/A2[3]}] [get_pins              \
nibble_0/CE1] [get_pins nibble_0/CE2] [get_pins nibble_0/CSB1] [get_pins       \
nibble_0/CSB2] [get_pins {nibble_0/I1[0]}] [get_pins {nibble_0/I1[1]}]         \
[get_pins {nibble_0/I1[2]}] [get_pins {nibble_0/I1[3]}] [get_pins              \
{nibble_0/I2[0]}] [get_pins {nibble_0/I2[1]}] [get_pins {nibble_0/I2[2]}]      \
[get_pins {nibble_0/I2[3]}] [get_pins nibble_0/OEB1] [get_pins nibble_0/OEB2]  \
[get_pins nibble_0/SLEEPIN] [get_pins nibble_0/WEB1] [get_pins nibble_0/WEB2]  \
[get_pins nibble_0/ACK] [get_pins {nibble_0/O1[0]}] [get_pins                  \
{nibble_0/O1[1]}] [get_pins {nibble_0/O1[2]}] [get_pins {nibble_0/O1[3]}]      \
[get_pins {nibble_0/O2[0]}] [get_pins {nibble_0/O2[1]}] [get_pins              \
{nibble_0/O2[2]}] [get_pins {nibble_0/O2[3]}] [get_pins {nibble_1/A1[0]}]      \
[get_pins {nibble_1/A1[1]}] [get_pins {nibble_1/A1[2]}] [get_pins              \
{nibble_1/A1[3]}] [get_pins {nibble_1/A2[0]}] [get_pins {nibble_1/A2[1]}]      \
[get_pins {nibble_1/A2[2]}] [get_pins {nibble_1/A2[3]}] [get_pins              \
nibble_1/CE1] [get_pins nibble_1/CE2] [get_pins nibble_1/CSB1] [get_pins       \
nibble_1/CSB2] [get_pins {nibble_1/I1[0]}] [get_pins {nibble_1/I1[1]}]         \
[get_pins {nibble_1/I1[2]}] [get_pins {nibble_1/I1[3]}] [get_pins              \
{nibble_1/I2[0]}] [get_pins {nibble_1/I2[1]}] [get_pins {nibble_1/I2[2]}]      \
[get_pins {nibble_1/I2[3]}] [get_pins nibble_1/OEB1] [get_pins nibble_1/OEB2]  \
[get_pins nibble_1/SLEEPIN] [get_pins nibble_1/WEB1] [get_pins nibble_1/WEB2]  \
[get_pins nibble_1/ACK] [get_pins {nibble_1/O1[0]}] [get_pins                  \
{nibble_1/O1[1]}] [get_pins {nibble_1/O1[2]}] [get_pins {nibble_1/O1[3]}]      \
[get_pins {nibble_1/O2[0]}] [get_pins {nibble_1/O2[1]}] [get_pins              \
{nibble_1/O2[2]}] [get_pins {nibble_1/O2[3]}]]
set_multicycle_path 4 -setup -through [list [get_pins {nibble_0/A1[0]}]        \
[get_pins {nibble_0/A1[1]}] [get_pins {nibble_0/A1[2]}] [get_pins              \
{nibble_0/A1[3]}] [get_pins {nibble_0/A2[0]}] [get_pins {nibble_0/A2[1]}]      \
[get_pins {nibble_0/A2[2]}] [get_pins {nibble_0/A2[3]}] [get_pins              \
nibble_0/CE1] [get_pins nibble_0/CE2] [get_pins nibble_0/CSB1] [get_pins       \
nibble_0/CSB2] [get_pins {nibble_0/I1[0]}] [get_pins {nibble_0/I1[1]}]         \
[get_pins {nibble_0/I1[2]}] [get_pins {nibble_0/I1[3]}] [get_pins              \
{nibble_0/I2[0]}] [get_pins {nibble_0/I2[1]}] [get_pins {nibble_0/I2[2]}]      \
[get_pins {nibble_0/I2[3]}] [get_pins nibble_0/OEB1] [get_pins nibble_0/OEB2]  \
[get_pins nibble_0/SLEEPIN] [get_pins nibble_0/WEB1] [get_pins nibble_0/WEB2]  \
[get_pins nibble_0/ACK] [get_pins {nibble_0/O1[0]}] [get_pins                  \
{nibble_0/O1[1]}] [get_pins {nibble_0/O1[2]}] [get_pins {nibble_0/O1[3]}]      \
[get_pins {nibble_0/O2[0]}] [get_pins {nibble_0/O2[1]}] [get_pins              \
{nibble_0/O2[2]}] [get_pins {nibble_0/O2[3]}] [get_pins {nibble_1/A1[0]}]      \
[get_pins {nibble_1/A1[1]}] [get_pins {nibble_1/A1[2]}] [get_pins              \
{nibble_1/A1[3]}] [get_pins {nibble_1/A2[0]}] [get_pins {nibble_1/A2[1]}]      \
[get_pins {nibble_1/A2[2]}] [get_pins {nibble_1/A2[3]}] [get_pins              \
nibble_1/CE1] [get_pins nibble_1/CE2] [get_pins nibble_1/CSB1] [get_pins       \
nibble_1/CSB2] [get_pins {nibble_1/I1[0]}] [get_pins {nibble_1/I1[1]}]         \
[get_pins {nibble_1/I1[2]}] [get_pins {nibble_1/I1[3]}] [get_pins              \
{nibble_1/I2[0]}] [get_pins {nibble_1/I2[1]}] [get_pins {nibble_1/I2[2]}]      \
[get_pins {nibble_1/I2[3]}] [get_pins nibble_1/OEB1] [get_pins nibble_1/OEB2]  \
[get_pins nibble_1/SLEEPIN] [get_pins nibble_1/WEB1] [get_pins nibble_1/WEB2]  \
[get_pins nibble_1/ACK] [get_pins {nibble_1/O1[0]}] [get_pins                  \
{nibble_1/O1[1]}] [get_pins {nibble_1/O1[2]}] [get_pins {nibble_1/O1[3]}]      \
[get_pins {nibble_1/O2[0]}] [get_pins {nibble_1/O2[1]}] [get_pins              \
{nibble_1/O2[2]}] [get_pins {nibble_1/O2[3]}]]
set_input_delay -clock hclk  0.1  [get_ports sipo_scan_in]
set_input_delay -clock hclk  0.1  [get_ports piso_scan_in]
set_input_delay -clock hclk  0.1  [get_ports hv_scan_in]
set_input_delay -clock hclk  0.1  [get_ports lv_scan_in]
set_input_delay -clock hclk  0.1  [get_ports reset]
set_input_delay -clock hclk  0.1  [get_ports sin]
set_input_delay -clock hclk  0.1  [get_ports data_valid]
set_input_delay -clock hclk  0.1  [get_ports memory_sleep]
set_input_delay -clock hclk  0.1  [get_ports {shut_down_signals[1]}]
set_input_delay -clock hclk  0.1  [get_ports {shut_down_signals[0]}]
set_input_delay -clock hclk  0.1  [get_ports {isolation_signals[1]}]
set_input_delay -clock hclk  0.1  [get_ports {isolation_signals[0]}]
set_input_delay -clock hclk  0.1  [get_ports {retention_signals[1]}]
set_input_delay -clock hclk  0.1  [get_ports {retention_signals[0]}]
set_input_delay -clock hclk  0.1  [get_ports scan_enable]
set_output_delay -clock hclk  0.1  [get_ports sipo_scan_out]
set_output_delay -clock hclk  0.1  [get_ports piso_scan_out]
set_output_delay -clock hclk  0.1  [get_ports hv_scan_out]
set_output_delay -clock hclk  0.1  [get_ports lv_scan_out]
set_output_delay -clock lclk  0.1  [get_ports sout]
set_output_delay -clock hclk  0.1  [get_ports memory_ack]
set_output_delay -clock hclk  0.1  [get_ports {PG_ack_signals[1]}]
set_output_delay -clock hclk  0.1  [get_ports {PG_ack_signals[0]}]
set_clock_groups  -asynchronous -name hclk_others_1  -group [get_clocks hclk]
set_voltage 0.85  -min 0.85  -object_list SS.power
set_voltage 0  -min 0  -object_list SS.ground
set_voltage 0.78  -min 0.78  -object_list SSL.power
set_voltage 0.78  -min 0.78  -object_list SSL_SIPO_SW.power
set_voltage 0.78  -min 0.78  -object_list SSL_PISO_SW.power
set_voltage 0.85  -min 0.85  -object_list SS_MEM_SW.power
set_voltage 0  -min 0  -object_list TOP.primary.ground
set_voltage 0  -min 0  -object_list PD_SIPO.primary.ground
set_voltage 0  -min 0  -object_list PD_PISO.primary.ground
