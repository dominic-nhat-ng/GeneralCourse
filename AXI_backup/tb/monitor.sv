class master_axi_monitor extends uvm_monitor;

    `uvm_component_utils(master_axi_monitor)
    virtual axi_if intf;
    uvm_analysis_port #(transaction) monitor_analysis_port;
    transaction item;
    function new(string name ="master_axi_monitor", uvm_component parent =null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_error("Interface Error", "DUT interface not found")
        end
        else
            `uvm_info("Connect interface", "Monitor connected interface", UVM_NONE)
    monitor_analysis_port = new("monitor_analysis_port", this);
    endfunction
    extern task reset_dut();
    extern task collect_write_channel();
    extern task collect_read_channel();
    extern task collect_item();    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_dut();
        forever begin

            item = transaction::type_id::create("item");
            collect_item();
            //$display("Item at monitor");
            //item.print();
            monitor_analysis_port.write(item);
        end
    endtask
endclass

task master_axi_monitor::reset_dut();
    wait(intf.resetn);
endtask


task master_axi_monitor::collect_item();
    fork
        collect_write_channel();
        collect_read_channel();
    join
endtask

task master_axi_monitor::collect_write_channel();
    @(posedge intf.clk);
    @(negedge intf.awready);
    //$display("Start colelct data");
    item.awaddr         = intf.awaddr;
    item.awlen          = intf.awlen;
    item.awsize         = intf.awsize;
    item.awburst        = intf.awburst;
    item.awid           = intf.awid;
    item.wstrb          = intf.wstrb;
    for(int i = 0; i <= item.awlen; i++) begin
        @(posedge intf.wready);
        item.wdata.push_back(intf.wdata);
    end
    @(negedge intf.wlast);
    item.bresp          = intf.bresp;

endtask

task master_axi_monitor::collect_read_channel();
    @(posedge intf.clk);
    @(negedge intf.arready);
    item.arid           = intf.arid;
    item.arlen          = intf.arlen;
    item.arsize         = intf.arsize;
    item.araddr         = intf.araddr;
    item.arburst        = intf.arburst;
    for(int i = 0; i <= item.arlen; i++) begin
        @(posedge intf.rready);
        item.rdata.push_back(intf.rdata);
    end
    @(negedge intf.rlast);
    item.rresp          = intf.rresp;

endtask

