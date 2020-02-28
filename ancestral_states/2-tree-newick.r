#Miguel Camacho-Sanchez
#feb 2020
#Rattus_highlands
#write tree in newick format
#############
library(magrittr)
#read raxml tree
tr <- ape::read.nexus("phylogenetic_analysis/RAxML/raxml/RAxML_bipartitions.Rattus_mitogenomes_raxml.tree")
tr$tip.label %<>% {gsub(pattern = "\\.", replacement = "_", x = .)} %>%
  {gsub(pattern = "'", replacement = "", x = .)}
#write tree in newick format
ape::write.tree(tr, file = "ancestral_states/raxml.tre")
