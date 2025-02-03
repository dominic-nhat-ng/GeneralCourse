
interface apb_intf(input logic clk, input logic rst);

    //input of dut
    logic [31:0] P_addr;
    logic P_selx;
    logic P_enable;
    logic P_write;
    logic [31:0] P_wdata;

    //output of dut
    logic P_ready;
    logic P_slverr;
    logic [31:0] P_rdata;

endinterface
