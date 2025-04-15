# File added as part of PowerKit_L2016.06_v1

# Synthesis command to enable multi process synthesis
syn_set_global_option enable_multi_process 2
# Synthesis command to control maximum number of parallel synth process
syn_set_global_option max_core_count_for_multi_process 4

# To enable new ABC engine
# Disabled by default i.e old ABC engine is used
# Enable only under product team guidance.
# Usefull in case of Syntheis crash or Higher synth Area with old ABC
##syn_set_global_option select_new_ABC 1
