# Demovir
Democratic taxonomic classification of viral contigs to Order and Family level

When performing metagenomic sequencing of Viral-Like Particle (VLP), the majority of returned sequences often bare little to no homology to reference sequences - Viral Dark Matter. Frequently it may be useful to know which viral taxonomic group these novel viruses are likely to belong to as this will give information about nucleic acid type, size and behaviour.

DemoVir will classify viral contigs to the Order or Family taxonomic level by comparing genes on the amino acid level against the viral subset of the TrEMBL database, and then taking a vote of the Order and Family hits. Homology searches are performed by Usearch in order to increase speed. This type of method has previously been implemented in multiple published virome studies but to our knowledge none have performed benchmarking or made it available as a simple executable script easily downloaded and installed.

**Note - DemoVir is for classification of sequences into viral families and orders _only_ and _should not_ be used for discrminating viral contigs from bacterial/archael/eukaryotic sequences in a metagenomic sample.**


## INSTALLATION

### PREREQUISITES:

-R

-Usearch

-bzip2

-Prodigal

Usearch 32 bit is available for free from

http://www.drive5.com/more.html

Prodigal is available from

https://github.com/hyattpd/Prodigal

DemoVir assumes that all of the above are available in the PATH.

To download from GitHub:

```
git clone https://github.com/feargalr/Demovir.git
```

### DATABASE:
The viral subset of the TrEMBL database is available from UniProt, but will require some additional formatting for use with DemoVir. In the future we hope to make a method to automate this process.

Alternatively we have a made a version with redundant to 95% identity for increased speed with little to no loss in classification accuracy which is available at:

https://figshare.com/articles/NR_Viral_TrEMBL/5822166


Place the file from FigShare the DemoVir directory and execute the script below

```
/path_to_demovir/format_db.sh 
```



## Classifying contigs
DemoVir expects as input a multi fasta file of nucleotide sequences such as scaffolds or contigs generated by metagenomic assembly. It will then use Prodigal for gene prediction followed by USEARCH for homology searching and then utilises R for assigning taxonomy.

```
/path_to_demovir/demovir.sh input.fasta threads
```

The output is a tab delimited text file containing 5 columns. The first being the sequence ID, the second the Order classification, the third the percentage of the vote this classification got, then the 4th and 5th are the same for Family. Demovir assigns the classification simply by which ever taxa was most prevalant, it does not require a certain threshold to be crossed, or for one taxa to reach a majority (i.e. >50%).

