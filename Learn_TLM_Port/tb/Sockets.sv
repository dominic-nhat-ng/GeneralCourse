class initiator extends uvm_component;
    `uvm_component_utils(initiator)
    
    uvm_tlm_b_initiator_socket #(packet)    initSocket;
    uvm_tlm_time                            delay;
    packet                                  pkt;

    function new(string name = "initiator", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        initSocket = new("initiSocket", this);
        delay = new();
    endfunction 

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        repeat(5) begin
            pkt = packet::type_id::create("pkt");
            assert(pkt.random());
            `uvm_info(get_type_name(), "Packet sent to target", UVM_LOW)
            pkt.print();
            initSocket.b_transport(pkt, delay);
        end
    
    endtask
endclass

class target extends uvm_component;
    `uvm_component_utils(target)
    uvm_tlm_b_target_socket #(target, packet)   targetSocket;

    function new(string name = "target", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        targetSocket = new("targetSocket", this);
    endfunction

    task b_transport(packet pkt, uvm_tlm_time delay);
        `uvm_info(get_type_name, "Packet Received from initiator", UVM_LOW)
        pkt.print();
    endtask

endclass

class sockets_env extends uvm_env;
    `uvm_component_utils(sockets_env)
    
    initiator           init;
    target              tgt;

    function new(string name="sockets_env", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        init = initiator::type_id::create("init", this);
        tgt = target::type_id::create("tgt", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        init.initSocket.connect(tgt.targetSocket);
    endfunction

endclass

