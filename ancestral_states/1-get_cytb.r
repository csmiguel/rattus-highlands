#Miguel Camacho-Sanchez
#feb 2020
#Rattus_highlands
#get cytb sequences from genbank for Asian Rattus.
#############
#A potential source of bias in ancestral state reconstruction is having an incomplete taxonomic sampling. I will use the mitogenome tree in raxml as a solid backbone to place lineages in the Asian Rattus group for other lineages for which there is only cytochrome b available. Asian Rattus, seems to be a solid monophyletic clade originated in continental Asia (Fabre et al. 2013, 10.1111/zoj.12061, Clade M, Fig. 3; Thomson et al. 2018, 10.11646/zootaxa.4459.3.2, Clades A and B, Fig. 2).

library(rentrez)

#genbank accession for Asian Rattus from Thompson et al. 2018.I have included 2 seqs per species except for R. tiomanicus for which I have included from different islands to have a good phylogeographic representation.
qs <-
  c(
    "JN675511",
    "JN675512",
    "JN675493",
    "JN675494",
    "JX534046",
    "JX534055",
    "JN675628",
    "JN675508",
    "JN675487",
    "JQ823538",
    "HM217736",
    "HM217739",
    "JF436986",
    "JF436975",
    "HM217391",
    "KC010165",
    "KC010167",
    "KC010166",
    "KC010168",
    "JN675515",
    "EF186514",
    "JN675516")


sink("ancestral_states/asian_rattus_cytb.fasta")
fasta_qs <-
  qs %>%
  lapply(function(x){
    entrez_fetch(db = "nucleotide", id = x, rettype = "fasta") %>%
      {cat(strwrap(.), sep = "\n")}
  })
sink()

# the sequence KP876560 from R. tiomanicus is a complete mitogenome, which causes me trouble in the alignment. For that reason I will treat it sepparatedly and extract cytb from it.
sink("ancestral_states/KP876560.fasta")
entrez_fetch(db = "nucleotide", id = "KP876560", rettype = "fasta") %>%
  {cat(strwrap(.), sep = "\n")}
sink()
