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
##  FILE:      bit_top.sdc
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
set_input_delay 0.1 -clock hclk [remove_from_collection [all_inputs ] [get_ports *clk*]]

# OUTPUT DELAY
set_output_delay 0.1 -clock hclk [all_outputs ]

# FALSE PATH
set_false_path -setup -to *scan_o*
set_false_path -setup -from *scan_i*
set_false_path -to [get_pins *SI* -hier]
set_false_path -from [list scan_enable sipo_scan_in piso_scan_in hv_scan_in lv_scan_in]
set_false_path -to [list sipo_scan_out piso_scan_out hv_scan_out lv_scan_out]
set_false_path -from [list scan_enable sipo_scan_in piso_scan_in hv_scan_in lv_scan_in]
set_false_path -to [list sipo_scan_out piso_scan_out hv_scan_out lv_scan_out]

# MULTICYCLE PATH
set_multicycle_path -hold -setup -to sout* 2
set_multicycle_path -hold -setup -through */*nibble*/* 4
set_multicycle_path -hold -setup -to [get_pins *SI* -hier] 4
set_multicycle_path -hold -setup -from isolation_signals* 20
set_multicycle_path -hold -setup -to slice*/sipo*/count*/* 2
set_multicycle_path -hold -setup -from slice*/sync*/*sync*/* 3
set_multicycle_path -hold -setup -to slice*/sync*/*sync*/* 3
set_multicycle_path -hold -setup -from slice*/load*/* 2
set_multicycle_path -hold -setup -from slice*/piso*/temp* 2
set_multicycle_path -hold -setup -from sipo*/pout* 2
set_multicycle_path -hold -setup -from slice*/piso*/dout* 2
set_multicycle_path -hold -setup -through slice*/piso*/dout* 2
set_multicycle_path -hold -setup -through sipo*/pout* 2
set_multicycle_path -hold -setup -from [list reset data_in_serial data_valid memory_sleep shut_down_signals[1] shut_down_signals[0] isolation_signals[1] isolation_signals[0] retention_signals[1] retention_signals[0] scan_enable sipo_scan_in piso_scan_in hv_scan_in lv_scan_in] 20
set_multicycle_path -hold -setup -to slice*/nib*/I* 3
set_multicycle_path -hold -setup -through *sync* 4
set_multicycle_path -hold -setup -from [list reset data_in_serial data_valid memory_sleep shut_down_signals[1] shut_down_signals[0] isolation_signals[1] isolation_signals[0] retention_signals[1] retention_signals[0] scan_enable sipo_scan_in piso_scan_in hv_scan_in lv_scan_in] 20
set_multicycle_path -hold -setup -from isolation_signals* 20
set_multicycle_path -hold -setup -to *slice_f*/temp*/* 2
set_multicycle_path -hold -setup -from slice*/sipo*/wr*/* 3

# CLOCK GROUPS
set_clock_groups -asynchronous -group hclk
