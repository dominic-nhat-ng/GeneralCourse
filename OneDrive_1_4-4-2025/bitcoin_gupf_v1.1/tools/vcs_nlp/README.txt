Revs to use --> just default to latest for everything
module addlatest vcsmx
module addlatest verdi

gmake help [to get more information]

But the basic commands that you need are below 

Default is RTL sims with UPF with dumping for 50 transactions
-----------------------------------------------
gmake


RTL sims without UPF 
----------------------------------------------
gmake LP=0


RTL sims without UPF and without dumping
----------------------------------------------
gmake LP=0 MODE=NODEBUG


For GLS (gate level simulations)

GLS sims with UPF for 50 transactions with dumping
------------------------------------------------
gmake PHASE=GLS


GLS sims without UPF
---------------------------------------------
gmake LP=0 PHASE=GLS


GLS sims without UPF without dumping
---------------------------------------------
gmake LP=0 PHASE=GLS MODE=NODEBUG

* simv/csrc etc goes under ‘output’ separate directory based 'PHASE', 'MODE' &  'LP'
* all logs files and FSDB dumps go under ‘logs’ directory separate directory
* based on PHASE, MODE & LP

Outputs that will be consumed by other tools are written into 'outputsfromvcs'
