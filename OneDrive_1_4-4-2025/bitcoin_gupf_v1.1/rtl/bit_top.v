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
//  FILE    : bit_top.v
//
//  VERSION : 1.0
//
////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

module bit_top (
  hclk,
  lclk,
  reset,
  data_in_serial,
  data_valid,
  memory_sleep,
  shut_down_signals,
  isolation_signals,
  retention_signals,scan_enable,
  sipo_scan_in,
  piso_scan_in,
  hv_scan_in,
  lv_scan_in,
  sipo_scan_out,
  piso_scan_out,
  hv_scan_out,
  lv_scan_out,
  sout,
  memory_address,
  memory_ack,
  PG_ack_signals
);

// INPUTS
input hclk;
input lclk;
input reset;
input data_valid;
input memory_sleep;
input data_in_serial;

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

// OUTPUTS
output [1:0] sout;

// LP OUTPUTS
output memory_ack;
output [3:0] memory_address;
output [3:0] PG_ack_signals;

// DFT OUTPUTS
output sipo_scan_out;
output piso_scan_out;
output hv_scan_out;
output lv_scan_out;

// WIRES AND REGS
wire        wr_0;
wire        wr_1;
wire        rd_0;
wire        rd_1;
wire        lreset;
wire [3:0]  pout_addr2mem_0;
wire [3:0]  pout_addr2mem_1;
wire [15:0] pout2slice_0_15;
wire [15:0] pout2slice_16_31;
wire [31:0] slice_out;
wire [31:0] power_ack;
wire [63:0] t_ack_signals;
reg         temp_0;
reg         temp_1;
reg         load_data_from_memory_0;
reg         load_data_from_memory_1;

reset_sync lreset_sync (
  .reset(reset),
  .clk(lclk),
  .reset_sync(lreset)
);

// MEMORY ADDRESS MUX
assign memory_address = (wr_0) ? pout_addr2mem_0 : pout_addr2mem_1;

// ACK SIGNALS
assign PG_ack_signals[0] = t_ack_signals[0]|t_ack_signals[2]|t_ack_signals[4]|t_ack_signals[6]|t_ack_signals[8]|t_ack_signals[10]|t_ack_signals[12]|t_ack_signals[14]|t_ack_signals[16]|t_ack_signals[18]|t_ack_signals[20]|t_ack_signals[22]|t_ack_signals[24]|t_ack_signals[26]|t_ack_signals[28]|t_ack_signals[30]|t_ack_signals[32]|t_ack_signals[34]|t_ack_signals[36]|t_ack_signals[38]|t_ack_signals[40]|t_ack_signals[42]|t_ack_signals[44]|t_ack_signals[46]|t_ack_signals[48]|t_ack_signals[50]|t_ack_signals[52]|t_ack_signals[54]|t_ack_signals[56]|t_ack_signals[58]|t_ack_signals[60]|t_ack_signals[62];

assign PG_ack_signals[1] = t_ack_signals[1]|t_ack_signals[3]|t_ack_signals[5]|t_ack_signals[7]|t_ack_signals[9]|t_ack_signals[11]|t_ack_signals[13]|t_ack_signals[15]|t_ack_signals[17]|t_ack_signals[19]|t_ack_signals[21]|t_ack_signals[23]|t_ack_signals[25]|t_ack_signals[27]|t_ack_signals[29]|t_ack_signals[31]|t_ack_signals[33]|t_ack_signals[35]|t_ack_signals[37]|t_ack_signals[39]|t_ack_signals[41]|t_ack_signals[43]|t_ack_signals[45]|t_ack_signals[47]|t_ack_signals[49]|t_ack_signals[51]|t_ack_signals[53]|t_ack_signals[55]|t_ack_signals[57]|t_ack_signals[59]|t_ack_signals[61]|t_ack_signals[63];

