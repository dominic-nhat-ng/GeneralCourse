
`ifndef BTSLICE_MON_2COV_CONNECT
`define BTSLICE_MON_2COV_CONNECT
class btslice_mon_2cov_connect extends uvm_component;
   btslice_cov cov;
   uvm_analysis_export # (btslice) an_exp;
   `uvm_component_utils(btslice_mon_2cov_connect)
   function new(string name="", uvm_component parent=null);
   	super.new(name, parent);
   endfunction: new

   virtual function void write(btslice tr);
      cov.tr = tr;
      -> cov.cov_event;
   endfunction:write 
endclass: btslice_mon_2cov_connect

`endif // BTSLICE_MON_2COV_CONNECT
