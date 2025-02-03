class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    virtual apb_intf intf;

    uvm_analysis_port #(transaction) transfer_item;
    transaction apb;

  // Constructor
    function new(string name = "apb_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Constructor executed", UVM_MEDIUM);
    endfunction

  // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        transfer_item = new("transfer_item", this);

      if(!uvm_config_db#(virtual apb_intf)::get(this, "", "intf", intf))
        `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
      `uvm_info(get_type_name(), "Build phase completed", UVM_MEDIUM);
    endfunction

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        
        forever begin
            apb = transaction::type_id::create("apb", this);
            @(posedge intf.P_ready);
            apb.type_trans = intf.P_write ? transaction::WRITE : transaction::READ;
            if(apb.type_trans == transaction::WRITE) begin
                apb.P_wdata = intf.P_wdata;
                apb.P_addr = intf.P_addr;

            end else begin
                apb.P_addr = intf.P_addr;
                apb.P_rdata = intf.P_rdata;
            end
            transfer_item.write(apb);
            apb.print();
        end
    endtask


endclass

