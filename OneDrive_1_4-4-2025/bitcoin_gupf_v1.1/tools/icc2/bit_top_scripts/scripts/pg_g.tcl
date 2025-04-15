#create_net -power VDDH
#create_net -power VDDL
#create_net -ground VSS
connect_pg_net
connect_pg_net -net VDDH [get_pins -physical_context *VDDH]
connect_pg_net -net VDDL [get_pins -physical_context *VDDL]
connect_pg_net -net VSS [get_pins -physical_context *VSS]


 create_pg_ring_pattern ring_pat -horizontal_layer @hlayer \
-horizontal_width {@hwidth} -horizontal_spacing {@hspace} \
-vertical_layer {@vlayer} -vertical_width {@vwidth} \
-vertical_spacing {@vspace} -corner_bridge @cbridge \
-parameters {hlayer hwidth hspace vlayer vwidth vspace cbridge }

 set_pg_strategy ring_strat -core \
-pattern {{name: ring_pat} {nets: {VDDH VSS VDDL}} {offset: {3 3}} {parameters: {M9 10 2 M8 10 2 false}}} \
-extension {{stop: design_boundary}}

compile_pg -strategies ring_strat -ignore_drc

create_pg_mesh_pattern mesh_pat \
-parameters {width1 width2 width3} \
-layers { {vertical_layer: M8} {width: @width1} {spacing: interleaving} {pitch: 180} } 

set_pg_strategy mesh_strat \
 -pattern {{pattern: mesh_pat} {nets: {VDDH VSS VDDL}} {parameters: 3 3 3}} \
  -core -extension {{stop: outermost_ring}}

compile_pg -strategies mesh_strat -ignore_drc


create_pg_std_cell_conn_pattern \
    std_cell_rail_va  \
    -layers {M1} \
    -rail_width 0.06

set_pg_strategy rail_strat_va -voltage_area PD_PISO_SECURE \
    -pattern {{name: std_cell_rail_va} {nets: piso_sw_out VSS} }

compile_pg -strategies rail_strat_va -ignore_drc

create_pg_std_cell_conn_pattern \
    std_cell_rail_default_va  \
    -layers {M1} \
    -rail_width 0.06

set_pg_strategy rail_strat_default_va -voltage_area DEFAULT_VA \
    -blockage {blocks: bit_secure_0 bit_secure_1 bit_secure_10 bit_secure_11 bit_secure_12 bit_secure_13 bit_secure_14 bit_secure_15 bit_secure_2 bit_secure_3 bit_secure_4 bit_secure_5 bit_secure_6 bit_secure_7 bit_secure_8 bit_secure_9} \
    -pattern {{name: std_cell_rail_default_va} {nets: VDDH VSS} }
compile_pg -strategies rail_strat_default_va

#source -e -v scripts/insert_power_switch.tcl


