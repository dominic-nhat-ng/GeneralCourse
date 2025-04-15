`ifndef BTSLICE_DRV__SV
`define BTSLICE_DRV__SV
`include "btslice.sv"

typedef class btslice;
typedef class btslice_drv;

class btslice_drv_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use "task" if callbacks cannot be blocking

   // Called before a transaction is executed
   virtual task pre_tx( btslice_drv xactor,
                        btslice tr);
                                   
     // ToDo: Add relevant code

   endtask: pre_tx


   // Called after a transaction has been executed
   virtual task post_tx( btslice_drv xactor,
                         btslice tr);
     // ToDo: Add relevant code

   endtask: post_tx

endclass: btslice_drv_callbacks


class btslice_drv extends uvm_driver # (btslice);

   
   typedef virtual btslice_intf v_if; 
   v_if drv_if;
   `uvm_register_cb(btslice_drv,btslice_drv_callbacks); 
   
   extern function new(string name = "btslice_drv",
                       uvm_component parent = null); 
 
      `uvm_component_utils_begin(btslice_drv)
      // ToDo: Add uvm driver member
      `uvm_component_utils_end
   // ToDo: Add required short hand override method


   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void end_of_elaboration_phase(uvm_phase phase);
   extern virtual function void start_of_simulation_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern protected virtual task send(btslice tr); 
   extern protected virtual task tx_driver();

endclass: btslice_drv


function btslice_drv::new(string name = "btslice_drv",
                   uvm_component parent = null);
   super.new(name, parent);

   
endfunction: new


function void btslice_drv::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here

endfunction: build_phase

function void btslice_drv::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   uvm_config_db#(v_if)::get(this, "", "drv_if", drv_if);
endfunction: connect_phase

function void btslice_drv::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);
   if (drv_if == null)
       `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   
endfunction: end_of_elaboration_phase

function void btslice_drv::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here
endfunction: start_of_simulation_phase

 
task btslice_drv::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Reset output signals
   phase.raise_objection(this);
   this.drv_if.memory_sleep            <= 2'b0;
   this.drv_if.shut_down_signals       <= 2'b0;
   this.drv_if.isolation_signals       <= 2'b0;
   this.drv_if.retention_signals       <= 2'b11;
   wait(bitslice_top.rst == 1'b0);
   this.drv_if.master.mck.data_valid   <= 1'b0;
   this.drv_if.master.mck.sin          <= 32'b0;
   wait(bitslice_top.rst == 1'b1);
   repeat (20) @(drv_if.mck);
   phase.drop_objection(this);
endtask: reset_phase

task btslice_drv::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
endtask:configure_phase


task btslice_drv::run_phase(uvm_phase phase);
   super.run_phase(phase);
   fork 
      tx_driver();
   join
endtask: run_phase


task btslice_drv::tx_driver();
 forever begin
      btslice tr;
      // ToDo: Set output signals to their idle state
      `uvm_info("bitslice_DRIVER", "Starting transaction...",UVM_LOW)
       seq_item_port.get_next_item(tr);
      `uvm_info("DRV_RUN", {"\n", tr.sprint()}, UVM_MEDIUM);
      /* case (tr.kind) 
         btslice::READ: begin
            // ToDo: Implement READ transaction

         end
         btslice::WRITE: begin
            // ToDo: Implement READ transaction

         end
      endcase
	  `uvm_do_callbacks(btslice_drv,btslice_drv_callbacks,
                    pre_tx(this, tr)) */
      send(tr); 
      seq_item_port.item_done();
      `uvm_info("bitslice_DRIVER", "Completed transaction...",UVM_LOW)
      `uvm_info("bitslice_DRIVER", tr.sprint(),UVM_HIGH)
      `uvm_do_callbacks(btslice_drv,btslice_drv_callbacks,
                    post_tx(this, tr))

   end
endtask : tx_driver

task btslice_drv::send(btslice tr);
      this.drv_if.master.mck.data_valid          <= tr.data_valid;
      this.drv_if.master.mck.memory_sleep        <= tr.memory_sleep;
      this.drv_if.master.mck.shut_down_signals   <= tr.shut_down_signals;
      this.drv_if.master.mck.isolation_signals   <= tr.isolation_signals;
      this.drv_if.master.mck.retention_signals   <= tr.retention_signals;
      repeat (1) @(drv_if.mck);
      this.drv_if.master.mck.sin      <= tr.sin;
  
endtask: send


`endif // BTSLICE_DRV__SV


