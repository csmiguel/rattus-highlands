# Phylogeography of *Rattus* in Sundaland

Phylogeography of *Rattus* native to Sundaland based on complete mitochondrial genomes. We determine the phylogenetic position of mountain species from Borneo (*R. baluensis*) and Sumatra (*R. korinci* and *R. hoogerwerfi*), with ML trees, date the divergence, evaluate selection in the mitochondrial protein-coding genes and test for morphological convergence.

This repository contains supplementary data and results on the analysis of the manuscript:

Miguel Camacho-Sanchez, Jennifer Leonard (2020) Mitogenomes reveal multiple colonization of mountains by *Rattus* in Sundaland. In review.

### DNA sequences

Mitochondrial genomes have been deposited in GenBank under accession numbers:

* *R. hoogerwerfi* (ANSP 20319): [MN126561](genbank.com)
* *R. korinchi* (BM 19.11.5.81): [MN126567](genbank.com)
* *R. korinchi* (RMNH 23151): [MN126568](genbank.com)
* R. R3 (NH 2147): [MN126565](genbank.com)
* *R. tanezumi* (BOR260): [MN126566](genbank.com)
* *R. tiomanicus* (NH 2015): [MN126562](genbank.com)
* *R. tiomanicus* (USNM 590332): [MN126563](genbank.com)
* *R. tiomanicus* (USNM 590720): [MN126564](genbank.com)

### phylogenetic analysis

I did phylogenetic reconstructions in a Maximum Likelihood framework (RAxML) and dated the tree with BEAST.

BEAST: it is included analysis in [PartitionFinder](phylogenetic_analysis/Beast/PartitionFinder), input for BEAST elaborated in [BEAUti](phylogenetic_analysis/Beast/27_mito_Rattus.xml), runs [1](phylogenetic_analysis/Beast/run1_cipress) and [2](phylogenetic_analysis/Beast/run2_cipress), and consensus [tree](phylogenetic_analysis/Beast/27_rattus_consensus.tre).

### selection analysis

The [selection analysis](selection_analysis/) test whether the mitogenomes of high-elevation *Rattus* show signs of positive selection. The folder contains the input  trees, DNA alignments and controls files used in the analysis with codeml from [paml](http://abacus.gene.ucl.ac.uk/software/paml.html), and results in the output folder. I have included a [script in R](selection_analysis/lrt.r) to extract the important information from the output, compute the LRT and produce a summary table (see Table x, in the manuscript).
I have included 3 analysis to test if the background dN/dS in the tree is different to that from the highland species. For that reason, I have used 3 datasets:

* 1. [Concatenated MSA: one individual per species (n = 20)](selection_analysis/1ind_per_lineage)
* 2. [Concatenated MSA: full dataset (n = 56)](selection_analysis/fulldata/concatenated)
* 3. [Per gene analysis: full dataset (n = 56)](selection_analysis/1ind_per_lineage/concatenated)

I had to exclude BM19.11.5.81 from the full dataset because due to its large amounts of missing data I was loosing around 10% of the positions in the alignment for the selection analysis in codeml.
