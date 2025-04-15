interface ahb_intf(input logic HCLK, input logic HRSTN);
    

    // output
    logic           HREADYOUT   ;       
    logic           HRESP       ;
    logic   [31:0]  HRDATA      ;
    
    // input
    logic           HREADY      ;// control signal
    logic           HSEL        ;// control signal
    logic   [15:0]  HADDR       ;
    logic   [31:0]  HWDATA      ;
    logic   [1:0]   HTRANS      ;
    logic           HWRITE      ;//control signal
    logic   [2:0]   HSIZE       ;


    clocking drv_cb @(posedge HCLK);
        default input #1 output #0;

        input       HREADYOUT   ;
        input       HRESP       ;
        input       HRDATA      ;
        input       HREADY      ;

        output      HSEL        ;
        output      HADDR       ;
        output      HWDATA      ;
        output      HTRANS      ;
        output      HWRITE      ;
        output      HSIZE       ;

    endclocking

    clocking mon_cb @(posedge HCLK);

        default input #1 output #0;

        input       HREADYOUT   ;
        input       HRESP       ;
        input       HRDATA      ;
        
        input       HREADY      ;
        input       HSEL        ;
        input       HADDR       ;
        input       HWDATA      ;
        input       HTRANS      ;
        input       HWRITE      ;
        input       HSIZE       ;
        
    endclocking

    modport     DRV_MODPORT (clocking drv_cb);
    modport     MON_MODPORT (clocking mon_cb);

endinterface


