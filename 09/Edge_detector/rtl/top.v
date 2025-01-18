module edge_detector(
    input  wire clk,
    input  wire rst_n,
    input  wire sig_in,
    output wire pulse_out_p,
    output wire pulse_out_n
);

    reg signal;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) signal <= 0;
        else signal <= sig_in;
    
    end

    assign pulse_out_p = sig_in & ~signal;
    assign pulse_out_n = ~sig_in & signal;
endmodule
