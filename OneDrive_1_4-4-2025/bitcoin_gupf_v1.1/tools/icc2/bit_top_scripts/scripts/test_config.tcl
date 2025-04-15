create_port test_se
create_port test_mode

set_dft_signal -view existing -type TestClock -port [get_ports clk* ] -timing [list 45 55]

set_dft_signal -view spec -type ScanEnable  -port test_se        -active 1
set_dft_signal -view spec -type TestMode    -port test_mode      -active 1
set_dft_drc_configuration -clock_gating_init_cycles 1
set_dft_configuration -connect_clock_gating enable
set_dft_insertion_configuration -preserve_design_name true
set_dft_insertion_configuration -synthesis_optimization none
set_dft_configuration -scan_compression disable


set_scan_configuration -clock_mixing mix_edges
set_scan_configuration -add_lockup true
set_scan_configuration -internal_clocks none
set_dft_configuration -fix_bidirectional disable
set test_dedicated_subdesign_scan_outs true
#set_scan_compression_configuration -minimum_compression 14 -min_power TRUE


set_dft_insertion_configuration -route_scan_enable true -route_scan_serial true -preserve_design_name true
