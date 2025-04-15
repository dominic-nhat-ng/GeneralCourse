class nested_sequence_lp1 extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(nested_sequence_lp1)
  `uvm_add_to_seq_lib(nested_sequence_lp1, btslice_lp_seq_sequence_library_seq1)

  sequence_0 normal_sequence;
  power_down_sequence pd_dwn_sequence;
  power_up_sequence pd_up_sequence;
  power_off_sequence pd_off_sequence;

  function new(string name = "nested_sequence_lp1");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new
  virtual task body();
   repeat(item_count) begin
	`uvm_do(pd_up_sequence);
	`uvm_do(normal_sequence);
	`uvm_do(normal_sequence);
	`uvm_do(pd_dwn_sequence);
   end
  endtask
endclass
class nested_sequence_lp2 extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(nested_sequence_lp2)
  `uvm_add_to_seq_lib(nested_sequence_lp2,btslice_lp_seq_sequence_library_seq1)

  sequence_0 normal_sequence;
  power_down_sequence pd_dwn_sequence;
  power_up_sequence pd_up_sequence;
  power_off_sequence pd_off_sequence;

  function new(string name = "nested_sequence_lp2");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new
  virtual task body();
   repeat(item_count) begin
	`uvm_do(pd_off_sequence);
	`uvm_do(pd_off_sequence);
	`uvm_do(pd_off_sequence);
	`uvm_do(pd_off_sequence);
   end
  endtask
endclass
class nested_sequence_lp3 extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(nested_sequence_lp3)
  `uvm_add_to_seq_lib(nested_sequence_lp3, btslice_lp_seq_sequence_library_seq2)

  sequence_0 normal_sequence;
  power_down_sequence pd_dwn_sequence;
  power_up_sequence pd_up_sequence;
  power_off_sequence pd_off_sequence;

  function new(string name = "nested_sequence_lp3");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new
  virtual task body();
   repeat(item_count) begin
	`uvm_do(pd_dwn_sequence);
	`uvm_do(pd_off_sequence);
	`uvm_do(pd_off_sequence);
	`uvm_do(pd_up_sequence);
   end
  endtask
endclass

class nested_sequence_lp4 extends base_sequence;

  int item_count = 1;
  `uvm_object_utils(nested_sequence_lp4)
  `uvm_add_to_seq_lib(nested_sequence_lp4, btslice_lp_seq_sequence_library_seq2)

  sequence_0 normal_sequence;
  power_down_sequence pd_dwn_sequence;
  power_up_sequence pd_up_sequence;
  power_off_sequence pd_off_sequence;

  function new(string name = "nested_sequence_lp3");
    super.new(name);
	`ifdef UVM_POST_VERSION_1_1
     set_automatic_phase_objection(1);
    `endif
  endfunction:new
  virtual task body();
   repeat(item_count) begin
	`uvm_do(normal_sequence);
	`uvm_do(normal_sequence);
	`uvm_do(normal_sequence);
	`uvm_do(normal_sequence);
   end
  endtask
endclass
