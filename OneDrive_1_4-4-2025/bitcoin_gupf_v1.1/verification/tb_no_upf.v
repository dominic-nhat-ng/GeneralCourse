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
wire [15:0] pout_tb_0,pout_tb_1,pout_check_tb;
reg memory_sleep;
reg data_valid;
wire [3:0] addr_tb_0,addr_tb_1,add_check;
reg [17:0] din;
reg [3:0] count;

reg [15:0] sent_memory[511:0];
reg [15:0] recieved_memory_0[20000:0];
reg [15:0] recieved_memory_1[20000:0];
//reg [8:0] in_count,out_count;
integer in_count,out_count;
wire [15:0] in_data,out_data;
wire [1:0] sout_tb;



reg sin_tb_task;
reg sending_data;

// bit_top dut (clk,reset,sin_tb_task,sending_data,memory_sleep,sout_tb,memory_ack);
// working bit_top dut (clk,reset,sin_tb,data_valid,memory_sleep,sout_tb,memory_ack);
// piso tb_piso_bit( din[15:0] ,clk ,reset ,load ,sin_tb );
//
//
//
//
//

reg [31:0] secure_data_in,hash_key;
wire [31:0] secure_data_out;
wire [20:0] power_ack_signals;

reg [17:0] sleep_signals;
reg [1:0] isolation_signals,retention_signals;

wire [63:0] memory_address;

bit_coin dut (clk,reset,secure_data_in,hash_key,sending_data,sleep_signals,isolation_signals,retention_signals, secure_data_out,memory_address,data_ready,power_ack_signals);

 sipo tb_sipo_bit_0(clk,reset, sending_data,sout_tb[0], pout_tb_0,addr_tb_0,wr_tb_0); 
 sipo tb_sipo_bit_1(clk,reset, sending_data,sout_tb[1], pout_tb_1,addr_tb_1,wr_tb_1); 

// sipo tb_check_sipo(clk,reset,data_valid,sin_tb,pout_check_tb,add_check,wr_check,rd_check);




initial
  begin
        $vcdpluspowerenableon;
        $vcdpluspowerstateon;
        $vcdpluson;
  end

task power_down_sipo(input integer bits);
  begin
    isolation_signals[0] <= 1;
    $display ("Asserting Isolation for SIPO", $time);
    delay_time(2) ;
    retention_signals[0] <= 1;
    $display ("Asserting Retention for SIPO", $time);
    delay_time(4) ;
    $display ("Asserting Shut_down for SIPO", $time);
    sleep_signals[16]<=1;
    $display ("Waiting for Power Down Ack from SIPO", $time);
       @(negedge clk);
    wait(power_ack_signals[18])
    $display ("Recieved Power Down Ack, SIPO is Powered Down", $time);
  end
endtask


task send_data (input integer bits);
   begin
     integer bits_temp;
     bits_temp = bits; 
     din<=$random;
     while (bits > 0)
      begin
       @(negedge clk);
       sending_data=1;
        bits = bits - 1 ;
        sin_tb_task = din[bits];
      end
       sending_data=0;
     $display ("Data Sent %d",din[15:0],$time);
   end
endtask

task send_parallel_data (input integer bits);
   begin
     integer bits_temp;
     bits_temp=bits;
     while (bits > 0)
      begin
       @(negedge clk);
        secure_data_in<=$random;
        hash_key<=$random;
        sending_data=1;
        bits = bits - 1 ;
      end
       sending_data=0;
     $display ("Total %d Data Bytes Sent ",bits_temp-1,$time);
   end
endtask

task delay_time (input integer time_delay);
  begin
    integer temp_time;
    temp_time=time_delay;
    $display ("Waiting for %d cycles", time_delay,$time);
    while (time_delay > 0)
     begin
       @(negedge clk);
       time_delay = time_delay - 1;
     end
    $display ("Finished Waiting for %d cycles", temp_time,$time);
  end
endtask

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
      sending_data=0;
      retention_signals<=0;
      secure_data_in<=0;
      hash_key<=0;
      sleep_signals<=0;
      isolation_signals<=0;
   #105 reset=1;
   #30 data_valid=1;
       load=1;
   #10 load=0;
   
  end


always #5 clk = ~clk;


initial begin:main
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    @(negedge clk);
    $display ("Sending Data ",$time);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    delay_time (20);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    delay_time (20);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    delay_time (20);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    delay_time (20);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    delay_time (20);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    send_parallel_data(17);
    delay_time (50);
    $finish;
end

always @(posedge clk)
  begin
    if (reset&&data_valid)
      begin
        count<=count+1;
        load<=(count==4'b1111);
      end
  end



always @(posedge clk)
  begin
   if(reset) 
     begin
       sent_memory[out_count]=din;
       out_count=out_count+1;
     end
  end
always @(secure_data_out)
  begin
   if(reset) 
     begin
       recieved_memory_0[in_count] = secure_data_out[15:0];
       recieved_memory_1[in_count] = secure_data_out[31:16];
       $display("Data Recieved %h %h ", recieved_memory_0[in_count],recieved_memory_1[in_count],$time);
       in_count=in_count+1;
     end
  end

endmodule
