////////////////////////////////////////////////////////////////////////////////
//
//  This confidential and proprietary software may be used only
//  as authorized by a licensing agreement from Synopsys Inc.
//  In the event of publication, the following notice is applicable:
//
//  (C) COPYRIGHT 1994 - 2017 SYNOPSYS INC.
//  ALL RIGHTS RESERVED
//
//  The entire notice above must be reproduced on all authorized copies.
//
//  AUTHOR  : Godwin Maben
//
//  FILE    : sipo.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module sipo (
  clk,
  reset,
  data_valid,
  sin,
  shut_down_signals,
  isolation_signals,
  retention_signals,
  pout,
  addr,
  wr
); 

// INPUTS
input  clk;
input  reset;
input  sin;
input  data_valid;

// LP INPUTS
input  shut_down_signals;
input  isolation_signals;
input  retention_signals;

// OUTPUTS
output wr;
output [3:0] addr;
output [15:0] pout; 

// WIRES AND REGS
wire trd;
wire twr_tmp;
wire [3:0] taddr;
wire [15:0] tpout;

reg rd;
reg wr;
reg wr_0;
reg wr_1;
reg wr_2;
reg wr_3;
reg wr_tmp;
reg [3:0] addr;
reg [3:0] count;
reg [3:0] rd_addr;
reg [3:0] wr_addr;
reg [15:0] pout;
reg [15:0] tmp; 

assign tpout = tmp; 
assign twr_tmp = (&count[3:0]);
assign trd = !wr;
assign taddr = (rd) ? rd_addr:wr_addr;

always @(posedge clk or negedge reset) begin 
  if (!reset) begin
    tmp <= 0;
  end else begin 
    if (data_valid)
      tmp <= {tmp[14:0], sin}; 
  end
end 

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    count <= 0;
    wr_addr <= 0;
    rd_addr <= 4'b1111;
    wr <= 0;
    wr_0 <= 0;
    wr_1 <= 0;
  end else begin 
    if (data_valid) begin
      if (wr) begin
        wr_addr <= wr_addr+1;
        rd_addr <= rd_addr+1;
      end
      count <= count+1;
      wr_0 <= wr_tmp;
      wr_1 <= wr_0;
      wr <= wr_1;
    end
  end
end

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    pout <= 0;
    wr_tmp <= 0;
    rd <= 0;
    addr <= 0;
  end else begin
    pout <= tpout;
    wr_tmp <= twr_tmp;
    rd <= trd;
    addr <= taddr;
  end
end

endmodule
