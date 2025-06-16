typedef enum {READ, WRITE} ptype;
class transaction extends uvm_sequence_item;

    //`uvm_object_utils(transaction)

    rand bit [31:0] paddr;
    rand bit [31:0] pwdata;
    rand ptype type_item;
    bit [31:0] prdata;

    // Constructor
    function new(string name = "transaction");
        super.new(name);
    endfunction
    `uvm_object_utils_begin(transaction)
    `uvm_field_int(paddr, UVM_ALL_ON)
    `uvm_field_int(pwdata, UVM_ALL_ON)
    `uvm_field_int(prdata, UVM_ALL_ON)
    `uvm_field_enum(ptype, type_item, UVM_ALL_ON)
    `uvm_object_utils_end
endclass

