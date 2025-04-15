###############################################################
#                                                             #
#  Messages from preview_dft                                  #
#  WARNING: Remove these messages before sourcing this script #
#                                                             #
###############################################################

#
#


###########################################################
#                                                         #
#  Created by preview_dft() on Thu Aug 25 15:48:53 2016
#                                                         #
###########################################################


set_scan_configuration -chain_count 3


set_scan_path 1 -dedicated_scan_out false -test_mode Internal_scan -include_elements { \
  "sipo_slice_first/count_reg_0_" \
  "sipo_slice_first/count_reg_1_" \
  "sipo_slice_first/count_reg_2_" \
  "sipo_slice_first/count_reg_3_" \
  "sipo_slice_first/rd_addr_reg_0_" \
  "sipo_slice_first/rd_addr_reg_1_" \
  "sipo_slice_first/rd_addr_reg_2_" \
  "sipo_slice_first/rd_addr_reg_3_" \
  "sipo_slice_first/tmp_reg_0_" \
  "sipo_slice_first/tmp_reg_1_" \
  "sipo_slice_first/tmp_reg_2_" \
  "sipo_slice_first/tmp_reg_3_" \
  "sipo_slice_first/tmp_reg_4_" \
  "sipo_slice_first/tmp_reg_5_" \
  "sipo_slice_first/tmp_reg_6_" \
  "sipo_slice_first/tmp_reg_7_" \
  "sipo_slice_first/tmp_reg_8_" \
  "sipo_slice_first/tmp_reg_9_" \
  "sipo_slice_first/tmp_reg_10_" \
  "sipo_slice_first/tmp_reg_11_" \
  "sipo_slice_first/tmp_reg_12_" \
  "sipo_slice_first/tmp_reg_13_" \
  "sipo_slice_first/tmp_reg_14_" \
  "sipo_slice_first/tmp_reg_15_" \
  "sipo_slice_first/wr_0_reg" \
  "sipo_slice_first/wr_1_reg" \
  "sipo_slice_first/wr_addr_reg_0_" \
  "sipo_slice_first/wr_addr_reg_1_" \
  "sipo_slice_first/wr_addr_reg_2_" \
  "sipo_slice_first/wr_addr_reg_3_" \
  "sipo_slice_first/wr_reg" \
  "sipo_slice_last/count_reg_0_" \
  "sipo_slice_last/count_reg_1_" \
  "sipo_slice_last/count_reg_2_" \
  "sipo_slice_last/count_reg_3_" \
  "sipo_slice_last/rd_addr_reg_0_" \
  "sipo_slice_last/rd_addr_reg_1_" \
  "sipo_slice_last/rd_addr_reg_2_" \
  "sipo_slice_last/rd_addr_reg_3_" \
  "sipo_slice_last/tmp_reg_0_" \
  "sipo_slice_last/tmp_reg_1_" \
  "sipo_slice_last/tmp_reg_2_" \
  "sipo_slice_last/tmp_reg_3_" \
  "sipo_slice_last/tmp_reg_4_" \
  "sipo_slice_last/tmp_reg_5_" \
  "sipo_slice_last/tmp_reg_6_" \
  "sipo_slice_last/tmp_reg_7_" \
  "sipo_slice_last/tmp_reg_8_" \
  "sipo_slice_last/tmp_reg_9_" \
  "sipo_slice_last/tmp_reg_10_" \
  "sipo_slice_last/tmp_reg_11_" \
  "sipo_slice_last/tmp_reg_12_" \
  "sipo_slice_last/tmp_reg_13_" \
  "sipo_slice_last/tmp_reg_14_" \
  "sipo_slice_last/tmp_reg_15_" \
  "sipo_slice_last/wr_0_reg" \
  "sipo_slice_last/wr_1_reg" \
  "sipo_slice_last/wr_addr_reg_0_" \
  "sipo_slice_last/wr_addr_reg_1_" \
  "sipo_slice_last/wr_addr_reg_2_" \
  "sipo_slice_last/wr_addr_reg_3_" \
  "sipo_slice_last/wr_reg" \
"slice_0/1" \
"slice_1/1" \
"slice_2/1" \
"slice_3/1" \
"slice_4/1" \
"slice_5/1" \
"slice_6/1" \
"slice_7/1" \
"slice_8/1" \
"slice_9/1" \
"slice_10/1" \
"slice_11/1" \
"slice_12/1" \
"slice_13/1" \
"slice_14/1" \
"slice_15/1" \
"slice_16/1" \
"slice_17/1" \
"slice_18/1" \
"slice_19/1" \
"slice_20/1" \
"slice_21/1" \
"slice_22/1" \
"slice_23/1" \
"slice_24/1" \
"slice_25/1" \
"slice_26/1" \
"slice_27/1" \
"slice_28/1" \
"slice_29/1" \
"slice_30/1" \
"slice_31/1" \
} -complete true

