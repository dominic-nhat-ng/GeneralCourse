class axi_driver_slave extends uvm_driver#(transaction);

    `uvm_component_utils(axi_driver_slave)

    virtual axi_if intf;
    transaction item;
    
    
    function new(string name = "axi_driver_slave", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_fatal ("Can't connect interface", "Didn't get handle to virtual interface if_name")
    end
        else
            `uvm_info("Connect interface", "Driver Connected to interface", UVM_NONE)
    endfunction
    
    virtual task run_phase(uvm_phase phase);
        fork
            slave_write_address();
            slave_write_data();
            slave_write_response();
            //slave_read_address();
            //slave_read_data();
        join_any
    endtask
    
    extern task slave_write_address();
    extern task slave_write_data();
    extern task slave_write_response();
    extern task slave_read_address();
    extern task slave_read_data();
endclass

/*-----------logic-------------*/
task axi_driver_slave::slave_write_address();
    forever begin
        @(posedge intf.clk);
        if (intf.awvalid) begin
            @(posedge intf.clk);
            intf.awready = 1'b1;
            $display("Slave: Received write address %h", intf.awaddr);
            @(posedge intf.clk);
            intf.awready = 1'b0;
        end
    end
endtask

task axi_driver_slave::slave_write_data();
    forever begin
        @(posedge intf.clk);
        if(intf.wvalid) begin
            @(posedge intf.clk);
            #1;
            intf.wready = 1'b1;
            $display("Slave: Received write data %h", intf.wdata);
            @(posedge intf.clk);
            intf.wready = 1'b0;
        end
    end
endtask

task axi_driver_slave::slave_write_response();
    forever begin
        intf.bvalid = 1'b0;
        intf.bid = 4'b01;
        @(negedge intf.clk iff intf.wvalid == 1'b1 && intf.wready == 1'b1 && intf.wlast == 1'b1) begin
            intf.bvalid = 1'b1;
            intf.bresp = 2'b0;
            
        
        end
    end
endtask

task axi_driver_slave::slave_read_address();
    forever begin
        @(posedge intf.clk);
        if (intf.arvalid && intf.arready) begin
            $display("Slave: Received read address %h", intf.araddr);
        end
    end
endtask

task axi_driver_slave::slave_read_data();
    forever begin
        @(posedge intf.clk);
    end
endtask

