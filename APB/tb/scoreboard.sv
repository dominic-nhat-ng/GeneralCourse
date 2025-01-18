class adder_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(adder_scoreboard) // reg class to uvm factory
  
  uvm_analysis_imp#(adder_sequence_item, adder_scoreboard) item_collected_export;

  adder_sequence_item tx_q[$];

  //standard constructor
  function new(string name ="dff_scoreboard", uvm_component parent);
    super.new(name, parent);
    `uvm_info("scoreboard Class", "constructor", UVM_MEDIUM)
  endfunction
  
    //build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);

  endfunction
  
  virtual function void write(adder_sequence_item tx);
    tx_q.push_back(tx);
  endfunction
  
  task run_phase(uvm_phase phase);
    adder_sequence_item scb_item;

    forever begin
        wait(tx_q.size > 0);

        scb_item = tx_q.pop_front();
      `uvm_info("INPUT", $sformatf("a = %0d, b = %0d, cin = %0d", scb_item.a, scb_item.b, scb_item.cin), UVM_LOW);
      `uvm_info("OUTPUT", $sformatf("cout = %0d, sum = %0d", scb_item.cout, scb_item.sum), UVM_LOW);

        $display("----------------------------------------------------------------------------------------------------------");
        // Check if the adder logic matches the expected result
        if (scb_item.a + scb_item.b + scb_item.cin == {scb_item.cout, scb_item.sum}) begin
      	
//           `uvm_info("DEBUG", $sformatf("a = %0d, b = %0d, cin = %0d", tx.a, tx.b, tx.cin), UVM_LOW);

          `uvm_info("RESULT", $sformatf("Matched: a = %0d, b = %0d, cin = %0d, cout = %0d, sum = %0d",
                                          scb_item.a, scb_item.b, scb_item.cin, scb_item.cout, scb_item.sum), UVM_LOW);
        end else begin
          `uvm_error("RESULT", $sformatf("NOT Matched: a = %0d, b = %0d, cin = %0d, cout = %0d, sum = %0d",
                                           scb_item.a, scb_item.b, scb_item.cin, scb_item.cout, scb_item.sum));
        end
        $display("----------------------------------------------------------------------------------------------------------");
    end
endtask

  
  
endclass

