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
##  FILE:      bit_slice.sdc
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
set_output_delay 0.1 -clock lclk [get_ports sout ]

# FALSE PATH
set_false_path -setup -to *scan_o*
set_false_path -setup -from *scan_in*

# MULTICYCLE PATH
set_multicycle_path -setup -to sout* 2
set_multicycle_path -setup -through *nibble*/* 4
set_multicycle_path -hold -to sout* 2
set_multicycle_path -hold -through *nibble*/* 4

# CLOCK GROUPS
set_clock_groups -asynchronous -group hclk
