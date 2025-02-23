`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "transaction.sv"
`include "test.sv"
module testbench;
    initial begin
        //run_test("test_BlockingPutPort");
        //run_test("test_NonBlockingPutPort");
        //run_test("test_PortExportImp");
        //run_test("test_BlockingGetPort");
        //run_test("test_NonBlockingGetPort");
        run_test("test_fifo");
        //run_test("test_example");
    end
endmodule

