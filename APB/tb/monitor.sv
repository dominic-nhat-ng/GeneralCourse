class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    virtual dut_if intf;

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

      if(!uvm_config_db#(virtual dut_if)::get(this, "", "intf", intf))
        `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
      `uvm_info(get_type_name(), "Build phase completed", UVM_MEDIUM);
    endfunction

   //virtual task run_phase(uvm_phase phase);
   //  super.run_phase(phase);
   //  forever begin
   //    transaction tr;
   //    // Wait for a SETUP cycle
   //    do begin
   //      @ (this.vif.monitor_cb);
   //      end
   //      while (this.vif.monitor_cb.psel !== 1'b1 ||
   //             this.vif.monitor_cb.penable !== 1'b0);
   //      //create a transaction object
   //      tr = transaction::type_id::create("tr", this);
   //     
   //      //populate fields based on values seen on interface
   //    tr.pwrite = (this.vif.monitor_cb.pwrite) ? transaction::WRITE : transaction::READ;
   //      tr.addr = this.vif.monitor_cb.paddr;

   //      @ (this.vif.monitor_cb);
   //      if (this.vif.monitor_cb.penable !== 1'b1) begin
   //         `uvm_error("APB", "APB protocol violation: SETUP cycle not followed by ENABLE cycle");
   //      end
   //      
   //    if (tr.pwrite == apb_transaction::READ) begin
   //      tr.data = this.vif.monitor_cb.prdata;
   //    end
   //    else if (tr.pwrite == apb_transaction::WRITE) begin
   //      tr.data = this.vif.monitor_cb.pwdata;
   //    end
   //    
   //      uvm_report_info("APB_MONITOR", $psprintf("Got Transaction %s",tr.convert2string()));
   //      //Write to analysis port
   //      transfer_item.write(tr);
   //   end
   //endtask

endclass

