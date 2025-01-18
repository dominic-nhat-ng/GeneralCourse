`timescale 1ns/1ns
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "interface.sv"
`include "transaction.sv"
`include "sequence.sv"
`include "sequencer_slave.sv"
`include "sequencer.sv"
`include "driver_slave.sv"
`include "driver.sv"
`include "monitor_slave.sv"
`include "monitor.sv"
`include "agent_slave.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"
module testbench;

    // Declare clock signal
    bit clk;

    // Instantiate the AXI interface
    axi_if intf(.clk(clk));

    // Instantiate the DUT
//      axi_slave dut (
//          // Clock and reset
//          .clk(intf.clk),
//          .resetn(intf.resetn),
//  
//          // Write address channel
//          .awvalid(intf.awvalid),
//          .awready(intf.awready),
//          .awid(intf.awid),
//          .awlen(intf.awlen),
//          .awsize(intf.awsize),
//          .awaddr(intf.awaddr),
//          .awburst(intf.awburst),
//  
//          // Write data channel
//          .wvalid(intf.wvalid),
//          .wready(intf.wready),
//          .wid(intf.wid),
//          .wdata(intf.wdata),
//          .wstrb(intf.wstrb),
//          .wlast(intf.wlast),
//  
//          // Write response channel
//          .bready(intf.bready),
//          .bvalid(intf.bvalid),
//          .bid(intf.bid),
//          .bresp(intf.bresp),
//  
//          // Read address channel
//          .arvalid(intf.arvalid),
//          .arready(intf.arready),
//          .arid(intf.arid),
//          .arlen(intf.arlen),
//          .arsize(intf.arsize),
//          .araddr(intf.araddr),
//          .arburst(intf.arburst),
//  
//          // Read data channel
//          .rvalid(intf.rvalid),
//          .rready(intf.rready),
//          .rid(intf.rid),
//          .rdata(intf.rdata),
//          //.rstrb(intf.rstrb),
//          .rlast(intf.rlast),
//          .rresp(intf.rresp)
//      );

    // Generate clock signal
    initial clk = 0;
    always #10 clk = ~clk;
    initial begin
        uvm_config_db#(virtual axi_if)::set(null, "*", "intf", intf);
    end

    initial begin
        fork
            //#10000 $finish;

            $dumpvars(0, testbench); // Include all variables in the testbench

            // Run the test
            run_test("axi_test");
        join
    end


endmodule
