class adder_driver extends uvm_driver#(adder_sequence_item);

  `uvm_component_utils(adder_driver) // Register class with the factory

  virtual add_intf intf;
  adder_sequence_item tx;

  function new (string name = "adder_driver", uvm_component parent);
    super.new(name, parent);
    `uvm_info("Driver class", "Constructor", UVM_MEDIUM);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if(!uvm_config_db#(virtual add_intf)::get(this, "", "intf", intf))
      `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
  endfunction


  // Run phase
  task run_phase(uvm_phase phase);
    forever begin
      `uvm_info("Driver class", "run_phase", UVM_MEDIUM);

      // Get transaction from sequence
      seq_item_port.get_next_item(tx);

      // Check for null transaction
      if (tx == null) begin
        `uvm_error("Driver Class", "Received null transaction");
        continue;
      end

      // Drive DUT
      drive(tx);

      // Indicate transaction is done
      seq_item_port.item_done();
    end
  endtask

  // Drive task
  task drive(adder_sequence_item tx);
      @(posedge intf.clk);
      intf.rst <= tx.rst;
      intf.a <= tx.a;
      intf.b <= tx.b;
      intf.cin <= tx.cin;
      `uvm_info("DRIVER", $sformatf("Driving signals: a = %0d, b = %0d, cin = %0d, rst = %b", tx.a, tx.b, tx.cin, tx.rst), UVM_HIGH);
endtask


endclass

