class apb_env extends uvm_env; // uvm_test is a base test class 
  
    `uvm_component_utils(apb_env) // register class to the factory
  
  // standard constructor
  
    apb_agent agt;
    apb_scoreboard scb;
  
    function new (string name = "apb_env", uvm_component parent);
        
        super.new(name, parent);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
    endfunction
  
  
    function void build_phase(uvm_phase phase);
    
        super.build_phase(phase);
    
        agt = apb_agent::type_id::create("agent", this);
        scb = apb_scoreboard::type_id::create("scb", this);
    
    
    endfunction
  
  //connect phase
    function void connect_phase(uvm_phase phase);
    
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Connect phase", UVM_MEDIUM);
        agt.monitor.transfer_item.connect(scb.received_data);
    
    endfunction
  
  
endclass
