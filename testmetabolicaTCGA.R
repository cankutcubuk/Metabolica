# tested on R/4.2.2
# module load R/4.2.2
# foreach_1.5.2, doMC_1.3.8, igraph_2.1.3, R.utils_2.12.3

# example script to run: Rscript testmetabolicaTCGA.R --algM "nsqrt" --algR "minprod" --thread 20 --workdir /home/username/ResultsFolder
# dir structure
# ./          --- testmetabolicaTCGA.R
# ./files/    --- all_producers.RData, rxn2gene.RData and combat.vals.LUAD.RData

rm(list=ls())

suppressMessages(library(foreach))
suppressMessages(library(doMC))
suppressMessages(library(igraph))
library(R.utils,quietly=T,verbose=F,warn.conflicts=F)
args <- commandArgs(trailingOnly = F, asValues = T,excludeEnvVars = F)

algM <- args[["algM"]] #"nsqrt", "sum", "mean"
algR <- args[["algR"]] # "maxmin","minmin","minprod"
thread  <- as.numeric(args[["thread"]]) # multicore usage
wdir  <- args[["workdir"]] # directory to save the results
wdir <- normalizePath(wdir)

print(algR)
print(algM)
print(thread)
print(wdir)

registerDoMC(cores=thread) 

source("https://raw.githubusercontent.com/cankutcubuk/Metabolica/master/propagationFuncs.R")
# load("./files/combat.vals.LUAD.RData")
load(url("https://raw.githubusercontent.com/babelomics/Metabolica/refs/heads/master/files/combat.vals.LUAD.RData"))
# load("./files/all_producers.RData")
load(url("https://raw.githubusercontent.com/babelomics/Metabolica/refs/heads/master/files/all_producers.RData"))
# load("./files/rxn2gene.RData")
load(url("https://raw.githubusercontent.com/babelomics/Metabolica/refs/heads/master/files/rxn2gene.RData"))

nodeVals <- do.calc.rxnvals(all_producers,rxn2gene,combat.vals)

res <- foreach(i=1:length(all_producers), .combine = c) %dopar% {
  my_producer <- all_producers[[i]] 

  pathvals <- metabolica(nodes.vals=nodeVals, subgraph = my_producer$produceRigraph, ininodes = my_producer$initialNodes, endnode = my_producer$isProduced, algR = algR, algM = algM, maxnum = my_producer$maxnum*1.5)

  print(names(all_producers)[i])
  return(setNames(list(pathvals), names(all_producers)[i]))
}

res$parameters <- c("algR"=algR, "algM"=algM, "wdir"=wdir)
save(res, file = paste0(wdir,"/TCGA_18cancertype_withVariants_",algM,"_",algR,"_quantile50.RData"))
