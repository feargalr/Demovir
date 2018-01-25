# Demovir
Taxonomic classification of viral contigs to Order and Family level

When performing metagenomic sequencing of Viral-Like Particle (VLP) captures the majority of returned sequences often bare little to no homology to reference sequences. Frequently it may be useful to know which viral taxonomic group these novel viruses are likely to belong to as this will give information about nucleic acid type, size and behaviour.

DemoVir will classify viral contigs to the Order or Family taxonomic level by comparing genes on the amino acid level against the viral subset of the TrEMBL database, and then taking a vote of the Order and Family hits. Homology searches are performed by Usearch in order to increase speed.

DemoVir expects as input a multi fasta file of amino acid sequences where the sequence headers are contigid_geneid, such as in the output produced by prodigal (e.g. NODE_1_length_100_cov_25_1, NODE_1_length_100_cov_25_2, NODE_1_length_100_cov_25_3).

## INSTALLATION

### PREREQUISITES:

-R

-Usearch

Usearch 32 bit is available for free from
http://www.drive5.com/more.html

### DATABASE:
The viral subset of the TrEMBL database is available from
http://www.uniprot.org/uniprot/?query=reviewed:no+taxonomy:10239
Download -> FASTA (canonical) compressed. 


To format the database for use with DemoVir simply execute the following in the directory where you have place the above file

```
format.sh 
```



## Classifying contigs
DemoVir expects a multi fasta 

```
demovir.sh input.fasta evalue threads
```