set_scan_path 2 -dedicated_scan_out false -test_mode Internal_scan -include_elements { \
  "piso_slice_first/dout_reg" \
  "piso_slice_first/temp_reg_0_" \
  "piso_slice_first/temp_reg_1_" \
  "piso_slice_first/temp_reg_2_" \
  "piso_slice_first/temp_reg_3_" \
  "piso_slice_first/temp_reg_4_" \
  "piso_slice_first/temp_reg_5_" \
  "piso_slice_first/temp_reg_6_" \
  "piso_slice_first/temp_reg_7_" \
  "piso_slice_first/temp_reg_8_" \
  "piso_slice_first/temp_reg_9_" \
  "piso_slice_first/temp_reg_10_" \
  "piso_slice_first/temp_reg_11_" \
  "piso_slice_first/temp_reg_12_" \
  "piso_slice_first/temp_reg_13_" \
  "piso_slice_first/temp_reg_14_" \
  "piso_slice_first/temp_reg_15_" \
  "piso_slice_last/dout_reg" \
  "piso_slice_last/temp_reg_0_" \
  "piso_slice_last/temp_reg_1_" \
  "piso_slice_last/temp_reg_2_" \
  "piso_slice_last/temp_reg_3_" \
  "piso_slice_last/temp_reg_4_" \
  "piso_slice_last/temp_reg_5_" \
  "piso_slice_last/temp_reg_6_" \
  "piso_slice_last/temp_reg_7_" \
  "piso_slice_last/temp_reg_8_" \
  "piso_slice_last/temp_reg_9_" \
  "piso_slice_last/temp_reg_10_" \
  "piso_slice_last/temp_reg_11_" \
  "piso_slice_last/temp_reg_12_" \
  "piso_slice_last/temp_reg_13_" \
  "piso_slice_last/temp_reg_14_" \
  "piso_slice_last/temp_reg_15_" \
"slice_0/2" \
"slice_1/2" \
"slice_2/2" \
"slice_3/2" \
"slice_4/2" \
"slice_5/2" \
"slice_6/2" \
"slice_7/2" \
"slice_8/2" \
"slice_9/2" \
"slice_10/2" \
"slice_11/2" \
"slice_12/2" \
"slice_13/2" \
"slice_14/2" \
"slice_15/2" \
"slice_16/2" \
"slice_17/2" \
"slice_18/2" \
"slice_19/2" \
"slice_20/2" \
"slice_21/2" \
"slice_22/2" \
"slice_23/2" \
"slice_24/2" \
"slice_25/2" \
"slice_26/2" \
"slice_27/2" \
"slice_28/2" \
"slice_29/2" \
"slice_30/2" \
"slice_31/2" \
} -complete true

set_scan_path 3 -dedicated_scan_out false -test_mode Internal_scan -include_elements { \
"slice_0/3" \
"slice_1/3" \
"slice_2/3" \
"slice_3/3" \
"slice_4/3" \
"slice_5/3" \
"slice_6/3" \
"slice_7/3" \
"slice_8/3" \
"slice_9/3" \
"slice_10/3" \
"slice_11/3" \
"slice_12/3" \
"slice_13/3" \
"slice_14/3" \
"slice_15/3" \
"slice_16/3" \
"slice_17/3" \
"slice_18/3" \
"slice_19/3" \
"slice_20/3" \
"slice_21/3" \
"slice_22/3" \
"slice_23/3" \
"slice_24/3" \
"slice_25/3" \
"slice_26/3" \
"slice_27/3" \
"slice_28/3" \
"slice_29/3" \
"slice_30/3" \
"slice_31/3" \
"temp_0_reg" \
"load_data_from_memory_0_reg" \
"temp_1_reg" \
"load_data_from_memory_1_reg" \
} -complete true
