class apb_driver extends uvm_driver#(transaction);

    `uvm_component_utils(apb_driver) // Register class with the factory

    virtual dut_if intf;
    transaction data;

    function new (string name = "apb_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction

    // Build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if(!uvm_config_db#(virtual dut_if)::get(this, "", "intf", intf)) begin
            `uvm_fatal("no_inif in driver","virtual interface get failed from config db")
        end
        else
            `uvm_info(get_type_name(), "Driver connected to interface", UVM_MEDIUM)
    endfunction

    extern task reset_dut();
    extern task drive_logic(transaction item);
    virtual task run_phase(uvm_phase phase);
        super.run_phase(phase);
        reset_dut();
        forever begin
            //repeat(2) @(posedge intf.clk);
            seq_item_port.get_next_item(data);
            drive_logic(data);
            seq_item_port.item_done();
        end
    endtask
endclass

task apb_driver::reset_dut();
  intf.master_cb.paddr <= 0;
  intf.master_cb.psel <= 0;
  intf.master_cb.penable <= 0;
  intf.master_cb.pwrite <= 0;
  intf.master_cb.pwdata <= 0;
  wait(!intf.presetn);
  repeat(4) @(posedge intf.pclk);
endtask

task apb_driver::drive_logic(transaction item);
  intf.master_cb.paddr <= item.paddr;
  case(item.type_item)
    READ:
      begin
      	intf.master_cb.psel <= 1;
      	intf.master_cb.pwrite <= 0;
        @(posedge intf.pclk);
    	intf.master_cb.penable <= 1;
        wait(intf.master_cb.pready);
    	intf.master_cb.psel <= 0;
    	item.prdata <= intf.master_cb.prdata;
    	intf.master_cb.penable <= 0;
      end
    WRITE:
      begin
        intf.master_cb.psel <= 1;
        intf.master_cb.pwrite <= 1;
        @(posedge intf.pclk);
        intf.master_cb.penable <= 1;
        intf.master_cb.pwdata <= item.pwdata;
        wait(intf.master_cb.pready);
        intf.master_cb.psel <= 0;
        intf.master_cb.penable <= 0;
      end
  endcase
endtask
    
