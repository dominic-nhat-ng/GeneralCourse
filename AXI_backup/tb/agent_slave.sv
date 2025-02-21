class slave_axi_agent extends uvm_agent;
    `uvm_component_utils(slave_axi_agent)
    
    slave_axi_driver slave_driver;
    slave_axi_monitor slave_monitor;

    function new(string name="slave_axi_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        slave_driver = slave_axi_driver::type_id::create("slave_driver", this);
        slave_monitor = slave_axi_monitor::type_id::create("slave_monitor", this);
    endfunction


endclass
