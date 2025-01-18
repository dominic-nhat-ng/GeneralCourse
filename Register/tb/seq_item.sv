class adder_sequence_item extends uvm_sequence_item;

    ////// Input //////
    rand bit [7:0] a, b;
    rand bit cin;
    rand bit rst;

    ////// Output /////
    bit [7:0] sum;
    bit cout;

    // Constructor
    function new(string name = "adder_sequence_item");
        super.new(name);
    endfunction

    // Macros
    `uvm_object_utils_begin(adder_sequence_item)
        `uvm_field_int(a, UVM_DEFAULT)
        `uvm_field_int(b, UVM_DEFAULT)
        `uvm_field_int(cin, UVM_DEFAULT)
        `uvm_field_int(rst, UVM_DEFAULT)
        `uvm_field_int(sum, UVM_DEFAULT) 
        `uvm_field_int(cout, UVM_DEFAULT)
    `uvm_object_utils_end

    // Constraints
    constraint in { rst != 1; }

endclass

