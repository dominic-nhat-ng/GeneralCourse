class apb_driver extends uvm_driver #(transaction)

    `uvm_component_utils(apb_driver)
    virtual apb_intf    intf;


    function new(string name = "apb_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual apb_intf)::get(this, "", "intf", intf)) begin
            `uvm_fatal("no_inif in driver","virtual interface get failed from config db")
        end
        else
            `uvm_info(get_type_name(), "Driver connected to interface", UVM_MEDIUM)
    endfunction


endclass

