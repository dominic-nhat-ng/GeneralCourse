# AXI memory

## Understanding AXI channels

Include 5 channels: Write Address, Write Data, Response, Read Address, Read Data

### Write Address channel
Memory will have *n* number of location depending on the depth of memory that we have each location will have a unique address and that address will be communicated with the help of the write address channel

### Write Data channel

Whenever we want to write data to the memory, we will utilize the write data channel

### Response
Whether our transaction is successful or not is conveyed with the help of a write response
3 types of response:
-   Sucessfull transaction: OKAY/ 2'b00
-   Specified burst size greater than supported burst size: SLV ERR / 2'b10
-   Out of range address: No such Slave Address / 2'b11


### Write Address Channel

input awvalid,          // master is sending new address

output reg awready,     // slave is ready to accept request

input [3:0] awid,       // unique ID for each transaction

input [3:0] awlen,      // burst length AXI3: 1 to 16, AXI4: 1 to 256

input [2:0] awsize,     // unique transaction size: 1, 2, 4, 8, 16,... 128 bytes

input [31:0] awaddr,    // write address of transaction

input [1:0] awburst,    // burst type: fixed, INCR, WRAP

### Read address channel

input [3:0] arid,      // Read address ID. This signal is the identification tag for the read address group of signals

input [31:0] araddr,    // Initial address of a read burst transaction. 

input [3:0] arlen,      // Gives exact number of transfer in a burst. The number of data transfer associated with the address

input [2:0] arsize,     // This signal indicates the size of each transfer in the burst

input [1:0] arburst,    // details how the address for each transfer within the burst is calculated

input arvalid,          // when HIGH, the address and information is valid and will remain stable until arready is HIGH

output arready,         // slave is ready to accept an address and information associated control signal

### Read data channel

output [3:0] rid,      // must match the arrid

output [31:0] rdata,   // the read data bus can be 8, 16, 64,..., 1024 bits wide

output [1:0] rresp,     // OKAY, EXOKAY, SLVERR, and DECERR.

output rlast,           // this signal indicates the last transfer in a read burst

output rvalid,          // this signal indicates that the required data is available and the read transfer can complete

input rready,           // master can accept the read data
