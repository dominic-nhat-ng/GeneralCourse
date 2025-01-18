module full_adder_nbit #(parameter BIT_WIDTH = 32)(
    input wire [BIT_WIDTH - 1:0] a, b;
    output wire [BIT_WIDTH - 1: 0]sum;
    output wire [BIT_WIDTH - 1: 0] carry
);

    genvar i;
    generate
        for(i = 0; i < BIT_WIDTH; i++) begin
            full_adder dut(
                .a(a[i]),
                .b(b[i]),
                .sum(sum[i]),
                .cout(carry[i])
            )
        end

    endgenerate

endmodule