assign memory_ack = power_ack[0]|power_ack[1]|power_ack[2]|power_ack[3]|power_ack[4]|power_ack[5]|power_ack[6]|power_ack[7]|power_ack[8]|power_ack[9]|power_ack[10]|power_ack[11]|power_ack[12]|power_ack[13]|power_ack[14]|power_ack[15]|power_ack[16]|power_ack[17]|power_ack[18]|power_ack[19]|power_ack[20]|power_ack[21]|power_ack[22]|power_ack[23]|power_ack[24]|power_ack[25]|power_ack[26]|power_ack[27]|power_ack[28]|power_ack[29]|power_ack[30]|power_ack[31];

// SIPO FIRST
sipo sipo_slice_first (
  .clk(lclk),
  .reset(lreset),
  .data_valid(data_valid),
  .sin(data_in_serial),
  .shut_down_signals(shut_down_signals[0]),
  .isolation_signals(isolation_signals[0]),
  .retention_signals(retention_signals[0]),
  .pout(pout2slice_0_15),
  .addr(pout_addr2mem_0),
  .wr(wr_0)
); 

// SIPO LAST
sipo sipo_slice_last (
  .clk(lclk),
  .reset(lreset),
  .data_valid(data_valid),
  .sin(data_in_serial),
  .shut_down_signals(shut_down_signals[0]),
  .isolation_signals(isolation_signals[0]),
  .retention_signals(retention_signals[0]),
  .pout(pout2slice_16_31),
  .addr(pout_addr2mem_1),
  .wr(wr_1)
); 

// BIT SLICE INSTANCES 0 to 15
bit_slice slice_0 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[0]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in),
  .piso_scan_in(piso_scan_in),
  .hv_scan_in(hv_scan_in),
  .lv_scan_in(lv_scan_in),
  .sipo_scan_out(sipo_scan_out0),
  .piso_scan_out(piso_scan_out0),
  .hv_scan_out(hv_scan_out0),
  .lv_scan_out(lv_scan_out0),
  .sout(slice_out[0]),
  .memory_ack(power_ack[0]),
  .PG_ack_signals(t_ack_signals[1:0])
);

bit_slice slice_1 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[1]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in1),
  .piso_scan_in(piso_scan_in1),
  .hv_scan_in(hv_scan_in1),
  .lv_scan_in(lv_scan_in1),
  .sipo_scan_out(sipo_scan_out1),
  .piso_scan_out(piso_scan_out1),
  .hv_scan_out(hv_scan_out1),
  .lv_scan_out(lv_scan_out1),
  .sout(slice_out[1]),
  .memory_ack(power_ack[1]),
  .PG_ack_signals(t_ack_signals[3:2])
);

bit_slice slice_2 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[2]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in2),
  .piso_scan_in(piso_scan_in2),
  .hv_scan_in(hv_scan_in2),
  .lv_scan_in(lv_scan_in2),
  .sipo_scan_out(sipo_scan_out2),
  .piso_scan_out(piso_scan_out2),
  .hv_scan_out(hv_scan_out2),
  .lv_scan_out(lv_scan_out2),
  .sout(slice_out[2]),
  .memory_ack(power_ack[2]),
  .PG_ack_signals(t_ack_signals[5:4])
);

bit_slice slice_3 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[3]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in3),
  .piso_scan_in(piso_scan_in3),
  .hv_scan_in(hv_scan_in3),
  .lv_scan_in(lv_scan_in3),
  .sipo_scan_out(sipo_scan_out3),
  .piso_scan_out(piso_scan_out3),
  .hv_scan_out(hv_scan_out3),
  .lv_scan_out(lv_scan_out3),
  .sout(slice_out[3]),
  .memory_ack(power_ack[3]),
  .PG_ack_signals(t_ack_signals[7:6])
);

bit_slice slice_4 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[4]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in4),
  .piso_scan_in(piso_scan_in4),
  .hv_scan_in(hv_scan_in4),
  .lv_scan_in(lv_scan_in4),
  .sipo_scan_out(sipo_scan_out4),
  .piso_scan_out(piso_scan_out4),
  .hv_scan_out(hv_scan_out4),
  .lv_scan_out(lv_scan_out4),
  .sout(slice_out[4]),
  .memory_ack(power_ack[4]),
  .PG_ack_signals(t_ack_signals[9:8])
);

