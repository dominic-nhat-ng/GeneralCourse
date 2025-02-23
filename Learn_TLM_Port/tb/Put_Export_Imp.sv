class subcomponentA extends uvm_component;
    `uvm_component_utils(subcomponentA)

    function new(string name ="subcomponentA", uvm_component parent =null);
        super.new(name, parent);
    endfunction

    uvm_blocking_put_port #(packet) m_put_port;
    int m_num_tx = 2;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
    endfunction
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        repeat(m_num_tx) begin
            packet pkt = packet::type_id::create("pkt");
            assert(pkt.random());
            `uvm_info(get_type_name(), "Packet sent to subcomponentB", UVM_LOW)
            pkt.print();
            m_put_port.put(pkt);
        end
        phase.drop_objection(this);
    endtask
endclass

class componentA extends uvm_component;
    `uvm_component_utils(componentA)
    function new(string name = "componentA", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    subcomponentA subcmpA;
    uvm_blocking_put_port #(packet) m_put_port;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        subcmpA = subcomponentA::type_id::create("subcmpA", this);
        m_put_port = new("m_put_port", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        subcmpA.m_put_port.connect(this.m_put_port);
    endfunction
endclass

class subcomponentB extends uvm_component;
    `uvm_component_utils(subcomponentB)
    uvm_blocking_put_imp #(packet, subcomponentB) m_put_imp;

    function new(string name = "subcomponentB", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_imp = new("m_put_imp", this);
    endfunction

    virtual task put(packet pkt);
        `uvm_info(get_type_name(), "Packet received from subcomponentA", UVM_LOW)
        pkt.print();
    endtask
endclass

class componentB extends uvm_component;
    `uvm_component_utils(componentB)
    uvm_blocking_put_export #(packet) m_put_export;
    subcomponentB subcmpB;

    function new(string name ="componentB", uvm_component parent= null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_export = new("m_put_export", this);
        subcmpB = subcomponentB::type_id::create("subcmpB", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        m_put_export.connect(subcmpB.m_put_imp);
    endfunction

endclass

class TLM_Environment extends uvm_env;
    `uvm_component_utils(TLM_Environment)
    componentA cmpA;
    componentB cmpB;

    function new(string name ="TLM_Environment", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cmpA = componentA::type_id::create("cmpA", this);
        cmpB = componentB::type_id::create("cmpB", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cmpA.m_put_port.connect(cmpB.m_put_export);
    endfunction
endclass
