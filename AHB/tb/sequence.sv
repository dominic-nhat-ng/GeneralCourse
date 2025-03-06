// Sequence creates stimulus and drive them to the driver via sequencer
class ahb_sequence extends uvm_sequence #(transaction); 
    `uvm_object_utils(ahb_sequence) 
    transaction item;
  
    function new (string name = "ahb_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction
    
    virtual task body();
        item    =   transaction::type_id::create("item");
        start_item(item);
        assert(item.random());
        `uvm_info(get_type_name(), "Sequence generated done", UVM_MEDIUM)
        finish_item(item);
    endtask
endclass

