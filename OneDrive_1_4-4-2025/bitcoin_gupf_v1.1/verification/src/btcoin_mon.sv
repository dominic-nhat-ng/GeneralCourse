`ifndef BTCOIN_MON__SV
`define BTCOIN_MON__SV

`include "btcoin.sv"

typedef class btcoin;
typedef class btcoin_mon;

class btcoin_mon_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use a task if callbacks can be blocking


   // Called at start of observed transaction
   virtual function void pre_trans(btcoin_mon xactor,
                                   btcoin tr);
   endfunction: pre_trans


   // Called before acknowledging a transaction
   virtual function pre_ack(btcoin_mon xactor,
                            btcoin tr);
   endfunction: pre_ack
   

   // Called at end of observed transaction
   virtual function void post_trans(btcoin_mon xactor,
                                    btcoin tr);
   endfunction: post_trans

   
   // Callback method post_cb_trans can be used for coverage
   virtual task post_cb_trans(btcoin_mon xactor,
                              btcoin tr);
   endtask: post_cb_trans

endclass: btcoin_mon_callbacks

   

class btcoin_mon extends uvm_monitor;

   uvm_analysis_port #(btcoin) mon_analysis_port;  //TLM analysis port
   typedef virtual btcoin_intf v_if;
   v_if mon_if;
   int nested = 1;
   // ToDo: Add another class property if required
   extern function new(string name = "btcoin_mon",uvm_component parent);
   `uvm_register_cb(btcoin_mon,btcoin_mon_callbacks);
   `uvm_component_utils_begin(btcoin_mon)
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

endclass: btcoin_mon


function btcoin_mon::new(string name = "btcoin_mon",uvm_component parent);
   super.new(name, parent);
   mon_analysis_port = new ("mon_analysis_port",this);
endfunction: new

function void btcoin_mon::build_phase(uvm_phase phase);
   super.build_phase(phase);

endfunction: build_phase

function void btcoin_mon::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   uvm_config_db#(v_if)::get(this, "", "mon_if", mon_if);
endfunction: connect_phase

function void btcoin_mon::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase); 

endfunction: end_of_elaboration_phase


function void btcoin_mon::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);

endfunction: start_of_simulation_phase


task btcoin_mon::reset_phase(uvm_phase phase);
   super.reset_phase(phase);

endtask: reset_phase


task btcoin_mon::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
endtask:configure_phase


task btcoin_mon::run_phase(uvm_phase phase);
   super.run_phase(phase);
   fork
   begin
      `uvm_info("bitcoin_MONITOR", "Starting transaction...",UVM_MEDIUM)
      tx_monitor(phase);
      `uvm_info("bitcoin_MONITOR", "Ending transaction...",UVM_MEDIUM)
   end
   join

endtask: run_phase


task btcoin_mon::tx_monitor(uvm_phase phase);
   int secure_data_int;
   int trans_id = 1;
   forever begin
      btcoin tr;
      wait(this.mon_if.slave.sck.data_valid == 1'b1);
      if(^this.mon_if.secure_data_out === 1'bx) `uvm_fatal("bitcoin_MONITOR",$sformatf("Found X's on secure_data_out && secure_data_out == %h", this.mon_if.secure_data_out));
      wait(this.mon_if.slave.sck.secure_data_out !== 32'b0);

      `uvm_do_callbacks(btcoin_mon,btcoin_mon_callbacks,
                    pre_trans(this, tr))

      for(int i=1; i<= (16 * nested); i++) begin
        @(this.mon_if.slave.sck);
	if(^this.mon_if.slave.sck.secure_data_out === 1'bx) `uvm_error("bitcoin_MONITOR",$sformatf("Found X's on secure_data_out && secure_data_out == %h", this.mon_if.slave.sck.secure_data_out))
        if(this.mon_if.slave.sck.secure_data_out != secure_data_int) `uvm_info("bitcoin_MONITOR",$sformatf("secure_data_out == %h \t byte#==%0d Transaction#==%0d", this.mon_if.slave.sck.secure_data_out, i, trans_id),UVM_MEDIUM)
        if(this.mon_if.slave.sck.isolation_signals == 2'b11) 
           if(this.mon_if.slave.sck.secure_data_out == 32'hffffffff) 
             `uvm_info("bitcoin_MONITOR",$sformatf("secure_data_out == %h \t byte#==%0d Transaction#==%0d", this.mon_if.slave.sck.secure_data_out, i, trans_id),UVM_MEDIUM)
           else
	     `uvm_error("bitcoin_MONITOR",$sformatf("secure_data_out == %h expected == 32'hffffffff", this.mon_if.slave.sck.secure_data_out))

        secure_data_int = this.mon_if.slave.sck.secure_data_out;
        if(i == 16 * nested) trans_id++;
      end

      `uvm_do_callbacks(btcoin_mon,btcoin_mon_callbacks,
                    pre_ack(this, tr))
      `uvm_info("bitcoin_MONITOR", "Completed transaction...",UVM_HIGH)
      `uvm_info("bitcoin_MONITOR", tr.sprint(),UVM_HIGH)
      `uvm_do_callbacks(btcoin_mon,btcoin_mon_callbacks,
                    post_trans(this, tr))
      mon_analysis_port.write(tr);
   end
endtask: tx_monitor

`endif // BTCOIN_MON__SV
