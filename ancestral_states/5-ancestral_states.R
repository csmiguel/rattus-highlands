#Miguel Camacho-Sanchez
#feb 2020
#Rattus_highlands
# ancestral state reconstructiona and plotting
#############
library(dplyr)
library(phytools)
library(magrittr)

source("ancestral_states/ancestral_states_function.r")

#read raxml tree for complete mitogenomes
tr <- ape::read.nexus("phylogenetic_analysis/RAxML/raxml/RAxML_bipartitions.Rattus_mitogenomes_raxml.tree")
ancestral_reconstruction(tr = tr,
                         "ancestral_states/ancestral_mitogenomes", sizze = 4)
#tree after EPA
trepa <- ape::read.tree("ancestral_states/RAxML_labelledTree.addcytb")
ancestral_reconstruction(tr = trepa,
                         "ancestral_states/ancestral_epa",
                         sizze = 4, fsizze = .6)
