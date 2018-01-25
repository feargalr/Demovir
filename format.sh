#!/bin/bash
gunzip unipro*fasta.gz
sed 's/tr|//' unipro*fasta | sed 's/|/\t/' | cut -f 1 > uniprot_viral.sedded.fasta
zcat TrEMBL_ids_which_have_order_family.txt.gz | pullseq -N -i uniprot_viral.sedded.fasta
rm uniprot_viral.sedded.fasta
usearch -makeudb_ublast uniprot_viral.sedded.fasta  -output uniprot_trembl.viral.udb
