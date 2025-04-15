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

module tb;

`ifdef UPF
import UPF::*;
`endif


reg clk,reset,load;
reg read;
wire [15:0] pout_tb,pout_check_tb;
reg memory_sleep;
reg data_valid;
wire [4:0] addr_tb,add_check;
reg [15:0] din;
reg [3:0] count;

reg [15:0] sent_memory[511:0];
reg [15:0] recieved_memory[511:0];
//reg [8:0] in_count,out_count;
integer in_count,out_count;
wire [15:0] in_data,out_data;

bit_top dut (clk,reset,sin_tb,read,data_valid,memory_sleep,sout_tb,memory_ack);
piso tb_piso_bit( din ,clk ,reset ,load ,sin_tb );

sipo tb_sipo_bit(clk,reset, data_valid,sout_tb, pout_tb,addr_tb,wr_tb,rd_tb); 

sipo tb_check_sipo(clk,reset,data_valid,sin_tb,pout_check_tb,add_check,wr_check,rd_check);




initial
  begin
        $vcdpluspowerenableon;
        $vcdpluspowerstateon;
        $vcdpluson;
  end

initial
  begin
   #0 clk=0;
      reset=0;
      din=$random;
      count=5'b11111;
      load=0; 
      read=0;
      memory_sleep=0;
      data_valid=0;
      in_count=0;
      out_count=0;
      sent_memory[0]<=0;
      recieved_memory[0]<=0;
   #105 reset=1;
   #30 data_valid=1;
       load=1;
   #10 load=0;
   
   #10000 $finish;
  end


always #5 clk = ~clk;

always @(posedge clk)
  begin
    if (reset&&data_valid)
      begin
        din<=$random;
        count<=count+1;
        load<=(count==4'b1111);
      end
  end



always @(posedge load)
  begin
   if(reset) 
     begin
       //sent_memory[out_count]<=din;
       sent_memory[out_count]=din;
       $display("Data Sent %h ",sent_memory[out_count],$time);
       out_count=out_count+1;
     end
  end
always @(posedge wr_tb)
  begin
   if(reset) 
     begin
       recieved_memory[in_count] = pout_tb;
       $display("Data Recieved %h  ", recieved_memory[in_count],$time);
       in_count=in_count+1;
     end
  end

endmodule
