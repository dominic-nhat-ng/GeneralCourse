class axi_driver_slave extends uvm_driver#(transaction);

    `uvm_component_utils(axi_driver_slave)

    virtual axi_if intf;
    transaction item;

    bit [31:0] virtual_mem[1024] = '{default: 32'h0c0c0c0c};
    
    
    function new(string name = "axi_driver_slave", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        item = transaction::type_id::create("item", this);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_fatal ("Can't connect interface", "Didn't get handle to virtual interface if_name")
    end
        else
            `uvm_info("Connect interface", "Driver Connected to interface", UVM_NONE)
    endfunction
    
    extern task slave_write_address();
    extern task slave_write_data();
    extern task slave_write_response();
    extern task slave_read_address();
    extern task slave_read_data();
    extern task reset_slave();
    
    virtual task run_phase(uvm_phase phase);
    
        super.run_phase(phase);
        reset_slave();

        forever begin
            item = transaction::type_id::create("item", this);
            fork
                slave_write_address();
                slave_write_data();
                slave_write_response();
                slave_read_address();
                slave_read_data();
            join
        end
    endtask
endclass

/*-----------logic-------------*/
task axi_driver_slave::reset_slave();
    intf.resetn = 0;
    intf.awready = 0;
    intf.wready = 0;
    // intf.bid = 0;
    intf.bresp = 0;
    intf.bvalid = 0;
    intf.arready = 0;
    intf.rvalid = 0;
    intf.rlast = 0;
    repeat(2) @(posedge intf.clk);
    intf.resetn = 1;
    @(posedge intf.clk);
endtask

task axi_driver_slave::slave_write_address();
    // forever begin
    // @(posedge intf.clk);
    intf.awready = 1'b0;
    @(posedge intf.awvalid);
    @(posedge intf.clk);
    intf.awready = 1'b1;
    @(posedge intf.clk);
    intf.awready = 1'b0;
    @(posedge intf.clk);

endtask

task axi_driver_slave::slave_write_data();
    @(posedge intf.clk);
    @(posedge intf.wvalid);
    for (int i = 0; i < intf.awlen + 1; i++) begin
        // $display("The %d loop", i);
        // if(i == )
        @(posedge intf.clk);
        intf.wready <= 1'b1;
        virtual_mem[intf.awaddr + i] = intf.wdata;

        @(posedge intf.clk);
        intf.wready <= 1'b0;
        @(posedge intf.clk);
    end
endtask

task axi_driver_slave::slave_write_response();
    @(posedge intf.clk);
    intf.bresp <= 2'b00;
    intf.bid <= intf.awid;

    @(posedge intf.wvalid);
    intf.bready <= 1'b1;


    @(posedge intf.clk);
    @(negedge intf.wlast);
    intf.bvalid <= 1'b1;
    @(posedge intf.clk);
    intf.bvalid <= 1'b0;
    intf.bready <= 1'b0;
    @(posedge intf.clk);


endtask

task axi_driver_slave::slave_read_address();
    @(posedge intf.clk);
    intf.arready = 1'b0;
    @(posedge intf.arvalid);
    @(posedge intf.clk);
    intf.arready = 1'b1;
    @(posedge intf.clk);
    intf.arready = 1'b0;
    @(posedge intf.clk);
endtask

task axi_driver_slave::slave_read_data();
    @(posedge intf.clk);
    // $display("Time at this point :%t", $time);
    intf.rvalid <= 1'b0;
    item.arlen = intf.arlen;
    $display("[DEBUG] Time item get arlen, arlen = %d at time: %t", item.arlen, $time);
    $display("[DEBUG] Time at this point --- before loop :%t", $time);
    for (int i = 0; i <= item.arlen; i++) begin

        $display("[DEBUG] Time at this point :%t at loop: %d", $time, i);
        if (i == item.arlen) begin
            // intf.rlast <= 1'b1;
            @(posedge intf.rready);
            @(posedge intf.clk);
            intf.rvalid <= 1'b1;
            intf.rdata <= virtual_mem[intf.araddr];
            intf.rid <= intf.arid;
            intf.rlast <= 1'b1;
            @(posedge intf.clk);
            intf.rvalid <= 1'b0;
            intf.rlast <= 1'b0;
            $display("[DEBUG] Time at this point :%t", $time);
        end
        else begin
            // intf.rlast <= 1'b0;
            @(posedge intf.rready);
            @(posedge intf.clk);
            intf.rvalid <= 1'b1;
            intf.rdata <= virtual_mem[intf.araddr];
            intf.rid <= intf.arid;
            @(posedge intf.clk);
            intf.rvalid <= 1'b0;
            $display("[DEBUG] Time at this point :%t", $time);
            
        end
        @(posedge intf.clk);
        
    end
endtask

