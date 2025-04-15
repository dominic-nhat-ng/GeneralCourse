`ifndef BITSLICE_TOP__SV
`define BITSLICE_TOP__SV

module bitslice_top();

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
        // need to modify for golden UPF flow 
        //supply_on ("VSS", 0.0);
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
      $saif_region_create("bitslice", 0, dut);
      $saif_region_monitor("bitslice", "start");
      $display("SAIF DUMPING START\n\n");
      @(end_of_saif);
      $display("SAIF DUMPING END\n\n");
      $saif_region_monitor("bitslice", "stop");
      $saif_region_report("bitslice", saif_report, 1e-12);
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
   btslice_intf mon_if(lclk,rst);
   btslice_intf drv_if(hclk,rst);

   //Temp fix
   assign mon_if.data_valid = drv_if.data_valid;
   assign mon_if.shut_down_signals = drv_if.shut_down_signals;
   assign mon_if.isolation_signals= drv_if.isolation_signals;
   assign mon_if.retention_signals= drv_if.retention_signals;
   assign mon_if.memory_sleep= drv_if.memory_sleep;
   assign mon_if.sin= drv_if.sin;
   
   tb_top test(); 
   
   bit_slice dut (.hclk(hclk), .lclk(lclk), .reset(rst), .data_valid(drv_if.data_valid), .sin(drv_if.sin),.memory_sleep(drv_if.memory_sleep), .shut_down_signals(drv_if.shut_down_signals), .isolation_signals(drv_if.isolation_signals), .retention_signals(drv_if.retention_signals), .memory_ack(drv_if.memory_ack), .sout(mon_if.sout), .PG_ack_signals(drv_if.PG_ack_signals), .scan_enable(1'b0), .sipo_scan_in(1'b0), .piso_scan_in(1'b0), .hv_scan_in(1'b0), .lv_scan_in(1'b0));  

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

endmodule: bitslice_top

`endif // BITSLICE_TOP__SV
