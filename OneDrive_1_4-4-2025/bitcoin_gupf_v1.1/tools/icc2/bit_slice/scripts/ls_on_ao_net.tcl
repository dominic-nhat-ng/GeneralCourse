set search_path ". ./libs ./libs/stdcell_hvt/db_nldm/ ./libs/stdcell_hvt/tech/milkyway/ ./libs/stdcell_hvt/tech/star_rcxt/ ./libs/stdcell_hvt/milkyway/"

set target_library "./libs/stdcell_hvt/db_nldm/saed90nm_max_hth_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hth_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hth_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hth_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hthh_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hthm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hthn_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htln_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htm_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htm_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htm_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htm_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_htmm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lt_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lt_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lt_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lt_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lt_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lth_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lth_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lth_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lth_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lth_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lthh_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lthm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_lthn_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltln_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltm_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltm_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltm_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltm_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ltmm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nt_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nt_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nt_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nt_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nt_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nth_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nth_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nth_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nth_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nth_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nthh_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nthm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_nthn_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ntln_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_ntmm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_rdr_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_tm_cg_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_tm_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_tm_hvt_rdsr.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_tm_rd_hvt.db ./libs/stdcell_hvt/db_nldm/saed90nm_max_tm_rdr_hvt.db"


set link_library "* $target_library"


set mw_reference_library "./libs/stdcell_hvt/milkyway/saed90nm_hvt"

sh rm -rf design_ft

create_mw_lib -mw_reference_library $mw_reference_library -tech ./libs/stdcell_hvt/tech/milkyway/saed90nm_icc_1p9m.tf design_ft -open

read_verilog ./sen_mod.v

current_design TOP

link

set_tlu_plus_files -max_tluplus ./libs/stdcell_hvt/tech/star_rcxt/saed90nm_1p9m_1t_Cmax.tluplus -tech2itf_map ./libs/stdcell_hvt/tech/star_rcxt/tech2itf.map

source -e -v ./upf/siva.upf

set mv_no_main_power_violations false

return

insert_mv_cells -verbose -all
