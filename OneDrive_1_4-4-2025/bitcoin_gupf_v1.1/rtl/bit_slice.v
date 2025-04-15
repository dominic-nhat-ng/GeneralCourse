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
//  FILE    : bit_slice.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module bit_slice ( 
  hclk,
  lclk,
  reset,
  sin,
  data_valid,
  memory_sleep,
  shut_down_signals,
  isolation_signals,
  retention_signals,
  scan_enable,
  sipo_scan_in,
  piso_scan_in,
  hv_scan_in,
  lv_scan_in,
  sipo_scan_out,
  piso_scan_out,
  hv_scan_out,
  lv_scan_out,
  sout,
  memory_ack,
  PG_ack_signals
);

// INPUTS
input hclk;
input lclk;
input reset;
input sin;
input data_valid;
input memory_sleep;

// LP INPUTS
input [1:0] shut_down_signals;
input [1:0] isolation_signals;
input [1:0] retention_signals;

// DFT INPUTS
input scan_enable;
input sipo_scan_in;
input piso_scan_in;
input hv_scan_in;
input lv_scan_in;

// OUTPUT
output sout;

// LP OUTPUTS
output memory_ack;
output [1:0] PG_ack_signals;

// DFT OUTPUTS
output sipo_scan_out;
output piso_scan_out;
output hv_scan_out;
output lv_scan_out;

// WIRES AND REGS
wire [15:0]  pout2mem;
wire [15:0]  t_pout2mem;
wire [15:0]  din2piso;
wire [15:0]  t_din2piso;
wire [3:0]   pout_addr2mem;
wire [3:0]   t_pout_addr2mem;
wire [3:0]   pout_addr;
wire [1:0]   power_ack;
wire         wr;
wire         rd;
reg          temp_0;
reg          temp_1;
reg          temp_2;
reg          load_data_from_memory;

assign memory_ack = power_ack[0] | power_ack[1];

// RESET SYNC
reset_sync lreset_sync( .reset(reset), .clk(lclk), .reset_sync(lreset));
reset_sync hreset_sync( .reset(reset), .clk(hclk), .reset_sync(hreset));

// SIPO
sipo sipo_bit(
  .clk(lclk),
  .reset(lreset), 
  .data_valid(data_valid), 
  .sin(sin), 
  .shut_down_signals(shut_down_signals[0]), 
  .isolation_signals(isolation_signals[0]), 
  .retention_signals(retention_signals[0]), 
  .pout(t_pout2mem), 
  .addr(t_pout_addr2mem), 
  .wr(wr)
); 

// DATA SYNC
sync_wrapper #(.width(4))  sync_add2mem     (.clk(hclk), .reset(hreset), .din(t_pout_addr2mem), .dout(pout_addr2mem));
sync_wrapper #(.width(16)) sync_data2mem    (.clk(hclk), .reset(hreset), .din(t_pout2mem), .dout(pout2mem));
sync_wrapper #(.width(16)) sync_datafrommem (.clk(lclk), .reset(lreset), .din(t_din2piso), .dout(din2piso));

// BIT_SLICE MEMORIES
SRAM2RW16x4 nibble_0(
  .SLEEPIN(memory_sleep),
  .ACK(power_ack[0]),
  .A1(pout_addr2mem[3:0]),
  .A2(pout_addr2mem[3:0]),
  .CE1(hclk),
  .CE2(hclk),
  .WEB1(!wr),
  .WEB2(!wr),
  .OEB1(1'b0),
  .OEB2(1'b0),
  .CSB1(1'b0),
  .CSB2(1'b0),
  .I1(pout2mem[3:0]),
  .I2(pout2mem[7:4]),
  .O1(t_din2piso[3:0]),
  .O2(t_din2piso[7:4])
);

SRAM2RW16x4 nibble_1(
  .SLEEPIN(memory_sleep),
  .ACK(power_ack[1]),
  .A1(pout_addr2mem[3:0]),
  .A2(pout_addr2mem[3:0]),
  .CE1(hclk),
  .CE2(hclk),
  .WEB1(!wr),
  .WEB2(!wr),
  .OEB1(1'b0),
  .OEB2(1'b0),
  .CSB1(1'b0),
  .CSB2(1'b0),
  .I1(pout2mem[11:8]),
  .I2(pout2mem[15:12]),
  .O1(t_din2piso[11:8]),
  .O2(t_din2piso[15:12])
);

// PISO
piso piso_bit( 
  .din(din2piso),
  .clk(lclk),
  .reset(lreset),
  .load(load_data_from_memory),
  .shut_down_signals(shut_down_signals[1]),
  .isolation_signals(isolation_signals[1]),
  .retention_signals(retention_signals[1]),
  .dout(sout)
);

always @(posedge lclk or negedge lreset)
  begin
    if (!lreset) 
      begin
        temp_0 <= 0;
        temp_1 <= 0;
        temp_2 <= 0;
        load_data_from_memory <= 0;
      end
    else 
      begin
        temp_0 <= wr;
        temp_1 <= temp_0;
        temp_2 <= temp_1;
        load_data_from_memory <= temp_2;
      end
  end

endmodule
