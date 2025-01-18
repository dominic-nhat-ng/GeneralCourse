// test class
/*
uvm components

test - environment - agent - driver - monitor - sequencer - scoreboard

uvm objects

sequence - sequence item
*/
class adder_test extends uvm_test; // uvm_test is a base test class 
  
  `uvm_component_utils(adder_test) // register class to the factory
  
  adder_env env; 
  adder_sequence seq;
  
  // standard constructor
  
  function new (string name = "adder_test", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info("Test class", "Constructor", UVM_MEDIUM);
    
  endfunction
  
  // --------------------build phase-----------------------
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    // create lower components
    env = adder_env::type_id::create("env", this);
    seq = adder_sequence::type_id::create("seq", this);
    
  endfunction
  
  // ------------------connect phase-----------------------
  function void connect_phase(uvm_phase phase);
    
    super.connect_phase(phase);
    `uvm_info("Test class", "connect phase", UVM_MEDIUM);
    
    //connect the components
    
  endfunction
  
  // end of elaboration phase
  virtual function void end_of_elaboration();
    
    `uvm_info("Test class", "elab phase", UVM_MEDIUM);
    print();
    
  endfunction
  
  task run_phase(uvm_phase phase);
    
    `uvm_info("Test Class", "run_phase", UVM_MEDIUM)
    
    phase.raise_objection(this);
    seq.start(env.agent.seqcer);
    phase.drop_objection(this);
    
  endtask
  
endclass
