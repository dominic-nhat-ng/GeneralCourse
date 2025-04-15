
########### IDEALLY WE SHOULD BE ABLE TO ALIGN THE 32 "bit_slice*" FROM TOP ,BUT THAT IS NOT WORKING ######################
########### SO GO TO THE BLOCK LEVEL and create grid and align ############################################################
############ PLS. SEE STAR 9001078090 ############################

########### Arrange and Align the bit_slice inside bit_secure  #############
####### the bit slices overlap on one of the grids and the grid closest to left boundary edge is empty  #########

open_block bit_top.design
set_app_options -name plan.shaping.enable_rigid_block_percentage_check -value false
remove_abstract

###Below is a workaround , i have to define multiple grids because to avoid overlapping of blocks #####
###################### -x_offset DOESNOT work if -x_step  is not specified so i used a very big offset #####

##### Planning grids below so that 2 sides are open for pin placement ##############

create_grid align_bit_block_0 -x_offset 20 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_0 -cells [get_cells { slice_0 slice_2 }]

create_grid align_bit_block_01 -x_offset 170 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_01 -cells [get_cells {  slice_1  slice_3}]

create_grid align_bit_block_1 -x_offset 20 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_1 -cells [get_cells {slice_4  slice_6  }]

create_grid align_bit_block_11 -x_offset 170 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_11 -cells [get_cells { slice_5  slice_7 }]



create_grid align_bit_block_2 -x_offset 340 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_2 -cells [get_cells {slice_8  slice_10  }]

create_grid align_bit_block_21 -x_offset 490 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_21 -cells [get_cells { slice_9  slice_11 }]



create_grid align_bit_block_3 -x_offset 340 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_3 -cells [get_cells { slice_12  slice_14 }]

create_grid align_bit_block_31 -x_offset 490 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_31 -cells [get_cells { slice_13  slice_15}]

create_grid align_bit_block_4 -x_offset 660 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_4 -cells [get_cells {slice_16  slice_18  }]
 
create_grid align_bit_block_41 -x_offset 810 -y_offset 220   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_41 -cells [get_cells { slice_17  slice_19 }]



create_grid align_bit_block_5 -x_offset 660 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_5 -cells [get_cells {slice_20  slice_22  }]

create_grid align_bit_block_51 -x_offset 810 -y_offset 80   -y_step 1000  -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_51 -cells [get_cells { slice_21  slice_23 }]



create_grid align_bit_block_6 -x_offset 980 -y_offset 220   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_6 -cells [get_cells {slice_24  slice_26  }]


create_grid align_bit_block_61 -x_offset 1130 -y_offset 220   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_61 -cells [get_cells { slice_25  slice_27 }]


create_grid align_bit_block_7 -x_offset 980 -y_offset 80   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_7 -cells [get_cells { slice_28  slice_30 }]

create_grid align_bit_block_71 -x_offset 1130 -y_offset 80   -y_step 1000 -orientations {R0} -x_step 2000
set_snap_setting -enabled true -snap block
snap_cells_to_block_grid -grid align_bit_block_71 -cells [get_cells {  slice_29  slice_31}]




set_app_options -name abstract.allow_all_level_abstract -value true
#create_abstract -placement -all_blocks
create_abstract -placement 
save_block -force -hier -label bit_top_shape
save_lib -all
close_block -force

################## "bit_slice*"  aligning DONE. GO BACK TO TOP##############

open_block bit_coin.design


push_down_objects [get_site_rows]
set all_macros [get_cells -hier -filter is_hard_macro==true]


create_placement -floorplan
report_placement \
   -physical_hierarchy_violations all \
   -wirelength all -hard_macro_overlap \
   -verbose high > $REPORTS_DIR_PLACEMENT/report_placement.rpt
set_attribute $all_macros status fixed -quiet
place_pins
place_pins -ports  [get_ports]
write_pin_constraints \
    -file_name def/preferred_pin_locations.tcl \
    -physical_pin_constraint {side | offset | offset_range 5} \
    -from_existing_pins

check_pin_placement -pin_spacing true -layers true

   report_feedthrough -reporting_style net_based -file_name $REPORTS_DIR_PLACE_PINS/report_feedthrough.rpt




route_global -congestion_map_only true
save_lib -all

