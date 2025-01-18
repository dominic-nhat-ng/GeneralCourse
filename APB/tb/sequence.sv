// Sequence creates stimulus and drive them to the driver via sequencer
class adder_sequence extends uvm_sequence #(adder_sequence_item); 
  // registration
  `uvm_object_utils(adder_sequence) 
  adder_sequence_item tx;
  
  function new (string name = "adder_sequence");
    super.new(name);
    `uvm_info("Sequence class", "Constructor", UVM_MEDIUM);
  endfunction
  
  task body();
      forever begin
      tx = adder_sequence_item::type_id::create("tx");
      `uvm_info("ADDER SEQUENCE", "Base sequence: Inside body", UVM_LOW);

      wait_for_grant();
      tx.a = $urandom;
      tx.b = $urandom;
      tx.cin = $urandom;
      send_request(tx);
      wait_for_item_done();
      end
  endtask
endclass
