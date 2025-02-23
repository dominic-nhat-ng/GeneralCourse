class ExSubcomp1 extends uvm_component;
    `uvm_component_utils(ExSubcomp1)
    uvm_blocking_put_port #(packet) m_put_port;

    function new(string name = "ExSubcomp1", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
    endfunction
    int m_num_tx = 3;
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        repeat(m_num_tx) begin
            packet pkt = packet::type_id::create("m_num_tx");
            assert(pkt.random());
            #50;
            `uvm_info(get_type_name(), "Subcomponent 1 sent data to Fifo in Component A", UVM_LOW)
            m_put_port.put(pkt);
        end
    endtask
endclass

class ExSubcomp2 extends uvm_component;
    `uvm_component_utils(ExSubcomp2)
    uvm_blocking_put_port #(packet) m_put_port;
    uvm_blocking_get_port #(packet) m_get_port;

    function new(string name="ExSubcomp2", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
        m_get_port = new("m_get_port", this);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        packet pkt;
        forever begin
            #100;
            m_get_port.get(pkt);
            `uvm_info(get_type_name(), "Packet received from Component A, forward it", UVM_LOW)
            pkt.print();
            m_put_port.put(pkt);
        end
    endtask
endclass

class ExComponentA extends uvm_component;
    `uvm_component_utils(ExComponentA)
    function new(string name = "ExComponentA", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    uvm_tlm_fifo #(packet)          m_tlm_fifo;
    uvm_blocking_put_port #(packet) m_put_port;
    int                             m_num_tx;

    ExSubcomp1 subcom1;
    ExSubcomp2 subcom2;

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_tlm_fifo = new("m_tlm_fifo", this, 2);
        m_put_port = new("m_put_port", this);

        subcom1 = ExSubcomp1::type_id::create("subcom1", this);
        subcom2 = ExSubcomp2::type_id::create("subcom2", this);

        subcomp1.m_num_tx = m_num_tx;
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        subcom1.m_put_port.connect(m_tlm_fifo.put_export);
        subcom2.m_get_port.connect(m_tlm_fifo.get_export);
        subcom2.m_put_port.connect(this.m_put_port);
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            #10 if(m_tlm_fifo.is_full()) begin
                `uvm_info(get_type_name, "TLM fifo is now full", UVM_LOW)
            end
        end

    endtask
endclass

class ExSubcomp3 extends uvm_component;
    `uvm_component_utils(ExSubcomp3)
    uvm_blocking_get_port #(packet) m_get_port;

endclass


class ExComponentB extends uvm_component;

endclass
class ExampleEnv extends uvm_env;

endclass

