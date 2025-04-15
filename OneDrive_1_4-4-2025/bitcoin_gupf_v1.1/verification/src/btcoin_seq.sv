`ifndef BTCOIN_SEQ__SV
`define BTCOIN_SEQ__SV


typedef class btcoin;
class btcoin_seq extends uvm_sequencer # (btcoin);

   `uvm_component_utils(btcoin_seq)
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 
endclass:btcoin_seq

`endif // BTCOIN_SEQ__SV
