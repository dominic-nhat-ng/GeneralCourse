`ifndef BTCOIN_INTF__SV
`define BTCOIN_INTF__SV

interface btcoin_intf (input bit clk, input bit reset);

   parameter setup_time = 2ps/*ns*/;
   parameter hold_time  = 1ps/*ns*/;

   logic  [31:0]  secure_data_in;
   logic  [31:0]  hash_key;
   logic          data_valid;
   logic          lp_enable;
   logic  [31:0]  secure_data_out;
   logic  [20:0]  power_ack_signals;
   logic  [17:0]  sleep_signals;
   logic   [1:0]  isolation_signals;
   logic   [1:0]  retention_signals;

   clocking mck @(posedge clk);
      default input #setup_time output #hold_time;

      input power_ack_signals;
      input secure_data_out;

      output secure_data_in;
      output hash_key;
      output data_valid;
      output lp_enable;
      output sleep_signals;
      output isolation_signals;
      output retention_signals;
   endclocking: mck

   clocking sck @(posedge clk);
      default input #setup_time output #hold_time;

      input secure_data_in;
      input secure_data_out;
      input power_ack_signals;
      input data_valid;
      input lp_enable;
      input sleep_signals;
      input isolation_signals;
      input retention_signals;
   endclocking: sck

   modport master(clocking mck);

   modport slave(clocking sck);

endinterface: btcoin_intf

`endif // BTCOIN_INTF__SV
