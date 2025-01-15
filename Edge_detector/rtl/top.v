module edge_detector(
    input  wire clk,
    input  wire rst_n,
    input  wire sig_in,
    output reg pulse_out_p,
    output reg pulse_out_n
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pulse_out_n <= 0;
            pulse_out_p <= 0;
        end
        @(posedge sig_in) begin
            pulse_out_p <= 1;
            @(posedge clk) begin
                pulse_out_p <= 0;
            end
        end

        @(negedge sig_in) begin
            pulse_out_n <= 1;
            @(posedge clk) begin
                pulse_out_n <= 0;
            end
        end
    end
endmodule
