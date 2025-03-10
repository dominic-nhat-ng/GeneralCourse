class ahb_agent extends uvm_agent; // uvm_test is a base test class 
    `uvm_component_utils(ahb_agent)
    
    ahb_driver          driver;
    ahb_sequencer       sequencer;
    ahb_monitor         monitor;


    function new(string name="ahb_agent", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        driver      =   ahb_driver::type_id::create("driver", this);
        sequencer   =   ahb_sequencer::type_id::create("sequencer",this);
        monitor     =   ahb_monitor::type_id::create("monitor", this);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        driver.seq_item_port.connect(sequencer.seq_item_export);
    endfunction
endclass
