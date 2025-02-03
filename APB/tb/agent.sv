class apb_agent extends uvm_agent; // uvm_test is a base test class 
  
    `uvm_component_utils(apb_agent) // register class to the factory
  
    apb_driver driver;
    apb_monitor monitor;
    apb_sequencer seqcer;
  
  // standard constructor
  
    function new (string name = "apb_agent", uvm_component parent);
    
      super.new(name, parent);
      `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
    endfunction
  
    function void build_phase(uvm_phase phase);
    
      super.build_phase(phase);
      driver = apb_driver::type_id::create("driver", this);
      monitor = apb_monitor::type_id::create("monitor", this);
      seqcer = apb_sequencer::type_id::create("seqcer", this);
    
    endfunction
  
    //connect phase
  
    function void connect_phase(uvm_phase phase);
    
      super.connect_phase(phase);
      `uvm_info(get_type_name(), " connect phase", UVM_MEDIUM);
      // connecting driver sequencer using TLM ports
      driver.seq_item_port.connect(seqcer.seq_item_export);
    
    endfunction

  
  
endclass
