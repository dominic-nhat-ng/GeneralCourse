read_power_intent -upf  results/top_compiled.upf
read_verilog -file results/top_compiled.v
create_mv_db -top top
read_db
report_power_intent -file reports/mvrc_power_intent_syn.rpt
report_protection -critique -file reports/mvrc_protection_syn.rpt
report_architecture -file reports/mvrc_arch_syn.rpt
report_order
exit
