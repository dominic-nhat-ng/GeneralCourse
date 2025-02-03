class apb_scoreboard extends uvm_scoreboard;
    `uvm_component_utils(apb_scoreboard) // reg class to uvm factory
  
    uvm_analysis_imp#(transaction, apb_scoreboard) received_data;

    transaction exp_queue[$];
    bit [31:0] sc_mem [0:31];
    bit all_tests_passed = 1;
    //standard constructor
    function new(string name ="apb_scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), "constructor", UVM_MEDIUM)
        received_data = new("received_data", this);
    endfunction
  
    //build phase
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        $display("scoreboard build_phase");
    endfunction
    
    // receive the pkg from monitor and pushes into queue
    virtual function void write (transaction data);
        // `uvm_info ("write", $sformatf("Data received = 0x%0h", data.P_addr), UVM_MEDIUM)
        exp_queue.push_back(data);
    endfunction

    virtual task run_phase(uvm_phase phase);
        transaction expdata;
        super.run_phase(phase);
        // $display("scoreboard run_phase");
        forever begin
            // $display("scoreboard run_phase forever loop");
            // $display("scoreboard run_phase with exp_queue size = %0d", exp_queue.size());
            wait(exp_queue.size() > 0);


            expdata = exp_queue.pop_front();
            `uvm_info("APB_SCOREBOARD",$sformatf("------ :: WRITE DATA       :: ------"),UVM_LOW)
            sc_mem[expdata.P_addr] = expdata.P_wdata;
            if(sc_mem[expdata.P_addr] == expdata.P_rdata) begin
                `uvm_info("APB_SCOREBOARD",$sformatf("------ :: READ DATA Match :: ------"),UVM_LOW)
                `uvm_info("",$sformatf("Addr: %0h",expdata.P_addr),UVM_LOW)
                `uvm_info("",$sformatf("Expected data: %0h----Actual data: %0h", sc_mem[expdata.P_addr], expdata.P_rdata), UVM_LOW)
            end
            else begin
                `uvm_error("APB_SCOREBOARD","------ :: READ DATA MisMatch :: ------")
                `uvm_info("",$sformatf("Addr: %0h",expdata.P_addr),UVM_LOW)
                `uvm_info("",$sformatf("Expected data: %0h----Actual data: %0h", sc_mem[expdata.P_addr], expdata.P_rdata), UVM_LOW)
                all_tests_passed = 0;
            end
        end

    endtask

    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        if (all_tests_passed) begin
            `uvm_info(get_type_name(), "All tests passed", UVM_MEDIUM)
        end else begin
            `uvm_error(get_type_name(), "Some tests failed")
        end
    endfunction
endclass
