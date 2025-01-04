class adder_env extends uvm_env; // uvm_test is a base test class 
  
  `uvm_component_utils(adder_env) // register class to the factory
  
  // standard constructor
  
  adder_agent agent;
  adder_scoreboard scb;
  
  function new (string name = "adder_env", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info("Environment class", "Constructor", UVM_MEDIUM);
    
  endfunction
  
  // build phase
  
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    agent = adder_agent::type_id::create("agent", this);
    scb = adder_scoreboard::type_id::create("scb", this);
    
    
  endfunction
  
  //connect phase
  function void connect_phase(uvm_phase phase);
    
    super.connect_phase(phase);
    `uvm_info("Environment Class", "Connect phase", UVM_MEDIUM);
    agent.monitor.item_collected_port.connect(scb.item_collected_export);
    
  endfunction
  
  
endclass
