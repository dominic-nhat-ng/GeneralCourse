
create_grid align_bit_secure08 -type block -x_offset 50 -y_offset 50 -x_step  7000 -y_step 300
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure08 -cells [get_cells {bit_secure_8}]

create_grid align_bit_secure09 -type block -x_offset 50 -y_offset 515 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure09 -cells [get_cells {bit_secure_9}]

create_grid align_bit_secure01 -type block -x_offset 50 -y_offset 620 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure01 -cells [get_cells {bit_secure_1 }]

create_grid align_bit_secure00 -type block -x_offset 50 -y_offset 670 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure00 -cells [get_cells {bit_secure_0 }]

create_grid align_bit_secure1011 -type block -x_offset 1470 -y_offset 470 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure1011 -cells [get_cells {bit_secure_10 bit_secure_11}]

create_grid align_bit_secure23 -type block -x_offset 1470 -y_offset 1290 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure23 -cells [get_cells {bit_secure_2 bit_secure_3}]



create_grid align_bit_secure45 -type block -x_offset 2890 -y_offset 1290 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure45 -cells [get_cells {bit_secure_4 bit_secure_5}]

create_grid align_bit_secure1213 -type block -x_offset 2890 -y_offset 470 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure1213 -cells [get_cells {bit_secure_12 bit_secure_13}]

create_grid align_bit_secure67 -type block -x_offset 4290 -y_offset 1290 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure67 -cells [get_cells {bit_secure_6 bit_secure_7}]

create_grid align_bit_secure1415 -type block -x_offset 4290 -y_offset 470 -x_step  7000 -y_step 3000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_secure1415 -cells [get_cells {bit_secure_14 bit_secure_15}]


