// test class
/*
uvm components

test - environment - agent - driver - monitor - sequencer - scoreboard

uvm objects

sequence - sequence item
*/
class apb_test extends uvm_test; // uvm_test is a base test class 
  
  `uvm_component_utils(apb_test) // register class to the factory
  
  apb_env env; 
  apb_sequence seq;
  
  // standard constructor
  
  function new (string name = "apb_test", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
  endfunction
  
  // --------------------build phase-----------------------
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    // create lower components
    env = apb_env::type_id::create("env", this);
    seq = apb_sequence::type_id::create("seq", this);
    
  endfunction
  
  // ------------------connect phase-----------------------
  //function void connect_phase(uvm_phase phase);
  //  
  //  super.connect_phase(phase);
  //  `uvm_info("Test class", "connect phase", UVM_MEDIUM);
  //  
  //  //connect the components
  //  
  //endfunction
  
  // end of elaboration phase
  virtual function void end_of_elaboration();
    
    `uvm_info(get_type_name(), "elab phase", UVM_MEDIUM);
    print();
    
  endfunction
  
  task run_phase(uvm_phase phase);
    
    `uvm_info(get_type_name(), "run_phase", UVM_MEDIUM)
    
    phase.raise_objection(this);
    repeat(100) seq.start(env.agent.seqcer);
    phase.drop_objection(this);
    
  endtask
  
endclass