bit_slice slice_5 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[5]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in5),
  .piso_scan_in(piso_scan_in5),
  .hv_scan_in(hv_scan_in5),
  .lv_scan_in(lv_scan_in5),
  .sipo_scan_out(sipo_scan_out5),
  .piso_scan_out(piso_scan_out5),
  .hv_scan_out(hv_scan_out5),
  .lv_scan_out(lv_scan_out5),
  .sout(slice_out[5]),
  .memory_ack(power_ack[5]),
  .PG_ack_signals(t_ack_signals[11:10])
);

bit_slice slice_6 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[6]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in6),
  .piso_scan_in(piso_scan_in6),
  .hv_scan_in(hv_scan_in6),
  .lv_scan_in(lv_scan_in6),
  .sipo_scan_out(sipo_scan_out6),
  .piso_scan_out(piso_scan_out6),
  .hv_scan_out(hv_scan_out6),
  .lv_scan_out(lv_scan_out6),
  .sout(slice_out[6]),
  .memory_ack(power_ack[6]),
  .PG_ack_signals(t_ack_signals[13:12])
);

bit_slice slice_7 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[7]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in7),
  .piso_scan_in(piso_scan_in7),
  .hv_scan_in(hv_scan_in7),
  .lv_scan_in(lv_scan_in7),
  .sipo_scan_out(sipo_scan_out7),
  .piso_scan_out(piso_scan_out7),
  .hv_scan_out(hv_scan_out7),
  .lv_scan_out(lv_scan_out7),
  .sout(slice_out[7]),
  .memory_ack(power_ack[7]),
  .PG_ack_signals(t_ack_signals[15:14])
);

bit_slice slice_8 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[8]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in8),
  .piso_scan_in(piso_scan_in8),
  .hv_scan_in(hv_scan_in8),
  .lv_scan_in(lv_scan_in8),
  .sipo_scan_out(sipo_scan_out8),
  .piso_scan_out(piso_scan_out8),
  .hv_scan_out(hv_scan_out8),
  .lv_scan_out(lv_scan_out8),
  .sout(slice_out[8]),
  .memory_ack(power_ack[8]),
  .PG_ack_signals(t_ack_signals[17:16])
);

bit_slice slice_9 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[9]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in9),
  .piso_scan_in(piso_scan_in9),
  .hv_scan_in(hv_scan_in9),
  .lv_scan_in(lv_scan_in9),
  .sipo_scan_out(sipo_scan_out9),
  .piso_scan_out(piso_scan_out9),
  .hv_scan_out(hv_scan_out9),
  .lv_scan_out(lv_scan_out9),
  .sout(slice_out[9]),
  .memory_ack(power_ack[9]),
  .PG_ack_signals(t_ack_signals[19:18])
);

bit_slice slice_10 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[10]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in10),
  .piso_scan_in(piso_scan_in10),
  .hv_scan_in(hv_scan_in10),
  .lv_scan_in(lv_scan_in10),
  .sipo_scan_out(sipo_scan_out10),
  .piso_scan_out(piso_scan_out10),
  .hv_scan_out(hv_scan_out10),
  .lv_scan_out(lv_scan_out10),
  .sout(slice_out[10]),
  .memory_ack(power_ack[10]),
  .PG_ack_signals(t_ack_signals[21:20])
);

bit_slice slice_11 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[11]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in11),
  .piso_scan_in(piso_scan_in11),
  .hv_scan_in(hv_scan_in11),
  .lv_scan_in(lv_scan_in11),
  .sipo_scan_out(sipo_scan_out11),
  .piso_scan_out(piso_scan_out11),
  .hv_scan_out(hv_scan_out11),
  .lv_scan_out(lv_scan_out11),
  .sout(slice_out[11]),
  .memory_ack(power_ack[11]),
  .PG_ack_signals(t_ack_signals[23:22])
);

bit_slice slice_12 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[12]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in12),
  .piso_scan_in(piso_scan_in12),
  .hv_scan_in(hv_scan_in12),
  .lv_scan_in(lv_scan_in12),
  .sipo_scan_out(sipo_scan_out12),
  .piso_scan_out(piso_scan_out12),
  .hv_scan_out(hv_scan_out12),
  .lv_scan_out(lv_scan_out12),
  .sout(slice_out[12]),
  .memory_ack(power_ack[12]),
  .PG_ack_signals(t_ack_signals[25:24])
);

