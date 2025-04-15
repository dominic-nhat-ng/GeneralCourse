for {set a 0} {$a<63} {incr a} {
create_rp_group group_a_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_a_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_a_q_${a}
        echo "search_hash_hash1_a_q${a}_reg_${i}_"
        echo "group_a_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_b_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_b_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_b_q_${a}
        echo "search_hash_hash1_b_q${a}_reg_${i}_"
        echo "group_b_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_c_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_c_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_c_q_${a}
        echo "search_hash_hash1_c_q${a}_reg_${i}_"
        echo "group_c_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_d_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_d_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_d_q_${a}
        echo "search_hash_hash1_d_q${a}_reg_${i}_"
        echo "group_d_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_e_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_e_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_e_q_${a}
        echo "search_hash_hash1_e_q${a}_reg_${i}_"
        echo "group_e_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_f_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_f_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_f_q_${a}
        echo "search_hash_hash1_f_q${a}_reg_${i}_"
        echo "group_f_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_g_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_g_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_g_q_${a}
        echo "search_hash_hash1_g_q${a}_reg_${i}_"
        echo "group_g_q_${a}"
        }
}

for {set a 0} {$a<63} {incr a} {
create_rp_group group_h_q_${a} -design arm2_top -columns 1 -rows 32
for {set i 0} {$i<31} {incr i} {
        add_to_rp_group -leaf [get_cells -hier search_hash_hash1_h_q${a}_reg_${i}_] -col 0 -row $i arm2_top::group_h_q_${a}
        echo "search_hash_hash1_h_q${a}_reg_${i}_"
        echo "group_h_q_${a}"
        }
}

