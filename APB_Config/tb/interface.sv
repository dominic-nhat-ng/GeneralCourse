interface apb_intf(input logic clk, input clk rst);

    logic       [31:0]      p_addr;
    logic       [31:0]      p_wdata;
    logic                   p_write;
    logic                   p_selx;
    logic                   p_enable;

    logic       [31:0]      p_rdata;
    logic                   p_ready;
    logic                   p_slverr;


endinterface
