class slave_axi_driver extends uvm_driver;

    `uvm_component_utils(slave_axi_driver)

    function new(string name = "slave_axi_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass
