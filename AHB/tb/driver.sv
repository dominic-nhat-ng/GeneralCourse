class ahb_driver extends uvm_driver#(transaction);

    `uvm_component_utils(ahb_driver)
    
    virtual ahb_intf    intf;
    transaction         item;


    function new(string name ="ahb_driver", uvm_component parent=null);
        super.new(name, parent);
    endfunction

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
    endfunction

    virtual function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (! uvm_config_db #(virtual ahb_intf) :: get (this, "", "intf", intf)) begin
            `uvm_fatal (get_type_name (), "Didn't get handle to virtual interface dut_if")
        end
    endfunction

    extern task reset_dut();
    extern task drive_logic(transaction item);

    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        seq_item_port.get_next_item(item);
        `uvm_info(get_type_name(), "Driver received item", UVM_MEDIUM)
        //item.print();
        seq_item_port.item_done();
    endtask


endclass
