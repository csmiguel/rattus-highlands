#Miguel Camacho-Sanchez
#feb 2020
#Rattus_highlands
#align query sequences (qs) to MSA
#############

#fix korinchi name from Rattus_korinchi_BM_19.11.5.81 to Rattus_korinchi_BM_19_11_5_81
# and replace ? with N.
#prepare reference dna alignment
cat phylogenetic_analysis/RAxML/raxml/mito_all_cds.phy | \
sed 's/\./_/g' |  sed 's/\?/N/g' > ancestral_states/mito_all_cds.phy

trimal -in ancestral_states/mito_all_cds.phy -fasta -out ancestral_states/mito_all_cds.fasta

#since I have problems running papara2.5 I will use mafft
# https://mafft.cbrc.jp/alignment/software/addsequences.html
mafft --add ancestral_states/asian_rattus_cytb_fixed.fasta \
--reorder --keeplength ancestral_states/mito_all_cds.fasta > ancestral_states/mito_cds_cytb.fasta

#convert to phylip format for RAxML
trimal -in ancestral_states/mito_cds_cytb.fasta -phylip -out ancestral_states/mito_cds_cytb.phy
