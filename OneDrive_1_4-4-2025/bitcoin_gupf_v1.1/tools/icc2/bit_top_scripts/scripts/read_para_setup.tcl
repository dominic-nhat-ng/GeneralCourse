set G_MAX_TLUPLUS_FILE tech/star_rcxt/saed32nm_1p9m_Cmax.tluplus
set G_MIN_TLUPLUS_FILE tech/star_rcxt/saed32nm_1p9m_Cmin.tluplus
set G_TLUPLUS_MAP_FILE tech/milkyway/saed32nm_tf_itf_tluplus.map
set_app_options -list {mv.upf.upf_bias_support true}
set_app_options -list {mv.upf.upf_use_new_bias_leq true}
set_app_options -list {mv.upf.enable_nwell_only_support true}

set_app_options -list {mv.upf.multi_pd_single_va_strict_check false}

read_parasitic_tech  -name maxTLU  -tlup $G_MAX_TLUPLUS_FILE -layermap $G_TLUPLUS_MAP_FILE
read_parasitic_tech  -name minTLU  -tlup $G_MIN_TLUPLUS_FILE -layermap $G_TLUPLUS_MAP_FILE
set_app_option -as -list {constraint.convert_from_bc_wc wc_only}

