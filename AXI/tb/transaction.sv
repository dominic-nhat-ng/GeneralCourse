typedef enum bit [1:0] {
    fixed = 0,
    increase = 1,
    wrap = 2,
    error = 3
} operation_mode;

class transaction extends uvm_sequence_item;
    
  function new(string name ="transaction");
    super.new(name);
  endfunction
  bit clk;
  rand bit 			resetn;
  operation_mode op;
  //////WRITE ADDRESS
  bit 				awready; // doesn't need to randomize
  rand bit [3:0]	awid;
  rand bit [3:0]	awlen;
  rand bit [2:0]	awsize;
  rand bit [31:0]	awaddr;
  rand bit [1:0]	awburst;
  rand bit 			awvalid;
  
  ///////WRITE DATA
  bit				wready;
  rand bit			wvalid;
  rand bit [3:0]	wid;
  rand bit [31:0]	wdata;
  rand bit [3:0]	wstrb;
  rand bit 			wlast;
  
  ////WRITE RESPONSE
  rand bit 			bready;
  bit 				bvalid;
  bit [3:0]			bid;
  bit [1:0]			bresp;
  
  //////READ ADDRESS
  bit				arready;
  rand bit [3:0]	arid;
  rand bit [31:0]	araddr;
  rand bit [3:0]	arlen;
  rand bit [2:0]	arsize;
  rand bit [1:0]	arburst;
  rand bit			arvalid;
  
  //////READ DATA
  bit [3:0]			rid;
  bit [31:0]		rdata;
  bit [1:0]			rresp;
  bit				rlast;
  bit				rvalid;
  rand bit			rready;
  
  `uvm_object_utils_begin(transaction)
  `uvm_field_int(resetn, UVM_ALL_ON)
  /////////WRITE ADDRESS BUS
  `uvm_field_int(awready, UVM_ALL_ON)
  `uvm_field_int(awid, UVM_ALL_ON)
  `uvm_field_int(awlen, UVM_ALL_ON)
  `uvm_field_int(awsize, UVM_ALL_ON)
  `uvm_field_int(awaddr, UVM_ALL_ON)
  `uvm_field_int(awburst, UVM_ALL_ON)
  
  ///////// WRITE DATA BUS
  `uvm_field_int(wvalid, UVM_ALL_ON)
  `uvm_field_int(wready, UVM_ALL_ON)
  `uvm_field_int(wid, UVM_ALL_ON)
  `uvm_field_int(wdata, UVM_ALL_ON)
  `uvm_field_int(wstrb, UVM_ALL_ON)
  `uvm_field_int(wlast, UVM_ALL_ON)
  
  //////////// WRITE RESPONSE
  `uvm_field_int(bready, UVM_ALL_ON)
  `uvm_field_int(bvalid, UVM_ALL_ON)
  `uvm_field_int(bid, UVM_ALL_ON)
  `uvm_field_int(bresp, UVM_ALL_ON)
  
  ///////////// READ ADDRESS BUS
  `uvm_field_int(arready, UVM_ALL_ON)
  `uvm_field_int(arid, UVM_ALL_ON)
  `uvm_field_int(araddr, UVM_ALL_ON)
  `uvm_field_int(arlen, UVM_ALL_ON)
  `uvm_field_int(arsize, UVM_ALL_ON)
  `uvm_field_int(arburst, UVM_ALL_ON)
  `uvm_field_int(arvalid, UVM_ALL_ON)
  
  ///////// READ DATA BUS
  `uvm_field_int(rid, UVM_ALL_ON)
  `uvm_field_int(rdata, UVM_ALL_ON)
  `uvm_field_int(rresp, UVM_ALL_ON)
  `uvm_field_int(rlast, UVM_ALL_ON)
  `uvm_field_int(rvalid, UVM_ALL_ON)
  `uvm_field_int(rready, UVM_ALL_ON)
  
  `uvm_object_utils_end
endclass
