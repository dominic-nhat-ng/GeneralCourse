# PLEASE MODIFY THIS SETUP FILE TO SUIT YOUR ENVIRONMENT

module unload spyglass
module unload vcstatic
module unload vcsmx
module unload verdi
module unload powrep
module unload syn
module unload pt
module unload fm
module unload icc2
module unload starrc

module load spyglass/2017.03-SP1
module load vcstatic/2017.03-SP1
module load vcsmx/2017.03-SP1
module load verdi/2017.03-SP1
module load powrep/2017.03-SP1
module load syn/2016.12-SP5
module load pt/2016.12-SP3
module load fm/2016.12-SP5
module load icc2/2016.12-SP5
module load starrc/2016.12-SP3

# PowerReplay
setenv FSDB_GATE 0
