class transaction extends uvm_sequence_item;
    
  function new(string name ="transaction");
    super.new(name);
  endfunction
  rand bit [3:0]	awlen;
  rand bit [2:0]	awsize;
  rand bit [31:0]	awaddr;
  rand bit [1:0]	awburst;
  rand bit [3:0]    awid;
  
  ///////WRITE DATA
  rand bit [31:0]	wdata[$];
  rand bit [3:0]	wstrb;
  
  // ////WRITE RESPONSE
  bit [3:0]			bid;
  
  //////READ ADDRESS
  rand bit [3:0]	arid;
  rand bit [31:0]	araddr;
  rand bit [3:0]	arlen;
  rand bit [2:0]	arsize;
  rand bit [1:0]	arburst;
  
  //////READ DATA
  bit [3:0]			rid;
  bit [31:0]		rdata;
  bit [1:0]			rresp;
  
  `uvm_object_utils_begin(transaction)
  /////////WRITE ADDRESS BUS
  // `uvm_field_int(awready, UVM_ALL_ON)
  `uvm_field_int(awlen, UVM_ALL_ON)
  `uvm_field_int(awsize, UVM_ALL_ON)
  `uvm_field_int(awaddr, UVM_ALL_ON)
  `uvm_field_int(awburst, UVM_ALL_ON)
  `uvm_field_int(awid, UVM_ALL_ON)
  
  ///////// WRITE DATA BUS
  `uvm_field_queue_int(wdata, UVM_ALL_ON)
  `uvm_field_int(wstrb, UVM_ALL_ON)
  
  //////////// WRITE RESPONSE
  `uvm_field_int(bid, UVM_ALL_ON)
  ///////////// READ ADDRESS BUS
  `uvm_field_int(arid, UVM_ALL_ON)
  `uvm_field_int(araddr, UVM_ALL_ON)
  `uvm_field_int(arlen, UVM_ALL_ON)
  `uvm_field_int(arsize, UVM_ALL_ON)
  `uvm_field_int(arburst, UVM_ALL_ON)
  ///////// READ DATA BUS
  `uvm_field_int(rid, UVM_ALL_ON)
  `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_field_int(rresp, UVM_ALL_ON)
  
  `uvm_object_utils_end

    function transaction randomize_custom();
        
        awlen   = $urandom_range(0, 15);
        awsize  = $urandom_range(0, 7);
        awaddr  = $urandom_range(0, 1023);
        awburst = $urandom_range(0, 3);
        awid    = $urandom_range(0, 15);
        wstrb   = $urandom();

        arid    = $urandom_range(0, 15);
        araddr  = $urandom_range(0, 1023);
        arlen   = $urandom_range(0, 15);
        arsize  = $urandom_range(0, 7);
        arburst = $urandom_range(0, 3);
        rid     = $urandom_range(0, 15);
        
        rresp   = $urandom_range(0, 3);

        for (int i = 0; i<awlen+1; i++) begin
            wdata.push_back($urandom());
        end

        return this;
    endfunction
endclass
