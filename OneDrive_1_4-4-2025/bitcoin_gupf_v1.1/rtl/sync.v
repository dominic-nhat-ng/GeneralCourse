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
//  FILE    : sync.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

module sync (
  clk,
  reset,
  sync_in,
  sync_out
);

parameter width = 8;

// INPUTS
input clk;
input reset;
input [width-1:0] sync_in;

// OUTPUTS
output [width-1:0] sync_out;

// REGS
reg [width-1:0] sync_out;
reg [width-1:0] t_sync_out;

always @(posedge clk or negedge reset) begin 
  if (!reset) begin
    sync_out <= 0;
    t_sync_out <= 0;
  end else begin
    t_sync_out <= sync_in;
    sync_out <= t_sync_out;
  end
end 

endmodule
