
source -e ./rm_setup/icc2_pnr_setup.tcl 

open_lib $DESIGN_LIBRARY
if {$USE_RM_BLOCK_NAME_AS_LABEL} {
	copy_block -from ${DESIGN_NAME}/${SIGNOFF_DRC_BLOCK_NAME} -to ${DESIGN_NAME}/${CHIP_FINISH_BLOCK_NAME}_rail
	current_block ${DESIGN_NAME}/${CHIP_FINISH_BLOCK_NAME}_rail
} else {
	copy_block -from ${SIGNOFF_DRC_BLOCK_NAME} -to ${CHIP_FINISH_BLOCK_NAME}_rail
	current_block ${CHIP_FINISH_BLOCK_NAME}_rail
}

link_block
set_attribute [get_lib_cells */*] dont_touch false
set_attribute [get_lib_cells */*] dont_use false

save_block

update_timing

source scripts/ar.tcl

stop_gui

close_blocks -force
close_lib -all

sh touch rail_analysis



exit

