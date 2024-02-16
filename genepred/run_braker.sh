#!/bin/bash

case $1 in
  "build_image")
    apptainer build braker3.sif docker://teambraker/braker3:v3.0.7.1
    ;;
  "copy_config")
    # see https://github.com/Gaius-Augustus/BRAKER/issues/609#issuecomment-1571506735
    # workaround with copy of config folder
    apptainer exec --cleanenv braker3.sif cp -r /usr/share/augustus/config .
    chmod -R 777 ./config
    ;;
  "braker_ecau2")
    # Reannotation of Entodinium caudatum
    mkdir -p ecau2
    apptainer exec --bind /mnt/data/ciliate-introns/:/mnt/data/ciliate-introns/ \
      braker3.sif braker.pl \
      --AUGUSTUS_CONFIG_PATH=/mnt/data/ciliate-introns/genepred/config \
      --genome=/mnt/data/ciliate-introns/Ent_caudatum/Ent_caudatum_genome.fasta \
      --bam=/mnt/data/ciliate-introns/map/SRR8478280.ecau.hisat2.sort.bam \
      --workingdir=${PWD}/ecau2 --species="ecau2" --gff3 --threads=16 --verbosity 3
    ;;
  *)
    echo "build_image copy_config braker_ecau2"
    exit 1
esac
