`timescale 1ns/1ns

module testbench;

    logic d_in;
    logic clk;
    logic rstn;
    logic q;

    delay_flipflop u_dut(.a(d_in), .clk(clk), .rstn(rstn), .out(q));

    initial begin
        d_in = 1;


        @(posedge clk);
        $display("%t first clk: a: %b | b: %b | c: %b", $time, d_in, testbench.u_dut.b, q);
        d_in = 0;
        @(posedge clk);
        $display("%t second clk: a: %b | b: %b | c: %b", $time, d_in, testbench.u_dut.b, q);
        @(posedge clk);
        $display("%t third clk: a: %b | b: %b | c: %b", $time, d_in, testbench.u_dut.b, q);
        
        @(posedge clk);
        $display("%t fourth clk: a: %b | b: %b | c: %b", $time, d_in, testbench.u_dut.b, q);
        #100;
        $finish();
    end
    
    initial begin 
  	  clk = 0;
  	  forever #5 clk = ~clk;
  	end

  	initial begin
  	  rstn = 1'b0;
  	  #5 rstn = 1'b1;
  	end


endmodule
