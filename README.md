Comparative analysis of introns in published ciliate genomes
============================================================

To accompany [Seah, Shaikhutdinov et al., 2026](https://doi.org/10.64898/2026.07.09.736142)

Reference genome annotation sources are listed in
`annot/annotation-sources.yaml`.

Mapping reannotation of selected genomes are documented in scripts
`map_rnaseq.sh` and `genepred/run_braker.sh`. Conda environment is defined in
`rnaseq.yml`.

Analysis code and notes are in the Jupyter notebooks.


## Limitations of published gene models for ciliate genomes

Available gene predictions for ciliate genomes were produced by a variety of
methods and investigators.

We considered the gene models and published intron annotations from
well-studied laboratory model species with gene-dense MAC genomes, particularly
*Paramecium tetraurelia*, *Tetrahymena thermophila*, and *Oxytricha trifallax*,
to be the most reliable, because the gene models are supported by multiple
evidence modes (e.g. https://doi.org/10.1101/2024.01.31.578305), and have been
curated by active communities of users. In the case of *Oxytricha*, the
gene-sized nanochromosomes of the MAC genome also aided accurate gene
prediction. The remainder have issues that affect their use in comparative
analyses.

The *Blepharisma stoltei* and *Loxodes magnus* genomes were assembled and
annotated in previous studies from our group
(https://doi.org/10.1073/pnas.2213887120,
https://doi.org/10.1073/pnas.2213985120,
https://doi.org/10.1073/pnas.2400503121). Because of their unusually short
introns, which poorly fit available gene models, we annotated splice junctions
empirically from RNA-Seq mappings, and then predicted genes from an artificial
“intronless” version of the genome. Not all genes (and hence introns) will be
represented in the RNA-Seq dataset, so there are possible unanticipated gene
prediction artifacts or systematic biases.

*Pseudokeronopsis* spp. The published gene annotations appear largely spurious;
visual inspection of RNA-Seq mappings show little overlap between predicted
genes and RNA-Seq coverage. The published gene models have an uncharacteristic
enrichment of 3n introns, and a 3’-localization bias of introns. In comparison,
introns empirically annotated from RNA-Seq data have a narrower length
distribution more typical of ciliates, and without the 3n-enrichment.

*Entodinium caudatum*. Assembly is published (GCA_002087855.3), while annotations
were obtained by personal communication. The annotated introns have a longer
tailed length distribution than those found empirically by read mapping, a
sharp lower length cutoff (32 bp) that would have excluded many real introns,
and an unusual bimodal 5’- and 3’-localization bias. The length cutoff suggests
inappropriate parameterization of the gene prediction model. Our reannotation
of the same assembly with BRAKER3 using RNA-Seq mapping as hints produced more
realistic intron metrics. The longest contig in the assembly,
Genbank accession NBJL03000001.1 (original contig identifier Ento_MGS_1), has
no RNA-Seq reads mapped but many predicted genes; BLAST of selected regions and
mmseqs taxonomy confirm that this contig is a methanogen sequence. There are
other likely contaminant sequences too.

*Balantidium ctenopharyngodoni*. The published annotation
(https://doi.org/10.6084/m9.figshare.24439159) has very few introns (75 total,
0.003 per gene), which appears to be an under-prediction based on our
reanalysis of the RNA-Seq data with Portcullis (8689 with canonical GT-AG
splice junctions and length greater than 10, less than 100).

*Chilodonella uncinata*. No MAC draft genome. MIC raw reads have been published,
but not the assemblies, so we cannot evaluate claims made in a previous
publication (https://doi.org/10.1128/mbio.01836-17).

*Nyctotherus ovalis*. Only 48 introns have been reported, but the published
genome is only partial. There was insufficient public data for us to perform a
reanalysis.

*Enterocytozoon bieneusi*. No public RNA-Seq data were found on SRA.
Publications that reported lack of introns only performed genome sequencing
(https://doi.org/10.1371/journal.ppat.1000261,
https://doi.org/10.1093/gbe/evq022) and used homology- and modeling-based
methods for intron detection, so we could not include them in our current
analysis. Note also that other *Enterocytozoon* species do have introns
(https://doi.org/10.1038/ncomms1082).

Short introns of ciliates are challenging to model. Gene prediction software
typically expects the longer introns of typical model organisms like metazoans,
yeast, and plants. RNA-Seq mappings are usually used as hints for gene
prediction, but the default settings of mappers like Hisat2 often have an
excessively short minimum intron length cutoff that excludes real short introns
of many ciliates.
