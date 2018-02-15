bunzip2 nr.95.fasta.bz2
usearch -makeudb_ublast nr.95.fasta -output uniprot_trembl.viral.udb &> usearch_database.log
