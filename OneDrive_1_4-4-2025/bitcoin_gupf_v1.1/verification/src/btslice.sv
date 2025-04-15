`ifndef BTSLICE__SV
`define BTSLICE__SV


class btslice extends uvm_sequence_item;

   typedef enum {READ, WRITE } kinds_e;
   rand kinds_e kind;
   typedef enum {IS_OK, ERROR} status_e;
   rand status_e status;
   rand byte sa;

   rand bit        sin;
   rand bit        data_valid;
   rand bit        memory_sleep;
   rand bit  [1:0] shut_down_signals;
   rand bit  [1:0] isolation_signals;
   rand bit  [1:0] retention_signals;
   // ToDo: Add constraint blocks to prevent error injection
   // ToDo: Add relevant class properties to define all transactions
   // ToDo: Modify/add symbolic transaction identifiers to match

   constraint btslice_valid {
      // ToDo: Define constraint to make descriptor valid
      status == IS_OK;
   }
 
   extern function new(string name = "bitslice_trans");
   `uvm_object_utils(btslice)
   extern virtual function void do_print(uvm_printer printer = null);
   extern virtual function void do_copy(uvm_object rhs = null);
   extern virtual function bit do_compare(uvm_object rhs,
                                  uvm_comparer comparer = null);
   extern virtual function void do_pack(input uvm_packer packer = null );
   extern virtual function void do_unpack(input uvm_packer packer = null );

endclass: btslice


function btslice::new(string name = "bitslice_trans");
   super.new(name);
endfunction: new


function void btslice::do_print(uvm_printer printer);
   super.do_print(printer); 
   //ToDo: Implement this method here
   printer.print_field("sin", sin, $bits(sin), UVM_BIN);
   printer.print_field("data_valid", data_valid, $bits(data_valid), UVM_BIN);
   printer.print_field("memory_sleep", memory_sleep, $bits(memory_sleep), UVM_BIN);
   printer.print_field("shut_down_signals", shut_down_signals, $bits(shut_down_signals), UVM_BIN);
   printer.print_field("isolation_signals", isolation_signals, $bits(isolation_signals), UVM_BIN);
   printer.print_field("retention_signals", retention_signals, $bits(retention_signals), UVM_BIN);
endfunction: do_print


function void btslice::do_copy(uvm_object rhs = null);
   btslice to;
   super.do_copy(rhs);
   $cast(to,rhs);
   to.kind = this.kind;

   // ToDo: Copy additional class properties

endfunction: do_copy


function bit btslice::do_compare(uvm_object rhs,
                         uvm_comparer comparer); //use of uvm comparer is optional
   btslice tr;
   do_compare = super.do_compare(rhs,comparer); 
   if (rhs == null) begin 
      `uvm_fatal("COMPARE", "Cannot compare to NULL instance");
      return 0;
   end

   if (!$cast(tr,rhs)) begin 
      `uvm_fatal("COMPARE", "Attempting to compare to a non btslice instance");
      return 0;
   end

   if (this.kind != tr.kind) begin
      return 0;
   end
   // ToDo: Compare additional class properties
   else
   return 1;
endfunction: do_compare


function void btslice::do_pack ( input uvm_packer packer);
   super.do_pack(packer);

   // ToDo: Implement this method here
 
endfunction: do_pack


function void btslice::do_unpack( input uvm_packer packer); //use of uvm packer is optional
   super.do_unpack(packer);

   // ToDo: Implement this method here

endfunction: do_unpack


`endif // BTSLICE__SV
