/*
    * This rtl code is designed for slave side for AHB protocol
    *
    *
*/

module AMBA_AHB(HRDATA, HREADYOUT, HRESP, HRESETn, HCLK, HREADY, HSEL, HADDR, HWDATA, HTRANS, HWRITE, HSIZE);

	output HREADYOUT; 		//output signal which allows the written data to be read only when it gets 'HIGH'.	
	output HRESP;			//response signal, when HRESP = 0 (OKAY) then new data can be entered and when HRESP = 1 (ERROR) then data flow should be stopped until it gets 'OKAY'. 
  	output [31:0] HRDATA;		//represents the 32-bit read data bus.

	input HRESETn;			//RESET the whole device signals to their default values when gets 'HIGH' and allows the dataflow to continue when 'LOW'.
	input HCLK;			//the clock signal which is there for the synchronization.
	input HREADY;			//the Signal which shows that the previous data transaction has been completed successfully.
	input HSEL;			//Select Signal which selects the Slave (In this case HSEl = 1, which means only one slave is there).
  	input [15:0] HADDR;		//represents the 16-bit Address bus.
  	input [31:0] HWDATA;		//represents the 32-bit write Data bus.
	input [1:0] HTRANS;		//represents the transfer type. 0 = WAIT state
					//				1 = BUSY state
					//				2 = NONSEQuential transfer type
					//				3 = SEQuential transfer type
	input HWRITE;			//represents the Write or read signal. Enables Writing when goes 'HIGH' and enables reading when goes 'LOW'.
	input [2:0]HSIZE;		//represents the size of data read 000(0) = Byte (8 bit)
					//				   001(1) = halfword (16 bit)
					//				   010(2) = word (32 bit)
					//				   011(3) = double word (64 bit)	
	reg HREADYOUT;			//declared as a register to store previous values inside always block 
  	reg HRESP;
  	reg [31:0]HRDATA;
//input memory registers which store 8-bit data of the input written data. 
	reg [7:0]memory0;		//memory0 for first 8-bit [7:0]
	reg [7:0]memory1;		//memory1 for next 8-bit [15:8]
	reg [7:0]memory2;		//memory2 for next 8-bit [23:16]
	reg [7:0]memory3;		//memory3 for last 8-bit [32:24]
//output memory registers which stores the data read by the master and then assign these values to HRDATA
	reg [7:0]memory_out0;		//memory_out0 for first 8-bit [7:0]
	reg [7:0]memory_out1;		//memory_out1 for next 8-bit [15:8]
	reg [7:0]memory_out2;		//memory_out2 for next 8-bit [23:16]
	reg [7:0]memory_out3;		//memory_out3 for last 8-bit [31:24]

//the device will start and will show change in values only at the positive
//edge of the clock driving this whole device.
	always@(posedge HCLK)
		begin
//the device will not start until the HRESETn = 0
		if(HRESETn)
			begin
//setting the default values to the output terminals + output registers
				HREADYOUT = 0;
				memory_out0 = 0;
				memory_out1 = 0;
				memory_out2 = 0;
				memory_out3 = 0;

			end
		else
			begin
//when HREADY = 1 shows that the earlier data transaction has been
//successfully completed. so, we can now take new inputs as HADDR and HWDATA
//when HREADY = 0 then we cannot/should not give new inputs(data).
			if(HREADY)
				begin
//when HWRITE = 1 then the data is written at the HADDR provided and the input
//data is stored in some memory location which then sent to be read when
//HWRITE = 0
				if(HWRITE)
					begin
//keeping transfer type NONSEQ or SEQ we need to have HTRANS value equal to
//2(2'b10) or 3(2'b11). as wee can see for both of them HTRANS[1] = 1
					if(HTRANS[1])
						begin
//assigning 8-bit write data bus values to memory							
						memory0 = HWDATA[7:0];
						memory1 = HWDATA[15:8];
						memory2 = HWDATA[23:16];
						memory3 = HWDATA[31:24];
							
						end
//when HTRANS[1] = 0, WAIT state {0 (2'b00)} or BUSY state {1 (2'b01)} then
//the device and the read and write busses should retain their previous values
					else
						begin
							$display("device has entered into the wait state or busy state");
						end
					end
//HWRITE = 0 then the data can be sent to read.
				else
					begin
//when HREADYOUT = 1 it shows that the data has been successfully written and
//now can be sent to read to the master.
//when HREADYOUT = 0 then no data will be read.
//HREADYOUT is kept 1 all the time.

						HREADYOUT = 1;
//there are different sizes to read data.							
						case(HSIZE)
//when the size is 0 then only 8 bit data can be read. so, first 8-bit data will be assigned.								
						0: 
						begin
							memory_out0 = memory0;
						end
//when the size is 1 then only 16 bit (halfword) data can be read. So, first
//16-bit data will be assigned.
						1:
						begin	
							memory_out0 = memory0;
							memory_out1 = memory1;
						end
//when the size is 3 then 32-bit (word) data can be read. so, all
//32-bit data will be assigned
						2:
						begin
							memory_out0 = memory0;
							memory_out1 = memory1;
							memory_out2 = memory2;
							memory_out3 = memory3;
						end
//when the size is 3 then 64 bit (double word) data can be read. we have only
//32-bit data so this 32-bit data will be assigned. 
						3:
						begin

							memory_out0 = memory0;
							memory_out1 = memory1;
							memory_out2 = memory2;
							memory_out3 = memory3;
						end
							
						endcase
					end
				end
//when HREADY = 0 then we cannot/should not give new inputs(data).
			else
				begin
//output memory registers are assigned default 0 value.
				memory_out0 = 0;
				memory_out1 = 0;
				memory_out2 = 0;
				memory_out3 = 0;

				end
			end
		end
//response is kept to be always 'OKAY' (0) 		
	assign HRESP = 1'b0;
	assign HRDATA = {memory_out3, memory_out2, memory_out1, memory_out0};

endmodule						



