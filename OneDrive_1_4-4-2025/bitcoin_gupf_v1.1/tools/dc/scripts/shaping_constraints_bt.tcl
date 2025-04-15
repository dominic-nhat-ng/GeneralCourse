
block bit_top {

voltage_area PD_SIPO_SLICE {
        boundary {
            type: rigid;
            shape: {{158.1040 361.8080} {534.1520 450.0960}};
        }}
voltage_area PD_PISO_SLICE {
        boundary {
            type: rigid;
            shape: {{1061.2880 363.1520} {1482.5040 444.7520}};
        }}
}


block bit_slice {
boundary {
           type: rigid;
shape: {{0 0} {200 68}};
}

voltage_area PD_SIPO {
        boundary {
            type: rigid;
            shape: {{2.2970 1.8730} {53.6800 60.1920}};
        }}
    voltage_area PD_PISO {
        boundary {
            type: rigid;
            shape: {{165.0960 2.0000} {201.8800 56.7700}};
        }}
}



block bit_top {

define_group ROW_01 {
arrange_in_array {
contents: block_inst slice_0,
          block_inst slice_1;
direction: east ;
}}

define_group ROW_23 {
arrange_in_array {
contents: block_inst slice_2,
          block_inst slice_3;
direction: east ;
}}

define_group ROW_45 {
arrange_in_array {
contents: block_inst slice_4,
          block_inst slice_5;
direction: east ;
}}

define_group ROW_67 {          
arrange_in_array {
contents: block_inst slice_6,
          block_inst slice_7;

direction: east ;

}} 

define_group ROW_89 {
arrange_in_array {
contents: block_inst slice_8,
          block_inst slice_9;
direction: east ;

}}

define_group ROW_1011 {
arrange_in_array {
contents: block_inst slice_10,
          block_inst slice_11;
direction: east ;

}}          

define_group ROW_1213 {
arrange_in_array {
contents: block_inst slice_12,
          block_inst slice_13;
direction: east ;

}}

define_group ROW_1415 {
arrange_in_array {
contents: block_inst slice_14,
          block_inst slice_15;
direction: east ;

}}

define_group ROW_1617 {
arrange_in_array {
contents: block_inst slice_16,
          block_inst slice_17;
direction: east ;

}}

define_group ROW_1819 {
arrange_in_array {
contents: block_inst slice_18,
          block_inst slice_19;
direction: east ;

}}

define_group ROW_2021 {
arrange_in_array {
contents: block_inst slice_20,
          block_inst slice_21;
direction: east ;

}}

define_group ROW_2223 {
arrange_in_array {
contents: block_inst slice_22,
          block_inst slice_23;
direction: east ;

}}

define_group ROW_2425 {
arrange_in_array {
contents: block_inst slice_24,
          block_inst slice_25;
direction: east ;

}}


define_group ROW_2627 {
arrange_in_array {
contents: block_inst slice_26,
          block_inst slice_27;
direction: east ;

}}

define_group ROW_2829 {
arrange_in_array {
contents: block_inst slice_28,
          block_inst slice_29;
direction: east ;

}}

define_group ROW_3031 {
arrange_in_array {
contents: block_inst slice_30,
          block_inst slice_31;
direction: east ;

}}

define_group 2X2_1 {
arrange_in_array {
contents: group ROW_01, 
          group ROW_23;
direction: south ;
}}

define_group 2X2_2 {
arrange_in_array {
contents: group ROW_45,
          group ROW_67;
direction: south ;
}}

define_group 2X2_3 {
arrange_in_array {
contents: group ROW_89,
          group ROW_1011;
direction: south ;
}}

define_group 2X2_4 {
arrange_in_array {
contents: group ROW_1213,
          group ROW_1415;
direction: south ;
}}

define_group 2X2_5 {
arrange_in_array {
contents: group ROW_1617,
          group ROW_1819;
direction: south ;
}}

define_group 2X2_6 {
arrange_in_array {
contents: group ROW_2021,
          group ROW_2223;
direction: south ;
}}

define_group 2X2_7 {
arrange_in_array {
contents: group ROW_2425,
          group ROW_2627;
direction: south ;
}}

define_group 2X2_8 {
arrange_in_array {
contents: group ROW_2829,
          group ROW_3031;
direction: south ;
}}

define_group 2X4_1 {
arrange_in_array {
contents: group 2X2_1,
          group 2X2_2;
direction: south ;
}}
define_group 2X4_2 {
arrange_in_array {
contents: group 2X2_3,
          group 2X2_4;
direction: south ;
}}
define_group 2X4_3 {
arrange_in_array {
contents: group 2X2_5,
          group 2X2_6;
direction: south ;
}}
define_group 2X4_4 {
arrange_in_array {
contents: group 2X2_7,
          group 2X2_8;
direction: south ;
}}

define_group full {
arrange_in_array {
contents: group 2X4_1,
          group 2X4_2,
          group 2X4_3,
          group 2X4_4;
direction: east ;
}}


allowed_orientation {

block_inst slice_0,  block_inst slice_1,  block_inst slice_4, block_inst slice_5,  block_inst slice_8, block_inst slice_9,  block_inst slice_12, block_inst slice_13,  block_inst slice_16, block_inst slice_17,  block_inst slice_20, block_inst slice_21,  block_inst slice_24, block_inst slice_25,  block_inst slice_28, block_inst slice_29  ;

{R0};
}

allowed_orientation {
 block_inst slice_2,  block_inst slice_3,  block_inst slice_6, block_inst slice_7,  block_inst slice_10, block_inst slice_11,  block_inst slice_14, block_inst slice_15,  block_inst slice_18, block_inst slice_19,  block_inst slice_22, block_inst slice_23,  block_inst slice_26, block_inst slice_27,  block_inst slice_30, block_inst slice_31 ;

{MX};

}





}


