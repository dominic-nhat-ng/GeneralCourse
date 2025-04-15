`ifndef BTSLICE_MON__SV
`define BTSLICE_MON__SV

`include "btslice.sv"

typedef class btslice;
typedef class btslice_mon;

class btslice_mon_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use a task if callbacks can be blocking


   // Called at start of observed transaction
   virtual function void pre_trans(btslice_mon xactor,
                                   btslice tr);
   endfunction: pre_trans


   // Called before acknowledging a transaction
   virtual function pre_ack(btslice_mon xactor,
                            btslice tr);
   endfunction: pre_ack
   

   // Called at end of observed transaction
   virtual function void post_trans(btslice_mon xactor,
                                    btslice tr);
   endfunction: post_trans

   
   // Callback method post_cb_trans can be used for coverage
   virtual task post_cb_trans(btslice_mon xactor,
                              btslice tr);
   endtask: post_cb_trans

endclass: btslice_mon_callbacks

   

class btslice_mon extends uvm_monitor;

   uvm_analysis_port #(btslice) mon_analysis_port;  //TLM analysis port
   typedef virtual btslice_intf v_if;
   v_if mon_if;
   int nested = 1;
   // ToDo: Add another class property if required
   extern function new(string name = "btslice_mon",uvm_component parent);
   `uvm_register_cb(btslice_mon,btslice_mon_callbacks);
   `uvm_component_utils_begin(btslice_mon)
      `uvm_field_int(nested, UVM_ALL_ON);
   `uvm_component_utils_end


   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern protected virtual task tx_monitor(uvm_phase phase);

endclass: btslice_mon


function btslice_mon::new(string name = "btslice_mon",uvm_component parent);
   super.new(name, parent);
   mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void btslice_mon::build_phase(uvm_phase phase);
   super.build_phase(phase);

endfunction: build_phase

function void btslice_mon::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   uvm_config_db#(v_if)::get(this, "", "mon_if", mon_if);
endfunction: connect_phase

function void btslice_mon::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 

endfunction: end_of_elaboration_phase


function void btslice_mon::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);

endfunction: start_of_simulation_phase


task btslice_mon::reset_phase(uvm_phase phase);
   super.reset_phase(phase);

endtask: reset_phase


task btslice_mon::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
endtask:configure_phase


task btslice_mon::run_phase(uvm_phase phase);
   super.run_phase(phase);
   fork
   begin
      `uvm_info("bitslice_MONITOR", "Starting transaction...",UVM_MEDIUM)
      tx_monitor(phase);
      `uvm_info("bitslice_MONITOR", "Ending transaction...",UVM_MEDIUM)
   end
   join

endtask: run_phase


task btslice_mon::tx_monitor(uvm_phase phase);
   int sint;
   int trans_id = 1;
   forever begin
      btslice tr;
      wait(this.mon_if.slave.sck.data_valid == 1'b1);
      wait(this.mon_if.slave.sck.sout != 1'b0);

      `uvm_do_callbacks(btslice_mon,btslice_mon_callbacks,
                    pre_trans(this, tr))

        @(this.mon_if.slave.sck);
        if(this.mon_if.slave.sck.isolation_signals == 2'b11) begin 
           if(this.mon_if.slave.sck.sout == 1'b1) 
             `uvm_info("bitslice_MONITOR",$sformatf("sout == %h \t Transaction#==%0d", this.mon_if.slave.sck.sout, trans_id),UVM_MEDIUM)
           else
	     `uvm_error("bitslice_MONITOR",$sformatf("sout == %h expected == 1'b1", this.mon_if.slave.sck.sout))
        end

        if( sint != this.mon_if.slave.sck.sout) begin
           `uvm_info("bitslice_MONITOR",$sformatf("sout == %h \t Transaction#==%0d", this.mon_if.slave.sck.sout,trans_id),UVM_MEDIUM)
           trans_id++;
        end
        sint = this.mon_if.slave.sck.sout;

      `uvm_do_callbacks(btslice_mon,btslice_mon_callbacks,
                    pre_ack(this, tr))
      `uvm_info("bitslice_MONITOR", "Completed transaction...",UVM_HIGH)
      `uvm_info("bitslice_MONITOR", tr.sprint(),UVM_HIGH)
      `uvm_do_callbacks(btslice_mon,btslice_mon_callbacks,
                    post_trans(this, tr))
      mon_analysis_port.write(tr);
   end
endtask: tx_monitor

`endif // BTSLICE_MON__SV
