class transaction extends uvm_sequence_item;

    //`uvm_object_utils(transaction)

    rand bit [31:0] P_addr;
    rand bit [31:0] P_wdata;
    typedef enum {READ, WRITE} P_type;
    rand P_type type_trans;

    //bit P_selx;
    //bit P_enable;
    //bit P_write;

    //bit P_ready;
    //bit P_slverr;
    bit [31:0] P_rdata;

    // Constructor
    function new(string name = "transaction");
        super.new(name);
    endfunction
    `uvm_object_utils_begin(transaction)
    `uvm_field_int(P_addr, UVM_ALL_ON)
    `uvm_field_int(P_wdata, UVM_ALL_ON)
    `uvm_field_int(P_rdata, UVM_ALL_ON)
    `uvm_field_enum(P_type, type_trans, UVM_ALL_ON)
    `uvm_object_utils_end
endclass

