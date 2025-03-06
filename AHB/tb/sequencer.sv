class ahb_sequencer extends uvm_sequencer#(transaction); 
  
  `uvm_component_utils(ahb_sequencer) 
  
  function new (string name = "ahb_sequencer", uvm_component parent);
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
  endfunction

  function void build_phase(uvm_phase phase);
      super.build_phase(phase);

  endfunction
endclass
