class axi_agent extends uvm_agent; // uvm_test is a base test class 

    `uvm_component_utils(axi_agent)

    axi_sequencer sequencer;
    axi_driver driver;
    axi_monitor monitor;

    function new(string name = "axi_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequencer = axi_sequencer::type_id::create("sequencer", this);
        driver = axi_driver::type_id::create("driver", this);
        monitor = axi_monitor::type_id::create("monitor", this);

    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);

    endfunction

endclass
