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

exit



