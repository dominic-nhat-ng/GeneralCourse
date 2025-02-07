class axi_sequencer extends uvm_sequencer#(transaction); // uvm_test is a base test class 
  
    `uvm_component_utils(axi_sequencer)

    function new (string name = "axi_sequencer", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
    endfunction
endclass
