class apb_subscriber extends uvm_subscriber #(transaction);

    `uvm_component_utils(apb_subscriber)

    bit [31:0]  addr;
    bit [31:0]  data;




endclass 
