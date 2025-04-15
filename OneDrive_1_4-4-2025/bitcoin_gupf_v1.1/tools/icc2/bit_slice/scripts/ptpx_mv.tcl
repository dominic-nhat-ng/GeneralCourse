

set power_enable_analysis TRUE
source rm_setup/dc_setup.tcl
set sh_continue_on_error true


source -e -v scripts/pt_setup.tcl

suppress_message UITE-130
suppress_message PARA-007

set wd [pwd]



lappend search_path rtl
lappend search_path results
lappend search_path .

echo $search_path


set DC_IN_FILE           ./results/bit_coin_upf_2.1.vg 
set DESIGN_NAME bit_coin


set svr_keep_unconnected_nets true

echo $search_path
echo $link_library

read_verilog [list outputs2icc2/bit_coin_dft.vg outputs2icc2/bit_top_dft.vg outputs2icc2/bit_slice_dft.vg]
current_design $DESIGN_NAME
link



###### Use all the libraries in Target Library of place/cts/route #############################



#load_upf $DESIGN_NAME.output.upf
#source $wd/sdc/$DESIGN_NAME.output.sdc

read_vcd ./vcdplus.vpd -strip_path tb/dut


##### Make sure there are no residual CAP/R's in the design #############
set all_nets [get_nets -hier *]
remove_capacitance          $all_nets
remove_resistance           $all_nets
remove_annotated_parasitics $all_nets
remove_annotated_delay -all
remove_annotated_check -all

########## Clock is not ideal as we are running Power analysis on Post-Routed Database ###########
#remove_clock_uncertainty [all_clocks]
#set_propagated_clock [all_clocks]


########## Read parasitics file generated from STAR RC ##########################
#read_parasitics $wd/SYN_TOP_WRAPPER_HIER_IMPLEMENTATION/SYN_TOP_WRAPPER/results/$DESIGN_NAME.output.sbpf.max -keep_capacitive_coupling
#report_annotated_parasitics -list_not_annotated



################## Read the vectors generated from Verification ##############
#set_operating_conditions  WCCOM
#set_voltage 1.08 -obj {VDD_HIGH VDD_HIGH_CRC_VIRTUAL }
#set_voltage 0 -object_list {VSS}
#set_voltage 0.864 -object_list {VDD_LOW VDD_LOW_RX_VIRTUAL}

### Power Analysis is required to be run twice for Prime-Rail analysis ################
update_power
### The option below is required only if Vector Based (VCD) analysis is done in PR ####
set report_dir $wd/reports
report_power > $report_dir/ptpx_power_vector.rpt
report_timing -delay max -tran -cap -path full_clock -crosstalk_delta -significant_digits 4 -max_paths 1000 -nosplit > $report_dir/pt_timing.rpt
