#Miguel Camacho-Sanchez
#feb 2020
#Rattus_highlands
#Evolutionary phylogenetic placement of the new sequencesa added to the msa
#############
#This is RAxML version 8.2.11 released by Alexandros Stamatakis on June 2017.
NPWD=$(pwd)
#If you frequently want to insert different sequence into the same reference tree, there is a shortcut to make this more efficient, because the model parameters and branch lengths are estimated from scratch for the reference tree each time when you invoke the program. If you want to avoid this you proceed as follows.

rm ancestral_states/*addcytb
#1. Generate a binary file containing the model parameters for the reference tree:
raxmlHPC-SSE3 -f e -m GTRGAMMA -s ancestral_states/mito_all_cds.phy \
-t ancestral_states/raxml.tre -n PARAMS -w "$NPWD"/ancestral_states/

#This will generate a file called: RAxML_binaryModelParameters.PARAMS which can then be read by the EPA to avoid re-optimizing parameters:
raxmlHPC-SSE3 -f v -R ancestral_states/RAxML_binaryModelParameters.PARAMS \
-t ancestral_states/RAxML_result.PARAMS -s ancestral_states/mito_cds_cytb.phy \
-m GTRGAMMA -n addcytb -w "$NPWD"/ancestral_states/
