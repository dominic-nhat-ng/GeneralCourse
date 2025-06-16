`timescale 1ns/1ps
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

    dut_if intf(.pclk(clk), .presetn(rst));

    initial begin
        uvm_config_db#(virtual dut_if)::set(null, "*", "intf", intf);
    end

    AMBA_APB apb_ip(
        //common input
        .P_clk(clk),
        .P_rst(rst),
        //input of ip
        .P_addr(intf.paddr),
        .P_enable(intf.penable),
        .P_selx(intf.psel),
        .P_write(intf.pwrite),
        .P_wdata(intf.pwdata),
        //output of ip
        .P_ready(intf.pready),
        .P_slverr(intf.pslverr),
        .P_rdata(intf.prdata)
    );

    initial begin
        run_test("apb_test");
        // run_test("write_test");
        // run_test("read_test");
    end
    // initial begin
    //     $monitor("value stored at mem[%h]: %h", apb_ip.P_addr, apb_ip.P_wdata);
    // end
endmodule