bit_slice slice_13 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[13]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in13),
  .piso_scan_in(piso_scan_in13),
  .hv_scan_in(hv_scan_in13),
  .lv_scan_in(lv_scan_in13),
  .sipo_scan_out(sipo_scan_out13),
  .piso_scan_out(piso_scan_out13),
  .hv_scan_out(hv_scan_out13),
  .lv_scan_out(lv_scan_out13),
  .sout(slice_out[13]),
  .memory_ack(power_ack[13]),
  .PG_ack_signals(t_ack_signals[27:26])
);

bit_slice slice_14 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[14]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in14),
  .piso_scan_in(piso_scan_in14),
  .hv_scan_in(hv_scan_in14),
  .lv_scan_in(lv_scan_in14),
  .sipo_scan_out(sipo_scan_out14),
  .piso_scan_out(piso_scan_out14),
  .hv_scan_out(hv_scan_out14),
  .lv_scan_out(lv_scan_out14),
  .sout(slice_out[14]),
  .memory_ack(power_ack[14]),
  .PG_ack_signals(t_ack_signals[29:28])
);

bit_slice slice_15 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_0_15[15]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in15),
  .piso_scan_in(piso_scan_in15),
  .hv_scan_in(hv_scan_in15),
  .lv_scan_in(lv_scan_in15),
  .sipo_scan_out(sipo_scan_out15),
  .piso_scan_out(piso_scan_out15),
  .hv_scan_out(hv_scan_out15),
  .lv_scan_out(lv_scan_out15),
  .sout(slice_out[15]),
  .memory_ack(power_ack[15]),
  .PG_ack_signals(t_ack_signals[31:30])
);

// BIT SLICE INSTANCES 16 to 31
bit_slice slice_16 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[0]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in16),
  .piso_scan_in(piso_scan_in16),
  .hv_scan_in(hv_scan_in16),
  .lv_scan_in(lv_scan_in16),
  .sipo_scan_out(sipo_scan_out16),
  .piso_scan_out(piso_scan_out16),
  .hv_scan_out(hv_scan_out16),
  .lv_scan_out(lv_scan_out16),
  .sout(slice_out[16]),
  .memory_ack(power_ack[16]),
  .PG_ack_signals(t_ack_signals[33:32])
);

bit_slice slice_17 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[1]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in17),
  .piso_scan_in(piso_scan_in17),
  .hv_scan_in(hv_scan_in17),
  .lv_scan_in(lv_scan_in17),
  .sipo_scan_out(sipo_scan_out17),
  .piso_scan_out(piso_scan_out17),
  .hv_scan_out(hv_scan_out17),
  .lv_scan_out(lv_scan_out17),
  .sout(slice_out[17]),
  .memory_ack(power_ack[17]),
  .PG_ack_signals(t_ack_signals[35:34])
);

bit_slice slice_18 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[2]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in18),
  .piso_scan_in(piso_scan_in18),
  .hv_scan_in(hv_scan_in18),
  .lv_scan_in(lv_scan_in18),
  .sipo_scan_out(sipo_scan_out18),
  .piso_scan_out(piso_scan_out18),
  .hv_scan_out(hv_scan_out18),
  .lv_scan_out(lv_scan_out18),
  .sout(slice_out[18]),
  .memory_ack(power_ack[18]),
  .PG_ack_signals(t_ack_signals[37:36])
);

bit_slice slice_19 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[3]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in19),
  .piso_scan_in(piso_scan_in19),
  .hv_scan_in(hv_scan_in19),
  .lv_scan_in(lv_scan_in19),
  .sipo_scan_out(sipo_scan_out19),
  .piso_scan_out(piso_scan_out19),
  .hv_scan_out(hv_scan_out19),
  .lv_scan_out(lv_scan_out19),
  .sout(slice_out[19]),
  .memory_ack(power_ack[19]),
  .PG_ack_signals(t_ack_signals[39:38])
);

