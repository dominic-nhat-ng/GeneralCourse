// test class
/*
uvm components

test - environment - agent - driver - monitor - sequencer - scoreboard

uvm objects

sequence - sequence item
*/
class axi_test extends uvm_test; // uvm_test is a base test class 
    `uvm_component_utils(axi_test)
    axi_env environment;
    sequence_fixed seq_fixed;

    function new (string name = "axi_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = axi_env::type_id::create("environment", this);
        seq_fixed = sequence_fixed::type_id::create("seq", this);
    endfunction

    virtual function void end_of_elaboration();
        `uvm_info("Test class", "Elaboration phase", UVM_NONE);
        print();
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        //$display("Loop %d", i);
        phase.raise_objection(this);
        seq_fixed.start(environment.agent.sequencer);
        //repeat(2) seq_fixed.start(environment.agent.sequencer);
        phase.drop_objection(this);

    endtask
endclass

//class test_fixed_mode extends axi_test;
//    `uvm_component_utils(test_fixed_mode)
//
//    function new(string name = "test_fixed_mode", uvm_component parent = null);
//        super.new(name, parent);
//    endfunction
//
//    virtual function void build_phase(uvm_phase);
//        super.build_phase(phase);
//    endfunction
//
//endclass
//
//class test_incr_mode extends axi_test;
//
//    `uvm_component_utils(test_incr_mode)
//
//    function new(string name = "test_incr_mode", uvm_component parent = null);
//        super.new(name, parent);
//    endfunction
//
//    virtual function void build_phase(uvm_phase);
//        super.build_phase(phase);
//    endfunction
//
//endclass
//
//
//class test_wrap_mode extends axi_test;
//
//    `uvm_component_utils(test_wrap_mode)
//
//    function new(string name = "test_wrap_mode", uvm_component parent = null);
//        super.new(name, parent);
//    endfunction
//
//    virtual function void build_phase(uvm_phase);
//        super.build_phase(phase);
//    endfunction
//
//endclass
