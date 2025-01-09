class axi_scoreboard extends uvm_scoreboard;
  
    `uvm_component_utils(axi_scoreboard)

    function new(string name = "axi_scoreboard", uvm_component parent = null);
        super.new(name, parent);
    endfunction
    
    //uvm_analysis_imp #(transaction, axi_scoreboard) item_export;

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        //item_export = new("item_export", this);
    endfunction



endclass

