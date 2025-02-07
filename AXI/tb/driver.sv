class axi_driver extends uvm_driver#(transaction);
    `uvm_component_utils(axi_driver)
    
    
    virtual axi_if intf;
    transaction trans_queue[$];
    transaction trans;
    
    // int write_data_idx = 0;

    function new(string name = "axi_driver", uvm_component parent = null);
        super.new(name, parent);
        // trans_queue = new("trans_queue", this);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_fatal ("Can't connect interface", "Didn't get handle to virtual interface if_name")
    end
        else
            `uvm_info("Connect interface", "Driver Connected to interface", UVM_NONE)
        
    endfunction

    /*-------------RESET DUT---------------------*/


    // Drive all signal into DUT
    extern task drive_logic(transaction trans);
    extern task reset_dut();
    //extern task push_trans();

    /*Fixed mode*/
    extern task write_fixed_address(transaction local_trans);
    extern task write_fixed_data(transaction local_trans);
    extern task write_fixed_response(transaction local_trans);
    extern task read_fixed_addr(transaction local_trans);
    extern task read_fixed_data(transaction local_trans);


    /*Increase mode*/
    extern task write_incr_mode();
    extern task read_incr_mode();

    /*Wrap mode*/
    extern task write_wrap_mode();
    extern task read_wrap_mode();
    int count = 0;
    event process_event;
    
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);        

        reset_dut();
        forever begin
            
            trans = transaction::type_id::create("trans", this);
            seq_item_port.get_next_item(trans);

            drive_logic(trans);
            seq_item_port.item_done();
        end

    endtask



endclass

/*-------------drive logic-------------------*/

task axi_driver::reset_dut();
    intf.resetn = 0;
    intf.wlast = 0;    
    intf.awvalid = 0;
    intf.wvalid = 0;
    intf.bvalid = 0;
    // intf.arvalid = 0;
    intf.rready = 0;
    repeat(2) @(posedge intf.clk);
    intf.resetn = 1;
    @(posedge intf.clk);
    // $display("%t", $time);
endtask


// fix it !!!
task axi_driver::drive_logic(transaction trans);
    if (trans.awburst == 2'b00) begin
        fork
            axi_driver::write_fixed_address(trans);
            axi_driver::write_fixed_data(trans);
            axi_driver::write_fixed_response(trans);
            axi_driver::read_fixed_addr(trans);
            axi_driver::read_fixed_data(trans);
        join
        // axi_driver::read_fixed_addr(trans);
        // axi_driver::read_fixed_data(trans);
    end
    else if (trans.awburst == 2'b01) begin
        axi_driver::write_incr_mode();
        axi_driver::read_incr_mode();
    end

    else if (trans.awburst == 2'b10) begin
        axi_driver::write_wrap_mode();
        axi_driver::read_wrap_mode();
    end


endtask : drive_logic

task axi_driver::write_fixed_address(transaction local_trans);
    @(posedge intf.clk);
    intf.awvalid = 1'b1;
        
    //@(posedge intf.clk);
    intf.awid <= local_trans.awid;
    intf.awaddr <= local_trans.awaddr;
    intf.awlen <= local_trans.awlen;
    intf.awsize <= local_trans.awsize;
    intf.awburst <= local_trans.awburst;
    @(posedge intf.awready);
    @(posedge intf.clk);
    intf.awvalid <= 1'b0;
    @(posedge intf.clk);
    
    // $display("%t", $time);
endtask

task axi_driver::write_fixed_data(transaction local_trans);
    //intf.wvalid <= 0;
    @(posedge intf.clk);
    intf.wlast <= 0;
    //wait(intf.awready);
    @(posedge intf.clk);
    intf.wvalid <= 1;

    //@(posedge intf.clk);
    
    for (int i = 0; i < local_trans.awlen + 1; i++) begin
        intf.wdata <= local_trans.wdata.pop_front();
        intf.wid <= local_trans.awid;
        intf.wstrb <= local_trans.wstrb;
        if (i == local_trans.awlen) begin
            @(posedge intf.wready);
            intf.wlast <= 1;
            @(posedge intf.clk);
            // intf.awvalid <= 0;
            intf.wvalid <= 0;
            intf.wlast = 0;
            // @(posedge intf.clk);
        end
        //@(posedge intf.wready);
        //
        else begin
            @(posedge intf.wready);
            // @(posedge intf.clk);
        end
        @(posedge intf.clk);
        // $display("%t", $time);
    end

endtask

task axi_driver::write_fixed_response(transaction local_trans);
    @(posedge intf.clk);
    intf.bready <= 1'b0;
    // intf.bid <= local_trans.awid;
    @(posedge intf.bvalid);
    @(posedge intf.clk);
    intf.bready <= 1'b1;
    @(posedge intf.clk);
    intf.bready <= 1'b0;
    @(posedge intf.clk);
    // $display("%t", $time);
endtask

task axi_driver::read_fixed_addr(transaction local_trans);
    @(posedge intf.clk);
    intf.arvalid <= 1'b1;
    intf.arid <= local_trans.arid;
    intf.araddr <= local_trans.araddr;
    intf.arlen = local_trans.arlen;
    $display("Time arlen is giving on interface %t", $time);
    intf.arburst <= local_trans.arburst;
    intf.arsize <= local_trans.arsize;
    @(posedge intf.arready);
    @(posedge intf.clk);
    intf.arvalid <= 1'b0;
    @(posedge intf.clk);   
    // $display("End task at :%t", $time);
endtask


task axi_driver:: read_fixed_data(transaction local_trans);
    intf.rready = 1'b0;
    @(posedge intf.clk);
    @(negedge intf.arready);
    for (int i = 0; i <= intf.arlen; i++) begin
        @(posedge intf.clk);
        intf.rready = 1'b1;
        @(negedge intf.rvalid);
        intf.rready = 1'b0;
        @(posedge intf.clk);
    end
endtask


task axi_driver::write_incr_mode();
endtask

task axi_driver::read_incr_mode();
endtask

task axi_driver::write_wrap_mode();
endtask

task axi_driver::read_wrap_mode();
endtask
