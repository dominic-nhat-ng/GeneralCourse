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
    extern function void write_mem(input bit [31:0] addr, input bit [31:0] data, input bit [3:0] strb);
    extern function bit [31:0] read_mem(input bit[31:0] addr);
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
        intf.bid            = intf.awid;
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
            @(posedge intf.clk);
            write_mem(intf.awaddr, intf.wdata, intf.wstrb);
            @(posedge intf.clk);
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
    forever begin
        intf.arready    = 1'b0;
        @(posedge intf.arvalid);
        @(posedge intf.clk);
        intf.arready        = 1'b1;
        @(posedge intf.clk);
        intf.arready        = 1'b0;
        @(posedge intf.clk);
    end
endtask

task slave_axi_driver::slave_read_data();
    forever begin
        @(posedge intf.clk);
        //$display("Time at this point: %0t", $time);
        intf.rlast      = 1'b0;
        intf.rresp      = 2'b00;
        //$display("Pull down edge arvalid detected");
        @(negedge intf.arvalid);
        intf.rid        = intf.arid;
        for(int i = 0; i <= intf.arlen; i++) begin
            bit [31:0] data_out;
            intf.rvalid        = 1'b1;
            data_out            = read_mem(intf.araddr);
            intf.rdata          = data_out;
            if(i == intf.arlen) begin
                intf.rlast      = 1'b1;
            end
            @(negedge intf.rready);
            intf.rvalid         = 1'b0;
            @(posedge intf.clk);
            //$display("Read data at Slave side: %0t", $time);
        end
        intf.rlast          = 1'b0;
        if(intf.araddr > 1023) begin
            intf.rresp          = 2'b10;
        end else begin
            intf.rresp          = 2'b00;
        end
    end
endtask

function void slave_axi_driver::write_mem(input bit [31:0] addr, input bit [31:0] data, input bit [3:0] strb);
    //if (burst == 2b'00)   ->> fixed mode
    //else if (burst == 2'b01)  ->> increase mode 
    //else if (burst == 2'b10) ->> wrap mode
    if(addr < 1020) begin
        if (strb[0]) mem[addr]          = data[7:0];
        if (strb[1]) mem[addr + 1]      = data[15:8];
        if (strb[2]) mem[addr + 2]      = data[23:16];
        if (strb[3]) mem[addr + 3]      = data[31:24];
        //`uvm_info("WRITE MEM", $sformatf("Write data %h with strobe %b at address %0d", data, strb, addr), UVM_MEDIUM)
    end
    else begin
        //`uvm_error("WRITE MEM", $sformatf("Address %0d out of range!", addr))
    end

endfunction

function bit [31:0] slave_axi_driver::read_mem(bit [31:0] addr);
    bit [31:0] data_out;
    if (addr < 1020) begin
        data_out[7:0]       = mem[addr];
        data_out[15:8]      = mem[addr + 1];
        data_out[23:16]     = mem[addr + 2];
        data_out[31:24]     = mem[addr + 3];
        //`uvm_info("READ MEM", $sformatf("Read data %h from address %0d", data_out, addr), UVM_MEDIUM)
        return data_out;
    end
    else begin 
        //`uvm_error("READ MEM", $sformatf("Address %0d out of range!", addr))
        return 32'hxxxx_xxxx;
    end

endfunction
