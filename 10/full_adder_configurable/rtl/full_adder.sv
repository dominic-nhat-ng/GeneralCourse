module full_adder(
    input a,
    input b,
    input cin,
    output cout,
    output sum
);
    reg carry[1:0];
    half_adder ha1(.a(a), .b(b), .sum(sum), .carry(carry[0])); // sum = a^b, carry[0] = a&b
    half_adder ha2(.sum(sum), .b(cin), .sum(sum), .carry(carry[1]); // sum = a^b^cin, carry[1] = a^b & cin
    assign cout = carry[0] | carry[1];

endmodule

