read_power_intent -upf  upf/top_scope_2.0.upf
read_verilog -file [glob rtl/*.v]
create_mv_db -top top
read_db
report_power_intent -file reports/mvrc_power_intent.rpt
report_protection -critique -file reports/mvrc_protection.rpt
report_architecture -file reports/mvrc_arch.rpt
report_order
exit
