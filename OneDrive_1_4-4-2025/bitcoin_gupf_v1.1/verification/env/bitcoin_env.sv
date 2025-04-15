`ifndef BITCOIN_ENV__SV
`define BITCOIN_ENV__SV
`include "bitcoin.sv"
//Including all the required component files here
class bitcoin_env extends uvm_env;
   btcoin_drv mast_drv;
   //btcoin_drv slave_drv;
   //btcoin_mon i_monitor;
   btcoin_mon o_monitor;   
   btcoin_cov cov;
   btcoin_seq mast_seqr;
   
   
   btcoin_mon_2cov_connect mon2cov;


    `uvm_component_utils(bitcoin_env)

   extern function new(string name= "bitcoin_env", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: bitcoin_env

function bitcoin_env::new(string name= "bitcoin_env",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void bitcoin_env::build_phase(uvm_phase phase);
   super.build();
   mast_drv = btcoin_drv::type_id::create("mast_drv",this); 

   //slave_drv = btcoin_drv::type_id::create("slave_drv",this);
   //i_monitor = btcoin_mon::type_id::create("i_monitor",this); 
   o_monitor = btcoin_mon::type_id::create("o_monitor",this);
   mast_seqr = btcoin_seq::type_id::create("mast_seqr",this);
   //slave_seqr = btcoin_seq::type_id::create("slave_seqr",this);

   //ToDo: Instantiate other components,callbacks and TLM ports if added by user  

   cov = btcoin_cov::type_id::create("cov",this); //Instantiating the coverage class
   mon2cov  = btcoin_mon_2cov_connect::type_id::create("mon2cov", this);
   mon2cov.cov  = cov;
   //i_monitor.mon_analysis_port.connect(cov.cov_export);

endfunction: build_phase

function void bitcoin_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //Connecting the driver to the sequencer via ports
   mast_drv.seq_item_port.connect(mast_seqr.seq_item_export);
   //slave_drv.seq_item_port.connect(slave_seqr.seq_item_export);


   // ToDo: Register any required callbacks

endfunction: connect_phase

function void bitcoin_env::start_of_simulation_phase(uvm_phase phase);
   super.start_of_simulation_phase(phase);
  
  `ifdef UVM_VERSION_1_0
   uvm_top.print_topology();  
   factory.print();          
   `endif
   
   `ifdef UVM_VERSION_1_1
	uvm_root::get().print_topology(); 
    uvm_factory::get().print();      
   `endif

   `ifdef UVM_POST_VERSION_1_1
	uvm_root::get().print_topology(); 
    uvm_factory::get().print();      
   `endif
endfunction: start_of_simulation_phase


task bitcoin_env::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
endtask:reset_phase

task bitcoin_env::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
endtask:configure_phase

task bitcoin_env::run_phase(uvm_phase phase);
   super.run_phase(phase);
endtask:run_phase

function void bitcoin_env::report_phase(uvm_phase phase);
   super.report_phase(phase);
endfunction:report_phase

task bitcoin_env::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
endtask:shutdown_phase
`endif // BITCOIN_ENV__SV
