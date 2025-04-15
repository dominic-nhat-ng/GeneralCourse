source scripts/dc_variables.tcl
source rm_setup/dc_setup.tcl
source scripts/procs.tcl
suppress_message TFCHK-014
suppress_message TLUP-005
suppress_message PSYN-025
suppress_message PWR-536
suppress_message PSYN-058
suppress_message OPT-1209
suppress_message UPF-018

source scripts/dc_variables.tcl

define_design_lib -path ./work work
set DESIGN_NAME bit_top

set_top_implementation_options -block_references "bit_slice"
read_ddc results_bit_slice/bit_slice_bam.ddc

read_ddc ./results_bit_top/bit_top.ddc
current_design $DESIGN_NAME
link
set_tlu_plus_files -max_tluplus $TLUPLUS_MAX_FILE -tech2itf_map $MAP_FILE
propagate_constraints -power_supply_data

