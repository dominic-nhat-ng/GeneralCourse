`ifndef BITCOIN_TOP__SV
`define BITCOIN_TOP__SV

module bitcoin_top();

   logic hclk;
   logic lclk;
   logic rst;

   //SAIF Dumping
   logic end_of_saif;
   string saif_report;

   // Clock Generation
   parameter sim_cycle = 1000ps;
   
   // Reset Delay Parameter
   parameter rst_delay = 50;

   //UPF Related
   `ifdef UPF
     import UPF::*;
   `endif
   initial
    begin
    `ifdef UPF
        supply_on ("SS.power", 0.85);
        supply_on ("SSL.power", 0.78);
        supply_on ("SS.ground", 0.0);
        supply_on ("SSL.ground", 0.0);
        supply_on ("SS.ground", 0.0);
        supply_on ("SS_MEM_SW.ground", 0.0);
        supply_on ("VSS", 0.0);
    `endif
    end

   //FSDB Dumping
  `ifdef DUMP 
   initial $fsdbDumpvars;
   `ifdef VPD
     initial $vcdpluson;
   `endif
  `endif

  `ifndef NO_SAIF
   initial begin
      $value$plusargs("SAIF_REPORT=%s", saif_report);
      $saif_region_create("bitcoin", 0, dut);
      $saif_region_monitor("bitcoin", "start");
      $display("SAIF DUMPING START\n");
      @(end_of_saif);
      $display("SAIF DUMPING END\n");
      $saif_region_monitor("bitcoin", "stop");
      $saif_region_report("bitcoin", saif_report, 1e-12);
   end
  `endif

   always 
      begin
         #(sim_cycle/2) hclk = ~hclk;
      end
   always 
      begin
         #(sim_cycle/2) lclk = ~lclk;
      end
   btcoin_intf mon_if(lclk,rst);
   btcoin_intf drv_if(hclk,rst);

   //Temp fix
   assign mon_if.data_valid = drv_if.data_valid;
   assign mon_if.lp_enable = drv_if.lp_enable;
   assign mon_if.isolation_signals= drv_if.isolation_signals;
   assign mon_if.retention_signals= drv_if.retention_signals;
   assign mon_if.sleep_signals= drv_if.sleep_signals;
   assign mon_if.secure_data_in= drv_if.secure_data_in;
   
   tb_top test(); 
   
   bit_coin dut (.hclk(hclk && drv_if.lp_enable), .lclk(lclk && drv_if.lp_enable), .reset(rst), .data_valid(drv_if.data_valid && drv_if.lp_enable), .secure_data_in(drv_if.secure_data_in), .hash_key(drv_if.hash_key), .sleep_signals(drv_if.sleep_signals), .isolation_signals(drv_if.isolation_signals), .retention_signals(drv_if.retention_signals), .power_ack_signals(drv_if.power_ack_signals), .secure_data_out(mon_if.secure_data_out), .test_mode(1'b0), .scan_enable(1'b0), .sipo_scan_in(1'b0), .piso_scan_in(1'b0), .hv_scan_in(1'b0), .lv_scan_in(1'b0));  

//   bit_coin dut (hclk,lclk,reset,secure_data_in,hash_key,data_valid,sleep_signals,isolation_signals,retention_signals, test_mode, scan_enable, sipo_scan_in,piso_scan_in, hv_scan_in, lv_scan_in,sipo_scan_out,piso_scan_out, hv_scan_out,lv_scan_out,secure_data_out,memory_address,data_ready,power_ack_signals);
   //Driver reset depending on rst_delay
   initial
      begin
         hclk = 0;
         lclk = 1;
         rst = 1;
      #1 rst = 0;
         repeat (rst_delay) @(hclk);
         rst = 1'b1;
         @(hclk);
   end

endmodule: bitcoin_top

`endif // BITCOIN_TOP__SV
