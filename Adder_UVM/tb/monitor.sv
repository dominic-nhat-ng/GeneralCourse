class adder_monitor extends uvm_monitor;

  `uvm_component_utils(adder_monitor)

  virtual add_intf intf;

  uvm_analysis_port #(adder_sequence_item) item_collected_port;
  adder_sequence_item mon_item;

  // Constructor
  function new(string name = "adder_monitor", uvm_component parent);
    super.new(name, parent);
    `uvm_info("Monitor class", "Constructor executed", UVM_MEDIUM);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_port = new("item_collected_port", this);

    if(!uvm_config_db#(virtual add_intf)::get(this, "", "intf", intf))
      `uvm_fatal("no_inif in driver","virtual interface get failed from config db");
    `uvm_info("Monitor class", "Build phase completed", UVM_MEDIUM);
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    if (intf == null) begin
      `uvm_fatal("NULL_VIF", "The virtual interface is NULL");
    end

    forever begin
      wait(!intf.rst);

      @(posedge intf.clk);

      if (mon_item == null) begin
        mon_item = adder_sequence_item::type_id::create("mon_item", this);
      end

      mon_item.a = intf.a;
      mon_item.b = intf.b;
      mon_item.cin = intf.cin;

      `uvm_info("MONITOR", $sformatf("a = %0d, b = %0d, cin = %0d", mon_item.a, mon_item.b, mon_item.cin), UVM_HIGH);

      @(posedge intf.clk);

      mon_item.cout = intf.cout;
      mon_item.sum = intf.sum;

      item_collected_port.write(mon_item);
    end
  endtask

endclass

