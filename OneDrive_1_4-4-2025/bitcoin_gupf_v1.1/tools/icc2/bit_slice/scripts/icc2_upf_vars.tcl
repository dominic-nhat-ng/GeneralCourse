#mv.hierarchical.apply_parent_domain_for_block_without_upf
#mv.incomplete_upf.enable
#mv.incomplete_upf.iso_infer_csn_rule
#mv.incomplete_upf.ls_infer_csn_rule
#mv.incomplete_upf.psw_infer_csn_rule
#mv.incomplete_upf.ret_infer_csn_rule
#mv.upf.check_vio_between_top_port_and_pad
#mv.upf.connect_missing_backup_to_domain_primary
#mv.upf.connect_supply_net_ignore_nonexistent_objects
#mv.upf.derive_unknown_supply_net_type_by_pg_nets
#mv.upf.disable_bias_polarity_check
#mv.upf.enable_pg_pin_reconnection
#mv.upf.enable_size_only_on_hier_pins
#mv.upf.expand_wildcard_in_pst
#mv.upf.infer_csn_from_pg_nets_only
#mv.upf.input_enforce_simple_names
#mv.upf.load_upf_continue_on_error
#mv.upf.load_upf_object_name_strict_check
#mv.upf.load_upf_tcl_variables_inheritance
#mv.upf.max_supply_count_without_driver
#mv.upf.multi_pd_single_va_strict_check
#mv.upf.mvft_no_dash_update
#mv.upf.name_change_disable_cstr_tracking
#mv.upf.name_map_version
#mv.upf.save_upf_include_supply_exceptions
#mv.upf.semantic_error_cause_tcl_error
#mv.upf.snps_handle_physical_only
#mv.upf.upf_bias_support
#mv.upf.use_domain_primary_for_macro_pins
#mv.upf.use_preswitched_supply_for_macro_pins
#mv.upf.write_crosstool_no_upf_update_command
#mv.upf.write_crosstool_wrappers 
#plan.estimate_timing.honor_upf
#
set_app_options -name mv.upf.enable_pg_pin_reconnection -value 1
set_app_options -name mv.hierarchical.apply_parent_domain_for_block_without_upf -value 1
set_app_options -name mv.upf.enable_golden_upf -value true

