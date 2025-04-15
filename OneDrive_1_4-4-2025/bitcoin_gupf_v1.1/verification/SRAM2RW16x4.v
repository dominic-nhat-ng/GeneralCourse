////////////////////////////////////////////////////////////////////////////////
//////
//////       This confidential and proprietary software may be used only
//////     as authorized by a licensing agreement from Synopsys Inc.
//////     In the event of publication, the following notice is applicable:
//////
//////                    (C) COPYRIGHT 1994  - 2016 SYNOPSYS INC.
//////                           ALL RIGHTS RESERVED
//////
//////       The entire notice above must be reproduced on all authorized
//////     copies.
//////
////// AUTHOR:    Godwin Maben
//////
////// VERSION:   0.97
//////
//////
////////////////////////////////////////////////////////////////////////////////////
//////-----------------------------------------------------------------------------------

`define numAddr 4
`define numWords 16
`define wordLength 4

module SRAM2RW16x4 (A1,A2,CE1,CE2,WEB1,WEB2,OEB1,OEB2,CSB1,CSB2,I1,I2,SLEEPIN,O1,O2,ACK);


input SLEEPIN;
output ACK;

input                           CE1;
input                           CE2;
input                           WEB1;
input                           WEB2;
input                           OEB1;
input                           OEB2;
input                           CSB1;
input                           CSB2;

input   [`numAddr-1:0]          A1;
input   [`numAddr-1:0]          A2;
input   [`wordLength-1:0]       I1;
input   [`wordLength-1:0]       I2;
output  [`wordLength-1:0]       O1;
output  [`wordLength-1:0]       O2;

/*reg   [`wordLength-1:0]       memory[`numWords-1:0];*/
/*reg   [`wordLength-1:0]       data_out1;*/
/*reg   [`wordLength-1:0]       data_out2;*/
wire    [`wordLength-1:0]       O1;
wire    [`wordLength-1:0]       O2;
     
wire                            RE1;
wire                            RE2; 
wire                            WE1; 
wire                            WE2;

SRAM2RW16x4_1bit sram_IO0 ( CE1, CE2, WEB1, WEB2,  A1, A2, OEB1, OEB2, CSB1, CSB2, I1[0], I2[0], O1[0], O2[0]);
SRAM2RW16x4_1bit sram_IO1 ( CE1, CE2, WEB1, WEB2,  A1, A2, OEB1, OEB2, CSB1, CSB2, I1[1], I2[1], O1[1], O2[1]);
SRAM2RW16x4_1bit sram_IO2 ( CE1, CE2, WEB1, WEB2,  A1, A2, OEB1, OEB2, CSB1, CSB2, I1[2], I2[2], O1[2], O2[2]);
SRAM2RW16x4_1bit sram_IO3 ( CE1, CE2, WEB1, WEB2,  A1, A2, OEB1, OEB2, CSB1, CSB2, I1[3], I2[3], O1[3], O2[3]);


endmodule

module SRAM2RW16x4_1bit (CE1_i, CE2_i, WEB1_i, WEB2_i,  A1_i, A2_i, OEB1_i, OEB2_i, CSB1_i, CSB2_i, I1_i, I2_i, O1_i, O2_i);

input   CSB1_i, CSB2_i;
input   OEB1_i, OEB2_i;
input   CE1_i, CE2_i;
input   WEB1_i, WEB2_i;

input   [`numAddr-1:0]  A1_i, A2_i;
input   [0:0] I1_i, I2_i;

output  [0:0] O1_i, O2_i;

reg     [0:0] O1_i, O2_i;
reg     [0:0]   memory1[`numWords-1:0];
reg     [0:0]   memory2[`numWords-1:0];
reg     [0:0]   data_out1, data_out2;


and u1 (RE1, ~CSB1_i,  WEB1_i);
and u2 (WE1, ~CSB1_i, ~WEB1_i);
and u3 (RE2, ~CSB2_i,  WEB2_i);
and u4 (WE2, ~CSB2_i, ~WEB2_i);

//Primary ports

always @ (posedge CE1_i)
        if (RE1)
                data_out1 <= memory1[A1_i];
always @ (posedge CE1_i)
        if (WE1)
                memory1[A1_i] <= I1_i;


always @ (data_out1 or OEB1_i)
        if (!OEB1_i) 
                O1_i = data_out1;
        else
                O1_i =  1'bz;

//Dual ports    
always @ (posedge CE2_i)
        if (RE2)
                data_out2 <= memory2[A2_i];
always @ (posedge CE2_i)
        if (WE2)
                memory2[A2_i] <= I2_i;
                
always @ (data_out2 or OEB2_i)
        if (!OEB2_i) 
                O2_i = data_out2;
        else
                O2_i = 1'bz;

endmodule
