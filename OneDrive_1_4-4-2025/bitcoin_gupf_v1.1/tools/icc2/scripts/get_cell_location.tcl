foreach_in_collection x $xs {                                          
   set cell_name [get_object_name $x] 
   set location [get_attribute [get_cell $cell_name] origin] 
   echo "set_attribute \[get_cell $cell_name\] origin \{$location\}" >> bs_cell_location.tcl
   set orientation [get_attribute [get_cell $cell_name] orientation]
   echo "set_attribute \[get_cell $cell_name\] orientation $orientation" >> bs_cell_location.tcl        
   } 
