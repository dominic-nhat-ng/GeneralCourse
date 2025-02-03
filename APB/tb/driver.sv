class apb_driver extends uvm_driver#(transaction);

    `uvm_component_utils(apb_driver) // Register class with the factory

    virtual apb_intf intf;
    transaction data;

    function new (string name = "apb_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual apb_intf)::get(this, "", "intf", intf)) begin
            `uvm_fatal("no_inif in driver","virtual interface get failed from config db")
        end
        else
            `uvm_info(get_type_name(), "Driver connected to interface", UVM_MEDIUM)
    endfunction

    extern task reset_dut();
    extern task write_logic(transaction tx);
    extern task read_logic(transaction tx);

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_dut();
        forever begin
            //repeat(2) @(posedge intf.clk);
            seq_item_port.get_next_item(data);
            if (data.type_trans == transaction::WRITE)
                write_logic(data);
            else
                read_logic(data);

            seq_item_port.item_done();
        end
    endtask
endclass

task apb_driver::reset_dut();
    wait(intf.rst == 1);
        intf.P_addr <= 0;
        intf.P_selx <= 0;
        intf.P_enable <= 0;
        intf.P_write <= 0;
        intf.P_wdata <= 0;
    wait(intf.rst == 0);
        `uvm_info(get_type_name(), "reset completed", UVM_MEDIUM)
endtask

task apb_driver::write_logic(transaction tx);
    //@(posedge intf.clk);
    intf.P_addr <= tx.P_addr;
    intf.P_selx <= 1'b1;
    intf.P_write <= 1'b1;
    intf.P_wdata <= tx.P_wdata;
    @(posedge intf.clk);
    intf.P_enable = 1'b1;
    @(posedge intf.P_ready);
    @(posedge intf.clk);
    intf.P_enable = 1'b0;
    intf.P_selx <= 1'b0;
    //repeat(5) @(posedge intf.clk);
    @(posedge intf.clk);
endtask

task apb_driver::read_logic(transaction tx);
    intf.P_addr <= tx.P_addr;
    intf.P_selx <= 1'b1;
    intf.P_write <= 1'b0;
    @(posedge intf.clk);
    intf.P_enable <= 1'b1;
    @(posedge intf.P_ready);
    @(posedge intf.clk)
    intf.P_enable <= 1'b0;
    intf.P_selx <= 1'b0;
    @(posedge intf.clk);


endtask
