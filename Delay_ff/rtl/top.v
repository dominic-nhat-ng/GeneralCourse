module flipflop(
    input wire d_in, clk,
    input wire rstn,
    output reg q
);

    always @(posedge clk or negedge rstn) begin
        if (!rstn) begin
            q <= 0;
        end
        else q <= d_in;
    end
endmodule

// delay module

module delay_flipflop(
    input wire a,
    input wire clk,
    input wire rstn,
    output out

);
    wire b;

    flipflop ff1(.d_in(a), .clk(clk), .rstn(rstn), .q(b));
    flipflop ff2(.d_in(b), .clk(clk), .rstn(rstn), .q(out));



endmodule
