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
    logic rstn;

    initial begin
        clk = 0;
        forever #10 clk = ~clk;
    end

    initial begin
        rstn = 1;
        repeat(2) @(posedge clk);
        rstn = 0;
    end

    ahb_intf intf(.HCLK(clk), .HRSTN(rstn));

    initial begin
        uvm_config_db#(virtual ahb_intf)::set(null, "*", "intf", intf);
    end

    AMBA_AHB ahb_ip(
        //common input
        .HCLK(intf.HCLK),
        .HRESETn(intf.HRSTN),
        //input of ip
        .HREADY(intf.HREADY),
        .HSEL(intf.HSEL),
        .HADDR(intf.HADDR),
        .HWDATA(intf.HWDATA),
        .HTRANS(intf.HTRANS),
        .HWRITE(intf.HWRITE),
        .HSIZE(intf.HSIZE),
        //output of ip
        .HREADYOUT(intf.HREADY),
        .HRESP(intf.HRESP),
        .HRDATA(intf.HRDATA)
    );

    initial begin
        run_test("ahb_test");
        // run_test("write_test");
        // run_test("read_test");
    end
    // initial begin
    //     $monitor("value stored at mem[%h]: %h", apb_ip.P_addr, apb_ip.P_wdata);
    // end
endmodule

