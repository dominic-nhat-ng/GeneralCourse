class axi_environment extends uvm_env;
    `uvm_component_utils(axi_environment)

    axi_scoreboard scoreboard;
    slave_axi_agent slave_agent;
    master_axi_agent master_agent;

    function new(string name="axi_environment", uvm_component parent=null);
        super.new(name,parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        scoreboard = axi_scoreboard::type_id::create("scoreboard", this);
        slave_agent = slave_axi_agent::type_id::create("slave_agent", this);
        master_agent = master_axi_agent::type_id::create("master_agent", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        master_agent.master_monitor.monitor_analysis_port.connect(scoreboard.monitor_port);
        master_agent.master_driver.driver_put_port.connect(scoreboard.driver_port);

    endfunction
endclass


