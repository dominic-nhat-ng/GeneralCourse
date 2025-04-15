set DESIGN_REF_PATH ../SAED_library/
#set DESIGN_REF_PATH /global/lynx_gts/SAED90NM.SNPS.A.2011_09_30.alpha/

set search_path      " \
        ${DESIGN_REF_PATH}/lib/stdcell_rvt/db_nldm \
        ${DESIGN_REF_PATH}/lib/stdcell_hvt/db_nldm 
        ${DESIGN_REF_PATH}/lib/stdcell_lvt/db_nldm \
	${DESIGN_REF_PATH}/lib/ram_leon/db_nldm \
	${DESIGN_REF_PATH}/lib/io_fc/db_nldm "


set ADDITIONAL_LINK_LIB_FILES     " \
SRAM22x32_max_pg.db \
SRAM39x32_max_pg.db \
SRAM32x64_max_pg.db \
SRAM32x256_1rw_max_pg.db \
SRAM8x1024_1rw_max_pg.db  \
SRAM22x32_max_hth_pg.db \
SRAM39x32_max_hth_pg.db \
SRAM32x64_max_hth_pg.db \
SRAM32x256_1rw_max_hth_pg.db \
SRAM8x1024_1rw_max_hth_pg.db \
saed90nm_io_max_fc.db "

set MIN_LIBRARY_FILES   " \
        saed90nm_max.db 		saed90nm_min_ltl.db \
        saed90nm_max_hvt.db 		saed90nm_min_ltl_hvt.db\
        saed90nm_max_lvt.db 		saed90nm_min_ltl_lvt.db\
	        saed90nm_max_hth.db  		saed90nm_min.db\
	        saed90nm_max_hth_hvt.db 	saed90nm_min_hvt.db\
	        saed90nm_max_hth_lvt.db 	saed90nm_min_lvt.db\
        saed90nm_max_cg.db 		saed90nm_min_ltl_cg.db\
        saed90nm_max_cg_hvt.db 		saed90nm_min_ltl_cg_hvt.db\
        saed90nm_max_cg_lvt.db 		saed90nm_min_ltl_cg_lvt.db\	
		saed90nm_max_hth_cg.db 		saed90nm_min_cg.db\
		saed90nm_max_hth_cg_hvt.db 	saed90nm_min_cg_hvt.db\
		saed90nm_max_hth_cg_lvt.db 	saed90nm_min_cg_lvt.db\
	SRAM22x32_max.db 	SRAM22x32_min_ltl.db	\
	SRAM39x32_max.db 	SRAM39x32_min_ltl.db 	\
 	SRAM32x64_max.db 	SRAM32x64_min_ltl.db	\
	SRAM32x256_1rw_max.db 	SRAM32x256_1rw_min_ltl.db \
	SRAM8x1024_1rw_max.db  	SRAM8x1024_1rw_min_ltl.db \
		SRAM22x32_max_hth.db SRAM22x32_min.db \
		SRAM39x32_max_hth.db SRAM39x32_min.db \
		SRAM32x64_max_hth.db SRAM32x64_min.db \
		SRAM32x256_1rw_max_hth.db SRAM32x256_1rw_min.db \
		SRAM8x1024_1rw_max_hth.db SRAM8x1024_1rw_min.db"


#HINT: See if any of these libs are necessary for your run?
set TARGET_LIBRARY_FILES ""
# set TARGET_LIBRARY_FILES    " \
# saed90nm_max.db \
# saed90nm_max_hvt.db \
# saed90nm_max_lvt.db \
# saed90nm_max_hth.db \
# saed90nm_max_hth_hvt.db \
# saed90nm_max_hth_lvt.db \
# saed90nm_max_cg.db \
# saed90nm_max_cg_hvt.db \
# saed90nm_max_cg_lvt.db \	
# saed90nm_max_hth_cg.db \
# saed90nm_max_hth_cg_hvt.db \
# saed90nm_max_hth_cg_lvt.db \
# saed90nm_max_hthn_lsh.db \
# saed90nm_max_hthn_hvt_lsh.db \
# saed90nm_max_hthn_lvt_lsh.db "

set TARGET_LIBRARY_FILES    " \
${TARGET_LIBRARY_FILES} \
saed90nm_max_rdsr.db \
saed90nm_max_hth_rdsr.db \
saed90nm_max_hvt_rdsr.db \
saed90nm_max_hth_hvt_rdsr.db \
saed90nm_max_lvt_rdsr.db \
saed90nm_max_hth_lvt_rdsr.db"



set link_library "${TARGET_LIBRARY_FILES} ${ADDITIONAL_LINK_LIB_FILES} ${MIN_LIBRARY_FILES}"


puts "\nINFO: SEARCH_PATH: $search_path"
puts "\nINFO: LINK_LIBRARY : $link_library"

