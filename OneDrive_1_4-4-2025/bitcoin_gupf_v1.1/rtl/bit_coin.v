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
//  FILE    : bit_coin.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module bit_coin (
  hclk,
  lclk,
  reset,
  secure_data_in,
  hash_key,
  data_valid,
  sleep_signals,
  isolation_signals,
  retention_signals,
  test_mode,
  scan_enable,
  sipo_scan_in,
  piso_scan_in,
  hv_scan_in,
  lv_scan_in,
  sipo_scan_out,
  piso_scan_out,
  hv_scan_out,
  lv_scan_out,
  secure_data_out,
  memory_address,
  data_ready,
  power_ack_signals
);

// INPUTS
input hclk;
input lclk;
input reset;
input data_valid;
input [31:0] secure_data_in;
input [31:0] hash_key;

// DFT INPUTS
input test_mode;
input scan_enable;
input sipo_scan_in;
input piso_scan_in;
input hv_scan_in;
input lv_scan_in;

// LP INPUTS
input [17:0] sleep_signals;
input [1:0] isolation_signals;
input [1:0] retention_signals;

// OUTPUTS
output data_ready;
output [31:0] secure_data_out;
output [63:0] memory_address;

// LP OUTPUTS
output [20:0] power_ack_signals;

// DFT OUTPUTS
output sipo_scan_out;
output piso_scan_out;
output hv_scan_out;
output lv_scan_out;

// WIRES AND REGS
wire lreset;
wire hreset;
wire [1:0] sout;
wire [1:0] sout_sync;
wire [15:0] hash_data_out;
wire [15:0] t_hash_data_out;
wire [31:0] t_ack_signals;
wire [31:0] switch_ack_signal;

// DATA READY OUTPUT
assign data_ready = ^secure_data_out;

// RESET SYNCS
reset_sync lreset_sync ( .reset(reset), .clk(lclk), .reset_sync(lreset) );
reset_sync hreset_sync ( .reset(reset), .clk(hclk), .reset_sync(hreset) );

// ACK SIGNALS
assign power_ack_signals[19]=switch_ack_signal[1]|switch_ack_signal[3]|switch_ack_signal[5]|switch_ack_signal[7]|switch_ack_signal[9]|switch_ack_signal[11]|switch_ack_signal[13]|switch_ack_signal[15]|switch_ack_signal[17]|switch_ack_signal[19]|switch_ack_signal[21]|switch_ack_signal[23]|switch_ack_signal[25]|switch_ack_signal[27]|switch_ack_signal[29]|switch_ack_signal[31];

assign power_ack_signals[18]=switch_ack_signal[0]|switch_ack_signal[2]|switch_ack_signal[4]|switch_ack_signal[6]|switch_ack_signal[8]|switch_ack_signal[10]|switch_ack_signal[12]|switch_ack_signal[14]|switch_ack_signal[16]|switch_ack_signal[18]|switch_ack_signal[20]|switch_ack_signal[22]|switch_ack_signal[24]|switch_ack_signal[26]|switch_ack_signal[28]|switch_ack_signal[30];

assign power_ack_signals[17]=t_ack_signals[1]|t_ack_signals[3]|t_ack_signals[5]|t_ack_signals[7]|t_ack_signals[9]|t_ack_signals[11]|t_ack_signals[13]|t_ack_signals[15]|t_ack_signals[17]|t_ack_signals[19]|t_ack_signals[21]|t_ack_signals[23]|t_ack_signals[25]|t_ack_signals[27]|t_ack_signals[29]|t_ack_signals[31];

assign power_ack_signals[16]=t_ack_signals[0]|t_ack_signals[2]|t_ack_signals[4]|t_ack_signals[6]|t_ack_signals[8]|t_ack_signals[10]|t_ack_signals[12]|t_ack_signals[14]|t_ack_signals[16]|t_ack_signals[18]|t_ack_signals[20]|t_ack_signals[22]|t_ack_signals[24]|t_ack_signals[26]|t_ack_signals[28]|t_ack_signals[30];

// PISOS
piso piso_secure_0 ( 
  .din(secure_data_in[15:0]),
  .clk(lclk),
  .reset(lreset),
  .load(data_valid),
  .shut_down_signals(sleep_signals[17]),
  .isolation_signals(isolation_signals[1]),
  .retention_signals(retention_signals[1]),
  .dout(sout[0])
);

