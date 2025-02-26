class master_axi_driver extends uvm_driver #(transaction);

    `uvm_component_utils(master_axi_driver)
    
    virtual axi_if intf;
    transaction item;

    function new(string name = "master_axi_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase (uvm_phase phase);
        super.build_phase(phase);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_fatal ("Can't connect interface", "Didn't get handle to virtual interface if_name")
    end
        else
            `uvm_info("Connect interface", "Driver Connected to interface", UVM_NONE)
    endfunction

    extern task reset_dut();
    extern task drive_logic(transaction item);

    extern task write_address(transaction item);
    extern task write_data(transaction item);
    extern task write_response(transaction item);
    extern task read_address(transaction item);
    extern task read_data(transaction item);

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_dut();

        forever begin
            item = transaction::type_id::create("item");
            seq_item_port.get_next_item(item);
            drive_logic(item);
            seq_item_port.item_done();
        end

    endtask
endclass

/*----------------------drive logic---------------------------*/

task master_axi_driver::reset_dut();
    wait(intf.resetn);
    `uvm_info("RESET DUT", "Reset done in master side", UVM_LOW)
endtask

task master_axi_driver::drive_logic(transaction item);
    fork
        master_axi_driver::write_address(item);
        master_axi_driver::write_data(item);
        master_axi_driver::write_response(item);
        master_axi_driver::read_address(item);
        master_axi_driver::read_data(item);
    join
endtask

task master_axi_driver::write_address(transaction item);
    @(posedge intf.clk);
    intf.awvalid    = 1'b1;
    intf.awaddr     = item.awaddr;
    intf.awlen      = item.awlen;
    intf.awsize     = item.awsize;
    intf.awburst    = item.awburst;
    intf.awid       = item.awid;
    @(posedge intf.awready);
    @(posedge intf.clk);
    intf.awvalid = 1'b0;
    @(posedge intf.clk);
endtask

task master_axi_driver::write_data(transaction item);
    @(posedge intf.clk);
    intf.wvalid     = 1'b0;
    intf.wid        = item.wid;
    intf.wstrb      = item.wstrb;
    intf.wlast      = 1'b0;
    @(negedge intf.awready);
    foreach(item.wdata[i]) begin
        intf.wvalid     =   1'b1;
        intf.wdata      =   item.wdata[i];
        if(i == item.awlen) begin
            intf.wlast  =   1'b1;
        end
        @(negedge intf.wready);
        intf.wvalid     =   1'b0;
        @(posedge intf.clk);
    end
    intf.wlast      = 1'b0;
endtask

task master_axi_driver::write_response(transaction item);
    @(posedge intf.clk);
    intf.bready     = 1'b0;
    @(posedge intf.bvalid);
    @(posedge intf.clk);
    intf.bready     = 1'b1;
    repeat(2) @(posedge intf.clk);
    intf.bready     = 1'b0;
endtask

task master_axi_driver::read_address(transaction item);
    intf.arid       = item.arid;
    intf.araddr     = item.araddr;
    intf.arlen      = item.arlen;
    intf.arsize     = item.arsize;
    intf.arburst    = item.arburst;
    @(posedge intf.clk);
    intf.arvalid    = 1'b1;
    @(posedge intf.arready);
    @(posedge intf.clk);
    intf.arvalid    = 1'b0;
    @(posedge intf.clk);

endtask

task master_axi_driver::read_data(transaction item);
    @(posedge intf.clk);
    intf.rready     = 1'b0;
    for(int i =0; i<=intf.arlen; i++) begin
        @(posedge intf.rvalid);
        @(posedge intf.clk);
        intf.rready         = 1'b1;
        repeat(2) @(posedge intf.clk);
        intf.rready         = 1'b0;
        //@(posedge intf.clk);
    end
endtask



