// test class
/*
uvm components

test - environment - agent - driver - monitor - sequencer - scoreboard

uvm objects

sequence - sequence item
*/
class apb_test extends uvm_test; // uvm_test is a base test class 
  
  `uvm_component_utils(apb_test) // register class to the factory
  
  apb_env env; 
  // sequence_write seq_write;
  
  // standard constructor
  
  function new (string name = "apb_test", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
  endfunction
  
endclass

class write_test extends apb_test;
  
  `uvm_component_utils(write_test)
  apb_env environment;
  sequence_write seq_write;
  
  function new (string name = "write_test", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
  endfunction

  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    // create lower components
    environment = apb_env::type_id::create("environment", this);
    seq_write = sequence_write::type_id::create("seq_write", this);

  endfunction
  
  virtual function void end_of_elaboration();
    
    `uvm_info(get_type_name(), "elab phase", UVM_MEDIUM);
    print();
    
  endfunction
  
  task run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), "run_phase", UVM_MEDIUM)
    // Ensure environment and sequences are not null
    if (environment == null) begin
        `uvm_fatal("NULL_ENV", "Environment is null")
    end
    if (seq_write == null) begin
        `uvm_fatal("NULL_SEQ_READ", "Sequence read is null")
    end

    // Start the sequences
    phase.raise_objection(this);
    repeat(10) seq_write.start(environment.agent.seqcer);
    phase.drop_objection(this);
  endtask
endclass

class read_test extends apb_test;
  
  `uvm_component_utils(read_test)
  apb_env environment;
  sequence_read seq_read;
  
  function new (string name = "read_test", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    // create lower components
    environment = apb_env::type_id::create("environment", this);
    seq_read = sequence_read::type_id::create("seq_read", this);

  endfunction

  virtual function void end_of_elaboration();
    
    `uvm_info(get_type_name(), "elab phase", UVM_MEDIUM);
    print();
    
  endfunction
  
    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "run_phase", UVM_MEDIUM)
        // Ensure environment and sequences are not null
        if (environment == null) begin
            `uvm_fatal("NULL_ENV", "Environment is null")
        end
        if (seq_read == null) begin
            `uvm_fatal("NULL_SEQ_READ", "Sequence read is null")
        end

        // Start the sequences
        phase.raise_objection(this);
        repeat(10) seq_read.start(environment.agent.seqcer);
        phase.drop_objection(this);
    endtask

endclass

class random_test extends apb_test;
  
  `uvm_component_utils(random_test)
  apb_env environment;
  random_sequence seq_random;
  
  function new (string name = "random_test", uvm_component parent);
    
    super.new(name, parent);
    `uvm_info(get_type_name(), "Constructor", UVM_MEDIUM);
    
  endfunction
  
  function void build_phase(uvm_phase phase);
    
    super.build_phase(phase);
    
    // create lower components
    environment = apb_env::type_id::create("environment", this);
    seq_random = random_sequence::type_id::create("seq_random", this);

  endfunction

  virtual function void end_of_elaboration();
    
    `uvm_info(get_type_name(), "elab phase", UVM_MEDIUM);
    print();
    
  endfunction
  
    task run_phase(uvm_phase phase);
        `uvm_info(get_type_name(), "run_phase", UVM_MEDIUM)
        // Ensure environment and sequences are not null
        if (environment == null) begin
            `uvm_fatal("NULL_ENV", "Environment is null")
        end
        if (seq_random == null) begin
            `uvm_fatal("NULL_SEQ_READ", "Sequence read is null")
        end

        // Start the sequences
        phase.raise_objection(this);
        repeat(100) seq_random.start(environment.agent.seqcer);
        phase.drop_objection(this);
    endtask

endclass