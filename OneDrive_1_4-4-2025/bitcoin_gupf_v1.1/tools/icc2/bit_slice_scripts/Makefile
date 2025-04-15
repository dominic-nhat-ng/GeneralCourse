##########################################################################################
# Tool: IC Compiler II
# Script: Makefile_pnr
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2015 Synopsys, Inc. All rights reserved.
##########################################################################################

ICC2_EXEC = icc2_shell -64
# ICC2_EXEC = /global/apps/icc2_2016.12-SP1/bin/icc2_shell -64
# ICC2_EXEC_NIGHTLY = /global/snps_apps5/icc2_2016.12-SP2-PRE-170127/bin/icc2_shell -64
LOGS_DIR = logs_icc2
OPTIONS =

## Optional: Specify design library if you want backup step and clean step to use it
## CAUTION: if added, the clean step will delete it
DESIGN_LIB =

console:
	$(ICC2_EXEC)

setup:
	test -d $(LOGS_DIR)	|| mkdir $(LOGS_DIR)
	date > setup

init_design: setup
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/init_design.tcl | tee -i $(LOGS_DIR)/init_design.log

place_opt: setup init_design
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/place_opt.tcl | tee -i $(LOGS_DIR)/place_opt.log

clock_opt_cts: setup place_opt
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/clock_opt_cts.tcl | tee -i $(LOGS_DIR)/clock_opt_cts.log

clock_opt_opto: setup clock_opt_cts
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/clock_opt_opto.tcl | tee -i $(LOGS_DIR)/clock_opt_opto.log

route_auto: setup clock_opt_opto
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/route_auto.tcl | tee -i $(LOGS_DIR)/route_auto.log

route_opt: setup route_auto
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/route_opt.tcl | tee -i $(LOGS_DIR)/route_opt.log

signoff_drc: setup route_opt
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/signoff_drc.tcl | tee -i $(LOGS_DIR)/signoff_drc.log

chip_finish: setup signoff_drc
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/chip_finish.tcl | tee -i $(LOGS_DIR)/chip_finish.log
rail_analysis: setup chip_finish
	$(ICC2_EXEC) $(OPTIONS) -f ./scripts/pr.tcl | tee -i $(LOGS_DIR)/pr.log
star: setup rail_analysis
	StarXtract scripts/bs_star.cmd
write_data: setup chip_finish 
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/write_data.tcl | tee -i $(LOGS_DIR)/write_data.log

all: write_data
	date > all

################################################################################################################
## Optional for Flat P&R (DESIGN_STYLE set to flat in icc2_common_setup.tcl)
################################################################################################################
pt_eco: setup route_opt
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/pt_eco.tcl | tee -i $(LOGS_DIR)/pt_eco.log

################################################################################################################
## Optional for Hierarchical P&R (DESIGN_STYLE set to hier in icc2_common_setup.tcl)
################################################################################################################
# For bottom and intermediate levels of hiearchical designs (PHYSICAL_HIERARCHY_LEVEL set to bottom or intermediate)
export: setup
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/export.tcl | tee -i $(LOGS_DIR)/export.log

write_data_for_etm: setup
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_pnr_scripts/write_data_for_etm.tcl | tee -i $(LOGS_DIR)/write_data_for_etm.log

################################################################################################################
# Utilities Section
################################################################################################################

##Backup
BACKUP  = BACKUP.`date "+%m_%d_%H_%M"`
backup:
	rm -rf $(BACKUP)
	mkdir -p $(BACKUP)
	cp -rf $(DESIGN_LIB) $(LOGS_DIR) $(BACKUP)

##Clean
clean:
	rm  -f setup init_design place_opt clock_opt_cts clock_opt_opto route_auto route_opt signoff_drc chip_finish write_data all pt_eco

clean_all: clean
	rm -rf $(LOGS_DIR) $(DESIGN_LIB)