piso piso_secure_1 (
  .din(secure_data_in[31:16]),
  .clk(lclk),
  .reset(lreset),
  .load(data_valid),
  .shut_down_signals(sleep_signals[17]),
  .isolation_signals(isolation_signals[1]),
  .retention_signals(retention_signals[1]),
  .dout(sout[1])
);

// DATA SYNCS
sync_wrapper #(.width(2))  sync_sout_0    (.clk(hclk), .reset(hreset), .din(sout), .dout(sout_sync) );
sync_wrapper #(.width(16)) sync_hash_data (.clk(lclk), .reset(lreset), .din(t_hash_data_out), .dout(hash_data_out) );

// HASH
secure_data hash_it (
  .clk(hclk),
  .reset(hreset),
  .data_in(sout_sync),
  .hash_key(hash_key),
  .secure_data_out(t_hash_data_out)
);

// BIT TOP INSTANCES 0 to 15
bit_top bit_secure_0 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[0]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[0]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_0),
  .piso_scan_out(piso_scan_out_0),
  .hv_scan_out(hv_scan_out_0),
  .lv_scan_out(lv_scan_out_0),
  .sout(secure_data_out[1:0]),
  .memory_address(memory_address[3:0]),
  .memory_ack(power_ack_signals[0]),
  .PG_ack_signals({t_ack_signals[1:0], switch_ack_signal[1:0]})
);

bit_top bit_secure_1 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[1]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[1]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_1),
  .piso_scan_out(piso_scan_out_1),
  .hv_scan_out(hv_scan_out_1),
  .lv_scan_out(lv_scan_out_1),
  .sout(secure_data_out[3:2]),
  .memory_address(memory_address[7:4]),
  .memory_ack(power_ack_signals[1]),
  .PG_ack_signals({t_ack_signals[3:2], switch_ack_signal[3:2]})
);

bit_top bit_secure_2 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[2]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[2]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_2),
  .piso_scan_out(piso_scan_out_2),
  .hv_scan_out(hv_scan_out_2),
  .lv_scan_out(lv_scan_out_2),
  .sout(secure_data_out[5:4]),
  .memory_address(memory_address[11:8]),
  .memory_ack(power_ack_signals[2]),
  .PG_ack_signals({t_ack_signals[5:4], switch_ack_signal[5:4]})
);

bit_top bit_secure_3 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[3]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[3]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_3),
  .piso_scan_out(piso_scan_out_3),
  .hv_scan_out(hv_scan_out_3),
  .lv_scan_out(lv_scan_out_3),
  .sout(secure_data_out[7:6]),
  .memory_address(memory_address[15:12]),
  .memory_ack(power_ack_signals[3]),
  .PG_ack_signals({t_ack_signals[7:6], switch_ack_signal[7:6]})
);

bit_top bit_secure_4 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[4]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[4]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_4),
  .piso_scan_out(piso_scan_out_4),
  .hv_scan_out(hv_scan_out_4),
  .lv_scan_out(lv_scan_out_4),
  .sout(secure_data_out[9:8]),
  .memory_address(memory_address[19:16]),
  .memory_ack(power_ack_signals[4]),
  .PG_ack_signals({t_ack_signals[9:8], switch_ack_signal[9:8]})
);

bit_top bit_secure_5 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[5]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[5]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_5),
  .piso_scan_out(piso_scan_out_5),
  .hv_scan_out(hv_scan_out_5),
  .lv_scan_out(lv_scan_out_5),
  .sout(secure_data_out[11:10]),
  .memory_address(memory_address[23:20]),
  .memory_ack(power_ack_signals[5]),
  .PG_ack_signals({t_ack_signals[11:10], switch_ack_signal[11:10]})
);

bit_top bit_secure_6 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[6]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[6]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_6),
  .piso_scan_out(piso_scan_out_6),
  .hv_scan_out(hv_scan_out_6),
  .lv_scan_out(lv_scan_out_6),
  .sout(secure_data_out[13:12]),
  .memory_address(memory_address[27:24]),
  .memory_ack(power_ack_signals[6]),
  .PG_ack_signals({t_ack_signals[13:12], switch_ack_signal[13:12]})
);

