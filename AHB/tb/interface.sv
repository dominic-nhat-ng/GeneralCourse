
interface ahb_intf(input logic HCLK, input logic HRSTN);
    

    // output
    logic           HREADYOUT   ;       
    logic           HRESP       ;
    logic           HRDATA      ;
    
    // input
    logic           HREADY      ;// control signal
    logic           HSEL        ;// control signal
    logic   [15:0]  HADDR       ;
    logic   [31:0]  HWDATA      ;
    logic   [1:0]   HTRANS      ;
    logic           HWRITE      ;//control signal
    logic   [2:0]   HSIZE       ;

endinterface
