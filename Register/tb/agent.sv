class adder_agent extends uvm_agent; // uvm_test is a base test class 
  
  `uvm_component_utils(adder_agent) // register class to the factory
  
  adder_driver driver;
  adder_monitor monitor;
  adder_sequencer seqcer;
  
  // standard constructor
  
  function new (string name = "adder_agent", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info("Agent class", "Constructor", UVM_MEDIUM);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    driver = adder_driver::type_id::create("driver", this);
    monitor = adder_monitor::type_id::create("monitor", this);
    seqcer = adder_sequencer::type_id::create("seqcer", this);
    
  endfunction
  
  //connect phase
  
  function void connect_phase(uvm_phase phase);
    
    super.connect_phase(phase);
    `uvm_info("Agent Class", " connect phase", UVM_MEDIUM);
    // connecting driver sequencer using TLM ports
    driver.seq_item_port.connect(seqcer.seq_item_export);
    
  endfunction

  
  
endclass