bit_top bit_secure_7 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[7]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[7]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_7),
  .piso_scan_out(piso_scan_out_7),
  .hv_scan_out(hv_scan_out_7),
  .lv_scan_out(lv_scan_out_7),
  .sout(secure_data_out[15:14]),
  .memory_address(memory_address[31:28]),
  .memory_ack(power_ack_signals[7]),
  .PG_ack_signals({t_ack_signals[15:14], switch_ack_signal[15:14]})
);

bit_top bit_secure_8 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[8]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[8]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_8),
  .piso_scan_out(piso_scan_out_8),
  .hv_scan_out(hv_scan_out_8),
  .lv_scan_out(lv_scan_out_8),
  .sout(secure_data_out[17:16]),
  .memory_address(memory_address[35:32]),
  .memory_ack(power_ack_signals[8]),
  .PG_ack_signals({t_ack_signals[17:16], switch_ack_signal[17:16]})
);

bit_top bit_secure_9 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[9]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[9]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_9),
  .piso_scan_out(piso_scan_out_9),
  .hv_scan_out(hv_scan_out_9),
  .lv_scan_out(lv_scan_out_9),
  .sout(secure_data_out[19:18]),
  .memory_address(memory_address[39:36]),
  .memory_ack(power_ack_signals[9]),
  .PG_ack_signals({t_ack_signals[19:18], switch_ack_signal[19:18]})
);

bit_top bit_secure_10 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[10]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[10]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_10),
  .piso_scan_out(piso_scan_out_10),
  .hv_scan_out(hv_scan_out_10),
  .lv_scan_out(lv_scan_out_10),
  .sout(secure_data_out[21:20]),
  .memory_address(memory_address[43:40]),
  .memory_ack(power_ack_signals[10]),
  .PG_ack_signals({t_ack_signals[21:20], switch_ack_signal[21:20]})
);

bit_top bit_secure_11 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[11]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[11]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_11),
  .piso_scan_out(piso_scan_out_11),
  .hv_scan_out(hv_scan_out_11),
  .lv_scan_out(lv_scan_out_11),
  .sout(secure_data_out[23:22]),
  .memory_address(memory_address[47:44]),
  .memory_ack(power_ack_signals[11]),
  .PG_ack_signals({t_ack_signals[23:22], switch_ack_signal[23:22]})
);

bit_top bit_secure_12 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[12]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[12]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_12),
  .piso_scan_out(piso_scan_out_12),
  .hv_scan_out(hv_scan_out_12),
  .lv_scan_out(lv_scan_out_12),
  .sout(secure_data_out[25:24]),
  .memory_address(memory_address[51:48]),
  .memory_ack(power_ack_signals[12]),
  .PG_ack_signals({t_ack_signals[25:24], switch_ack_signal[25:24]})
);

bit_top bit_secure_13 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[13]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[13]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_13),
  .piso_scan_out(piso_scan_out_13),
  .hv_scan_out(hv_scan_out_13),
  .lv_scan_out(lv_scan_out_13),
  .sout(secure_data_out[27:26]),
  .memory_address(memory_address[55:52]),
  .memory_ack(power_ack_signals[13]),
  .PG_ack_signals({t_ack_signals[27:26], switch_ack_signal[27:26]})
);

bit_top bit_secure_14 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[14]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[14]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_14),
  .piso_scan_out(piso_scan_out_14),
  .hv_scan_out(hv_scan_out_14),
  .lv_scan_out(lv_scan_out_14),
  .sout(secure_data_out[29:28]),
  .memory_address(memory_address[59:56]),
  .memory_ack(power_ack_signals[14]),
  .PG_ack_signals({t_ack_signals[29:28], switch_ack_signal[29:28]})
);

bit_top bit_secure_15 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .data_in_serial(hash_data_out[15]),
  .data_valid(data_valid),
  .memory_sleep(sleep_signals[15]),
  .shut_down_signals(sleep_signals[17:16]),
  .isolation_signals(isolation_signals[1:0]),
  .retention_signals(retention_signals[1:0]),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out_15),
  .piso_scan_out(piso_scan_out_15),
  .hv_scan_out(hv_scan_out_15),
  .lv_scan_out(lv_scan_out_15),
  .sout(secure_data_out[31:30]),
  .memory_address(memory_address[63:60]),
  .memory_ack(power_ack_signals[15]),
  .PG_ack_signals({t_ack_signals[31:30], switch_ack_signal[31:30]})
);

endmodule
