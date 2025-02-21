class master_axi_driver extends uvm_driver #(transaction);

    `uvm_component_utils(master_axi_driver)

    function new(string name = "master_axi_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
    endfunction


endclass

