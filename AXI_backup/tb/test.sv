class axi_test extends uvm_test; // uvm_test is a base test class 
    `uvm_component_utils(axi_test)
    axi_environment environment;
    axi_sequence seq;

    function new (string name = "axi_test", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = axi_environment::type_id::create("environment", this);
        seq = axi_sequence::type_id::create("seq", this);
    endfunction

    virtual function void end_of_elaboration();
        `uvm_info("Test class", "Elaboration phase", UVM_NONE);
        print();
    endfunction

    virtual task run_phase(uvm_phase phase);
        //super.run_phase(phase);
        phase.raise_objection(this);
        repeat(3) seq.start(environment.master_agent.sequencer);
        phase.drop_objection(this);

    endtask

endclass

