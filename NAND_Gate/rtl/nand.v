module nandgate(
    input  a,
    input  b,
    output  out
);
    assign out = ~(a & b); // NAND operation

endmodule

