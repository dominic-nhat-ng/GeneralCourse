module Full_Adder(
    input [1:0] a,
    input [1:0] b,
    input cin,
    output cout,
    output [1:0] sum
);
    assign {cout, sum} = a + b + cin;

endmodule

