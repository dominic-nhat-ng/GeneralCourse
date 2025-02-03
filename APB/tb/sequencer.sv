class apb_sequencer extends uvm_sequencer#(transaction); // uvm_test is a base test class 
  
  `uvm_component_utils(apb_sequencer) // register class to the factory
  
  function new (string name = "apb_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
  endfunction

  function void build_phase(uvm_phase phase);
      super.build_phase(phase);

  endfunction
endclass
