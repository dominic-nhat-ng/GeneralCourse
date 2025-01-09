class axi_monitor_slave extends uvm_monitor;
    `uvm_component_utils(axi_monitor_slave)

    function new(string name = "axi_monitor_slave", uvm_component parent = null);
        super.new(name, parent);
    endfunction


endclass
