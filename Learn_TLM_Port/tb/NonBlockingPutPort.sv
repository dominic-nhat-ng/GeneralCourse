class NonBlockingPutPortA extends uvm_component;
    `uvm_component_utils(NonBlockingPutPortA)
    uvm_nonblocking_put_port #(packet) m_put_port;
    int m_num_tx;
    function new(string name ="NonBlockingPutPortA", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(phase);
        repeat(m_num_tx) begin
            bit success;
            packet pkt = packet::type_id::create("pkt");
            assert(pkt.random());
            `uvm_info(get_type_name, "Packet sent to componentB", UVM_LOW)
            pkt.print();

            success = m_put_port.try_put(pkt);
            if(success)
                `uvm_info(get_type_name, "Component B was ready to accept and transfer is successful", UVM_LOW)
            else
                `uvm_info(get_type_name, "Component B was NOT ready to accept and transfer is failed", UVM_LOW)
        end
        phase.drop_objection(phase);
    endtask
endclass

class NonBlockingPutPortB extends uvm_component;
    `uvm_component_utils(NonBlockingPutPortB)
    uvm_nonblocking_put_imp #(packet, NonBlockingPutPortB) m_put_imp;

    function new(string name = "NoneBlockingPutPortB", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_imp = new("m_put_imp", this);
    endfunction

    virtual function bit try_put(packet pkt);
        `uvm_info(get_type_name(), "Packet received", UVM_LOW)
        pkt.print();
        return 1;
    endfunction

    virtual function bit can_put();
    endfunction
endclass



