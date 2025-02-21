class master_axi_monitor extends uvm_monitor;

    `uvm_component_utils(master_axi_monitor)

    function new(string name ="master_axi_monitor", uvm_component parent =null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass


