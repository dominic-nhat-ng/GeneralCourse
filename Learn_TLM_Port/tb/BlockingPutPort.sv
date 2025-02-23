class BlockingPutPortA extends uvm_component;

    `uvm_component_utils(BlockingPutPortA)
    uvm_blocking_put_port #(packet) m_put_port;
    int m_num_tx;
    function new (string name ="BlockingPutPortA", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        phase.raise_objection(this);
        repeat(m_num_tx) begin
            packet pkt = packet::type_id::create("pkt");
            assert(pkt.random());
            `uvm_info(get_type_name(), "Packet from componentA", UVM_LOW)
            pkt.print();
            m_put_port.put(pkt);
        end
        phase.drop_objection(this);
    endtask
endclass

class BlockingPutPortB extends uvm_component;
    `uvm_component_utils(BlockingPutPortB)
    uvm_blocking_put_imp #(packet, BlockingPutPortB) m_put_imp;

    function new(string name ="BlockingPutPortB", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_imp = new("m_put_imp", this);
    endfunction

    virtual task put(packet pkt);
        `uvm_info(get_type_name, "Packet received from component A", UVM_LOW)
        pkt.print();
    endtask

endclass
