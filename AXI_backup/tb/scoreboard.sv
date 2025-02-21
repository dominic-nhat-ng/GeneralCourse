class axi_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(axi_scoreboard)

    function new(string name="axi_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction


endclass

