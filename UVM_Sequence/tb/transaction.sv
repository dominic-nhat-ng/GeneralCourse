class transaction extends uvm_sequence_item;
    
    rand bit [7:0] data;
    rand bit [7:0] addr;

    `uvm_object_utils_begin(transaction)
    `uvm_field_int(data)
    `uvm_field_int(addr)
    `uvm_object_utils_end

    function new(string name = "transaction");
        super.new(name);
    endfunction

endclass
