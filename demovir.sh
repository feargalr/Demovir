#!/bin/bash

#       Input parameters:
#       $1 = Fasta file of amino acid sequences predicted from contigs
#	$2 = Threads to use for UBLAST Trembl search

#This script assumes that gene name is contigid_geneNo
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
prodigal -a AA.fasta -i $1 -p meta &> /dev/null
echo "Genes predicted"
usearch -ublast AA.fasta -db $DIR/uniprot_trembl.viral.udb -evalue 1e-5 -trunclabels -blast6out trembl_ublast.viral.txt -threads $2 &> /dev/null
echo "UBLAST complete"
sort -u -k1,1 trembl_ublast.viral.txt > trembl_ublast.viral.u.txt
rm AA.fasta 
cut -f 1,2 trembl_ublast.viral.u.txt | sed 's/_[0-9]\+\t/\t/' | cut -f 1 | paste trembl_ublast.viral.u.txt - > trembl_ublast.viral.u.contigID.txt
rm trembl_ublast.viral.u.txt trembl_ublast.viral.txt
Rscript $DIR/demovir.R
rm trembl_ublast.viral.u.contigID.txt
echo "Done!"
