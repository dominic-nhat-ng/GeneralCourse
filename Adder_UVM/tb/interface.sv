
interface add_intf(input logic clk);
  // interface has all dut signals
  // declare with logic type
  // clock is generating and incoming from (testbench.sv) top
  // it is iput for interface 
  logic rst;
  logic [7:0] a;
  logic [7:0] b;
  logic cin;
  logic [7:0] sum;
  logic cout;
  
endinterface
