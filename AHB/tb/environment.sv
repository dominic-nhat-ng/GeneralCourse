class ahb_env extends uvm_env; // uvm_test is a base test class 
    `uvm_component_utils(ahb_env)

    ahb_agent       agent;

    function new(string name="ahb_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        agent   =   ahb_agent::type_id::create("agent", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
    endfunction

endclass
