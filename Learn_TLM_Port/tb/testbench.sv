`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"
`include "test.sv"

module testbench;
    initial begin
        string test_name;

        if (!$value$plusargs("UVM_TESTNAME=%s", test_name)) begin
            test_name = "test_example"; // Chạy test mặc định nếu không có argument
        end

        $display("Running test: %s", test_name);
        run_test(test_name);
    end
endmodule
