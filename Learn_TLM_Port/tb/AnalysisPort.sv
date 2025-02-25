class producer extends uvm_component;
    `uvm_component_utils(producer)
    uvm_blocking_put_port #(packet) m_put_port;

    function new(string name="producer", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_port = new("m_put_port", this);
    endfunction

    packet pkt;

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        repeat(3) begin
            pkt = packet::type_id::create("pkt");
            assert(pkt.random());
            `uvm_info(get_type_name, "Producing packet", UVM_LOW)
            pkt.print();
            m_put_port.put(pkt);
        end
    endtask
endclass

class sender extends uvm_component;
    `uvm_component_utils(sender)
    uvm_blocking_put_imp #(packet, sender)      m_put_export;
    uvm_analysis_port #(packet)                 m_analysis_port;

    function new(string name="sender", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_put_export = new("m_put_export", this);
        m_analysis_port = new("m_analysis_port", this);
    endfunction

    virtual task put(packet pkt);
        `uvm_info(get_type_name(), "Received packet from producer", UVM_LOW)
        pkt.print();
        m_analysis_port.write(pkt);  // Send to consumers
    endtask
endclass

class consumerA extends uvm_component;
    `uvm_component_utils(consumerA)

    uvm_analysis_imp #(packet, consumerA) m_analysis_imp;

    function new (string name="consumerA", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp = new("m_analysis_imp", this);
    endfunction

    virtual function void write(packet pkt);
        `uvm_info(get_type_name(), "Received data from sender", UVM_LOW)
        pkt.print();
    endfunction
endclass

class consumerB extends uvm_component;
    `uvm_component_utils(consumerB)
    uvm_analysis_imp #(packet, consumerB) m_analysis_imp;

    function new(string name="consumerB", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        m_analysis_imp = new("m_analysis_imp", this);
    endfunction

    virtual function void write(packet pkt);
        `uvm_info(get_type_name(), "Received data from sender", UVM_LOW)
        pkt.print();

    endfunction
endclass

class AnalysisEnv extends uvm_env;
    `uvm_component_utils(AnalysisEnv)
    producer    producer_inst;
    sender      sender_inst;
    consumerA   consumerA_inst;
    consumerB   consumerB_inst;

    function new(string name = "AnalysisEnv", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        producer_inst = producer::type_id::create("producer_inst", this);
        sender_inst = sender::type_id::create("sender_inst", this);
        consumerA_inst = consumerA::type_id::create("consumerA_inst", this);
        consumerB_inst = consumerB::type_id::create("consumerB_inst", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info(get_type_name(), "Connecting producer's put_port to sender's put_export", UVM_LOW)
        producer_inst.m_put_port.connect(sender_inst.m_put_export);
        `uvm_info(get_type_name(), "Connecting sender's analysis port to consumers", UVM_LOW)
        sender_inst.m_analysis_port.connect(consumerA_inst.m_analysis_imp);
        sender_inst.m_analysis_port.connect(consumerB_inst.m_analysis_imp);
    endfunction

    virtual task run_phase(uvm_phase phase);
        phase.raise_objection(this);
        #1000;
        phase.drop_objection(this);
    endtask
endclass
