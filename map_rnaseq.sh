#!/bin/bash
set -e

case "$1" in
  "index_ecau")
    source activate ./envs/rnaseq
    hisat2-build -p 8 -f Ent_caudatum/Ent_caudatum_genome.fasta ref/ecau
    hisat2-build -p 8 -f ref/GCA_001499635.1.fasta ref/cmag
    ;;
  "map_ecau")
    source activate ./envs/rnaseq
    # modified version of hisat2 that allows shorter introns
      ./hisat2/hisat2 -x ref/ecau \
      -1 rnaseq/SRR8478280_1.fastq.gz -2 rnaseq/SRR8478280_2.fastq.gz \
      --min-intronlen 9 --max-intronlen 500 -p 24 \
      --summary-file map/SRR8478280.ecau.hisat2.summary.txt \
      --no-unal -S map/SRR8478280.ecau.hisat2.sam
    ;;
  "sort_ecau")
    source activate ./envs/rnaseq
    samtools sort --threads 8 --write-index -o map/SRR8478280.ecau.hisat2.sort.bam map/SRR8478280.ecau.hisat2.sam
    ;;
  "index_cmag")
    source activate ./envs/rnaseq
    hisat2-build -p 8 -f ref/GCA_001499635.1.fasta ref/cmag
    ;;
  "map_cmag")
    source activate ./envs/rnaseq
    # modified version of hisat2 that allows shorter introns
      ./hisat2/hisat2 -x ref/cmag \
      -1 rnaseq/SRR1296902_1.fastq.gz -2 rnaseq/SRR1296902_2.fastq.gz \
      --min-intronlen 9 --max-intronlen 500 -p 24 \
      --summary-file map/SRR1296902.cmag.hisat2.summary.txt \
      --no-unal -S map/SRR1296902.cmag.hisat2.sam
    ;;
  "sort_cmag")
    source activate ./envs/rnaseq
    samtools sort --threads 8 --write-index -o map/SRR1296902.cmag.hisat2.sort.bam map/SRR1296902.cmag.hisat2.sam
    ;;
  "index_pcar")
    source activate ./envs/rnaseq
    hisat2-build -p 8 -f ref/Pse_carnea_Jun2021_assembly.fasta ref/pcar
    ;;
  "map_pcar")
    source activate ./envs/rnaseq
    hisat2 -x ref/pcar \
      -1 rnaseq/SRR15145271_1.fastq.gz -2 rnaseq/SRR15145271_2.fastq.gz \
      --min-intronlen 20 --max-intronlen 500 -p 24 \
      --summary-file map/SRR15145271.pcar.hisat2.summary.txt \
      --no-unal -S map/SRR15145271.pcar.hisat2.sam
    ;;
  "sort_pcar")
    source activate ./envs/rnaseq
    samtools sort --threads 8 --write-index -o map/SRR15145271.pcar.hisat2.sort.bam map/SRR15145271.pcar.hisat2.sam
    ;;
  "index_pfla")
    source activate ./envs/rnaseq
    hisat2-build -p 8 -f ref/Pse_flava_Jun2021_assembly.fasta ref/pfla
    ;;
  *)
    echo "index map sort"
    exit 1
esac
