module RSDFFARX1_RVT (VDD,VDDG, VSS, D, CLK, RETN, RSTB, SE, SI, Q, QN);


input VDD,VDDG, VSS;
supply1 VDD,VDDG;
supply0 VSS;

input   CLK, D, RETN, SE, SI, RSTB;
output  Q, QN;

reg mlatch,slatch;
wire poweron = ((VDD||VDDG)&!VSS);

assign Q = (poweron)?slatch:1'bx;
assign QN = (poweron)?!slatch:1'bx;


wire temp_clk;

assign temp_clk = CLK&&RETN;




 always @(posedge temp_clk or negedge RSTB)
  begin
    if(!RSTB)
      mlatch <= 0;
    else
      mlatch <= D;
  end

 always @(negedge temp_clk )
  begin
      slatch <= (RETN)?mlatch:slatch;
  end



endmodule

module RSDFFARX2_RVT (VDD,VDDG, VSS, D, CLK, RETN, RSTB, SE, SI, Q, QN);


input VDD,VDDG, VSS;
supply1 VDD,VDDG;
supply0 VSS;

input   CLK, D, RETN, SE, SI, RSTB;
output  Q, QN;

reg mlatch,slatch;
wire poweron = ((VDD||VDDG)&!VSS);

assign Q = (poweron)?slatch:1'bx;
assign QN = (poweron)?!slatch:1'bx;


wire temp_clk;

assign temp_clk = CLK&&RETN;




 always @(posedge temp_clk or negedge RSTB)
  begin
    if(!RSTB)
      mlatch <= 0;
    else
      mlatch <= D;
  end

 always @(negedge temp_clk )
  begin
      slatch <= (RETN)?mlatch:slatch;
  end



endmodule

module RSDFFARX1_LVT (VDD,VDDG, VSS, D, CLK, RETN, RSTB, SE, SI, Q, QN);


input VDD,VDDG, VSS;
supply1 VDD,VDDG;
supply0 VSS;

input   CLK, D, RETN, SE, SI, RSTB;
output  Q, QN;

reg mlatch,slatch;
wire poweron = ((VDD||VDDG)&!VSS);

assign Q = (poweron)?slatch:1'bx;
assign QN = (poweron)?!slatch:1'bx;


wire temp_clk;

assign temp_clk = CLK&&RETN;




 always @(posedge temp_clk or negedge RSTB)
  begin
    if(!RSTB)
      mlatch <= 0;
    else
      mlatch <= D;
  end

 always @(negedge temp_clk )
  begin
      slatch <= (RETN)?mlatch:slatch;
  end



endmodule

module RSDFFARX2_LVT (VDD,VDDG, VSS, D, CLK, RETN, RSTB, SE, SI, Q, QN);


input VDD,VDDG, VSS;
supply1 VDD,VDDG;
supply0 VSS;

input   CLK, D, RETN, SE, SI, RSTB;
output  Q, QN;

reg mlatch,slatch;
wire poweron = ((VDD||VDDG)&!VSS);

assign Q = (poweron)?slatch:1'bx;
assign QN = (poweron)?!slatch:1'bx;


wire temp_clk;

assign temp_clk = CLK&&RETN;




 always @(posedge temp_clk or negedge RSTB)
  begin
    if(!RSTB)
      mlatch <= 0;
    else
      mlatch <= D;
  end

 always @(negedge temp_clk )
  begin
      slatch <= (RETN)?mlatch:slatch;
  end



endmodule

