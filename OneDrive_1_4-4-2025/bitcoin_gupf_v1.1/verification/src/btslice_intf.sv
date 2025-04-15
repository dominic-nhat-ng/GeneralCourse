`ifndef BTSLICE_INTF__SV
`define BTSLICE_INTF__SV

interface btslice_intf (input bit clk, input bit reset);

   parameter setup_time = 2ps/*ns*/;
   parameter hold_time  = 1ps/*ns*/;

   logic          sin;
   logic          data_valid;
   logic          memory_sleep;
   logic   [1:0]  shut_down_signals;
   logic   [1:0]  isolation_signals;
   logic   [1:0]  retention_signals;
   logic          sout;
   logic          memory_ack;
   logic          PG_ack_signals;

   clocking mck @(posedge clk);
      default input #setup_time output #hold_time;

      input memory_ack;
      input PG_ack_signals;
      input sout;

      output sin;
      output data_valid;
      output memory_sleep;
      output shut_down_signals;
      output isolation_signals;
      output retention_signals;
   endclocking: mck

   clocking sck @(posedge clk);
      default input #setup_time output #hold_time;

      input sin;
      input sout;
      input memory_ack;
      input data_valid;
      input PG_ack_signals;
      input shut_down_signals;
      input isolation_signals;
      input retention_signals;
   endclocking: sck

   modport master(clocking mck);

   modport slave(clocking sck);

endinterface: btslice_intf

`endif // BTSLICE_INTF__SV
