class Fifo_ComponentA extends uvm_component;
    `uvm_component_utils(Fifo_ComponentA)

    uvm_blocking_put_port #(packet) m_put_port;
    function new(string name = "Fifo_ComponentA", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
    endfunction
    int m_num_tx = 2; 
    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        repeat(m_num_tx) begin
            packet pkt = packet::type_id::create("pkt");
            assert(pkt.random());
            #50;
            `uvm_info(get_type_name(), "Packet sent to Component B", UVM_LOW)
            m_put_port.put(pkt);
        end 
        phase.drop_objection(this);
    endtask
endclass

class Fifo_ComponentB extends uvm_component;
    `uvm_component_utils(Fifo_ComponentB)

    uvm_blocking_get_port #(packet) m_get_port;
    int m_num_req = 2;

    function new(string name = "Fifo_ComponentB", uvm_component parent = null);
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
            #100;
            m_get_port.get(pkt);
            `uvm_info(get_type_name(), "Component A just gave me the packet", UVM_LOW)
            pkt.print();

        end
        phase.drop_objection(this);

    endtask
endclass

