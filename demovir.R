initial.options <- commandArgs(trailingOnly = FALSE)
file.arg.name <- "--file="
script.name <- sub(file.arg.name, "", initial.options[grep(file.arg.name, initial.options)])
script.basename <- dirname(script.name)
other.name <- paste(sep="/", script.basename, "other.R")
print(script.basename)



results = read.delim("trembl_ublast.viral.u.contigID.txt",sep="\t",header=FALSE)
colnames(results) = c("query","subject","percentid","alnlen","qlen","slen","qstart","qend","sstart","send","evalue","bitscore","contig")
taxa_file = paste(script.basename,"TrEMBL_viral_taxa.RDS",sep="/")

taxa = readRDS(taxa_file)
rownames(taxa) = taxa$id
results2 = data.frame(results,taxa[as.character(results$subject),])


###This works but requires a table with the contig ID, gene id and assignments!!!
results3 = results2

## It seems like the list gets put out of order when it's iterating or something! Beacuse some things 
#get the wrong assignments in the final list but if I look at them one by one they're grand!
#

contig = "PbHybrid_NODE_305_length_6368_cov_3.77728"

taxassO = c()
taxassF = c()
sums_o = c()
sums_f = c()
margin_f = c()
margin_o = c()
for (contig in levels(factor(results3$contig))){
  
  totest = results3[results3$contig==contig,]
  totest$order = as.character(totest$order)
  totest$family = as.character(totest$family)
  for (rownum in 1:nrow(totest)){
    if(is.na(totest[rownum,"order"]) & !is.na(totest[rownum,"family"])){
      totest[rownum,"order"] = paste("no_order",as.character(totest[rownum,"family"]),sep="_")
    }
  }
  totest$order = as.factor(totest$order)
  totest$family = as.factor(totest$family)
  # Order level assignment
  if((length(levels(totest$order))>=0 & !(length(levels(totest$order))>=2 & isTRUE(all.equal(max(table(totest$order)),min(table(totest$order))))))){
  ass_o = names(which.max(table(totest$order)))
  margin_o = c(margin_o,sort(table(totest$order),decreasing = TRUE)[1]/(sum(table(totest$order)[1:(length(table(totest$order)))-1])+sort(table(totest$order),decreasing = TRUE)[1]))
    if(is.null(ass_o)){
      ass_o = "Unassigned"
    }
  }else{
    ass_o = "Unassigned"
    margin_o = c(margin_o,NA)
  }
  
  # Family level assignment
  if ((length(levels(totest$family))>=0 & !(length(levels(totest$family))>=2 & isTRUE(all.equal(max(table(totest$family)),min(table(totest$family))))))){
    ass_f = names(which.max(table(totest$family)))
    margin_f = c(margin_f,sort(table(totest$family),decreasing = TRUE)[1]/(sum(table(totest$family)[1:(length(table(totest$family)))-1])+sort(table(totest$family),decreasing = TRUE)[1]))
    if(is.null(ass_f)){
      ass_f = "Unassigned"
    }
  } else {
    ass_f = "Unassigned"
    margin_f = c(margin_f,NA)
  
  }
  sums_o = c(sums_o,sum(table(totest$order)))
  sums_f = c(sums_f,sum(table(totest$family)))
  
  if (length(table(totest$family))>1){
    if (sort(table(totest$family),decreasing = TRUE)[1] == sort(table(totest$family),decreasing = TRUE)[2]){
    ass_f = "Unassigned"  }
  }
  
  if(is.null(ass_f) & is.null(ass_o)){
    taxassO = c(taxassO,"Unassigned")
    taxassF = c(taxassF,"Unassigned")
  } else{
    taxassO = c(taxassO,ass_o)
    taxassF = c(taxassF,ass_f)
    
  }
}
margin_f = margin_f*100
margin_o = margin_o*100

taxassO[sums_o<=1] = "Unassigned"
taxassF[sums_f<=1] = "Unassigned"

towrite = data.frame(levels(results3$contig),taxassO,margin_o,taxassF,margin_f)
colnames(towrite) = c("Sequence_ID","Order","Percent_of_votes","Family","Percent_of_votes")

write.table(towrite,"DemoVir_assignments.txt",row.names = FALSE,quote=FALSE,sep = "\t")
