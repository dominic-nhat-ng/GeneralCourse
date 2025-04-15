`ifndef BITSLICE_ENV__SV
`define BITSLICE_ENV__SV
`include "bitslice.sv"
//Including all the required component files here
class bitslice_env extends uvm_env;
   btslice_drv mast_drv;
   //btslice_drv slave_drv;
   //btslice_mon i_monitor;
   btslice_mon o_monitor;   
   btslice_cov cov;
   btslice_seq mast_seqr;
   
   
   btslice_mon_2cov_connect mon2cov;


    `uvm_component_utils(bitslice_env)

   extern function new(string name= "bitslice_env", uvm_component parent=null);
   extern virtual function void build_phase(uvm_phase phase);
   extern virtual function void connect_phase(uvm_phase phase);
   extern function void start_of_simulation_phase(uvm_phase phase);
   extern virtual task reset_phase(uvm_phase phase);
   extern virtual task configure_phase(uvm_phase phase);
   extern virtual task run_phase(uvm_phase phase);
   extern virtual function void report_phase(uvm_phase phase);
   extern virtual task shutdown_phase(uvm_phase phase);

endclass: bitslice_env

function bitslice_env::new(string name= "bitslice_env",uvm_component parent=null);
   super.new(name,parent);
endfunction:new

function void bitslice_env::build_phase(uvm_phase phase);
   super.build();
   mast_drv = btslice_drv::type_id::create("mast_drv",this); 

   //slave_drv = btslice_drv::type_id::create("slave_drv",this);
   //i_monitor = btslice_mon::type_id::create("i_monitor",this); 
   o_monitor = btslice_mon::type_id::create("o_monitor",this);
   mast_seqr = btslice_seq::type_id::create("mast_seqr",this);
   //slave_seqr = btslice_seq::type_id::create("slave_seqr",this);

   //ToDo: Instantiate other components,callbacks and TLM ports if added by user  

   cov = btslice_cov::type_id::create("cov",this); //Instantiating the coverage class
   mon2cov  = btslice_mon_2cov_connect::type_id::create("mon2cov", this);
   mon2cov.cov  = cov;
   //i_monitor.mon_analysis_port.connect(cov.cov_export);

endfunction: build_phase

function void bitslice_env::connect_phase(uvm_phase phase);
   super.connect_phase(phase);
   //Connecting the driver to the sequencer via ports
   mast_drv.seq_item_port.connect(mast_seqr.seq_item_export);
   //slave_drv.seq_item_port.connect(slave_seqr.seq_item_export);


   // ToDo: Register any required callbacks

endfunction: connect_phase

function void bitslice_env::start_of_simulation_phase(uvm_phase phase);
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


task bitslice_env::reset_phase(uvm_phase phase);
   super.reset_phase(phase);
endtask:reset_phase

task bitslice_env::configure_phase (uvm_phase phase);
   super.configure_phase(phase);
endtask:configure_phase

task bitslice_env::run_phase(uvm_phase phase);
   super.run_phase(phase);
endtask:run_phase

function void bitslice_env::report_phase(uvm_phase phase);
   super.report_phase(phase);
endfunction:report_phase

task bitslice_env::shutdown_phase(uvm_phase phase);
   super.shutdown_phase(phase);
endtask:shutdown_phase
`endif // BITSLICE_ENV__SV
