
block bit_top {
boundary {
           type: rigid;
shape: {{0 0} {1635 465}};
}
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
shape: {{0 0} {200 68 }};
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




block bit_coin {

voltage_area PD_PISO_SECURE {
        boundary {
            type: rigid;
            shape: { {2470 873} {3270 887} };
        }}

allowed_orientation {

block_inst bit_secure_0 ,  block_inst bit_secure_2 ,  block_inst bit_secure_4  ,  block_inst bit_secure_6 ,  block_inst bit_secure_8 ,  block_inst bit_secure_10 ,  block_inst bit_secure_12 ,  block_inst bit_secure_14  ;

{R0};

}

allowed_orientation {

 block_inst bit_secure_1 ,  block_inst bit_secure_3 ,  block_inst bit_secure_5 ,  block_inst bit_secure_7 ,  block_inst bit_secure_9 ,  block_inst bit_secure_11 ,  block_inst bit_secure_13 ,  block_inst bit_secure_15 ;

{MX};

}
}

