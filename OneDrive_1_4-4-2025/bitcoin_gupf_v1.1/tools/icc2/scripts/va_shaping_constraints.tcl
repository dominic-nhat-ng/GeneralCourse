block bit_slice { 
    voltage_area PD_SIPO { 
        contents:  block_inst sipo_bit; 
        boundary { 
            type: rigid; 
            shape: {{{ 2.297 1.873} {25.618 56.290 }}} ;
        } 
    }
    voltage_area PD_PISO { 
        contents:  block_inst piso_bit; 
        boundary { 
            type: rigid; 
            shape: {{{ 127.915 1.873} {148.057 56.643 }}};
        } 
    }
}

block bit_top { 
    voltage_area PD_SIPO_SLICE { 
        contents:  block_inst sipo_slice_first, block_inst sipo_slice_last; 
        boundary { 
            type: rigid; 
            shape: {{{ 57.392 137.675} {541.073 147.556 }}};
        } 
    }
    voltage_area PD_PISO_SLICE { 
        contents:  block_inst piso_slice_first, block_inst piso_slice_last; 
        boundary { 
            type: rigid; 
            shape: {{{ 803.500 138.827} {1237.098 147.385 }}};
        } 
    }
}
