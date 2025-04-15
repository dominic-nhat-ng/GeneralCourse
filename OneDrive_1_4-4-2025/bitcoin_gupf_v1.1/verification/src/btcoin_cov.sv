`ifndef BTCOIN_COV__SV
`define BTCOIN_COV__SV

class btcoin_cov extends uvm_component;
   event cov_event;
   btcoin tr;
   uvm_analysis_imp #(btcoin, btcoin_cov) cov_export;
   `uvm_component_utils(btcoin_cov)
 
   covergroup cg_trans @(cov_event);
      coverpoint tr.kind;
      // ToDo: Add required coverpoints, coverbins
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      cov_export = new("Coverage Analysis",this);
   endfunction: new

   virtual function write(btcoin tr);
      this.tr = tr;
      -> cov_event;
   endfunction: write

endclass: btcoin_cov

`endif // BTCOIN_COV__SV

