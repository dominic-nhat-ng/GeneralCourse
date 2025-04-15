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
//  FILE    : secure_data.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module secure_data (
  clk,
  reset,
  data_in,
  hash_key,
  secure_data_out
);

// INPUTS
input clk;
input reset;
input [1:0] data_in;
input [31:0] hash_key;

// OUTPUTS
output [15:0] secure_data_out;

// REG
reg [15:0] secure_data_out;

// "HASH"
always @(posedge clk or negedge reset) begin
  if (!reset)
    secure_data_out<=0;
  else begin 
    secure_data_out[0] <= data_in[0] ^ hash_key[31] ^ hash_key[0] & data_in[1];
    secure_data_out[1] <= data_in[0] ^ hash_key[30] ^ hash_key[1] | data_in[1];
    secure_data_out[2] <= data_in[0] ^ hash_key[29] ^ hash_key[2] & data_in[1];
    secure_data_out[3] <= data_in[0] ^ hash_key[28] ^ hash_key[3] & data_in[1];
    secure_data_out[4] <= data_in[0] ^ hash_key[27] ^ hash_key[4] & data_in[1];
    secure_data_out[5] <= data_in[0] ^ hash_key[26] ^ hash_key[5] & data_in[1];
    secure_data_out[6] <= data_in[0] ^ hash_key[25] ^ hash_key[6] & data_in[1];
    secure_data_out[7] <= data_in[0] ^ hash_key[24] ^ hash_key[7] & data_in[1];
    secure_data_out[8] <= data_in[0] ^ hash_key[23] ^ hash_key[8] & data_in[1];
    secure_data_out[9] <= data_in[0] ^ hash_key[22] ^ hash_key[9] & data_in[1];
    secure_data_out[10] <= data_in[0] ^ hash_key[21] ^ hash_key[10] & data_in[1];
    secure_data_out[11] <= data_in[0] ^ hash_key[20] ^ hash_key[11] & data_in[1];
    secure_data_out[12] <= data_in[0] ^ hash_key[19] ^ hash_key[12] & data_in[1];
    secure_data_out[13] <= data_in[0] ^ hash_key[18] ^ hash_key[13] & data_in[1];
    secure_data_out[14] <= data_in[0] ^ hash_key[17] ^ hash_key[14] & data_in[1];
    secure_data_out[15] <= data_in[0] ^ hash_key[16] ^ hash_key[15] & data_in[1];
  end
end

endmodule
