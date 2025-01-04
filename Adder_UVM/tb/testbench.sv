`timescale 1ns/1ns
import uvm_pkg::*;

`include "uvm_macros.svh"
`include "interface.sv"
`include "seq_item.sv"
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
  
  add_intf intf(.clk(clk)); 
  
  

  Full_Adder dut(
    .clk(intf.clk),
    .rst(intf.rst),
    .a(intf.a),
    .b(intf.b),
    .cin(intf.cin),
    .cout(intf.cout),
    .sum(intf.sum)
  );
  
  initial begin
  uvm_config_db#(virtual add_intf)::set(null, "*", "intf", intf);
end


  
  
  initial clk = 0;
  always #2 clk = ~clk;  
    
  // Testbench logic
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars(0);
    $monitor("[%0d] clk = %0d", $time, clk);
    #100
    $finish();
  end
  
  initial begin 
    run_test("adder_test");
  end
endmodule

