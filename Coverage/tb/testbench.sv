`timescale 1ns/1ns

module testbench;
    reg     [1:0] a;
    wire    [1:0] b;

    covergroup cvr_a;
        coverpoint a;
        coverpoint b;
    endgroup

    cvr_a ci = new();

    initial begin
        for(int i = 0; i < 10; i++) begin
            a = $urandom();
            ci.sample();
            #10;
        end
    end

    initial begin
        #500;
        $finish();
    end

endmodule
