class packet extends uvm_sequence_item;

    rand bit [7:0] addr;
    rand bit [7:0] data;

    `uvm_object_utils_begin(packet)
    `uvm_field_int(addr, UVM_ALL_ON)
    `uvm_field_int(data, UVM_ALL_ON)
    `uvm_object_utils_end

    function new (string name ="packet");
        super.new(name);
    endfunction

    function packet random();
        data = $urandom();
        addr = $urandom();
        return this;
    endfunction
endclass
