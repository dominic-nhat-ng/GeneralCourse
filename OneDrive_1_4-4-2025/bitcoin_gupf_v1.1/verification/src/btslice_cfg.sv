`ifndef BTSLICE_CFG__SV
`define BTSLICE_CFG__SV

class btslice_cfg extends uvm_object; 

   // Define test configuration parameters (e.g. how long to run)
   rand int num_trans;
   rand int num_scen;

   constraint cst_num_trans_default {
      num_trans inside {[1:7]};
   }
   constraint cst_num_scen_default {
      num_scen inside {[1:2]};
   }

   `uvm_object_utils_begin(btslice_cfg)
      `uvm_field_int(num_trans,UVM_ALL_ON) 
      `uvm_field_int(num_scen,UVM_ALL_ON)

   `uvm_object_utils_end

   extern function new(string name = "");
  
endclass: btslice_cfg

function btslice_cfg::new(string name = "");
   super.new(name);
endfunction: new


`endif // BTSLICE_CFG__SV
