##########################################################################################
# Tool: IC Compiler II
# Script: Makefile_dp_hier
# Version: L-2016.03 (April 4, 2016)
# Copyright (C) 2014-2015 Synopsys, Inc. All rights reserved.
##########################################################################################

#ICC2_EXEC = /u/nwtnmgr/image/L-2016.03-SP4/latest/Testing/bin/icc2_shell -64
#ICC2_EXEC = /global/apps/icc2_2016.03-SP4/bin/icc2_shell -64
#ICC2_EXEC = /u/nwtnmgr/image/L-2016.03-SP-DEV/latest/Testing/bin/icc2_shell -64
# ICC2_EXEC = /global/apps/icc2_2016.12-SP1/bin/icc2_shell -64
ICC2_EXEC = icc2_shell -64
LOGS_DIR = logs_icc2
OPTIONS = 

##Optional: Specify design library if you want backup step and clean step to use it
##CAUTION: if added, the clean step will delete it
DESIGN_LIB =

console:
	$(ICC2_EXEC)

setup:
	test -d $(LOGS_DIR)	|| mkdir $(LOGS_DIR)
	touch setup

split_constraints: setup
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/split_constraints.tcl | tee -i $(LOGS_DIR)/split_constraints.log

init_design: setup split_constraints
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/init_design.tcl | tee -i $(LOGS_DIR)/init_design.log

pre_shaping: setup init_design split_constraints
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/pre_shaping.tcl | tee -i $(LOGS_DIR)/pre_shaping.log

place_io: setup pre_shaping
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/place_io.tcl | tee -i $(LOGS_DIR)/place_io.log

shaping: setup place_io 
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/shaping.tcl | tee -i $(LOGS_DIR)/shaping.log

placement: setup shaping 
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/placement.tcl | tee -i $(LOGS_DIR)/placement.log

create_power: setup placement
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/create_power.tcl | tee -i $(LOGS_DIR)/create_power.log

place_pins: setup create_power
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/place_pins.tcl | tee -i $(LOGS_DIR)/place_pins.log

pre_timing: setup place_pins
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/pre_timing.tcl | tee -i $(LOGS_DIR)/pre_timing.log

timing_estimation: setup pre_timing
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/timing_estimation.tcl | tee -i $(LOGS_DIR)/timing_estimation.log

budgeting: setup timing_estimation
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/budgeting.tcl | tee -i $(LOGS_DIR)/budgeting.log

write_data: setup budgeting
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/write_data.tcl | tee -i $(LOGS_DIR)/write_data.log

all: setup write_data
	date > all


################################################################################################################
# Utilities Section
################################################################################################################
export: setup
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/export.tcl | tee -i $(LOGS_DIR)/export.log
view_copy:
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/view_copy.tcl | tee -i $(LOGS_DIR)/view_copy.log

view_in_place:
	$(ICC2_EXEC) $(OPTIONS) -f ./rm_icc2_dp_scripts/view_in_place.tcl | tee -i $(LOGS_DIR)/view_in_place.log

##Backup
BACKUP  = BACKUP.`date "+%m_%d_%H_%M"`
backup:
	rm -rf $(BACKUP)
	mkdir -p $(BACKUP)
	cp -rf $(DESIGN_LIB) $(LOGS_DIR) $(BACKUP)

clean:
	rm -rf init_design pre_shaping place_io shaping placement create_power place_pins pre_timing timing_estimation budgeting write_data export all
	rm -rf *.err *.log

clean_all: clean
	rm -rf setup split_constraints $(LOGS_DIR) ./rpts_icc2 ./outputs_icc2 ./images ./split ./block_budgets ./flat_place_and_route
	rm -rf icc2_output.txt ./block_pg ./pgroute_output ./work ./work_dir 
