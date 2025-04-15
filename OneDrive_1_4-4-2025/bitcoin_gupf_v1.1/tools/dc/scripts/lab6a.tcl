source -e -v ./rm_setup/dc_setup.tcl
read_ddc ./results_bit_slice/bit_slice_bam.ddc
read_ddc ./results_bit_top/bit_top.ddc
current_design bit_top
link
propagate_constraints -power -verbose
check_mv_design
