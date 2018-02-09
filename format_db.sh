bunzip2 nr95.fasta.bz2
usearch -makeudb_ublast nr95.fasta -output uniprot_trembl.viral.udb &> usearch_database.log
