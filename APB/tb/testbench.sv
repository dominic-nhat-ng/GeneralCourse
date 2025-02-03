`timescale 1ns/1ns
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "interface.sv"
`include "transaction.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environment.sv"
`include "test.sv"

module testbench;

    logic clk;
    logic rst;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rst = 1;
        repeat(2) @(posedge clk);
        rst = 0;
    end

    apb_intf intf(.clk(clk), .rst(rst));

    initial begin
        uvm_config_db#(virtual apb_intf)::set(null, "*", "intf", intf);
    end

    AMBA_APB apb_ip(
        //common input
        .P_clk(intf.clk),
        .P_rst(intf.rst),
        //input of ip
        .P_addr(intf.P_addr),
        .P_enable(intf.P_enable),
        .P_selx(intf.P_selx),
        .P_write(intf.P_write),
        .P_wdata(intf.P_wdata),
        //output of ip
        .P_ready(intf.P_ready),
        .P_slverr(intf.P_slverr),
        .P_rdata(intf.P_rdata)
    );

    initial begin
        run_test("random_test");
        // run_test("write_test");
        // run_test("read_test");
    end
    // initial begin
    //     $monitor("value stored at mem[%h]: %h", apb_ip.P_addr, apb_ip.P_wdata);
    // end
endmodule

