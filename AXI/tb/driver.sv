class axi_driver extends uvm_driver#(transaction);
    `uvm_component_utils(axi_driver)
    
    virtual axi_if intf;
    transaction trans_queue[$];
    
    int write_data_idx = 0;

    function new(string name = "axi_driver", uvm_component parent = null);
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
    transaction trans;
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
    //    transaction trans;
        phase.raise_objection(phase);

        reset_dut();
        forever begin
            seq_item_port.try_next_item(trans);
            if(trans == null) break;
            trans_queue.push_back(trans);
            seq_item_port.item_done();
        end

        foreach(trans_queue[i]) begin
            drive_logic(trans_queue[i]);
        end

        phase.drop_objection(phase);
    endtask


endclass

/*-------------drive logic-------------------*/

task axi_driver::reset_dut();
    intf.resetn = 0;
    intf.awvalid = 0;
    intf.wvalid = 0;
    intf.bvalid = 0;
    intf.arvalid = 0;
    intf.rvalid = 0;
    repeat(2) @(posedge intf.clk);
    intf.resetn = 1;
    @(posedge intf.clk);
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
    end
    else if (trans.op == increase) begin
        axi_driver::write_incr_mode();
        axi_driver::read_incr_mode();
    end

    else if (trans.op == wrap) begin
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
        
endtask

task axi_driver::write_fixed_data(transaction local_trans);
    //intf.wvalid <= 0;
    intf.wlast <= 0;
    //wait(intf.awready);
    @(posedge intf.clk);
    intf.wvalid = 1;

    //@(posedge intf.clk);
    
    for (int i = 0; i < local_trans.awlen + 1; i++) begin
        intf.wdata <= local_trans.wdata.pop_front();
        intf.wid <= local_trans.awid;
        intf.wstrb <= local_trans.wstrb;
        if (i == local_trans.awlen) begin
            @(posedge intf.wready);
            @(posedge intf.clk);
            intf.awvalid <= 0;
            intf.wvalid <= 0;
            //@(negedge intf.wready);
            intf.wlast = 1;
            repeat(2) @(posedge intf.clk);
        end
        //@(posedge intf.wready);
        //
        else begin
            @(posedge intf.wready);
            @(posedge intf.clk);
        end
    end

endtask

task axi_driver::write_fixed_response(transaction local_trans);
    //intf.bready = 0;
    if (intf.wvalid == 0) intf.bready = 1;
    else intf.bready = 0;
    //@(negedge intf.bvalid);
    //intf.bready = 0;

endtask

task axi_driver::read_fixed_addr(transaction local_trans);

    @(posedge intf.clk);
    intf.arvalid = 1'b1;
    intf.arlen <= local_trans.arlen;
    intf.arburst <= local_trans.arburst;
    intf.araddr <= local_trans.araddr;
    intf.arid <= local_trans.arid;
    intf.arsize <= local_trans.arsize;
    intf.rid <= local_trans.arid;

endtask


task axi_driver:: read_fixed_data(transaction local_trans);
    @(posedge intf.clk);
    intf.rready <= 1'b1;
    for(int j = 0; j < local_trans.arlen + 1;j++) begin
        @(posedge intf.arready);
        @(posedge intf.clk);
    end

    //$display("%d", local_trans.arlen + 1);

    @(negedge intf.rlast);
    intf.arvalid <= 1'b0;
    intf.rready <= 1'b0;

endtask


task axi_driver::write_incr_mode();
endtask

task axi_driver::read_incr_mode();
endtask

task axi_driver::write_wrap_mode();
endtask

task axi_driver::read_wrap_mode();
endtask
