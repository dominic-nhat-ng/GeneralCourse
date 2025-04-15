`ifndef BTSLICE_SEQ_SEQUENCE_LIBRARY__SV
`define BTSLICE_SEQ_SEQUENCE_LIBRARY__SV


typedef class btslice;

class btslice_seq_sequence_library extends uvm_sequence_library # (btslice);
  
  `uvm_object_utils(btslice_seq_sequence_library)
  `uvm_sequence_library_utils(btslice_seq_sequence_library)

  function new(string name = "simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class btslice_seq_sequence_library_simple extends uvm_sequence_library # (btslice);
  
  `uvm_object_utils(btslice_seq_sequence_library_simple)
  `uvm_sequence_library_utils(btslice_seq_sequence_library_simple)

  function new(string name = "simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class btslice_lp_seq_sequence_library_seq1 extends uvm_sequence_library # (btslice);
  
  `uvm_object_utils(btslice_lp_seq_sequence_library_seq1)
  `uvm_sequence_library_utils(btslice_lp_seq_sequence_library_seq1)

  function new(string name = "lp_simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class btslice_lp_seq_sequence_library_seq2 extends uvm_sequence_library # (btslice);
  
  `uvm_object_utils(btslice_lp_seq_sequence_library_seq2)
  `uvm_sequence_library_utils(btslice_lp_seq_sequence_library_seq2)

  function new(string name = "lp_simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class base_sequence extends uvm_sequence #(btslice);
  `uvm_object_utils(base_sequence)

  function new(string name = "base_seq");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  `ifdef UVM_VERSION_1_0
  virtual task pre_body();
    if (starting_phase != null)
      starting_phase.raise_objection(this);
  endtask:pre_body

  virtual task post_body();
    if (starting_phase != null)
      starting_phase.drop_objection(this);
  endtask:post_body
  `endif
  
  `ifdef UVM_VERSION_1_1
  virtual task pre_start();
    if((get_parent_sequence() == null) && (starting_phase != null))
      starting_phase.raise_objection(this, "Starting");
  endtask:pre_start

  virtual task post_start();
    if ((get_parent_sequence() == null) && (starting_phase != null))
      starting_phase.drop_objection(this, "Ending");
  endtask:post_start
  `endif
endclass

class sequence_0 extends base_sequence;
  int item_count = 16;
  `uvm_object_utils(sequence_0)
  `uvm_add_to_seq_lib(sequence_0,btslice_seq_sequence_library)

  function new(string name = "seq_0");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
    repeat(item_count) begin
      `uvm_do_with(req, {data_valid == 1'b1; memory_sleep == 1'b0; retention_signals == 2'b11; isolation_signals == 2'b0; shut_down_signals == 2'b0;} );
    end
  endtask
endclass

//Nested Sequences
//`include "btslice_seq_sequence_library_nested.sv"
`endif // BTSLICE_SEQ_SEQUENCE_LIBRARY__Sl
