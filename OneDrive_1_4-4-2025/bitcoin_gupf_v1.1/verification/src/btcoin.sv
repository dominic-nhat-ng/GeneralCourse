`ifndef BTCOIN__SV
`define BTCOIN__SV


class btcoin extends uvm_sequence_item;

   typedef enum {READ, WRITE } kinds_e;
   rand kinds_e kind;
   typedef enum {IS_OK, ERROR} status_e;
   rand status_e status;
   rand byte sa;

   rand bit [31:0] secure_data_in;
   rand bit [31:0] hash_key;
   rand bit        data_valid;
   rand bit        lp_enable;
   rand bit [17:0] sleep_signals;
   rand bit  [1:0] isolation_signals;
   rand bit  [1:0] retention_signals;
   // ToDo: Add constraint blocks to prevent error injection
   // ToDo: Add relevant class properties to define all transactions
   // ToDo: Modify/add symbolic transaction identifiers to match

   constraint btcoin_valid {
      // ToDo: Define constraint to make descriptor valid
      status == IS_OK;
   }
 
   extern function new(string name = "bitcoin_trans");
   `uvm_object_utils(btcoin)
   extern virtual function void do_print(uvm_printer printer = null);
   extern virtual function void do_copy(uvm_object rhs = null);
   extern virtual function bit do_compare(uvm_object rhs,
                                  uvm_comparer comparer = null);
   extern virtual function void do_pack(input uvm_packer packer = null );
   extern virtual function void do_unpack(input uvm_packer packer = null );

endclass: btcoin


function btcoin::new(string name = "bitcoin_trans");
   super.new(name);
endfunction: new


function void btcoin::do_print(uvm_printer printer);
   super.do_print(printer); 
   //ToDo: Implement this method here
   printer.print_field("secure_data_in", secure_data_in, $bits(secure_data_in), UVM_HEX);
   printer.print_field("hash_key", hash_key, $bits(hash_key), UVM_HEX);
   printer.print_field("sleep_signals", sleep_signals, $bits(sleep_signals), UVM_BIN);
   printer.print_field("isolation_signals", isolation_signals, $bits(isolation_signals), UVM_BIN);
   printer.print_field("retention_signals", retention_signals, $bits(retention_signals), UVM_BIN);
endfunction: do_print


function void btcoin::do_copy(uvm_object rhs = null);
   btcoin to;
   super.do_copy(rhs);
   $cast(to,rhs);
   to.kind = this.kind;

   // ToDo: Copy additional class properties

endfunction: do_copy


function bit btcoin::do_compare(uvm_object rhs,
                         uvm_comparer comparer); //use of uvm comparer is optional
   btcoin tr;
   do_compare = super.do_compare(rhs,comparer); 
   if (rhs == null) begin 
      `uvm_fatal("COMPARE", "Cannot compare to NULL instance");
      return 0;
   end

   if (!$cast(tr,rhs)) begin 
      `uvm_fatal("COMPARE", "Attempting to compare to a non btcoin instance");
      return 0;
   end

   if (this.kind != tr.kind) begin
      return 0;
   end
   // ToDo: Compare additional class properties
   else
   return 1;
endfunction: do_compare


function void btcoin::do_pack ( input uvm_packer packer);
   super.do_pack(packer);

   // ToDo: Implement this method here
 
endfunction: do_pack


function void btcoin::do_unpack( input uvm_packer packer); //use of uvm packer is optional
   super.do_unpack(packer);

   // ToDo: Implement this method here

endfunction: do_unpack


`endif // BTCOIN__SV
