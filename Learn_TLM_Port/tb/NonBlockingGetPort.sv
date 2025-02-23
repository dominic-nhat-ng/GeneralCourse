class NonBlockingGetPortA extends uvm_component;
    `uvm_component_utils(NonBlockingGetPortA)

    uvm_nonblocking_get_imp #(packet, NonBlockingGetPortA) m_get_imp;
    function new(string name="NonBlockingGetPortA", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_get_imp = new("m_get_imp", this);
    endfunction
    packet pkt;
    virtual function bit try_get(output packet pkt);
        pkt = new();
        assert(pkt.random());
        pkt.print();
        `uvm_info(get_type_name(), "Component B has requested for a packet", UVM_LOW)
        return 1;
    endfunction

    virtual function bit can_get();
    endfunction

endclass

class NonBlockingGetPortB extends uvm_component;
    `uvm_component_utils(NonBlockingGetPortB)
    uvm_nonblocking_get_port #(packet) m_get_port;

    int m_num_req = 2;
    function new(string name ="NonBlockingGetPortB", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_get_port = new("m_get_port", this);
    endfunction
    packet pkt;
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        repeat(m_num_req) begin
            if(m_get_port.try_get(pkt))
                `uvm_info(get_type_name(), "Component A just gave me the packet", UVM_LOW)
            else
                `uvm_info(get_type_name(), "Component A did not give me the packet", UVM_LOW)
        end
        phase.drop_objection(this);
    endtask
endclass


