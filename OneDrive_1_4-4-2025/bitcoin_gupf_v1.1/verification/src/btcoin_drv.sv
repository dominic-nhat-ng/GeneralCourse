`ifndef BTCOIN_DRV__SV
`define BTCOIN_DRV__SV
`include "btcoin.sv"

typedef class btcoin;
typedef class btcoin_drv;

class btcoin_drv_callbacks extends uvm_callback;

   // ToDo: Add additional relevant callbacks
   // ToDo: Use "task" if callbacks cannot be blocking

   // Called before a transaction is executed
   virtual task pre_tx( btcoin_drv xactor,
                        btcoin tr);
                                   
     // ToDo: Add relevant code

   endtask: pre_tx


   // Called after a transaction has been executed
   virtual task post_tx( btcoin_drv xactor,
                         btcoin tr);
     // ToDo: Add relevant code

   endtask: post_tx

endclass: btcoin_drv_callbacks


class btcoin_drv extends uvm_driver # (btcoin);

   
   typedef virtual btcoin_intf v_if; 
   v_if drv_if;
   `uvm_register_cb(btcoin_drv,btcoin_drv_callbacks); 
   
   extern function new(string name = "btcoin_drv",
                       uvm_component parent = null); 
 
      `uvm_component_utils_begin(btcoin_drv)
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
   extern protected virtual task send(btcoin tr); 
   extern protected virtual task tx_driver();

endclass: btcoin_drv


function btcoin_drv::new(string name = "btcoin_drv",
                   uvm_component parent = null);
   super.new(name, parent);

   
endfunction: new


function void btcoin_drv::build_phase(uvm_phase phase);
   super.build_phase(phase);
   //ToDo : Implement this phase here

endfunction: build_phase

function void btcoin_drv::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   uvm_config_db#(v_if)::get(this, "", "drv_if", drv_if);
endfunction: connect_phase

function void btcoin_drv::end_of_elaboration_phase(uvm_phase phase);
   super.end_of_elaboration_phase(phase);
   if (drv_if == null)
       `uvm_fatal("NO_CONN", "Virtual port not connected to the actual interface instance");   
endfunction: end_of_elaboration_phase

function void btcoin_drv::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
   //ToDo: Implement this phase here
endfunction: start_of_simulation_phase

 
task btcoin_drv::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
   // ToDo: Reset output signals
   phase.raise_objection(this);
   this.drv_if.sleep_signals           <= 18'b0;
   this.drv_if.isolation_signals       <= 2'b0;
   this.drv_if.retention_signals       <= 2'b11;
   wait(bitcoin_top.rst == 1'b0);
   this.drv_if.master.mck.data_valid          <= 1'b0;
   this.drv_if.master.mck.lp_enable           <= 1'b1;
   this.drv_if.master.mck.secure_data_in      <= 32'b0;
   this.drv_if.master.mck.hash_key            <= 32'b0;
   wait(bitcoin_top.rst == 1'b1);
   repeat (20) @(drv_if.mck);
   phase.drop_objection(this);
endtask: reset_phase

task btcoin_drv::configure_phase(uvm_phase phase);
   super.configure_phase(phase);
   //ToDo: Configure your component here
endtask:configure_phase


task btcoin_drv::run_phase(uvm_phase phase);
   super.run_phase(phase);
   fork 
      tx_driver();
   join
endtask: run_phase


task btcoin_drv::tx_driver();
 forever begin
      btcoin tr;
      // ToDo: Set output signals to their idle state
      `uvm_info("bitcoin_DRIVER", "Starting transaction...",UVM_LOW)
       seq_item_port.get_next_item(tr);
      `uvm_info("DRV_RUN", {"\n", tr.sprint()}, UVM_MEDIUM);
      /* case (tr.kind) 
         btcoin::READ: begin
            // ToDo: Implement READ transaction

         end
         btcoin::WRITE: begin
            // ToDo: Implement READ transaction

         end
      endcase
	  `uvm_do_callbacks(btcoin_drv,btcoin_drv_callbacks,
                    pre_tx(this, tr)) */
      send(tr); 
      seq_item_port.item_done();
      `uvm_info("bitcoin_DRIVER", "Completed transaction...",UVM_LOW)
      `uvm_info("bitcoin_DRIVER", tr.sprint(),UVM_HIGH)
      `uvm_do_callbacks(btcoin_drv,btcoin_drv_callbacks,
                    post_tx(this, tr))

   end
endtask : tx_driver

task btcoin_drv::send(btcoin tr);
      this.drv_if.master.mck.data_valid          <= tr.data_valid;
      this.drv_if.master.mck.lp_enable           <= tr.lp_enable;
      this.drv_if.master.mck.sleep_signals       <= tr.sleep_signals;
      this.drv_if.master.mck.isolation_signals   <= tr.isolation_signals;
      this.drv_if.master.mck.retention_signals   <= tr.retention_signals;
      repeat (1) @(drv_if.mck);
      this.drv_if.master.mck.secure_data_in      <= tr.secure_data_in;
      this.drv_if.master.mck.hash_key            <= tr.hash_key;
  
endtask: send


`endif // BTCOIN_DRV__SV


