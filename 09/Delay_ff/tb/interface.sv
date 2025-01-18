interface add_intf();
  // interface has all dut signals
  // declare with logic type
  // clock is generating and incoming from (testbench.sv) top
  // it is iput for interface 
  logic [1:0] a;
  logic [1:0] b;
  logic cin;
  logic [1:0] sum;
  logic cout;
  
endinterface

