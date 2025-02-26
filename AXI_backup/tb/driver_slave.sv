class slave_axi_driver extends uvm_driver;

    `uvm_component_utils(slave_axi_driver)
    
    virtual axi_if intf;
    transaction item;
    
    bit [0:7] mem[0:1023];

    function new(string name = "slave_axi_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (! uvm_config_db #(virtual axi_if) :: get (this, "", "intf", intf)) begin
            `uvm_fatal ("Can't connect interface", "Didn't get handle to virtual interface if_name")
    end
        else
            `uvm_info("Connect interface", "Driver slave Connected to interface", UVM_NONE)
    endfunction

    extern task reset_dut();
    extern task slave_drive_logic();

    extern task slave_write_address();
    extern task slave_write_data();
    extern task slave_write_response();
    extern task slave_read_address();
    extern task slave_read_data();
    extern function write_mem();
    extern function read_mem();
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_dut();
        forever begin
            slave_drive_logic();
        end
    endtask

endclass

/*--------------------drive logic---------------------*/

task slave_axi_driver::reset_dut();
    wait(intf.resetn);
    `uvm_info("RESET DUT", "Reset done in slave side", UVM_LOW)

endtask
task slave_axi_driver::slave_drive_logic();
    fork
        slave_write_address();
        slave_write_data();
        slave_write_response();
        slave_read_address();
        slave_read_data();
    join
endtask

task slave_axi_driver::slave_write_address();
    forever begin
        intf.awready        = 1'b0;
        @(posedge intf.awvalid);
        @(posedge intf.clk);
        intf.awready        = 1'b1;
        @(posedge intf.clk);
        intf.awready        = 1'b0;
        @(posedge intf.clk);
    end
endtask

task slave_axi_driver::slave_write_data();
    intf.wready         = 1'b0;
    forever begin
        @(posedge intf.wvalid);
        @(posedge intf.clk);
        if (intf.awaddr <= 1023) begin
            intf.wready     = 1'b1;
            repeat(2) @(posedge intf.clk);
            intf.wready     = 1'b0;
        end
        else begin
            intf.wready     = 1'b0;
            repeat(2) @(posedge intf.clk);
        end
    end
endtask

task slave_axi_driver::slave_write_response();
    @(posedge intf.clk);
    forever begin

        intf.bvalid         = 1'b0;
        intf.bid            = intf.awid;
        intf.bresp          = 2'b00;
        @(negedge intf.wlast);
        intf.bvalid         = 1'b1;
        if (intf.awaddr > 1023) begin
            intf.bresp          = 2'b10;
        end
        else
            intf.bresp          = 2'b00;

        @(negedge intf.bready);
        intf.bvalid         = 1'b0;
    end
endtask

task slave_axi_driver::slave_read_address();
    @(posedge intf.clk);
    intf.arvalid    = 1'b0;
    forever begin
        intf.arready        = 1'b0;
        @(posedge intf.arvalid);
        @(posedge intf.clk);
        intf.arready        = 1'b1;
        @(posedge intf.clk);
        intf.arready        = 1'b0;
        @(posedge intf.clk);
    end
endtask

task slave_axi_driver::slave_read_data();
    @(posedge intf.clk);
    intf.rid        = intf.arid;
    intf.rlast      = 1'b0;
    @(negedge intf.arvalid);
    for(int i = 0; i <= intf.arlen; i++) begin
        intf.rvalid        = 1'b1;
        intf.rdata          = mem[intf.araddr + i];
        if(i == intf.arlen) begin
            intf.rlast      = 1'b1;
        end
        @(negedge intf.rready);
        intf.rvalid         = 1'b0;
        @(posedge intf.clk);
    end
    intf.rlast          = 1'b0;
endtask

function slave_axi_driver::write_mem();

endfunction

function slave_axi_driver::read_mem();

endfunction
