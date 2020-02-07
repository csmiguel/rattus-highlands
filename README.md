# Phylogeography of *Rattus* in Sundaland

Phylogeography of *Rattus* native to Sundaland based on complete mitochondrial genomes. We determine the phylogenetic position of mountain species from Borneo (*R. baluensis*) and Sumatra (*R. korinci* and *R. hoogerwerfi*), with ML trees, date the divergence, evaluate selection in the mitochondrial protein-coding genes and test for morphological convergence.

This repository contains supplementary data and results on the analysis of the manuscript:

<font size="14">Miguel Camacho-Sanchez, Jennifer Leonard (2020) Mitogenomes reveal multiple colonization of mountains by *Rattus* in Sundaland. In review.</font>

### DNA sequences

Mitochondrial genomes have been deposited in GenBank under accession numbers:

* *R. hoogerwerfi* (ANSP 20319): [MN126561](https://www.genbank.com)
* *R. korinchi* (BM 19.11.5.81): [MN126567](https://wwwgenbank.com)
* *R. korinchi* (RMNH 23151): [MN126568](https://wwwgenbank.com)
* R. R3 (NH 2147): [MN126565](https://www.genbank.com)
* *R. tanezumi* (BOR260): [MN126566](https://www.genbank.com)
* *R. tiomanicus* (NH 2015): [MN126562](https://www.genbank.com)
* *R. tiomanicus* (USNM 590332): [MN126563](https://www.genbank.com)
* *R. tiomanicus* (USNM 590720): [MN126564](https://www.genbank.com)

### phylogenetic analysis

Phylogenetic reconstructions in a Maximum Likelihood framework (RAxML) and dated tree with BEAST.

BEAST: the repository includes [data](phylogenetic_analysis/Beast/PartitionFinder) from analysis in PartitionFinder, [xml file](phylogenetic_analysis/Beast/27_mito_Rattus.xml) from BEAUti, runs [1](phylogenetic_analysis/Beast/run1_cipress) and [2](phylogenetic_analysis/Beast/run2_cipress), and [consensus tree](phylogenetic_analysis/Beast/27_rattus_consensus.tre).

RAxML: the repository includes [data](phylogenetic_analysis/RAxML/PartitionFinder) from analysis in PartitionFinder, [input alignment](phylogenetic_analysis/RAxML/raxml/mito_all_cds.phy) for RAxML with its [partitions](phylogenetic_analysis/RAxML/raxml/partitions.txt) and resulting [trees](phylogenetic_analysis/RAxML/raxml).

### haplotype network

The [DNA alignment](haplotype_networks/network_matrix.nex) of *cytochrome b* to reconstruct the haplotype network within the *R. tiomanicus* group (*R. tiomanicus* + *R. baluensis*).


### selection analysis

The [selection analysis](selection_analysis/) test whether mitogenomes of high-elevation *Rattus* show signs of positive selection. The folder contains the input  trees, DNA alignments and control files used in the analysis with codeml from [paml](http://abacus.gene.ucl.ac.uk/software/paml.html), and results in the output folder. I have included a [script in R](selection_analysis/lrt.r) to extract the important information from the output, compute the LRT and produce a summary table (see Table x, in the manuscript).
I have included 3 analysis to test if the background dN/dS in the tree is different to that from the highland species. Three datasets were used:

* 1. [Concatenated MSA: one individual per species (n = 20)](selection_analysis/1ind_per_lineage)
* 2. [Concatenated MSA: full dataset (n = 56)](selection_analysis/fulldata/concatenated)
* 3. [Per gene analysis: full dataset (n = 56)](selection_analysis/1ind_per_lineage/concatenated)

Sample BM19.11.5.81 was excluded from the full dataset because due to its large amounts of missing data I was loosing around 10% of the positions in the alignment for the selection analysis in codeml.
