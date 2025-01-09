class axi_sequencer_slave extends uvm_sequencer #(transaction);
    
    `uvm_component_utils(axi_sequencer_slave)

    //transaction item;

    function new(string name = "axi_sequencer_slave", uvm_component parent =null);
        super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction
endclass
