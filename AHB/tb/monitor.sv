class ahb_monitor extends uvm_monitor;
    `uvm_component_utils(ahb_monitor)
    virtual ahb_intf    intf;
    function new(string name="ahb_monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (! uvm_config_db #(virtual ahb_intf) :: get (this, "", "intf", intf)) begin
            `uvm_error (get_type_name (), "DUT interface not found")
        end
    endfunction

endclass

