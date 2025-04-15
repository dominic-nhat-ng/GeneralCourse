`ifndef TB_TOP__SV
`define TB_TOP__SV
`include "btslice_intf.sv"  

module tb_top;

import uvm_pkg::*;

`include "bitslice_env.sv"
`include "btslice_test.sv"  
`include "btslice_lp_test.sv"  

   typedef virtual btslice_intf v_if;


   initial begin
      uvm_config_db #(v_if)::set(null,"","mon_if",bitslice_top.mon_if); 
      uvm_config_db #(v_if)::set(null,"","drv_if",bitslice_top.drv_if);
      run_test();
   end
endmodule: tb_top

`endif // TB_TOP__SV

