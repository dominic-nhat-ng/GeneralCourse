class transaction extends uvm_sequence_item;

    //`uvm_object_utils(transaction)
    
    rand bit [31:0]     HRDATA;
    rand bit [15:0]     HADDR;
    rand bit [31:0]     HWDATA;
    rand bit [1:0]      HTRANS;
    rand bit [2:0]      HSIZE;


    // Constructor
    function new(string name = "transaction");
        super.new(name);
    endfunction

    function transaction random();
        HRDATA      =   $urandom();
        HADDR       =   $urandom();
        HWDATA      =   $urandom();
        HTRANS      =   $urandom();
        HSIZE       =   $urandom();
        return this;
    endfunction

    `uvm_object_utils_begin(transaction)
        `uvm_field_int(HRDATA, UVM_ALL_ON)
        `uvm_field_int(HADDR, UVM_ALL_ON)
        `uvm_field_int(HWDATA, UVM_ALL_ON)
        `uvm_field_int(HTRANS, UVM_ALL_ON)
        `uvm_field_int(HSIZE, UVM_ALL_ON)
    `uvm_object_utils_end
endclass

