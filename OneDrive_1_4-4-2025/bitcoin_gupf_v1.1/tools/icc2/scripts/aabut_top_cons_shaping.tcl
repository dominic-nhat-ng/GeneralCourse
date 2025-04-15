

block bit_coin {

define_group GP_1 {
arrange_in_array {
 contents:  block_inst bit_secure_0,
            block_inst bit_secure_1;
direction: south ;
}}

define_group GP_2 {
arrange_in_array {
 contents:  block_inst bit_secure_2,
            block_inst bit_secure_3;
direction: south ;
}}

define_group GP_3 {
arrange_in_array {
 contents:  block_inst bit_secure_4,
            block_inst bit_secure_5;
direction: south ;
}}

define_group GP_4 {
arrange_in_array {
 contents:  block_inst bit_secure_6,
            block_inst bit_secure_7;
direction: south ;
}}

define_group GP_5 {
arrange_in_array {
 contents:  block_inst bit_secure_8,
            block_inst bit_secure_9;
direction: south ;
}}

define_group GP_6 {
arrange_in_array {
 contents:  block_inst bit_secure_10,
            block_inst bit_secure_11;
direction: south ;
}}

define_group GP_7 {
arrange_in_array {
 contents:  block_inst bit_secure_12,
            block_inst bit_secure_13;
direction: south ;
}}

define_group GP_8 {
arrange_in_array {
 contents:  block_inst bit_secure_14,
            block_inst bit_secure_15;
direction: south ;
}}

define_group 2X2_GP_1 {
arrange_in_array {
contents: group GP_1,
          group GP_2;
direction: east ;
}
}

define_group 2X2_GP_2 {
arrange_in_array {
contents: group GP_3,
          group GP_4;
direction: east ;
}
}
define_group 2X2_GP_3 {
arrange_in_array {
contents: group GP_5,
          group GP_6;
direction: east ;
}
}

define_group 2X2_GP_4 {
arrange_in_array {
contents: group GP_7,
          group GP_8;
direction: east ;
}
}

define_group 4X2_GP_1 {
arrange_in_array {
contents: group 2X2_GP_1,
          group 2X2_GP_2;
direction: east ;
}
}

define_group 4X2_GP_2 {
arrange_in_array {
contents: group 2X2_GP_3,
          group 2X2_GP_4;
direction: east ;
}
}

#allowed_orientation {

#block_inst bit_secure_0 , block_inst bit_secure_1 , block_inst bit_secure_2 , block_inst bit_secure_3 , block_inst bit_secure_4  , block_inst bit_secure_5 , block_inst bit_secure_6 , block_inst bit_secure_7 , block_inst bit_secure_8 , block_inst bit_secure_9 , block_inst bit_secure_10 , block_inst bit_secure_11 , block_inst bit_secure_12 , block_inst bit_secure_13 , block_inst bit_secure_14 , block_inst bit_secure_15 ;

#{R0};

#}


allowed_orientation { 

block_inst bit_secure_0 ,  block_inst bit_secure_2 ,  block_inst bit_secure_4  ,  block_inst bit_secure_6 ,  block_inst bit_secure_8 ,  block_inst bit_secure_10 ,  block_inst bit_secure_12 ,  block_inst bit_secure_14  ;

{R0};

}

allowed_orientation {

 block_inst bit_secure_1 ,  block_inst bit_secure_3 ,  block_inst bit_secure_5 ,  block_inst bit_secure_7 ,  block_inst bit_secure_9 ,  block_inst bit_secure_11 ,  block_inst bit_secure_13 ,  block_inst bit_secure_15 ;

{MX};

}


#block bit_slice { 
#    voltage_area PD_SIPO { 
#        contents:  block_inst sipo_bit; 
#        boundary { 
#            type: rigid; 
#            shape: {{{ 2.297 1.873} {25.618 56.290 }}} ;
#        } 
#    }
#    voltage_area PD_PISO { 
#        contents:  block_inst piso_bit; 
#        boundary { 
#            type: rigid; 
#            shape: {{{ 127.915 1.873} {148.057 56.643 }}};
#        } 
#    }
#}
#
#block bit_top { 
#    voltage_area PD_SIPO_SLICE { 
#        contents:  block_inst sipo_slice_first, block_inst sipo_slice_last; 
#        boundary { 
#            type: rigid; 
#            shape: {{{ 57.392 137.675} {541.073 147.556 }}};
#        } 
#    }
#    voltage_area PD_PISO_SLICE { 
#        contents:  block_inst piso_slice_first, block_inst piso_slice_last; 
#        boundary { 
#            type: rigid; 
#            shape: {{{ 803.500 138.827} {1237.098 147.385 }}};
#        } 
#    }
#}




#define_group 4X4_GP_TOP {
#arrange_in_array {
#contents: group 4X2_GP_1,
#          group 4X2_GP_2;
#direction: south ;
#}
#}

#channel_size { size=10; }
 
}

