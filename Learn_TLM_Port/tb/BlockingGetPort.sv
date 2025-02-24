class BlockingGetPortA extends uvm_component;
    `uvm_component_utils(BlockingGetPortA)
    uvm_blocking_get_imp #(packet, BlockingGetPortA) m_get_imp;
    packet pkt;
    function new(string name ="BlockingGetPortA", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_get_imp = new("m_get_imp", this);
    endfunction

    virtual task get(packet pkt);
        pkt = new();
        assert(pkt.random());
        `uvm_info(get_type_name(), "Component B has requested for a packet", UVM_LOW)
        pkt.print();
    endtask

endclass

class BlockingGetPortB extends uvm_component;
    `uvm_component_utils(BlockingGetPortB)
    uvm_blocking_get_port #(packet) m_get_port;
    int m_num_req = 2;

    function new(string name ="BlockingGetPortB", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_get_port = new("m_get_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        packet pkt;
        phase.raise_objection(this);
        repeat(m_num_req) begin
            m_get_port.get(pkt);
            `uvm_info(get_type_name(), "Component A just gave me the packet", UVM_LOW)
            //pkt.print();
        end
        phase.drop_objection(this);
    endtask
endclass

