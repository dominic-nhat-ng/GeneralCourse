################################################################################
##
##  This confidential and proprietary software may be used only
##  as authorized by a licensing agreement from Synopsys Inc.
##  In the event of publication, the following notice is applicable:
##
##  (C) COPYRIGHT 1994 - 2017 SYNOPSYS INC.
##  ALL RIGHTS RESERVED
##
##  The entire notice above must be reproduced on all authorized copies.
##
##  AUTHOR:    Godwin Maben
##
##  FILE:      bit_coin.sdc
##
##  VERSION:   1.0
##
################################################################################

# SDC VERSION
set sdc_version 2.0

# CLOCKS
create_clock -p 1 hclk
create_clock -p 1 lclk

# INPUT DELAY
set_input_delay 0.1 -clock hclk [list hash_key sleep_signals[15] sleep_signals[14] sleep_signals[13] sleep_signals[12] sleep_signals[11] sleep_signals[10] sleep_signals[9] sleep_signals[8] sleep_signals[7] sleep_signals[6] sleep_signals[5] sleep_signals[4] sleep_signals[3] sleep_signals[2] sleep_signals[1] sleep_signals[0]]
set_input_delay 0.1 -clock lclk [list secure_data_in data_valid sleep_signals[17] isolation_signals[1] retention_signals[1]]

# OUTPUT DELAY
set_output_delay 0.1 -clock lclk [list secure_data_out memory_address]

# FALSE PATH
set_false_path -from sleep_signals* -to power_ack*
set_false_path -to *scan_o*
set_false_path -from *scan_in*
set_false_path -from [list scan_enable sipo_scan_in piso_scan_in hv_scan_in lv_scan_in]
set_false_path -to [list sipo_scan_out piso_scan_out hv_scan_out lv_scan_out]

# MULTICYCLE PATH
set_multicycle_path -hold -setup 4 -from secure_data_in* -to secure_data_out*
set_multicycle_path -hold -setup 4 -from isolation_signal* -to data_ready
set_multicycle_path -hold -setup -to [get_pins *SI* -hier] 4
set_multicycle_path -hold -setup -from isolation_signals* 20
set_multicycle_path -hold -setup -from bit_secure_*/slice_*/sipo_bit/wr_tmp_reg/CLK -to  bit_secure_*/slice_*/sipo_bit/wr_0_reg/D 4
set_multicycle_path -hold -setup -through *sync* 4
set_multicycle_path -hold -setup -from [list secure_data_in hash_key reset data_valid isolation_signals[1] isolation_signals[0] retention_signals[1] retention_signals[0] scan_enable sipo_scan_in piso_scan_in hv_scan_in lv_scan_in] 20
set_multicycle_path -hold -setup -to */*/*nibble*/* 4
set_multicycle_path -hold -setup -to [all_outputs ] 2
set_multicycle_path -hold -setup -to [get_pins *SI* -hier] 5
set_multicycle_path -hold -setup -from */slice*/piso*/dout* 2
set_multicycle_path -hold -setup -from */slice*/sipo*/wr*/* 3
set_multicycle_path -hold -setup -to */*slice_f*/temp*/* 2
set_multicycle_path -hold -setup -from bit_secur*/slice*/piso*/dou* 2
set_multicycle_path -hold -setup -to bit*/piso*/temp* 2
set_multicycle_path -hold -setup -from bit_se*/slice_*/load* 2

# CLOCK GROUP
set_clock_groups -asynchronous -group hclk

# MAX DELAY
set_max_delay 10 -from reset
