`timescale 1ns/1ns

module testbench;


    logic clk;
    logic rst_n;
    logic sig_in;
    logic pulse_out_p;
    logic pulse_out_n;
    
    
    edge_detector dut(.*);

    
    always #5 clk = ~clk;

    //initial begin
    //end
    //
    initial begin
        clk = 0;
        rst_n = 0;
        repeat(4) @(posedge clk);
        rst_n = 1;
        
        ///
        sig_in = 0;

        for(int i = 0; i < 10; i++) begin
            repeat(2) @(posedge clk);
            sig_in = 1;
            @(posedge clk)
            if (pulse_out_p == 1'b1) $display("PASS!!!");
            else $display("FAILED!!!");

            repeat(3) @(posedge clk);
            sig_in = 0;
            @(posedge clk);
            if (pulse_out_n == 1'b1) $display("PASS!!!");
            else $display("FAILED!!!");

            repeat(3) @(posedge clk);
        end

        $finish();
    end
endmodule
