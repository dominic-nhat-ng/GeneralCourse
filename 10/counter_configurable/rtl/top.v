module counter #(parameter COUNT_W = 16)
(
    input  wire clk,
    input  wire rst_n,
    output reg [COUNT_W - 1:0]count,
    output wire overflow
);
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            count <= {COUNT_W{1'b0}};
        end
            
        else if (count == {COUNT_W{1'b1}}) begin
            count <= {COUNT_W{1'b0}};
        end
        else begin
            count <= count + 1'b1;
        end

    end

    assign overflow = 1 ? (count == {COUNT_W{1'b1}}) : 0;
endmodule
