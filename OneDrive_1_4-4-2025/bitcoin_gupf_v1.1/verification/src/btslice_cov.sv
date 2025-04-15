`ifndef BTSLICE_COV__SV
`define BTSLICE_COV__SV

class btslice_cov extends uvm_component;
   event cov_event;
   btslice tr;
   uvm_analysis_imp #(btslice, btslice_cov) cov_export;
   `uvm_component_utils(btslice_cov)
 
   covergroup cg_trans @(cov_event);
      coverpoint tr.kind;
      // ToDo: Add required coverpoints, coverbins
   endgroup: cg_trans


   function new(string name, uvm_component parent);
      super.new(name,parent);
      cg_trans = new;
      cov_export = new("Coverage Analysis",this);
   endfunction: new

   virtual function write(btslice tr);
      this.tr = tr;
      -> cov_event;
   endfunction: write

endclass: btslice_cov

`endif // BTSLICE_COV__SV

