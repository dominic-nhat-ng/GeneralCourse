source -echo ./icc_setup.tcl
source -e -v scripts/library.tcl
sh rm -rf top_mw_design_lib_1
create_mw_lib -mw_reference_library $mw_reference_library -tech ./libs/libs/stdcell_hvt/tech/milkyway/saed90nm_icc_1p9m.tf top_mw_design_lib_1 -open
import_designs -format verilog -top top -cell top $results/${DESIGN_NAME}_compiled.v
link -f
source -e -v $results/${DESIGN_NAME}_compiled.upf
source -e -v upf/parent_iso.upf
associate_mv_cells
associate_mv_cells -verbose -isolation_cells
