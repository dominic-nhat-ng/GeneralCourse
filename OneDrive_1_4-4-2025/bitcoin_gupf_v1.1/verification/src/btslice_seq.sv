`ifndef BTSLICE_SEQ__SV
`define BTSLICE_SEQ__SV


typedef class btslice;
class btslice_seq extends uvm_sequencer # (btslice);

   `uvm_component_utils(btslice_seq)
   function new (string name,
                 uvm_component parent);
   super.new(name,parent);
   endfunction:new 
endclass:btslice_seq

`endif // BTSLICE_SEQ__SV
