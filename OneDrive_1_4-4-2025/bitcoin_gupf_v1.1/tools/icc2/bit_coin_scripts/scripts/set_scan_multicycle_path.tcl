foreach_in_collection m [all_scenario] {
    current_scenario $m
    set_multicycle_path 5 -hold -end -through [get_ports *scan*in]
    set_multicycle_path 5 -setup -through [get_ports *scan*in]
    set_multicycle_path 5 -hold -end -through [get_ports *scan*out]
    set_multicycle_path 5 -setup -through [get_ports *scan*out]
}

