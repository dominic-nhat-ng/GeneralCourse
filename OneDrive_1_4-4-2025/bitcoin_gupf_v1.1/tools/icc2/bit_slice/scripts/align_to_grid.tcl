create_grid align_bit_secure89 -type block -x_offset 70 -y_offset 370 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure89 -cells [get_cells {bit_secure_9 bit_secure_8}]

create_grid align_bit_secure01 -type block -x_offset 70 -y_offset 1000 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure01 -cells [get_cells {bit_secure_0 bit_secure_1}]

create_grid align_bit_secure1011 -type block -x_offset 1330 -y_offset 370 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure1011 -cells [get_cells {bit_secure_10 bit_secure_11}]

create_grid align_bit_secure23 -type block -x_offset 1330 -y_offset 1000 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure23 -cells [get_cells {bit_secure_2 bit_secure_3}]



create_grid align_bit_secure45 -type block -x_offset 2610 -y_offset 1000 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure45 -cells [get_cells {bit_secure_4 bit_secure_5}]

create_grid align_bit_secure1213 -type block -x_offset 2610 -y_offset 370 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure1213 -cells [get_cells {bit_secure_12 bit_secure_13}]

create_grid align_bit_secure67 -type block -x_offset 3870 -y_offset 1000 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure67 -cells [get_cells {bit_secure_6 bit_secure_7}]

create_grid align_bit_secure1415 -type block -x_offset 3870 -y_offset 370 -x_step  6000 -y_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure1415 -cells [get_cells {bit_secure_14 bit_secure_15}]


