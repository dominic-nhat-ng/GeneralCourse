##########################################################################################
# Tool: IC Compiler II
# Script: write_data_for_etm.tcl
# Version: Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_pnr_setup.tcl 

######################################################################
## Write out ASCII Data needed to Generate ETM in PT and Create Frame
######################################################################

if {$USE_ETM_FOR_BLOCKS != ""} {
   foreach blk $USE_ETM_FOR_BLOCKS {
        echo "Writing out ASCII data to generate ETM for block ${blk}"

        if {[file exists ./${BLOCK}.nlib]} {
             open_lib ${blk}.nlib
     
             ## Following set of lines open the block saved after route_opt and dump out design data needed to generate ETM
             ## Modify ROUTE_OPT_BLOCK_NAME if you want to create ETM for some other stage of the block
     
             # Following is needed for ETM Reference Library Preparation
             # To enable reading of physical data from design.nlib using read_ndm -view frame, save the block as design_name.design
     	     copy_block -from $blk/$ROUTE_OPT_BLOCK_NAME -to ${blk}
     	     current_block ${blk}
     
     	     ## write_verilog for PT (without physical only cells and with diodes and DCAP for leakage power analysis)
     	     ## To enable write_verilog to write out UPF compatible for other Synopsys tools as well as verilog
     	     set_app_options -name mv.upf.write_crosstool_wrappers -value true
             set write_verilog_pt_cmd "write_verilog -compress gzip -exclude {scalar_wire_declarations leaf_module_declarations pg_objects end_cap_cells well_tap_cells filler_cells pad_spacer_cells} -hierarchy all ${OUTPUTS_DIR}/${WRITE_DATA_BLOCK_NAME}.pt.v"
             if {$CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST != ""} {lappend write_verilog_pt_cmd -force_reference $CHIP_FINISH_METAL_FILLER_LIB_CELL_LIST}
             eval $write_verilog_pt_cmd
     
     	     ## write_parasitics
     	     update_timing
     	     write_parasitics -output ${OUTPUTS_DIR}/${blk}
     
             ## write out sdc
     	     foreach_in_collection scn [all_scenarios] {
       		current_scenario $scn
       		write_sdc -output ./${OUTPUTS_DIR}/${blk}\_[get_object_name $scn]\.sdc
     	     }
     
             ## Generate UPF for ETMs; these will be used during Top Level Closure using ETMs
     	     save_upf -for_etm ${OUTPUTS_DIR}/${blk}.etm.upf
     
             save_lib
     	     close_lib
        } else {
               puts "RM-error: {blk}.nlib does not exist. Pls correct it. Exiting"
               exit
        }
   }
}

echo [date] > write_data_for_etm

exit 
