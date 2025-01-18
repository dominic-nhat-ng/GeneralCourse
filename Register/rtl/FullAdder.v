module Full_Adder(
  input clk,
  input rst,
  input [7:0] a,
  input [7:0] b,
  input cin,
  output reg cout,
  output reg [7:0] sum
);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      cout <= 0;
      sum <= 0;
    end
    else begin
      {cout, sum} <= a + b + cin;
    end
  end

endmodule

