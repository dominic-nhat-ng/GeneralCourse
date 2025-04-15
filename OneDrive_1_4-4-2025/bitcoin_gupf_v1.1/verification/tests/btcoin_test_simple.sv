//
// Template for UVM-compliant testcase

`ifndef TEST_SIMPLE__SV
`define TEST_SIMPLE__SV

typedef class bitcoin_env;

class btcoin_test_simple extends uvm_test;

  uvm_cmdline_processor clp = uvm_cmdline_processor::get_inst();
  string min_random_count , max_random_count, count;

  typedef virtual btcoin_intf v_if; 
   v_if mon_if;
   int nested = 4;
   int MAX_COUNT;
   int counter;

  `uvm_component_utils(btcoin_test_simple)

  bitcoin_env env;
  btcoin_seq_sequence_library_simple my_btcoin_seq_sequence_library;

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
        secure_data_int = this.mon_if.slave.sck.secure_data_out;
        repeat(50)@(this.mon_if.slave.sck);
        if(secure_data_int == this.mon_if.slave.sck.secure_data_out)
        phase.drop_objection(this);
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
    
endclass : btcoin_test_simple

`endif //TEST_SIMPLE__SV