bit_slice slice_20 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[4]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in20),
  .piso_scan_in(piso_scan_in20),
  .hv_scan_in(hv_scan_in20),
  .lv_scan_in(lv_scan_in20),
  .sipo_scan_out(sipo_scan_out20),
  .piso_scan_out(piso_scan_out20),
  .hv_scan_out(hv_scan_out20),
  .lv_scan_out(lv_scan_out20),
  .sout(slice_out[20]),
  .memory_ack(power_ack[20]),
  .PG_ack_signals(t_ack_signals[41:40])
);

bit_slice slice_21 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[5]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in21),
  .piso_scan_in(piso_scan_in21),
  .hv_scan_in(hv_scan_in21),
  .lv_scan_in(lv_scan_in21),
  .sipo_scan_out(sipo_scan_out21),
  .piso_scan_out(piso_scan_out21),
  .hv_scan_out(hv_scan_out21),
  .lv_scan_out(lv_scan_out21),
  .sout(slice_out[21]),
  .memory_ack(power_ack[21]),
  .PG_ack_signals(t_ack_signals[43:42])
);

bit_slice slice_22 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[6]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in22),
  .piso_scan_in(piso_scan_in22),
  .hv_scan_in(hv_scan_in22),
  .lv_scan_in(lv_scan_in22),
  .sipo_scan_out(sipo_scan_out22),
  .piso_scan_out(piso_scan_out22),
  .hv_scan_out(hv_scan_out22),
  .lv_scan_out(lv_scan_out22),
  .sout(slice_out[22]),
  .memory_ack(power_ack[22]),
  .PG_ack_signals(t_ack_signals[45:44])
);

bit_slice slice_23 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[7]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in23),
  .piso_scan_in(piso_scan_in23),
  .hv_scan_in(hv_scan_in23),
  .lv_scan_in(lv_scan_in23),
  .sipo_scan_out(sipo_scan_out23),
  .piso_scan_out(piso_scan_out23),
  .hv_scan_out(hv_scan_out23),
  .lv_scan_out(lv_scan_out23),
  .sout(slice_out[23]),
  .memory_ack(power_ack[23]),
  .PG_ack_signals(t_ack_signals[47:46])
);

bit_slice slice_24 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[8]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in24),
  .piso_scan_in(piso_scan_in24),
  .hv_scan_in(hv_scan_in24),
  .lv_scan_in(lv_scan_in24),
  .sipo_scan_out(sipo_scan_out24),
  .piso_scan_out(piso_scan_out24),
  .hv_scan_out(hv_scan_out24),
  .lv_scan_out(lv_scan_out24),
  .sout(slice_out[24]),
  .memory_ack(power_ack[24]),
  .PG_ack_signals(t_ack_signals[49:48])
);

bit_slice slice_25 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[9]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in25),
  .piso_scan_in(piso_scan_in25),
  .hv_scan_in(hv_scan_in25),
  .lv_scan_in(lv_scan_in25),
  .sipo_scan_out(sipo_scan_out25),
  .piso_scan_out(piso_scan_out25),
  .hv_scan_out(hv_scan_out25),
  .lv_scan_out(lv_scan_out25),
  .sout(slice_out[25]),
  .memory_ack(power_ack[25]),
  .PG_ack_signals(t_ack_signals[51:50])
);

bit_slice slice_26 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[10]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in26),
  .piso_scan_in(piso_scan_in26),
  .hv_scan_in(hv_scan_in26),
  .lv_scan_in(lv_scan_in26),
  .sipo_scan_out(sipo_scan_out26),
  .piso_scan_out(piso_scan_out26),
  .hv_scan_out(hv_scan_out26),
  .lv_scan_out(lv_scan_out26),
  .sout(slice_out[26]),
  .memory_ack(power_ack[26]),
  .PG_ack_signals(t_ack_signals[53:52])
);

