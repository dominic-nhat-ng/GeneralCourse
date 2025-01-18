class adder_sequencer extends uvm_sequencer#(adder_sequence_item); // uvm_test is a base test class 
  
  `uvm_component_utils(adder_sequencer) // register class to the factory
  
  function new (string name = "adder_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info("Sequencer class", "Constructor", UVM_MEDIUM);
  endfunction

  function void build_phase(uvm_phase phase);
      super.build_phase(phase);

  endfunction
endclass
