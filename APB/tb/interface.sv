
//interface apb_intf(input logic pclk, input logic rst);
//
//    //input of dut
//    logic [31:0] paddr;
//    logic psel;
//    logic penable;
//    logic pwrite;
//    logic [31:0] pwdata;
//
//    //output of dut
//    logic pready;
//    logic pslverr;
//    logic [31:0] prdata;
//
//    clocking master_cb @(posedge pclk);
//        input pready, prdata;
//        output paddr, psel, penable, pwrite, pwdata;
//    endclocking
//
//    clocking monitor_cb @(posedge pclk);
//        input paddr, psel, penable, pwrite, pwdata, pready, prdata;
//    endclocking 
//    modport master(clocking master_cb);
//    modport monitor(clocking monitor_cb);
//endinterface
interface dut_if(input logic pclk, input logic presetn);
  logic [31:0] paddr;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] pwdata;
  logic pready;
  logic [31:0] prdata;
  logic pslverr;
  
  // Clocking blocks (unchanged from your original)
  clocking master_cb @(posedge pclk);
    default input #0 output #1;
    output paddr, psel, penable, pwrite, pwdata;
    input pready, prdata;
  endclocking : master_cb
  
 // clocking slave_cb @(posedge pclk);
 //   input paddr, psel, penable, pwrite, pwdata;
 //   output pready, prdata;
 // endclocking : slave_cb
  
  clocking monitor_cb @(posedge pclk);
    default input #0 output #0;
    input paddr, psel, penable, pwrite, pwdata, pready, prdata;
  endclocking : monitor_cb
  
  modport master(clocking master_cb);
 // modport slave(clocking slave_cb);
  modport monitor(clocking monitor_cb);
  
  // Helper function for consistent messaging
  function void print_assertion(string assertion_name, bit success, string extra_info = "");
    if (success) begin
      $display("[%0t] ASSERT_PASS :: %s %s", $time, assertion_name, extra_info);
    end
    else begin
      $error("[%0t] ASSERT_FAIL :: %s %s", $time, assertion_name, extra_info);
    end
  endfunction
    
  // 1. Protocol Timing Assertions
  property apb_enable_one_cycle;
    @(posedge pclk) disable iff (!presetn)
    $rose(psel) |=> (penable && !$stable(penable)) ##1 !penable;
  endproperty
  
  assert_enable: assert property (apb_enable_one_cycle)
    print_assertion("apb_enable_one_cycle", 1, $sformatf("PSEL=%b PENABLE=%b", psel, penable));
    else
    print_assertion("apb_enable_one_cycle", 0, $sformatf("PSEL=%b PENABLE=%b", psel, penable));
  
  property apb_valid_transfer;
    @(posedge pclk) disable iff (!presetn)
    (psel && penable) |-> pready;
  endproperty
  
  assert_valid_transfer: assert property (apb_valid_transfer)
    print_assertion("apb_valid_transfer", 1, $sformatf("PREADY=%b", pready));
    else
    print_assertion("apb_valid_transfer", 0, $sformatf("PSEL=%b PENABLE=%b PREADY=%b", psel, penable, pready));
  
  // 2. Signal Validity Assertions
  property signal_valid_prdata_check;
    @(posedge pclk) disable iff (!presetn)
    (!pwrite && penable && pready) |-> !$isunknown(prdata);
  endproperty
  
  assert_valid_prdata: assert property (signal_valid_prdata_check)
    print_assertion("signal_valid_prdata_check", 1);
    else
    print_assertion("signal_valid_prdata_check", 0, $sformatf("PRDATA=%h", prdata));
  
  property signal_valid_pwdata_check;
    @(posedge pclk) disable iff (!presetn)
    (pwrite && penable) |-> !$isunknown(pwdata);
  endproperty
  
  assert_valid_pwdata: assert property (signal_valid_pwdata_check)
    print_assertion("signal_valid_pwdata_check", 1);
    else
    print_assertion("signal_valid_pwdata_check", 0, $sformatf("PWDATA=%h", pwdata));
  
  // [Similar enhanced assertions for all other properties...]
  
  property signal_valid_penable_check;
    @(posedge pclk) !$isunknown(penable);
  endproperty
  
  assert_valid_penable: assert property (signal_valid_penable_check)
    print_assertion("signal_valid_penable_check", 1);
    else
    print_assertion("signal_valid_penable_check", 0, $sformatf("PENABLE=%b", penable));
  
  // 3. State Transition Assertions
  property setup_to_setup;
    @(posedge pclk) disable iff (!presetn)
    $rose(psel) |=> !$rose(psel);
  endproperty
  
  assert_setup_to_setup: assert property (setup_to_setup)
    print_assertion("setup_to_setup", 1);
    else
    print_assertion("setup_to_setup", 0, "Consecutive setup phases detected");
  
  property access_to_access;
    @(posedge pclk) disable iff (!presetn)
    (penable && pready) |=> !(penable && pready);
  endproperty
  
  assert_access_to_access: assert property (access_to_access)
    print_assertion("access_to_access", 1);
    else
    print_assertion("access_to_access", 0, "Consecutive access phases detected");
  
  // 4. Special Case Assertions
  property initial_bus_state_after_reset;
    @(posedge pclk) $rose(presetn) |-> !psel && !penable;
  endproperty
  
  assert_initial_state: assert property (initial_bus_state_after_reset)
    print_assertion("initial_bus_state_after_reset", 1);
    else
    print_assertion("initial_bus_state_after_reset", 0, $sformatf("PSEL=%b PENABLE=%b after reset", psel, penable));
  
  property pready_timeout_check;
    @(posedge pclk) disable iff (!presetn)
    (penable && !pready) |-> ##[1:16] pready;
  endproperty
  
  assert_pready_timeout: assert property (pready_timeout_check)
    print_assertion("pready_timeout_check", 1);
    else
    print_assertion("pready_timeout_check", 0, "PREADY timeout exceeded 16 cycles");
  
  // [Add all other assertions with the same pattern...]
endinterface
