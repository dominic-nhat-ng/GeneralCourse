//
// Template for UVM-compliant testcase

`ifndef TEST1_LP__SV
`define TEST1_LP__SV

typedef class bitcoin_env;

class btcoin_lp_test1 extends uvm_test;

  uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();
  string min_random_count , max_random_count, count;

  typedef virtual btcoin_intf v_if; 
   v_if mon_if;
   int nested = 4;
   int MAX_COUNT;
   int counter;

  `uvm_component_utils(btcoin_lp_test1)

  bitcoin_env env;
  //btcoin_lp_seq_sequence_library_seq1 my_btcoin_seq_sequence_library;
  btcoin_lp_seq_sequence_library_seq2 my_btcoin_seq_sequence_library;

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    uvm_config_db#(v_if)::get(this,"", "mon_if", mon_if);
  endfunction :connect_phase

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = bitcoin_env::type_id::create("env", this);
    my_btcoin_seq_sequence_library = new("my_btcoin_seq_sequence_library");
    clp.get_arg_value("+min_random_count=", min_random_count);
    clp.get_arg_value("+max_random_count=", max_random_count);
    clp.get_arg_value("+timeout=", count);
    MAX_COUNT = count.atoi();
    counter = count.atoi();
    my_btcoin_seq_sequence_library.min_random_count = min_random_count.atoi();
    my_btcoin_seq_sequence_library.max_random_count = max_random_count.atoi();
    uvm_config_db #(uvm_sequence_base)::set(this, "env.mast_seqr.main_phase",
                    "default_sequence", my_btcoin_seq_sequence_library);
    uvm_config_db #(int)::set(this, "env.o_monitor", "nested", nested);
  endfunction

  task run_phase(uvm_phase phase);
    int secure_data_int;
    super.run_phase(phase);
    phase.raise_objection(this,"");
    @(bitcoin_top.rst == 0);
    @(bitcoin_top.rst == 1);
    fork: timeout
     begin
      wait(this.mon_if.slave.sck.secure_data_out != 32'b0);
      forever begin
        @(this.mon_if.slave.sck);
        secure_data_int = this.mon_if.slave.sck.secure_data_in;
        repeat(1000)@(this.mon_if.slave.sck);
        if(secure_data_int == this.mon_if.slave.sck.secure_data_in) begin
           uvm_hdl_deposit("bitcoin_top.end_of_saif", 1);
           #1ps phase.drop_objection(this);
        end
      end
     end
     begin
      forever begin
        if(counter <= MAX_COUNT) begin
            @(this.mon_if.slave.sck);
            counter = counter - 1;
        end
        if(counter == 0) phase.drop_objection(this);
      end
     end
    join_any: timeout 
  endtask
  function void final_phase(uvm_phase phase);
    uvm_report_server svr;
    super.final_phase(phase);
    svr = uvm_report_server::get_server();
    if (svr.get_severity_count(UVM_FATAL) + svr.get_severity_count(UVM_ERROR) > 0)
        `uvm_info("final_phase", "\n\n \033[0;37;41mSTATUS:SIMULATION FAILED\033[0m \n\n ", UVM_LOW)
    else 
       `uvm_info("final_phase", "\n\n \033[0;37;41mSTATUS:SIMULATION PASSED\033[0m \n\n ", UVM_LOW)

  endfunction
    
endclass : btcoin_lp_test1

`endif //TEST1_LP__SV

