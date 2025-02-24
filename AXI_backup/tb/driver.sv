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
    
endtask

task master_axi_driver::write_data(transaction item);

endtask

task master_axi_driver::write_response(transaction item);

endtask

task master_axi_driver::read_address(transaction item);

endtask

task master_axi_driver::read_data(transaction item);

endtask



