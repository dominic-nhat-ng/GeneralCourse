connect_pg_net
connect_pg_net -net VDDH [get_pins -physical_context *VDDH]
connect_pg_net -net VDDL [get_pins -physical_context *VDDL]
connect_pg_net -net VSS [get_pins -physical_context *VSS]


 create_pg_ring_pattern ring_pat -horizontal_layer @hlayer -horizontal_width {@hwidth} -horizontal_spacing {@hspace} -vertical_layer {@vlayer} -vertical_width {@vwidth} -vertical_spacing {@vspace} -corner_bridge @cbridge -parameters {hlayer hwidth hspace vlayer vwidth vspace cbridge }

 set_pg_strategy ring_strat -core -pattern {{name: ring_pat} {nets: {VDDH VSS VDDL}} {offset: {3 3}} {parameters: {M9 10 2 M8 10 2 false}}} -extension {{stop: design_boundary}}

compile_pg -strategies ring_strat -ignore_drc


#####################################################
remove_routes -stripe
remove_pg_regions -all
remove_pg_patterns -all
remove_routes -lib_cell_pin_connect

create_pg_region pp_region1 -polygon {{70.000 0.000} {70.000 2499.320} {1708.912 2499.320} {1708.912 0.000} }
create_pg_region pp_region2 -polygon {{1708.912 0.000} {1708.912 2499.320} {3347.824 2499.320} {3347.824 0.000} }
create_pg_region pp_region3 -polygon {{3347.824 0.000} {3347.824 2499.320} {4986.736 2499.320} {4986.736 0.000} }
create_pg_region pp_region4 -polygon {{4986.736 0.000} {4986.736 2493.856} {6625.648 2493.856} {6625.648 0.000} }
create_pg_region pp_region0 -polygon {{50.000 0.000} {50.000 2499.320} {70.000 2499.320} {70.000 0.000} }
create_pg_region pp_region5 -polygon {{6625.648 0.000} {6625.648 2493.856} {7052.904 2493.856} {7052.904 0.000} }




set pp_regions {pp_region1 pp_region2 pp_region3 pp_region4 pp_region0 pp_region5}

create_pg_mesh_pattern mesh_pat1 \
-parameters {width1 off1} \
-layers { {vertical_layer: M8} {width: @width1} {offset: @off1} {spacing: 2} {pitch: 200} }

create_pg_mesh_pattern mesh_pat2 \
-parameters {width1 off2} \
-layers { {vertical_layer: M8} {width: @width1} {offset: @off2} {spacing: 2} {pitch: 200} }

create_pg_mesh_pattern mesh_pat3 \
-parameters {width1 off2} \
-layers { {vertical_layer: M8} {width: @width1} {offset: @off2} {spacing: 2} {pitch: 200} }

set off1 30
set off2 160

foreach pp_region $pp_regions {


set_pg_strategy mesh_strat1 \
  -pg_regions $pp_region \
  -pattern {{pattern: mesh_pat1} {nets: {VDDH VSS VDDL}} {parameters: 3 104} } \
  -extension {{stop: outermost_ring}}

set_pg_strategy mesh_strat2 \
  -pg_regions $pp_region \
  -pattern {{pattern: mesh_pat2} {nets: {VDDH VSS VDDL}} {parameters: 3 170} } \
  -extension {{stop: outermost_ring}}

set_pg_strategy mesh_strat3 \
  -pg_regions $pp_region \
  -pattern {{pattern: mesh_pat3} {nets: {VDDH VSS VDDL}} {parameters: 3 40} } \
  -extension {{stop: outermost_ring}}

  compile_pg -strategies {mesh_strat1 mesh_strat2 mesh_strat3} -ignore_drc
  #compile_pg -strategies {mesh_strat1 } -ignore_drc
}
#######################################################################



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
