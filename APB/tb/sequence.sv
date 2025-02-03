// Sequence creates stimulus and drive them to the driver via sequencer
class apb_sequence extends uvm_sequence #(transaction); 
    `uvm_object_utils(apb_sequence) 
    // transaction tx;
  
    function new (string name = "apb_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction

    function transaction randomize_all(transaction tx);
        tx.P_addr = $urandom_range(0, 50);
        tx.P_wdata = $urandom();
        tx.type_trans = transaction::P_type'($urandom_range(0, 1));
        return tx;
    endfunction
  
endclass

class sequence_write extends apb_sequence;
    `uvm_object_utils(sequence_write)
    transaction tx;

    function new(string name = "sequence_write");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);

    endfunction

    virtual task body();
        tx = transaction::type_id::create("tx");
        start_item(tx);
        assert(randomize_all(tx));
        tx.type_trans = transaction::WRITE;
        `uvm_info(get_type_name(), "Sequence WRITE generated done", UVM_MEDIUM)
        finish_item(tx);

    endtask


endclass

class sequence_read extends apb_sequence;
    `uvm_object_utils(sequence_read)
    transaction tx;

    function new(string name = "sequence_read");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);

    endfunction

    virtual task body();
        tx = transaction::type_id::create("tx");
        start_item(tx);
        assert(randomize_all(tx));
        tx.type_trans = transaction::READ;
  //      $display("Address: %0h", tx.P_addr);
        `uvm_info(get_type_name(), "Sequence READ generated done", UVM_MEDIUM)
        finish_item(tx);

    endtask
endclass

class random_sequence extends apb_sequence;
    `uvm_object_utils(random_sequence)
    transaction tx;

    function new(string name = "random_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);

    endfunction

    virtual task body();
        tx = transaction::type_id::create("tx");
        start_item(tx);
        assert(randomize_all(tx));
        `uvm_info(get_type_name(), "Sequence RANDOM generated done", UVM_MEDIUM)
        finish_item(tx);
    endtask

endclass