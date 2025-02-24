class master_axi_monitor extends uvm_monitor;

    `uvm_component_utils(master_axi_monitor)
    virtual axi_if intf;

    function new(string name ="master_axi_monitor", uvm_component parent =null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_error("Interface Error", "DUT interface not found")
        end
        else
            `uvm_info("Connect interface", "Monitor connected interface", UVM_NONE)

    endfunction
endclass


