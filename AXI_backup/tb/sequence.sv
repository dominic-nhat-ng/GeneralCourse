class axi_sequence extends uvm_sequence #(transaction);

    `uvm_object_utils(axi_sequence)

    transaction item;

    function new (string name = "axi_sequence");
        super.new(name);
    endfunction

    virtual task body();
        item = transaction::type_id::create("item");
        start_item(item);
        assert(item.randomize_custom());
        `uvm_info(get_type_name(), "Item generated done", UVM_LOW)
        item.print();
        finish_item(item);
    endtask
endclass
