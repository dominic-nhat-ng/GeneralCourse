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
//  FILE    : piso.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module piso (
  din,
  clk,
  reset,
  load,
  shut_down_signals,
  isolation_signals,
  retention_signals,
  dout
);

// INPUTS
input clk;
input reset;
input load;
input [15:0] din;

// LP INPUTS
input shut_down_signals;
input isolation_signals;
input retention_signals;

// OUTPUTS
output dout;

// REGS
reg dout;
reg [15:0] temp;

always @ (posedge clk or negedge reset) 
begin
 if (!reset) begin
   temp <= 0;
   dout <= 0;
 end else if (load) begin
   temp <= din;
 end else begin
   dout <= temp[15];
   temp <= {temp[14:0],1'b0};
 end
end

endmodule
