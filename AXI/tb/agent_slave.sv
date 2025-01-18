class axi_agent_slave extends uvm_agent;
    `uvm_component_utils(axi_agent_slave)

    axi_sequencer_slave sequencer_slave;
    axi_driver_slave driver_slave;
    axi_monitor_slave monitor_slave;

    function new(string name = "axi_agent_slave", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        sequencer_slave = axi_sequencer_slave::type_id::create("sequencer_slave", this);
        driver_slave = axi_driver_slave::type_id::create("driver_slave", this);
        monitor_slave = axi_monitor_slave::type_id::create("monitor_slave", this);
    
    
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver_slave.seq_item_port.connect(sequencer_slave.seq_item_export);
    endfunction

endclass
