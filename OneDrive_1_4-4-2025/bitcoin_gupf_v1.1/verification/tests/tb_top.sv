`ifndef TB_TOP__SV
`define TB_TOP__SV
`include "btcoin_intf.sv"  

module tb_top;

import uvm_pkg::*;

`include "bitcoin_env.sv"
`include "btcoin_test.sv"  
`include "btcoin_test_simple.sv"  
`include "btcoin_lp_test.sv"  
`include "btcoin_lp_test1.sv"  

   typedef virtual btcoin_intf v_if;


   initial begin
      uvm_config_db #(v_if)::set(null,"","mon_if",bitcoin_top.mon_if); 
      uvm_config_db #(v_if)::set(null,"","drv_if",bitcoin_top.drv_if);
      run_test();
   end
endmodule: tb_top

`endif // TB_TOP__SV

