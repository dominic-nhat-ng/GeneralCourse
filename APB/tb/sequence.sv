// Sequence creates stimulus and drive them to the driver via sequencer
class apb_sequence extends uvm_sequence #(transaction); 
    `uvm_object_utils(apb_sequence) 
    transaction tx;
  
    function new (string name = "apb_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction

    function transaction randomize_all(transaction tx);
        tx.P_addr = $urandom_range(0, 31);
        tx.P_wdata = $urandom();
        return tx;
    endfunction

    virtual task body();
        tx = transaction::type_id::create("tx");

        start_item(tx);
        assert(randomize_all(tx));
        finish_item(tx);

        `uvm_info(get_type_name(), "Sequence generate done", UVM_MEDIUM)
    endtask
  
endclass

class sequence_write extends uvm_sequence #(transaction);
endclass

class sequence_read extends uvm_sequence #(transaction);
endclass
