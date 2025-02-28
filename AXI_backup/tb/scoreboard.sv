class axi_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(axi_scoreboard)
    uvm_analysis_imp #(transaction, axi_scoreboard) scoreboard_analyasis_imp;
    function new(string name="axi_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scoreboard_analyasis_imp = new("scoreboard_analyasis_imp", this);
    endfunction

    virtual function void write(transaction item);
        `uvm_info(get_type_name, "Received item", UVM_MEDIUM)
    endfunction
endclass
