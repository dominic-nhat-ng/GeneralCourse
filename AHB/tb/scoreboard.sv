class ahb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(ahb_scoreboard)

    function new(string name="ahb_scoreboard", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

endclass
