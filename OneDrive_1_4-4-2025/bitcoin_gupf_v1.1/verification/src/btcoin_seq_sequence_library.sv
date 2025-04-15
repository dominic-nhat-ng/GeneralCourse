`ifndef BTCOIN_SEQ_SEQUENCE_LIBRARY__SV
`define BTCOIN_SEQ_SEQUENCE_LIBRARY__SV


typedef class btcoin;

class btcoin_seq_sequence_library extends uvm_sequence_library # (btcoin);
  
  `uvm_object_utils(btcoin_seq_sequence_library)
  `uvm_sequence_library_utils(btcoin_seq_sequence_library)

  function new(string name = "simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class btcoin_seq_sequence_library_simple extends uvm_sequence_library # (btcoin);
  
  `uvm_object_utils(btcoin_seq_sequence_library_simple)
  `uvm_sequence_library_utils(btcoin_seq_sequence_library_simple)

  function new(string name = "simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class btcoin_lp_seq_sequence_library_seq1 extends uvm_sequence_library # (btcoin);
  
  `uvm_object_utils(btcoin_lp_seq_sequence_library_seq1)
  `uvm_sequence_library_utils(btcoin_lp_seq_sequence_library_seq1)

  function new(string name = "lp_simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class btcoin_lp_seq_sequence_library_seq2 extends uvm_sequence_library # (btcoin);
  
  `uvm_object_utils(btcoin_lp_seq_sequence_library_seq2)
  `uvm_sequence_library_utils(btcoin_lp_seq_sequence_library_seq2)

  function new(string name = "lp_simple_seq_lib");
    super.new(name);
    init_sequence_library();
  endfunction

endclass  

class base_sequence extends uvm_sequence #(btcoin);
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
  `uvm_add_to_seq_lib(sequence_0,btcoin_seq_sequence_library)

  function new(string name = "seq_0");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
    repeat(item_count) begin
      `uvm_do_with(req, {data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; lp_enable == 1;} );
    end
  endtask
endclass

class sequence_1 extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(sequence_1)
  `uvm_add_to_seq_lib(sequence_1, btcoin_seq_sequence_library_simple)

  function new(string name = "seq_1");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
    repeat(item_count) begin
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'haaaaaaa; hash_key == 32'h55555555; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00000000; hash_key == 32'h00000000; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h11111111; hash_key == 32'h11111111; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'hffffffff; hash_key == 32'hffffffff; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h55555555; hash_key == 32'haaaaaaaa; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00000001; hash_key == 32'h00000001; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00000010; hash_key == 32'h00000010; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00000100; hash_key == 32'h00000100; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00001000; hash_key == 32'h00001000; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00010000; hash_key == 32'h00010000; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h00100000; hash_key == 32'h00100000; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h01000000; hash_key == 32'h01000000; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h10000000; hash_key == 32'h10000000; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h10101010; hash_key == 32'h10101010; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'h01010101; hash_key == 32'h01010101; lp_enable == 1;} );
      `uvm_do_with(req, { data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b0; secure_data_in == 32'hffffffff; hash_key == 32'hffffffff; lp_enable == 1;} );
    end
  endtask
endclass

class power_down_sequence extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(power_down_sequence)
  //`uvm_add_to_seq_lib(power_down_sequence, btcoin_lp_seq_sequence_library)

  function new(string name = "power_down_sequence");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
   repeat(item_count) begin
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b00;  lp_enable == 0; secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b11;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'b0; retention_signals == 2'b00; isolation_signals == 2'b11;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'h30000; retention_signals == 2'b00; isolation_signals == 2'b11;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
   end
  endtask
endclass
class power_up_sequence extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(power_up_sequence)
  //`uvm_add_to_seq_lib(power_down_sequence, btcoin_lp_seq_sequence_library)

  function new(string name = "power_up_sequence");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
   repeat(item_count) begin
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'h30000; retention_signals == 2'b00; isolation_signals == 2'b11;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'b0; retention_signals == 2'b00; isolation_signals == 2'b11;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(4) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b11;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(2) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b00;  lp_enable == 0;secure_data_in == 32'h00000000; hash_key == 32'h00000000;} );
    end
    repeat(2) begin
      `uvm_do_with(req, {data_valid == 1'b1; sleep_signals == 18'b0; retention_signals == 2'b11; isolation_signals == 2'b00;  lp_enable == 1;} );
    end
   end
  endtask
endclass
class power_off_sequence extends base_sequence;

  int item_count = 16;
  `uvm_object_utils(power_off_sequence)
  //`uvm_add_to_seq_lib(power_down_sequence, btcoin_lp_seq_sequence_library)

  function new(string name = "power_off_sequence");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new

  virtual task body();
   repeat(item_count) begin
      `uvm_do_with(req, {data_valid == 1'b0; sleep_signals == 18'h30000; retention_signals == 2'b00; isolation_signals == 2'b11;  lp_enable == 0; secure_data_in == 32'h0000000; hash_key == 32'h00000000;} );
   end
  endtask
endclass

//Nested Sequences
`include "btcoin_seq_sequence_library_nested.sv"
`endif // BTCOIN_SEQ_SEQUENCE_LIBRARY__Sl
