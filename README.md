# *Rattus* Phylogeography in Sundaland

Phylogeography of *Rattus* native to Sundaland based on complete mitochondrial genomes. We determine the phylogenetic position of mountain species from Borneo (*R. baluensis*) and Sumatra (*R. korinchi* and *R. hoogerwerfi*), with ML trees, date the divergence, evaluate selection in the mitochondrial protein-coding genes and test for morphological convergence.

This repository contains supplementary data, results and analysis on:

<font size="16">Miguel Camacho-Sanchez, Jennifer Leonard (2020) Mitogenomes reveal multiple colonization of mountains by *Rattus* in Sundaland. [10.1093/jhered/esaa014](https://doi.org/10.1093/jhered/esaa014).</font>

### mitogenome assembly

General description [here](mitogenome-assembly.txt).

### DNA sequences

Mitochondrial genomes have been deposited in GenBank under accession numbers:

* *R. exulans* BOR577: [MN126569](https://www.ncbi.nlm.nih.gov/nuccore/MN126569)
* *R. hoogerwerfi* ANSP 20319: [MN126561](https://www.ncbi.nlm.nih.gov/nuccore/MN126561)
* *R. korinchi* BM 19.11.5.81: [MN126567](https://www.ncbi.nlm.nih.gov/nuccore/MN126567)
* *R. korinchi* RMNH 23151: [MN126568](https://www.ncbi.nlm.nih.gov/nuccore/MN126568)
* R. R3 NH 2147: [MN126565](https://www.ncbi.nlm.nih.gov/nuccore/MN126565)
* *R. tanezumi* BOR260: [MN126566](https://www.ncbi.nlm.nih.gov/nuccore/MN126566)
* *R. tiomanicus* NH 2015: [MN126562](https://www.ncbi.nlm.nih.gov/nuccore/MN126562)
* *R. tiomanicus* USNM 590332: [MN126563](https://www.ncbi.nlm.nih.gov/nuccore/MN126563)
* *R. tiomanicus* USNM 590720: [MN126564](https://www.ncbi.nlm.nih.gov/nuccore/MN126564)

### phylogenetic analysis

Phylogenetic reconstructions in a Maximum Likelihood framework (RAxML) and dated tree with BEAST.

BEAST: the repository includes [data](phylogenetic_analysis/Beast/PartitionFinder) from analysis in PartitionFinder, [xml file](phylogenetic_analysis/Beast/27_mito_Rattus.xml) from BEAUti, runs [1](phylogenetic_analysis/Beast/run1_cipress) and [2](phylogenetic_analysis/Beast/run2_cipress), and [consensus tree](phylogenetic_analysis/Beast/27_rattus_consensus.tre).

RAxML: the repository includes [data](phylogenetic_analysis/RAxML/PartitionFinder) from analysis in PartitionFinder, [input alignment](phylogenetic_analysis/RAxML/raxml/mito_all_cds.phy) for RAxML with its [partitions](phylogenetic_analysis/RAxML/raxml/partitions.txt) and resulting [trees](phylogenetic_analysis/RAxML/raxml).

```
raxmlHPC-PTHREADS-SSE3 -f a -m GTRGAMMA -q phylogenetic_analysis/RAxML/raxml/partitions.txt -p $RANDOM -x $RANDOM -# autoMRE -s phylogenetic_analysis/RAxML/raxml/mito_all_cds.phy -n Rattus_mitogenomes_raxml -T 10
```

### haplotype network

The [DNA alignment](haplotype_networks/network_matrix.nex) of *cytochrome b* to reconstruct the haplotype network within the *R. tiomanicus* group (*R. tiomanicus* + *R. baluensis*).

### ancestral distribution

The [ancestral distribution](ancestral_states/) of the lineages was evaluated with `phytools::rerootingMethod`. *Cyt b* sequences from other species of *Rattus* were added to the [RAxML tree](phylogenetic_analysis/RAxML/raxml) using an Evolutionary Placement Algorithm. [Matset et al. 2012](https://doi.org/10.1371/journal.pone.0031009) explain the interpretation of the raw [results](ancestral_states/RAxML_portableTree.addcytb.jplace). Analysis are done running scripts sequentially 1 to 5.

### selection analysis

The [selection analysis](selection_analysis/) test whether mitogenomes of high-elevation *Rattus* show signs of positive selection. The folder contains the input  trees, DNA alignments and control files used in the analysis with codeml from [paml](http://abacus.gene.ucl.ac.uk/software/paml.html), and results in the output folder. I have included a [script in R](selection_analysis/lrt.r) to extract the important information from the output, compute the LRT and produce a summary table (see Table x, in the manuscript).
I have included 3 analysis to test if the background dN/dS in the tree is different to that from the highland species. Three datasets were used:

* 1. [Concatenated MSA: one individual per species (n = 20)](selection_analysis/1ind_per_lineage)
* 2. [Concatenated MSA: full dataset (n = 56)](selection_analysis/fulldata/concatenated)
* 3. [Per gene analysis: full dataset (n = 56)](selection_analysis/1ind_per_lineage/concatenated)

Sample BM19.11.5.81 was excluded from the full dataset because due to its large amounts of missing data I was loosing around 10% of the positions in the alignment for the selection analysis in codeml.
