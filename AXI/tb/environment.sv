class axi_env extends uvm_env; // uvm_test is a base test class 
    `uvm_component_utils(axi_env)
    axi_scoreboard scoreboard;
    axi_agent agent;
    axi_agent_slave agent_slave;

    function new(string name = "axi_env", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        scoreboard = axi_scoreboard::type_id::create("scoreboard", this);
        agent = axi_agent::type_id::create("agent", this);
        agent_slave = axi_agent_slave::type_id::create("agent_slave", this);
    endfunction
endclass
