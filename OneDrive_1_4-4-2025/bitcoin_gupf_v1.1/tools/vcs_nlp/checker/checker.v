module iso_checker (isoSupply, isoGround, ISO_IN, ISO_OUT, ISOEN);
  input isoGround, isoSupply, ISO_IN, ISO_OUT, ISOEN;
  bit isopoweroff;
  import UPF::*;
  import SNPS_LP_MSG::*;
  supply_net_type isoGround, isoSupply;
  parameter string PD_NAME = "";
  parameter string ISOPOLICY1 = "";
  parameter string ISO_GRND_NET_NAME = "";
  parameter string ISO_OUT_GEN = "";
  parameter string ISO_IN_GEN = "";
  parameter string ISO_PWR_NET_NAME = "";
  assign isopoweroff = ((isoSupply.state == OFF) || (isoGround.state ==   OFF));
 
 always @(ISO_OUT)
        begin : my_msg_iso_checker
                my_assert : assert(ISO_OUT !== 1'bx) else 
                begin
                lp_msg_print("LP_MSG_ISO_OUT_CORRUPT", $sformatf( lp_msg_get_format("LP_MSG_ISO_OUT_CORRUPT"), ISO_OUT_GEN, ISOPOLICY1));
                end
         end : my_msg_iso_checker 
 
  always @ (ISO_IN, ISO_OUT) 
        begin
                $display (" %m %0t [CHECKER]  ISO_EN = %d %s = %d, %s = %d for policy %s \n", $time, ISOEN,ISO_IN_GEN,ISO_IN, ISO_OUT_GEN,ISO_OUT, ISOPOLICY1); 
        end
endmodule
