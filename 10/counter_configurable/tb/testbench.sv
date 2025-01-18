`timescale 1ns/1ns

module testbench;
    parameter CNT_W = 16;
    reg clk,rst_n;
    wire [CNT_W - 1:0] count;
    wire overflow;

    counter #(.COUNT_W(CNT_W)) dut(.*);

    integer expect_count;
    initial begin 
  	  clk = 0;
  	  forever #25 clk = ~clk;
  	end

  	initial begin
  	    rst_n = 1'b0;

        #100;
        if( count !== {CNT_W{1'b0}} ) begin
			    $display("------------------------------------------------");
			    $display("t=%10d FAIL: the init value of counter is not %d'h0",$time, CNT_W);
			    $display("------------------------------------------------");
                #100;
                $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: the init value of counter is %d'h0.", $stime, CNT_W);
			$display("------------------------------------------------");

		end
        
        #10;

        @(negedge clk);

        rst_n = 1'b1;
		
        repeat ({CNT_W{1'b1}}) begin
			@(posedge clk);
		end
        #1;
		if( count !== {CNT_W{1'b1}} ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter value is not correct, count = %2h , expect: %d'b1111",$stime,count, CNT_W );
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter value is correct,%d'b1111",$stime, CNT_W);
			$display("------------------------------------------------");
		end
		
        if( overflow !== 1'b1) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: overflow is not asserted",$stime);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: overflow is asserted",$stime);
			$display("------------------------------------------------");
		end
		@(posedge clk);
        #1;
		if( overflow == 1'b1) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: overflow is not negated",$stime);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: overflow is negated",$stime);
			$display("------------------------------------------------");
		end
		if( count !== {CNT_W{1'b0}} ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter value is not init to %d'h0 after overflow. count = %2h , expect: %d'h0",$stime,CNT_W, count, CNT_W);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter value is %d'h0 after overflow",$stime, CNT_W );
			$display("------------------------------------------------");
		end

        $display("----------------------------------------------------");
        $display("t=%10d Value of count that this time is: %d", $stime, count);
        $display("----------------------------------------------------");

		repeat (10) begin
			@(posedge clk);
		end
        #1;
		expect_count = 10;
		if( count !== expect_count ) begin
			$display("------------------------------------------------");
			$display("t=%10d FAIL: counter value is not correct, count = %2h , expect: %d'b%b",$stime,count, CNT_W , expect_count);
			$display("------------------------------------------------");
            #100;
            $finish;
		end else begin
			$display("------------------------------------------------");
			$display("t=%10d PASS: counter value is correct - %d'ha",$stime, CNT_W );
			$display("------------------------------------------------");
		end
        #100;

        $finish;
  	end




endmodule
