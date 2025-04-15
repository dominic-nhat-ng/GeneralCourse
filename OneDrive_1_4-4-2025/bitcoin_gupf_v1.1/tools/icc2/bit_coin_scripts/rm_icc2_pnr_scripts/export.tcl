##########################################################################################
# Tool: IC Compiler II
# Script: export.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

source -echo ./rm_setup/icc2_pnr_setup.tcl 
set_svf ${DESIGN_NAME}_svf -append

set RELEASE_DIR_PNR ../signoff_data

if {![file exists ${RELEASE_DIR_PNR}]} {
	## Check if target release directory exists. Create one if it doesn't exist.
	file mkdir ${RELEASE_DIR_PNR}
} elseif {$RELEASE_DIR_PNR == $RELEASE_DIR_DP} {
	## If already exists, make sure target release directory for PNR is not set to the same value as DP.
	puts "RM-error: RELEASE_DIR_PNR is set to same value as RELEASE_DIR_DP. Please change it to avoid data overwrite" 
	puts "RM-info: Exiting" 
	exit
}

if {[file exists ${RELEASE_DIR_PNR}/${DESIGN_LIBRARY}]} {
	## Check if the library to be copied already exists in the release directory. 
	puts "RM-error: DEISGN_LIBRARY ${DESIGN_LIBRARY} already exists in the target release area ${RELEASE_DIR_PNR}" 
	puts "RM-info: Please back up existing ${DESIGN_LIBRARY} to a new location to avoid ovewrite." 
	puts "RM-info: Exiting" 
	exit
} else {
	file copy ./$DESIGN_LIBRARY ${RELEASE_DIR_PNR}/
        sh cp -r rm* ${RELEASE_DIR_PNR}/
        sh cp -r scripts ${RELEASE_DIR_PNR}/
        sh cp -r lib ${RELEASE_DIR_PNR}/
        sh cp -r tech ${RELEASE_DIR_PNR}/
        sh mkdir ${RELEASE_DIR_PNR}/bc_outputs_icc2
        sh mkdir ${RELEASE_DIR_PNR}/bt_outputs_icc2
        sh mkdir ${RELEASE_DIR_PNR}/bs_outputs_icc2
        sh mkdir ${RELEASE_DIR_PNR}/logs
        sh mkdir ${RELEASE_DIR_PNR}/reports
        sh mkdir ${RELEASE_DIR_PNR}/results
        sh cp -r outputs_icc2/* ${RELEASE_DIR_PNR}/bc_outputs_icc2
        sh cp -r ../bit_top/outputs_icc2/* ${RELEASE_DIR_PNR}/bt_outputs_icc2
        sh cp -r ../bit_slice/outputs_icc2/* ${RELEASE_DIR_PNR}/bs_outputs_icc2
        sh cp -r ../bit_slice/bit_slice_svf ${RELEASE_DIR_PNR}
        sh cp -r ../bit_top/bit_top_svf ${RELEASE_DIR_PNR}
        sh cp -r ../bit_coin/bit_coin_svf ${RELEASE_DIR_PNR}
}
sh rm -rf ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf
echo "# Auto Generated Wrapper UPF for VG tools" > ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf
echo "for {set j 0} {\$j < 16} {incr j} {" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf
echo "for {set i 0} {\$i < 32} {incr i} {" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf
echo "load_upf -scope bit_secure_\${j}/slice_\${i} bs_outputs_icc2/chip_finish.upf" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf
echo "}" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf 
echo "}" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf 
echo "for {set k 0} {\$k < 16} {incr k} {" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf 
echo "load_upf -scope bit_secure_\${k} bt_outputs_icc2/chip_finish.upf" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf  
echo "}" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf 
echo "load_upf bc_outputs_icc2/chip_finish.upf" >> ${RELEASE_DIR_PNR}/bc_outputs_icc2/top_wrapper.upf 

exit