bit_slice slice_27 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[11]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in27),
  .piso_scan_in(piso_scan_in27),
  .hv_scan_in(hv_scan_in27),
  .lv_scan_in(lv_scan_in27),
  .sipo_scan_out(sipo_scan_out27),
  .piso_scan_out(piso_scan_out27),
  .hv_scan_out(hv_scan_out27),
  .lv_scan_out(lv_scan_out27),
  .sout(slice_out[27]),
  .memory_ack(power_ack[27]),
  .PG_ack_signals(t_ack_signals[55:54])
);

bit_slice slice_28 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[12]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in28),
  .piso_scan_in(piso_scan_in28),
  .hv_scan_in(hv_scan_in28),
  .lv_scan_in(lv_scan_in28),
  .sipo_scan_out(sipo_scan_out28),
  .piso_scan_out(piso_scan_out28),
  .hv_scan_out(hv_scan_out28),
  .lv_scan_out(lv_scan_out28),
  .sout(slice_out[28]),
  .memory_ack(power_ack[28]),
  .PG_ack_signals(t_ack_signals[57:56])
);

bit_slice slice_29 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[13]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in29),
  .piso_scan_in(piso_scan_in29),
  .hv_scan_in(hv_scan_in29),
  .lv_scan_in(lv_scan_in29),
  .sipo_scan_out(sipo_scan_out29),
  .piso_scan_out(piso_scan_out29),
  .hv_scan_out(hv_scan_out29),
  .lv_scan_out(lv_scan_out29),
  .sout(slice_out[29]),
  .memory_ack(power_ack[29]),
  .PG_ack_signals(t_ack_signals[59:58])
);

bit_slice slice_30 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[14]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in30),
  .piso_scan_in(piso_scan_in30),
  .hv_scan_in(hv_scan_in30),
  .lv_scan_in(lv_scan_in30),
  .sipo_scan_out(sipo_scan_out30),
  .piso_scan_out(piso_scan_out30),
  .hv_scan_out(hv_scan_out30),
  .lv_scan_out(lv_scan_out30),
  .sout(slice_out[30]),
  .memory_ack(power_ack[30]),
  .PG_ack_signals(t_ack_signals[61:60])
);

bit_slice slice_31 (
  .hclk(hclk),
  .lclk(lclk),
  .reset(reset),
  .sin(pout2slice_16_31[15]),
  .data_valid(data_valid),
  .memory_sleep(memory_sleep),
  .shut_down_signals(shut_down_signals),
  .isolation_signals(isolation_signals),
  .retention_signals(retention_signals),
  .scan_enable(scan_enable),
  .sipo_scan_in(sipo_scan_in31),
  .piso_scan_in(piso_scan_in31),
  .hv_scan_in(hv_scan_in31),
  .lv_scan_in(lv_scan_in31),
  .sipo_scan_out(sipo_scan_out31),
  .piso_scan_out(piso_scan_out31),
  .hv_scan_out(hv_scan_out31),
  .lv_scan_out(lv_scan_out31),
  .sout(slice_out[31]),
  .memory_ack(power_ack[31]),
  .PG_ack_signals(t_ack_signals[63:62])
);

// PISO FIRST
piso piso_slice_first(
  .din(slice_out[15:0]),
  .clk(lclk),
  .reset(lreset),
  .load(load_data_from_memory_0),
  .shut_down_signals(shut_down_signals[1]),
  .isolation_signals(isolation_signals[1]),
  .retention_signals(retention_signals[1]),
  .dout(sout[0])
);

// PISO LAST
piso piso_slice_last(
  .din(slice_out[31:16]),
  .clk(lclk),
  .reset(lreset),
  .load(load_data_from_memory_1),
  .shut_down_signals(shut_down_signals[1]),
  .isolation_signals(isolation_signals[1]),
  .retention_signals(retention_signals[1]),
  .dout(sout[1])
);

always @(posedge lclk or negedge lreset) begin
  if (!lreset) begin
    temp_0 <= 0;
    temp_1 <= 0;
    load_data_from_memory_0 <= 0;
    load_data_from_memory_1 <= 0;
  end else begin
    temp_0 <= wr_0;
    load_data_from_memory_0 <= temp_0;
    temp_1 <= wr_1;
    load_data_from_memory_1 <= temp_1;
  end
end

endmodule
