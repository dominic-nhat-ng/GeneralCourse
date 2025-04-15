class apb_env extends uvm_env;

    `uvm_component_utils(apb_env)

    apb_agent       agent;
    apb_scoreboard  scb;

    function new(string name = "apb_env", uvm_component parent=null);
        super.new(name, parent);
        agent   =   apb_agent::type_id::create("apb_agent", this);
        scb     =   apb_scoreboard::type_id::create("apb_scoreboard", this);
    endfunction 

endclass

