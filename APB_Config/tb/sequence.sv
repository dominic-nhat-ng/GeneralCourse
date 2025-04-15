class apb_sequence extends uvm_sequence #(transaction);
    
    `uvm_object_utils(apb_sequence)

    function new(string name = "apb_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Transaction generated", UVM_MEDIUM)

    endfunction


endclass

class apb_slave_sequence extends apb_sequence;

endclass

class apb_master_sequence extends apb_sequence;

endclass
