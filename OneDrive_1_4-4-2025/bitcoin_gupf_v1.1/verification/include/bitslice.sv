//
// Template for UVM-compliant verification environment
//

`ifndef BITSLICE__SV
`define BITSLICE__SV

`include "tr_file_list_bitslice.sv"
`include "btslice_mon.sv"

`include "btslice_drv.sv"
`include "btslice_seq.sv"  





`include "btslice_cfg.sv"



`include "btslice_cov.sv"

`include "mon_2cov_btslice.sv"


// ToDo: Add additional required `include directives

`endif // BITSLICE__SV
