`timescale 1ns/1ns
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "interface.sv"
`include "transaction.sv"
`include "sequence.sv"
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
    bit resetn;
    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        resetn = 0;
        repeat(2) @(posedge clk);
        resetn = 1;
    end

    axi_if intf(.clk(clk), .resetn(resetn));
    // Instantiate the AXI interface

    initial begin
        uvm_config_db#(virtual axi_if)::set(null, "*", "intf", intf);
    end

    initial begin
        run_test("axi_test");
    end


endmodule
