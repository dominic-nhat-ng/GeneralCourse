class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)
    virtual apb_intf        intf;

    function new(string name = "apb_monitor", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_intf)::get(this, "", "intf", intf))
        `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
      `uvm_info(get_type_name(), "Build phase completed", UVM_MEDIUM);
    endfunction 

endclass

