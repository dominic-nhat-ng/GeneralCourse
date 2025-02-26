interface axi_if(input logic clk, input logic resetn);
  

  logic awvalid;  
  logic awready;  
  logic [3:0] awid;     
  logic [3:0] awlen;    
  logic [2:0] awsize;   
  logic [31:0] awaddr;  
  logic [1:0] awburst;  
  
  
  logic wvalid;             
  logic wready;             
  logic [3:0] wid;         
  logic [31:0] wdata;      
  logic [3:0] wstrb;       
  logic wlast;             
  
  
  logic bready;             
  logic bvalid;             
  logic [3:0] bid;          
  logic [1:0] bresp;        
  
 
  logic arvalid;            
  logic arready;            
  logic [3:0] arid;         
  logic [3:0] arlen;        
  logic [2:0] arsize;       
  logic [31:0] araddr;      
  logic [1:0] arburst;      
  
  
  
  logic rready;             
  logic rvalid;             
  logic [3:0] rid;          
  logic [31:0] rdata;       
  logic rlast;              
  logic [1:0] rresp;        
  
endinterface 
