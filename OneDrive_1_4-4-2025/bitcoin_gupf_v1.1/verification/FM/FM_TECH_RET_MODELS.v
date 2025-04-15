module SEQDFF ( Q, AC, AS, SD, CLK, VSS, VDD );
output Q;
input AC, AS, SD, CLK;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
reg next_state;
wire poweron, reset, set, data, clock, isX, X;
assign poweron = ( VSS && VDD );
assign isX = !poweron || (AC && AS);
assign X = isX && 1'bX;
assign reset = X || ( !isX && AC );
assign set = X || ( !isX && AS );
assign data = SD;
assign clock = CLK;
GTECH_FD3 next_state_reg (
 .D(data),
 .CP(clock),
 .CD(!reset),
 .SD(!set),
 .Q(next_state));
assign Q = ( poweron && next_state ) || ( !poweron && 1'bX );
endmodule

module SEQLAT ( Q, AL, AD, VSS, VDD );
output Q;
input AL, AD;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
reg next_state;
wire poweron, enable, data;
assign poweron = ( VSS && VDD );
assign enable = ( poweron && AL ) || ( !poweron && 1'bX );
assign data = ( poweron && AD ) || ( !poweron && 1'bX );
always @ ( enable or data )
begin : U1
 if ( enable ) begin
 next_state <= data;
 end
end
assign Q = next_state;
endmodule

module GENUPFRR ( Q, AC, AS, SD, CLK, SAVE, RESTORE, VSS, VDD, VSSR,
VDDR );
output Q;
input AC, AS, SD, CLK, SAVE, RESTORE;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_ground" *) input VSSR;
(* pg_type = "backup_power" *) input VDDR;
wire shadow;
wire AC_i, AS_i, VSS_i, VDD_i;
assign AC_i = ( RESTORE && !shadow ) || ( !RESTORE && AC );
assign AS_i = ( RESTORE && shadow ) || ( !RESTORE && AS );
assign VSS_i = (VSS && VSSR );
assign VDD_i = (VDD && VDDR );
SEQDFF M (.Q(Q), .AC(AC_i), .AS(AS_i), .SD(SD), .CLK(CLK),
 .VSS(VSS_i), .VDD(VDD_i));
SEQLAT S (.Q(shadow), .AL(SAVE), .AD(Q), .VSS(VSSR), .VDD(VDDR) );
endmodule

`celldefine
// 1 
module RSDFFARX1_LVT (CLK, RSTB, D, RETN, SI, SE, Q, QN, VSS, VDD, VDDG);

input CLK, RSTB, D, SI, SE;
output Q, QN;
(* retention_port_type = "save_restore" *) input RETN;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_power" *) input VDDG;

wire D_i;
assign D_i = SE ? SI : D; // mux in the scan data

GENUPFRR U1 (
.Q(Q),
.AC(~RSTB), // active low reset
.AS(1'b0), // inactive set
.SD(D_i),
.CLK(CLK),
// save when RETN is low and restore on high
.SAVE(RETN), .RESTORE(~RETN),
// power connections
.VSS(~VSS), .VDD(VDD), .VSSR(~VSS), .VDDR(VDDG)
);
assign QN = ~Q;

endmodule
`endcelldefine

`celldefine
// 2
module RSDFFARX1_RVT (CLK, RSTB, D, RETN, SI, SE, Q, QN, VSS, VDD, VDDG);

input CLK, RSTB, D, SI, SE;
output Q, QN;
(* retention_port_type = "save_restore" *) input RETN;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_power" *) input VDDG;

wire D_i;
assign D_i = SE ? SI : D; // mux in the scan data

GENUPFRR U1 (
.Q(Q),
.AC(~RSTB), // active low reset
.AS(1'b0), // inactive set
.SD(D_i),
.CLK(CLK),
// save when RETN is low and restore on high
.SAVE(RETN), .RESTORE(~RETN),
// power connections
.VSS(~VSS), .VDD(VDD), .VSSR(~VSS), .VDDR(VDDG)
);
assign QN = ~Q;

endmodule 
`endcelldefine

`celldefine
// 3
module RSDFFARX2_HVT (CLK, RSTB, D, RETN, SI, SE, Q, QN, VSS, VDD, VDDG);

input CLK, RSTB, D,  SI, SE;
output Q, QN;
(* retention_port_type = "save_restore" *) input RETN;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_power" *) input VDDG;

wire D_i;
assign D_i = SE ? SI : D; // mux in the scan data

GENUPFRR U1 (
.Q(Q),
.AC(~RSTB), // active low reset
.AS(1'b0), // inactive set
.SD(D_i),
.CLK(CLK),
// save when RETN is low and restore on high
.SAVE(RETN), .RESTORE(~RETN),
// power connections
.VSS(~VSS), .VDD(VDD), .VSSR(~VSS), .VDDR(VDDG)
);
assign QN = ~Q;

endmodule 
`endcelldefine

`celldefine
// 4
module RSDFFARX2_LVT (CLK, RSTB, D, RETN, SI, SE, Q, QN, VSS, VDD, VDDG);

input CLK, RSTB, D,  SI, SE;
output Q, QN;
(* retention_port_type = "save_restore" *) input RETN;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_power" *) input VDDG;

wire D_i;
assign D_i = SE ? SI : D; // mux in the scan data

GENUPFRR U1 (
.Q(Q),
.AC(~RSTB), // active low reset
.AS(1'b0), // inactive set
.SD(D_i),
.CLK(CLK),
// save when RETN is low and restore on high
.SAVE(RETN), .RESTORE(~RETN),
// power connections
.VSS(~VSS), .VDD(VDD), .VSSR(~VSS), .VDDR(VDDG)
);
assign QN = ~Q;

endmodule 
`endcelldefine

`celldefine
// 5
module RSDFFARX2_RVT (CLK, RSTB, D, RETN, SI, SE, Q, QN, VSS, VDD, VDDG);

input CLK, RSTB, D,  SI, SE;
output Q, QN;
(* retention_port_type = "save_restore" *) input RETN;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_power" *) input VDDG;

wire D_i;
assign D_i = SE ? SI : D; // mux in the scan data

GENUPFRR U1 (
.Q(Q),
.AC(~RSTB), // active low reset
.AS(1'b0), // inactive set
.SD(D_i),
.CLK(CLK),
// save when RETN is low and restore on high
.SAVE(RETN), .RESTORE(~RETN),
// power connections
.VSS(~VSS), .VDD(VDD), .VSSR(~VSS), .VDDR(VDDG)
);
assign QN = ~Q;

endmodule 
`endcelldefine

`celldefine
// 6
module RSDFFARX1_HVT (CLK, RSTB, D, RETN, SI, SE, Q, QN, VSS, VDD, VDDG);

input CLK, RSTB, D,  SI, SE;
output Q, QN;
(* retention_port_type = "save_restore" *) input RETN;
(* pg_type = "primary_ground" *) input VSS;
(* pg_type = "primary_power" *) input VDD;
(* pg_type = "backup_power" *) input VDDG;

wire D_i;
assign D_i = SE ? SI : D; // mux in the scan data

GENUPFRR U1 (
.Q(Q),
.AC(~RSTB), // active low reset
.AS(1'b0), // inactive set
.SD(D_i),
.CLK(CLK),
// save when RETN is low and restore on high
.SAVE(RETN), .RESTORE(~RETN),
// power connections
.VSS(~VSS), .VDD(VDD), .VSSR(~VSS), .VDDR(VDDG)
);
assign QN = ~Q;

endmodule 
`endcelldefine
