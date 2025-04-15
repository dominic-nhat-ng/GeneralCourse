create_net -power VDD_high
create_net -power VDD_low
create_net -ground VSS
connect_pg_net -net VDD_high [get_pins -physical_context *VDD]
connect_pg_net -net VSS [get_pins -physical_context *VSS]


 create_pg_ring_pattern ring_pat -horizontal_layer @hlayer \
-horizontal_width {@hwidth} -horizontal_spacing {@hspace} \
-vertical_layer {@vlayer} -vertical_width {@vwidth} \
-vertical_spacing {@vspace} -corner_bridge @cbridge \
-parameters {hlayer hwidth hspace vlayer vwidth vspace cbridge }

 set_pg_strategy ring_strat -core \
-pattern {{name: ring_pat} {nets: {VDD_high VSS VDD_low}} {offset: {3 3}} {parameters: {M9 10 2 M8 10 2 false}}} \
-extension {{stop: design_boundary}}

compile_pg -strategies ring_strat -ignore_drc

create_pg_mesh_pattern mesh_pat -layers {
{{vertical_layer: M8} {width: @width8} {spacing: interleaving} {pitch: 30}  }
{{horizontal_layer: M9} {width: @width9} {spacing: interleaving} {pitch: 30}  }
{{horizontal_layer: M7} {width: @width7} {spacing: interleaving} {pitch: 30} }
} \
-parameters { width7 width8 width9 }

 set_pg_strategy mesh_strat -core -pattern {
{name: mesh_pat} {nets: {VDD_high VSS VDD_low}}
{parameters: {3  3 3}} } \
-extension {{stop: outermost_ring}}

compile_pg -strategies mesh_strat


