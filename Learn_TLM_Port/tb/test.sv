`include "BlockingPutPort.sv"
`include "NonBlockingPutPort.sv"
`include "Put_Export_Imp.sv"
`include "BlockingGetPort.sv"
`include "NonBlockingGetPort.sv"
`include "FiFo.sv"
`include "Example.sv"
`include "AnalysisPort.sv"
`include "Sockets.sv"
class testbase extends uvm_test;
    `uvm_component_utils(testbase)

    function new (string name="testbase", uvm_component parent=null);
        super.new(name, parent);
    endfunction

endclass

class test_BlockingPutPort extends uvm_test;
    
    `uvm_component_utils(test_BlockingPutPort)
    BlockingPutPortA componentA;
    BlockingPutPortB componentB;

    function new(string name="test_BlockingPutPort", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        componentA = BlockingPutPortA::type_id::create("componentA", this);
        componentB = BlockingPutPortB::type_id::create("componentB", this);
        componentA.m_num_tx = 2;
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        componentA.m_put_port.connect(componentB.m_put_imp);
    endfunction
endclass

class test_NonBlockingPutPort extends testbase;
    `uvm_component_utils(test_NonBlockingPutPort)
    NonBlockingPutPortA componentA;
    NonBlockingPutPortB componentB;

    function new (string name ="test_NoneBlockingPutPort", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        componentA = NonBlockingPutPortA::type_id::create("componentA", this);
        componentB = NonBlockingPutPortB::type_id::create("componentB", this);
        componentA.m_num_tx = 3;
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        componentA.m_put_port.connect(componentB.m_put_imp);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass

class test_PortExportImp extends testbase;
    `uvm_component_utils(test_PortExportImp)
    TLM_Environment environment;

    function new(string name ="test_PortExportImp", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = TLM_Environment::type_id::create("environment", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass

class test_BlockingGetPort extends testbase;
    `uvm_component_utils(test_BlockingGetPort)

    BlockingGetPortA cmpA;
    BlockingGetPortB cmpB;
    function new(string name ="test_BlockingGetPort", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cmpA = BlockingGetPortA::type_id::create("cmpA", this);
        cmpB = BlockingGetPortB::type_id::create("cmpB", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cmpB.m_get_port.connect(cmpA.m_get_imp);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass

class test_NonBlockingGetPort extends testbase;
    `uvm_component_utils(test_NonBlockingGetPort)

    NonBlockingGetPortA cmpA;
    NonBlockingGetPortB cmpB;

    function new(string name="test_NonBlockingGetPort", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        cmpA = NonBlockingGetPortA::type_id::create("cmpA", this);
        cmpB = NonBlockingGetPortB::type_id::create("cmpB", this);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        cmpB.m_get_port.connect(cmpA.m_get_imp);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass

class test_fifo extends testbase;
    `uvm_component_utils(test_fifo)
    Fifo_ComponentA fifo_A;
    Fifo_ComponentB fifo_B;
    uvm_tlm_fifo #(packet) m_tlm_fifo;
    int m_num_tx;

    function new(string name ="test_fifo", uvm_component parent =null);
        super.new(name, parent);
    endfunction
    
    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        fifo_A = Fifo_ComponentA::type_id::create("fifo_A", this);
        fifo_B = Fifo_ComponentB::type_id::create("fifo_B", this);
        m_num_tx = 10;
        fifo_A.m_num_tx = m_num_tx;
        fifo_B.m_num_req = m_num_tx;

        m_tlm_fifo = new("m_tlm_fifo", this, 2);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        fifo_A.m_put_port.connect(m_tlm_fifo.put_export);
        fifo_B.m_get_port.connect(m_tlm_fifo.get_export);
    endfunction

    virtual task run_phase(uvm_phase phase);
        forever begin
            #10;
            if(m_tlm_fifo.is_full())
                `uvm_info(get_type_name(), "Fifo is now full !!!", UVM_LOW)
        end
    endtask
endclass

class test_example extends testbase;
    `uvm_component_utils(test_example)
    ExampleEnv environment_ex;

    function new(string name = "test_example", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment_ex = ExampleEnv::type_id::create("environment_ex", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass

class test_AnalysisPort extends testbase;
    `uvm_component_utils(test_AnalysisPort)

    AnalysisEnv analysis_environment;

    function new(string name ="test_AnalysisPort", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        analysis_environment = AnalysisEnv::type_id::create("analysis_environment", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction

endclass


class test_Sockets extends testbase;
    `uvm_component_utils(test_Sockets)

    sockets_env environment;

    function new(string name="test_Sockets", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        environment = sockets_env::type_id::create("environment", this);
    endfunction

    virtual function void end_of_elaboration_phase(uvm_phase phase);
        super.end_of_elaboration_phase(phase);
        uvm_top.print_topology();
    endfunction
endclass


