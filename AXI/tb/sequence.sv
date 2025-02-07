class axi_sequence extends uvm_sequence #(transaction);

    `uvm_object_utils(axi_sequence)

    transaction item;

    function new(string name = "axi_sequence");
        super.new(name);
    endfunction

    function transaction randomize_all(transaction item);
        // Randomize resetn
        item.resetn = $urandom_range(0, 1);

        // WRITE ADDRESS
        item.awlen = $urandom_range(0, 7);
        item.awid = $urandom;
        item.awsize = $urandom_range(0, 7);
        item.awaddr = $urandom_range(1, 127);
        item.awburst = $urandom_range(0, 2);

        // WRITE DATA
        item.wstrb = $urandom_range(0, 15);

        // READ ADDRESS
        item.arid = $urandom_range(0, 15);
        item.araddr = $urandom_range(1, 127);
        item.arlen = $urandom_range(0, 15);
        item.arsize = $urandom_range(0, 7);
        item.arburst = $urandom_range(0, 3);

        return item;
    endfunction

    virtual task body();
        item = transaction::type_id::create("item");

        assert(randomize_all(item));

        for(int i = 0; i < item.awlen + 1; i++) begin
            item.wdata[i] = $urandom_range(1, 127);  
        end

        `uvm_info("Sequence", "Starting sequence_fixed generate done", UVM_NONE)

        finish_item(item);
    endtask

endclass

/*--------------Verification with Fixed sequence---------------------*/
class sequence_fixed extends axi_sequence;
    `uvm_object_utils(sequence_fixed)

    function new(string name = "sequence_fixed");
        super.new(name);
    endfunction
    
    virtual task body();
        // Tạo item từ lớp transaction
        item = transaction::type_id::create("item");
        
        start_item(item);
        assert(randomize_all(item));

        for(int i = 0; i < item.awlen + 1; i++) begin
            item.wdata[i] = $urandom_range(1, 127);
        end
        

        `uvm_info("Sequence", "Starting sequence_fixed generate done", UVM_NONE)
        
        finish_item(item);
    endtask

endclass


/*-----------------Verification with Increase sequence---------------------*/
class sequence_incr extends axi_sequence;

    `uvm_object_utils(sequence_incr)
    function new(string name = "sequece_incr");
        super.new(name);
    endfunction
endclass

/*--------------Verification with Wrap sequence---------------------*/
class sequence_wrap extends axi_sequence;

    `uvm_object_utils(sequence_wrap)
    function new(string name = "sequece_wrap");
        super.new(name);
    endfunction
endclass

/*--------------Verification with Error sequence---------------------*/
class sequence_error extends axi_sequence;

    `uvm_object_utils(sequence_error)
    function new(string name = "sequece_error");
        super.new(name);
    endfunction
endclass
