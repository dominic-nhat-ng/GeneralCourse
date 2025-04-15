##########################################################################################
# Tool: IC Compiler II
# Script: export.tcl
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2016 Synopsys, Inc. All rights reserved.
##########################################################################################

   source -echo ./rm_setup/icc2_dp_setup.tcl 

puts "RM-info : Release ${WORK_DIR_WRITE_DATA} to ${RELEASE_DIR_DP}"

if {![file exists ${RELEASE_DIR_DP}]} {
  file mkdir ${RELEASE_DIR_DP}
} else {
  puts "RM-error : Relase directory: ${RELEASE_DIR_DP} already exists, please remove and re-run"
  exit
}

foreach file [glob ${WORK_DIR_WRITE_DATA}/*] {
  file copy -- ${file} ${RELEASE_DIR_DP}
}



sh mkdir ${RELEASE_DIR_DP}/bit_slice
sh mkdir ${RELEASE_DIR_DP}/bit_slice/reports
sh mkdir ${RELEASE_DIR_DP}/bit_slice/results
sh mkdir ${RELEASE_DIR_DP}/bit_top
sh mkdir ${RELEASE_DIR_DP}/bit_top/reports
sh mkdir ${RELEASE_DIR_DP}/bit_top/results
sh mkdir ${RELEASE_DIR_DP}/bit_coin
sh mkdir ${RELEASE_DIR_DP}/bit_coin/reports
sh mkdir ${RELEASE_DIR_DP}/bit_coin/results
sh cp -r bit_coin_scripts/* ${RELEASE_DIR_DP}/bit_coin
sh cp -r bit_top_scripts/* ${RELEASE_DIR_DP}/bit_top
sh cp -r bit_slice_scripts/* ${RELEASE_DIR_DP}/bit_slice

sh cp -r tech ${RELEASE_DIR_DP}/bit_coin
sh cp -r tech ${RELEASE_DIR_DP}/bit_top
sh cp -r tech ${RELEASE_DIR_DP}/bit_slice

sh cp -r lib ${RELEASE_DIR_DP}/bit_coin
sh cp -r lib ${RELEASE_DIR_DP}/bit_top
sh cp -r lib ${RELEASE_DIR_DP}/bit_slice

sh cp -r def ${RELEASE_DIR_DP}/bit_slice

sh cp -r outputs2icc2 ${RELEASE_DIR_DP}/bit_coin
sh cp -r outputs2icc2 ${RELEASE_DIR_DP}/bit_top
sh cp -r outputs2icc2 ${RELEASE_DIR_DP}/bit_slice

sh cp run* ${RELEASE_DIR_DP}

exit



