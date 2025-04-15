##########################################################################################
# Tool: IC Compiler II
# Script: init_design_std_cell_rail_example.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

## Create M1 std cell rail pattern and strategy
#	create_pg_std_cell_conn_pattern m1_rail -layers {M1} -rail_width 0.08 
#	set_pg_strategy rail_strategy -pattern {{name: m1_rail} {nets: VDD VSS}} -core

## Run compile_pg to create the M1 rails
#	compile_pg -strategies rail_strategy

