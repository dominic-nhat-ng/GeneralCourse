
create_pg_std_cell_conn_pattern \
    std_cell_rail_va  \
    -layers {M1} \
    -rail_width 0.06

set_pg_strategy rail_strat_va_TOP -voltage_area DEFAULT_VA \
    -pattern {{name: std_cell_rail_va} {nets: VDDH VSS} }
set_pg_strategy rail_strat_va_PISO -voltage_area PD_PISO \
    -pattern {{name: std_cell_rail_va} {nets: piso_sw_out VSS} }
set_pg_strategy rail_strat_va_SIPO -voltage_area PD_SIPO \
    -pattern {{name: std_cell_rail_va} {nets: sipo_sw_out VSS} }

compile_pg -strategies rail_strat_va_PISO 
compile_pg -strategies rail_strat_va_SIPO 
compile_pg -strategies rail_strat_va_TOP 


create_pg_macro_conn_pattern -pin_conn_type scattered_pin -nets {VDDH VSS} macro_pin_conn
set_pg_strategy macro_pin_strat -pattern {{name:macro_pin_conn}{nets:{VDDH VSS}}} -macros {nibble_0 nibble_1}
compile_pg -strategies macro_pin_strat -ignore_drc

