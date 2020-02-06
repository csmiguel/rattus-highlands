# Phylogeography of *Rattus* in Sundaland

One Paragraph of project description goes here

## Description

This repository contains supplementary data and results on the analysis of the manuscript:

Miguel Camacho-Sanchez, Jennifer Leonard (2020) Mitogenomes reveal multiple colonization of mountains by *Rattus* in Sundaland. In review.

###DNA sequences
The mitochondrial genomes have been deposited in GenBank under accession numbers:


The DNA sequences from this ta
###selection analysis
The [selection analysis](selection_analysis/) test whether the mitogenomes of high-elevation *Rattus* show signs of positive selection. The folder contains the input  trees, DNA alignments and controls files used in the analysis with codeml from [paml](http://abacus.gene.ucl.ac.uk/software/paml.html), and results in the output folder. I have included a [script in R](selection_analysis/lrt.r) to extract the important information from the output, compute the LRT and produce a summary table (see Table x, in the manuscript).
I have included 3 analysis to test if the background dN/dS in the tree is different to that from the highland species. For that reason, I have used 3 datasets:

* 1. [Concatenated MSA: one individual per species (n = 20)](selection_analysis/1ind_per_lineage)
* 2. [Concatenated MSA: full dataset (n = 56)](selection_analysis/fulldata/concatenated)
* 3. [Per gene analysis: full dataset (n = 56)](selection_analysis/1ind_per_lineage/concatenated)

I had to exclude BM19.11.5.81 from the full dataset because due to its large amounts of missing data I was loosing around 10% of the positions in the alignment for the selection analysis in codeml.
