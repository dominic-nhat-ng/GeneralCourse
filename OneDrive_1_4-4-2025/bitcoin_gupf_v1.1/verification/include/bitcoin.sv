//
// Template for UVM-compliant verification environment
//

`ifndef BITCOIN__SV
`define BITCOIN__SV

`include "tr_file_list_bitcoin.sv"
`include "btcoin_mon.sv"

`include "btcoin_drv.sv"
`include "btcoin_seq.sv"  





`include "btcoin_cfg.sv"



`include "btcoin_cov.sv"

`include "mon_2cov.sv"


// ToDo: Add additional required `include directives

`endif // BITCOIN__SV
