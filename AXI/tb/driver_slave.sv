class axi_driver_slave extends uvm_driver#(transaction);

    `uvm_component_utils(axi_driver_slave)
    function new(string name = "axi_driver_slave", uvm_component parent = null);
        super.new(name, parent);
    endfunction
endclass
