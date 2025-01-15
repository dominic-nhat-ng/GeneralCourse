`timescale 1ns/1ns

module testbench;


logic clk, rst_n, sig_in, pulse_out_n, pulse_out_p;

edge_detector ed(.*);

always #5 clk = ~clk;

initial begin
	rst_n = 0;
	clk = 0;
	sig_in = 0;

	#20 rst_n = 1;

	#60;
	@(posedge clk);
	sig_in = 1;

	@(posedge clk);
	if (pulse_out_p == 1'b1) begin
		$display("-------------------------------------------------------------------------");
		$display("t = %10d PASS: rising edge is correct, pulse_out_p = 1'b%b, expect: 1'b1)", $time, pulse_out_p);
		$display("-------------------------------------------------------------------------");
	end
	else begin
		$display("-----------------------------------------------------------------------------");
		$display("t = %10d FAIL: rising edge is not correct, pulse_out_p = 1'b%b, expect: 1'b1)", $time, pulse_out_p);
		$display("-----------------------------------------------------------------------------");
	end

	#50;
	@(posedge clk);
	sig_in = 0;
	@(posedge clk);
	if(pulse_out_n == 1'b1) begin
		$display("-------------------------------------------------------------------------");
		$display("t = %10d PASS: falling edge is correct, pulse_out_p = 1'b%b, expect: 1'b1)", $time, pulse_out_n);
		$display("-------------------------------------------------------------------------");
	end
	else begin
		$display("-----------------------------------------------------------------------------");
		$display("t = %10d FAIL: falling edge is not correct, pulse_out_p = 1'b%b, expect: 1'b1)", $time, pulse_out_n);
		$display("-----------------------------------------------------------------------------");
	end

	#100;
	$finish;
end
endmodule
