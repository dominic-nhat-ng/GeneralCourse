change_names -rules verilog -hierarchy

set_dft_signal -view spec -type ScanDataOut -port "sipo_scan_out piso_scan_out hv_scan_out"
set_dft_signal -view spec -type ScanDataIn -port "sipo_scan_in piso_scan_in hv_scan_in"
set_dft_signal -view spec -type ScanEnable -port scan_enable
set_dft_signal -view existing_dft -type ScanClock -port [list clk] -timing {45 55}
set_dft_signal -view existing_dft -type Reset -port reset -active 0
set_dft_signal -view existing -type Constant -port isolation_signals[0] -active_state 0
set_dft_signal -view existing -type Constant -port isolation_signals[1] -active_state 0
set_dft_signal -view existing -type Constant -port retention_signals[0] -active_state 1
set_dft_signal -view existing -type Constant -port retention_signals[1] -active_state 1
