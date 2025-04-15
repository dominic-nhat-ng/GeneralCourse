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
//  FILE    : reset_sync.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

module reset_sync( reset, clk, reset_sync);

// INPUTS
input clk;
input reset;

// OUTPUTS
output reset_sync;

// REGS
reg reset_sync;
reg t_reset_sync;

always @(posedge clk or negedge reset) begin
  if (!reset) begin
    t_reset_sync <= 1'b0;
    reset_sync <= 1'b0; 
  end else begin
    t_reset_sync <= 1'b1;
    reset_sync <= t_reset_sync;
  end
end

endmodule
