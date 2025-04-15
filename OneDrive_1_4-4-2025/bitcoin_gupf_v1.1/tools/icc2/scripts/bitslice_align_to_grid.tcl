##### Planning grids below so that 2 sides are open for pin placement ##############

create_grid align_bit_block_0 -x_offset 10 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_0 -cells [get_cells { slice_0 slice_2 }]

create_grid align_bit_block_01 -x_offset 210 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_01 -cells [get_cells {  slice_1  slice_3}]

create_grid align_bit_block_1 -x_offset 10 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_1 -cells [get_cells {slice_4  slice_6  }]

create_grid align_bit_block_11 -x_offset 210 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_11 -cells [get_cells { slice_5  slice_7 }]



create_grid align_bit_block_2 -x_offset 412 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_2 -cells [get_cells {slice_8  slice_10  }]

create_grid align_bit_block_21 -x_offset 612 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_21 -cells [get_cells { slice_9  slice_11 }]



create_grid align_bit_block_3 -x_offset 412 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_3 -cells [get_cells { slice_12  slice_14 }]

create_grid align_bit_block_31 -x_offset 612 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_31 -cells [get_cells { slice_13  slice_15}]

create_grid align_bit_block_4 -x_offset 812 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_4 -cells [get_cells {slice_16  slice_18  }]

create_grid align_bit_block_41 -x_offset 1012 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_41 -cells [get_cells { slice_17  slice_19 }]

create_grid align_bit_block_5 -x_offset 812 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_5 -cells [get_cells {slice_20  slice_22  }]

create_grid align_bit_block_51 -x_offset 1012 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_51 -cells [get_cells { slice_21  slice_23 }]



create_grid align_bit_block_6 -x_offset 1212 -y_offset 220   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_6 -cells [get_cells {slice_24  slice_26  }]


create_grid align_bit_block_61 -x_offset 1412 -y_offset 220   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_61 -cells [get_cells { slice_25  slice_27 }]


create_grid align_bit_block_7 -x_offset 1212 -y_offset 80   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_7 -cells [get_cells { slice_28  slice_30 }]

create_grid align_bit_block_71 -x_offset 1412 -y_offset 80   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_71 -cells [get_cells {  slice_29  slice_31}]

