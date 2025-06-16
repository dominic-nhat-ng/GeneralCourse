// Sequence creates stimulus and drive them to the driver via sequencer
class apb_sequence extends uvm_sequence #(transaction); 
    `uvm_object_utils(apb_sequence) 
    // transaction tx;
  
    function new (string name = "apb_sequence");
        super.new(name);
        `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    endfunction

    task body();
        transaction rw_trans;
    //create 10 random APB read/write transaction and send to driver
       // repeat (2) begin
            rw_trans=new();
            start_item(rw_trans);
            rw_trans.randomize();
            rw_trans.paddr = 5;
            rw_trans.type_item = WRITE;
            finish_item(rw_trans);

            start_item(rw_trans);
            rw_trans.randomize();
            rw_trans.paddr = 5;
            rw_trans.type_item = READ;
            finish_item(rw_trans);
       // end
    endtask
endclass

