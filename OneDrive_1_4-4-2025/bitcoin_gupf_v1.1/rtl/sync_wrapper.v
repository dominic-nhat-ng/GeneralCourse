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
//  FILE    : sync_wrapper.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

module sync_wrapper (clk,reset,din, dout);

parameter width = 1;

// INPUTS
input clk;
input reset;
input [width-1:0] din;

// OUTPUT
output [width-1:0] dout;

// SYNC
sync #(.width(width)) dut_sync (
  .clk(clk),
  .reset(reset),
  .sync_in(din),
  .sync_out(dout)
);

endmodule
