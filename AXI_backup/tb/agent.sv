class master_axi_agent extends uvm_agent;
    `uvm_component_utils(master_axi_agent)

    axi_sequencer sequencer;
    master_axi_driver master_driver;
    master_axi_monitor master_monitor;

    function new(string name="master_axi_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        master_driver = master_axi_driver::type_id::create("master_driver", this);
        master_monitor = master_axi_monitor::type_id::create("master_monitor", this);
        sequencer = axi_sequencer::type_id::create("sequencer", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        master_driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction

endclass
