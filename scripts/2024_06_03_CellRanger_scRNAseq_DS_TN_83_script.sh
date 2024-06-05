#/usr/bin/env bash

RAN_ON=$(date +%Y_%m_%d_%Hhr%Mmin)
NUMBER=0

# Directories where all the data sets are located
PROJECT=2023_08_01_DJ_scRNA_sample
INVESTIGATOR=verneris

CELLRANGER=/beevol/home/hoffmeye/documents/scRNAseq
DATA=$CELLRANGER/${INVESTIGATOR}/$PROJECT
FASTQ=$DATA/fastq_files
TRANSCRIPTOME=/beevol/home/hoffmeye/documents/genomes/CellRanger_idx/Homo_sapiens.GRCh38.dna/Homo_sapiens.GRCh38.109_genome

FILE=DS_TN_83_
NUMBER=$((${NUMBER}+1))
cat << EOF > ${RAN_ON}_${FILE}.sh
#!/usr/bin/env bash

#BSUB -J DS_TN_83_$NUMBER
#BSUB -e ${RAN_ON}_${FILE}_CELLRANGER.err
#BSUB -o ${RAN_ON}_${FILE}_CELLRANGER.out
#BSUB -n 8
#BSUB -R "span[hosts=1]"
#BSUB -R "select[mem>20] rusage[mem=20]"

module load cellranger/7.1.0

cellranger count --id=DS_TN_83 \
--transcriptome=$TRANSCRIPTOME \
--fastqs=$FASTQ \
--sample=DS_TN_83 \
--expect-cells=5000 \
--localcores=8 \
--localmem=20


EOF
bsub -q normal < ${RAN_ON}_${FILE}.sh
rm -f ${RAN_ON}_${FILE}.sh




