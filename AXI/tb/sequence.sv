// Sequence creates stimulus and drive them to the driver via sequencer
class axi_sequence extends uvm_sequence #(transaction);

    `uvm_object_utils(axi_sequence)

    transaction item;

    function new(string name = "axi_sequence");
        super.new(name);
    endfunction

    function transaction randomize_all(transaction item);
        item.resetn = $urandom_range(0, 1);

        // WRITE ADDRESS
        item.awlen = $urandom_range(0, 7);
        item.awid = $urandom;
        item.awsize = $urandom_range(0, 7);
        item.awaddr = $urandom_range(1, 127);
        item.awvalid = $urandom_range(0, 1);
        item.awburst = $urandom_range(0, 2);

        // WRITE DATA
        item.wvalid = $urandom_range(0, 1);
        item.wstrb = $urandom_range(0, 15);
        item.wlast = $urandom_range(0, 1);

        // WRITE RESPONSE
        item.bready = $urandom_range(0, 1);

        // READ ADDRESS
        item.arid = $urandom_range(0, 15);
        item.araddr = $urandom_range(1, 127);
        item.arlen = $urandom_range(0, 15);
        item.arsize = $urandom_range(0, 7);
        item.arburst = $urandom_range(0, 3);
        item.arvalid = $urandom_range(0, 1);

        // READ DATA
        item.rready = $urandom_range(0, 1);

        return item;
    endfunction



endclass


/*--------------Verification with Fixed sequence---------------------*/
class sequence_fixed extends axi_sequence;
    `uvm_object_utils(sequence_fixed)
    function new(string name = "sequece_fixed");
        super.new(name);
    endfunction

    virtual task body();
        item = transaction::type_id::create("item");
        
        start_item(item);
        assert(randomize_all(item));

        item.op = fixed;
        item.awburst = 0;
        item.wstrb = 4'b1111;
        item.awsize = 2;
        //item.awlen = 7;
        for(int i = 0; i < item.awlen + 1; i++) begin
            item.wdata.push_back($urandom_range(1, 127));
        end
        //item.print();
        finish_item(item);
        //end
    endtask
endclass

/*--------------Verification with Increase sequence---------------------*/
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
