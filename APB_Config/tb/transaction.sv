class transaction extends uvm_sequence_item;

    rand bit    [31:0]     p_addr;
    rand bit    [31:0]     p_wdata;
    rand bit               p_write;
    rand bit    [31:0]     p_rdata;
    rand bit               p_slverr;

    function new(string name = "transaction");
        super.new(name);
    end 

    `uvm_object_utils_begin(transaction)
    `uvm_field_int(p_addr, UVM_ALL_ON)
    `uvm_field_int(p_wdata, UVM_ALL_ON)
    `uvm_field_int(p_write, UVM_ALL_ON)
    `uvm_field_int(p_rdata, UVM_ALL_ON)
    `uvm_field_int(p_slverr, UVM_ALL_ON)
    `uvm_object_utils_end

    function transaction random();
        p_addr      = $urandom;
        p_wdata     = $urandom;
        p_write     = $urandom;
        p_rdata     = $urandom;
        p_slverr    = $urandom;
        return this;
    endfunction


endclass
