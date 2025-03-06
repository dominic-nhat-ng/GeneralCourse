// test class
/*
uvm components

test - environment - agent - driver - monitor - sequencer - scoreboard

uvm objects

sequence - sequence item
*/
class ahb_test extends uvm_test; // uvm_test is a base test class 
    `uvm_component_utils(ahb_test)
    
    ahb_env     environment;

    function new(string name = "ahb_test", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment =   ahb_env::type_id::create("environment", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

    virtual function void end_of_elaboration_phase (uvm_phase phase);
      uvm_top.print_topology ();
   endfunction

   virtual task run_phase(uvm_phase phase);
        ahb_sequence    my_sequence = ahb_sequence::type_id::create("my_sequence", this);
        super.run_phase(phase);
        phase.raise_objection(this);
        my_sequence.start(environment.agent.sequencer);
        phase.drop_objection(this);
    endtask

endclass
