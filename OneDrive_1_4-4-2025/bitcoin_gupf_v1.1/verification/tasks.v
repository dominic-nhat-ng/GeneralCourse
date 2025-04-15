task reset_after_power_up(input integer bits);
  begin
    $display ("Resetting after Power UP:",$time);
    reset=0;
    delay_time(40);
    reset=1;
    delay_time(10);
  end
endtask

task power_up_all(input integer bits);
  begin
    $display(" POWERING UP SIP/PISO/MEMORY",$time);
    sleep_signals[16]<=0;
    sleep_signals[17]<=0;
    supply_on ("tb/dut/TOP.SS_MEM_SW.power", 0.85);
    $display ("Power UP SISO/PIPO/MEMORY", $time);
    delay_time(2) ;
    retention_signals[0] <= 1'b1;
    retention_signals[1] <= 1'b1;
    $display ("DEAsserting Retention for PISO/SIPO", $time);
    delay_time(2) ;
    isolation_signals[0] <= 0;
    isolation_signals[1] <= 0;
    $display ("DEAsserting Isolation for PISO/SIPO", $time);
    wait(power_ack_signals[18])
    $display ("Recieved Power UP Ack, SIPO is Powered UP", $time);
    wait(power_ack_signals[19])
    $display ("Recieved Power UP Ack, PISO is Powered UP", $time);
    $display(" COMPLETED POWERING UP SIP/PISO/MEMORY",$time);
  end
endtask

task power_down_all(input integer bits);
  begin
    $display(" POWERING DOWN SIP/PISO/MEMORY",$time);
    isolation_signals[0] <= 1;
    isolation_signals[1] <= 1;
    $display ("Asserting Isolation for SIPO", $time);
    delay_time(2) ;
    retention_signals[0] <= 1'b0;
    retention_signals[1] <= 1'b0;
    $display ("Asserting Retention for SIPO", $time);
    delay_time(4) ;
    $display ("Asserting Shut_down for SIPO", $time);
    sleep_signals[16]<=1;
    sleep_signals[17]<=1;
    supply_off ("tb/dut/TOP.SS_MEM_SW.power");
    $display ("Waiting for Power Down Ack from SIPO", $time);
       @(negedge hclk);
    wait(power_ack_signals[18])
    $display ("Recieved Power Down Ack, SIPO is Powered Down", $time);
    wait(power_ack_signals[19])
    $display ("Recieved Power Down Ack, PISO is Powered Down", $time);
    $display(" COMPLETED POWERING DOWN SIP/PISO/MEMORY",$time);
  end
endtask

task power_down_sipo(input integer bits);
  begin
    isolation_signals[0] <= 1;
    $display ("Asserting Isolation for SIPO", $time);
    delay_time(2) ;
    retention_signals[0] <= 1'b0;
    $display ("Asserting Retention for SIPO", $time);
    delay_time(4) ;
    $display ("Asserting Shut_down for SIPO", $time);
    sleep_signals[16]<=1;
    //supply_off ("tb/dut/TOP.SS_MEM_SW.power");
    $display ("Waiting for Power Down Ack from SIPO", $time);
       @(negedge hclk);
    wait(power_ack_signals[18])
    $display ("Recieved Power Down Ack, SIPO is Powered Down", $time);
  end
endtask

task power_down_piso(input integer bits);
  begin
    isolation_signals[1] <= 1;
    $display ("Asserting Isolation for PISO", $time);
    delay_time(2) ;
    retention_signals[1] <= 1'b0;
    $display ("Asserting Retention for PISO", $time);
    delay_time(4) ;
    $display ("Asserting Shut_down for PISO", $time);
    sleep_signals[17]<=1;
    $display ("Waiting for Power Down Ack from PISO", $time);
       @(negedge hclk);
    wait(power_ack_signals[19])
    $display ("Recieved Power Down Ack, PISO is Powered Down", $time);
  end
endtask

task power_up_piso(input integer bits);
  begin
    sleep_signals[17]<=0;
    $display ("Power UP PISO", $time);
    delay_time(2) ;
    retention_signals[1] <= 1'b1;
    $display ("DEAsserting Retention for PISO", $time);
    delay_time(2) ;
    isolation_signals[1] <= 0;
    $display ("DEAsserting Isolation for PISO", $time);
    wait(power_ack_signals[19])
    $display ("Recieved Power UP Ack, PISO is Powered UP", $time);
  end
endtask

task power_up_sipo(input integer bits);
  begin
    sleep_signals[16]<=0;
    $display ("Power UP SIPO", $time);
    delay_time(2) ;
    retention_signals[0] <= 1'b1;
    $display ("DEAsserting Retention for SIPO", $time);
    delay_time(2) ;
    isolation_signals[0] <= 0;
    $display ("DEAsserting Isolation for SIPO", $time);
    //supply_on ("tb/dut/TOP.SS_MEM_SW.power", 0.85);
    wait(power_ack_signals[18])
    $display ("Recieved Power UP Ack, SIPO is Powered UP", $time);
  end
endtask

task send_data (input integer bits);
   begin
     integer bits_temp;
     bits_temp = bits; 
     din<=$random;
     while (bits > 0)
      begin
       @(negedge hclk);
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
       @(negedge hclk);
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
       @(negedge hclk);
       time_delay = time_delay - 1;
     end
    $display ("Finished Waiting for %d cycles", temp_time,$time);
  end
endtask


task send_burst_data (input integer bits);
  begin
     integer bits_temp;
     bits_temp=bits;
     while (bits > 0)
      begin
       send_parallel_data(20);
       bits = bits - 1 ;
      end
     $display ("Total %d Burst Data Bytes Sent ",bits_temp-1,$time);
  end
endtask
