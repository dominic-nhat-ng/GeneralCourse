set_operating_conditions tt0p85v125c

set_voltage 0.85 -object_list {SS.power}
set_voltage 0.0  -object_list {SS.ground}
set_voltage 0.78 -object_list {SSL.power}
set_voltage 0.0  -object_list {SSL.ground}
set_voltage 0.78 -object_list {SSL_SIPO_SLICE_SW.power}
set_voltage 0.78 -object_list {SSL_PISO_SLICE_SW.power}

for {set i 0} {$i < 32} {incr i} {
  set_voltage 0.78 -object_list slice_${i}/SSL_SIPO_SW.power
  set_voltage 0.78 -object_list slice_${i}/SSL_PISO_SW.power
  set_voltage 0.85 -object_list slice_${i}/SS_MEM_SW.power
}

