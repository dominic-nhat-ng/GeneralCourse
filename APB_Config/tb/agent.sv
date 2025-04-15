class apb_agent extends uvm_agent;
    `uvm_component_utils(apb_agent)

    apb_driver      drv;
    apb_monitor     mon;
    apb_sequencer   seqcer;

    function new(string name = "apb_agent", uvm_component parent=null);
        super.new(name , parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        drv     =   apb_driver::type_id::create("drv", this);
        mon     =   apb_monitor::type_id::create("mon", this);
        seqcer  =   apb_sequencer::type_id::create("seqcer", this);
    endfunction


endclass
