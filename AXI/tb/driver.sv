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
    task reset_dut();
        intf.resetn <= 0;
        repeat(2) @(posedge intf.clk);
        intf.resetn <= 1;

    endtask
    /*-------------WRITE ADDRESS------------------*/
    // fixed type
    //
    int count_data;
    task write_fixed_mode(transaction trans);
        `uvm_info("DRV", "Write Transaction in Fixed Mode Started", UVM_NONE);
        $display("-------------------------------------------------------");
        intf.awid = 0;
        intf.awvalid = 1;
        intf.awlen = 7;
        intf.awsize = 2;
        intf.awaddr = 20;
        intf.awburst = trans.awburst;

        intf.wvalid = 1;
        intf.wid = trans.wid;
        intf.wdata = trans.wdata;
        intf.wstrb = 4'b1111;

        intf.arvalid = 0;
        intf.rready = 0;
        intf.bready = 0;

        @(posedge intf.clk);

        @(posedge intf.wready);
        @(posedge intf.clk);

        for(int i = 0; i < trans.awlen; i++) begin
            intf.wdata = $urandom;
            @(posedge intf.wready);
            @(posedge intf.clk);
        end
        intf.awvalid = 0;
        intf.wvalid = 0;
        intf.wlast = 1;
        intf.bready = 1;
        @(negedge intf.bvalid);
        intf.wlast = 0;
        intf.bready = 0;


    endtask

    task read_fixed_mode(transaction trans);
        `uvm_info("DRV", "Read Transaction in Fixed Mode Started", UVM_NONE)
        $display("-------------------------------------------------------");
        intf.arid = trans.arid;
        intf.arlen = 7;
        intf.arsize = 2;
        intf.araddr = 20;
        intf.arburst = 0;
        intf.arvalid = 1'b1;
        intf.rready = 1'b1;

        for(int i = 0; i < intf.arlen; i++) begin
            @(posedge intf.arready);
            @(posedge intf.clk);
        end

        @(negedge intf.rlast);
        intf.arvalid = 1'b0;
        intf.rready = 1'b0;
    endtask

    task write_incr_mode(transaction trans);

    endtask

    task read_incr_mode(transaction trans);

    endtask

    task write_wrap_mode(transaction trans);

    endtask

    task read_wrap_mode(transaction trans);

    endtask

    task write_error_mode(transaction trans);

    endtask

    task read_error_mode(transaction trans);

    endtask
    // Drive all signal into DUT
    task drive_logic(transaction trans);
        if (trans.op == fixed) begin
            write_fixed_mode(trans);
            read_fixed_mode(trans);
        end
        else if (trans.op == increase) begin
            write_incr_mode(trans);
            read_incr_mode(trans);
        end

        else if (trans.op == wrap) begin
            write_wrap_mode(trans);
            read_wrap_mode(trans);
        end

        else if (trans.op == error) begin
            write_error_mode(trans);
            read_error_mode(trans);
        end

    endtask
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        forever begin
            seq_item_port.get_next_item(trans);
            reset_dut();
            drive_logic(trans);
            //trans.print();
            seq_item_port.item_done();
        end
    endtask


endclass

