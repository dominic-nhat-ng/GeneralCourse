class axi_driver extends uvm_driver#(transaction);
    `uvm_component_utils(axi_driver)
    
    virtual axi_if intf;
    transaction trans;
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


    task write_error_mode(transaction trans);

    endtask

    task read_error_mode(transaction trans);

    endtask
    // Drive all signal into DUT
    extern task drive_logic(transaction trans);
    extern task reset_dut();

    /*Fixed mode*/
    extern task write_fixed_address(transaction trans);
    extern task write_fixed_data(transaction trans);
    extern task write_fixed_response(transaction trans);
    extern task read_fixed_mode(transaction trans);


    /*Increase mode*/
    extern task write_incr_mode(transaction trans);
    extern task read_incr_mode(transaction trans);

    /*Wrap mode*/
    extern task write_wrap_mode(transaction trans);
    extern task read_wrap_mode(transaction trans);

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_dut();
        forever begin
            seq_item_port.get_next_item(trans);
            drive_logic(trans);
            //trans.print();
            seq_item_port.item_done();
        end
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


task axi_driver::drive_logic(transaction trans);
    if (trans.op == fixed) begin
        fork
            axi_driver::write_fixed_address(trans);
            axi_driver::write_fixed_data(trans);
            //axi_driver::write_fixed_response(trans);
            //axi_driver::read_fixed_mode(trans);
        join
    end
    else if (trans.op == increase) begin
        axi_driver::write_incr_mode(trans);
        axi_driver::read_incr_mode(trans);
    end

    else if (trans.op == wrap) begin
        axi_driver::write_wrap_mode(trans);
        axi_driver::read_wrap_mode(trans);
    end

    else if (trans.op == error) begin
        axi_driver::write_error_mode(trans);
        axi_driver::read_error_mode(trans);
    end

endtask

task axi_driver::write_fixed_address(transaction trans);
    intf.awid = 4'b01;
    intf.awvalid = 1'b1;
    intf.awburst = trans.awburst;
    intf.awaddr = trans.awaddr;
    intf.awlen = trans.awlen;
    intf.awsize = trans.awsize;
    wait(intf.awready == 1);
    @(posedge intf.clk);
    intf.awvalid = 1'b0;
endtask

task axi_driver::write_fixed_data(transaction trans);
    intf.wid = 4'b01;
    intf.wlast = 1'b0;
    intf.wstrb = trans.wstrb;
    repeat(2) @(posedge intf.clk);
    
    intf.wvalid = 1;
    for(int i = 0; i < trans.awlen + 1; i++) begin
        if (i == trans.awlen) intf.wlast = 1;
        intf.wdata = trans.wdata.pop_front();
        @(posedge intf.wready);
        @(posedge intf.clk);
    end

endtask

task axi_driver::write_fixed_response(transaction trans);
    intf.bready = 0;
    repeat(2) @(posedge intf.clk);
    intf.bready = 1;
    @(negedge intf.bvalid);
    intf.bready = 0;

endtask

task axi_driver:: read_fixed_mode(transaction trans);
    `uvm_info("DRV", "Read Transaction in Fixed Mode Started", UVM_NONE)
    intf.arid = 0;
    intf.arlen = 7;
    intf.arsize = 2;
    intf.araddr = 32'h7d;
    intf.arburst = 0;
    intf.arvalid = 1'b1;
    intf.rready = 1'b1;
    //$display("Interface arlen: %d", intf.arlen);
    for(int i = 0; i < intf.arlen; i++) begin
        @(posedge intf.arready);
        @(posedge intf.clk);
    end

    @(negedge intf.rlast);
    intf.arvalid = 1'b0;
    intf.rready = 1'b0;
endtask


task axi_driver::write_incr_mode(transaction trans);
endtask

task axi_driver::read_incr_mode(transaction trans);
endtask

task axi_driver::write_wrap_mode(transaction trans);
endtask

task axi_driver::read_wrap_mode(transaction trans);
endtask
