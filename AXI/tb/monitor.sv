class axi_monitor extends uvm_monitor;

    `uvm_component_utils(axi_monitor)
    virtual axi_if intf;
    uvm_analysis_port #(transaction) collected_item;
    transaction item;

    transaction item_q [$];

    function new (string name = "axi_monitor", uvm_component parent = null);
        super.new(name, parent);
        `uvm_info("MONITOR", "Constructor Executed", UVM_NONE);
    endfunction
    
    function void build_phase(uvm_phase phase);
            super.build_phase(phase);
        collected_item = new("collected_item", this);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_error("Interface Error", "DUT interface not found")
        end
        else
            `uvm_info("Connect interface", "Monitor connected interface", UVM_NONE)
    
    endfunction
    virtual task run_phase(uvm_phase phase);
        if(intf == null) begin
            `uvm_fatal("MONITOR ERROR", "Interface is null")
        end
        
        if(item == null) begin // 2
            item = transaction::type_id::create("item", this);
        end // 2
        else if (!intf.resetn) begin
            `uvm_info("MONITOR RESPONSE", "Reset Detected", UVM_NONE)
        end
        fork
            collect_write_address(item);
            collect_write_data(item);
            collect_write_response(item);
            collect_read_address(item);
            collect_read_data(item);
        join_any
 //       item.print();

        `uvm_info("MONITOR SUMMARY", $sformatf("Transaction captured: awaddr: %h, wdata: %h, bresp: %h", item.awaddr, item.wdata[$], item.bresp), UVM_NONE)
            


        
    endtask
    /*---------MONITORING WRITE ADDRESS----------*/ 
    task collect_write_address(transaction item);
        forever begin
            @(posedge intf.awready);
            @(posedge intf.clk);
            item.awlen = intf.awlen;        
            item.awsize = intf.awsize;      
            item.awburst = intf.awburst;    
            item.awvalid = intf.awvalid;    
            item.awaddr = intf.awaddr;      
            item.awready = intf.awready;    
            //`uvm_info("WRITE ADDRESS", $sformatf("Captured awaddr: %h at time: %t", item.awaddr, $time), UVM_NONE)
        end
        $display("End write address");
    endtask
    /*---------MONITORING WRITE DATA-----------*/
    task collect_write_data(transaction item);
        forever begin
            @(posedge intf.wready);
            @(negedge intf.clk);
            item.wdata.push_back(intf.wdata);
            item.wready = intf.wready;
            item.wlast = intf.wlast;
            item.wstrb = intf.wstrb;
            item.wvalid = intf.wvalid;
            //`uvm_info("WRITE DATA", $sformatf("Captured wdata: %h, wlast: %0b", item.wdata[$], item.wlast), UVM_NONE)
        end
        $display("End write data");
    endtask
    /*---------MONITORING WRITE RESPONSE--------*/
    task collect_write_response(transaction item);
        forever begin
            @(posedge intf.bvalid);
            item.bready = intf.bready;
            item.bid = intf.bid;
            item.bresp = intf.bresp;
            item.bvalid = intf.bvalid;
            //`uvm_info("WRITE RESPONSE", $sformatf("Captured bresp: %h, bvalid: %0b", item.bresp, item.bvalid), UVM_NONE)
            item.print();
        end
        $display("End write response");
    endtask

    /*---------MONITORING READ ADDRESS----------*/
    task collect_read_address(transaction item);
        forever begin
            @(posedge intf.arready);
            @(posedge intf.clk);
            item.araddr = intf.araddr;
            item.arid = intf.arid;
            item.arlen = intf.arlen;
            item.arsize = intf.arsize;
            item.arburst = intf.arburst;
            item.arvalid = intf.arvalid;
            //`uvm_info("READ ADDRESS", $sformatf("Captured araddr: %h", item.araddr), UVM_NONE)
        end
        $display("End read address");
    endtask
    /*---------MONITORING READ DATA-----------*/
    task collect_read_data(transaction item);
        forever begin
            @(posedge intf.rvalid);
            @(posedge intf.clk);
            item.rid = intf.rid;
            item.rdata = intf.rdata;
            item.rlast = intf.rlast;
            //item. = intf.rvalid;
            //`uvm_info("READ DATA", $sformatf("Captured rdata: %h", item.rdata), UVM_NONE)
            //item.print();
        end
        //$display("End read data");
    endtask
endclass
