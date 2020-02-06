#computation of LRT for selection analysis
#Miguel Camacho Sanchez
#Feb 2020
#This script evaluates LRT for the selection analysis on the highland Rattus in Sundaland
#I did the following tests:
#1. Selection on a matrix with 1 individual per species (n = 20 tips)
# 1.1. Branch test M0 vs model = 2
# 1.2  Branch-site MA vs MA1
#2. Selection on a matrix with full data (n = 56 tips)
# 2.1 concatenated alignment
#   2.1.1 M0 vs model = 2
# 2.2 partitioned alignment (1 per gene, n = 13 genes)
#   2.2.1 M0 vs model = 2

#############
setwd("selection_analysis/")
library(dplyr)
library(magrittr)

#output paths
#1. Selection on a matrix with 1 individual per species (n = 20 tips)
# 1.1. Branch test M0 vs model = 2
b0 <- "1ind_per_lineage/output/M0"
b2 <- "1ind_per_lineage/output/B2"
# 1.2  Branch-site MA vs MA1
#bs0 <- "1ind_per_lineage/output/BS-H0"
#bs1 <- "1ind_per_lineage/output/BS-H1"
#2. Selection on a matrix with full data (n = 56 tips)
# 2.1 concatenated alignment
#   2.1.1 M0 vs model = 2
concatM0 <- "fulldata/concatenated/output/M0"
concatM2 <- "fulldata/concatenated/output/M2"
# 2.2 partitioned alignment (1 per gene, n = 13 genes)
#   2.2.1 M0 vs model = 2
partM0 <- "fulldata/partitioned/output/partitioned_M0"
partM2 <- "fulldata/partitioned/output/partitioned_M2"

######### function to extract lnL and degrees of freedom ########
lnl_df <- function(path){
  h <- readLines(path) %>% grep(pattern = "lnL",value = T)
  df <- stringr::str_replace(h, "^.*np: ?([0-9]*).*", "\\1") %>% as.numeric()
  lnl <- stringr::str_replace(h, "^.*(-[0-9]*\\.[0-9]*).*", "\\1") %>% as.numeric()
  hh <- data.frame(lnl = lnl, df = df, dataset = path)
}
#function to extract omega from model = 2 files
extract_omegaM2 <- function(x){
  tr <- readLines(x)[grep(readLines(x), pattern = "w ratios") + 1]
  w0 <-
    stringr::str_extract_all(tr, "Rattus_norvegicus_AJ428514 #[0-9]\\.[0-9]*") %>%
    unlist %>%
    stringr::str_replace("^.*#", "") %>%
    as.numeric() %>% round(3)
  w1 <-
    stringr::str_extract_all(tr, "Rattus_baluensis_BOR373 #[0-9]\\.[0-9]*") %>%
    unlist %>%
    stringr::str_replace("^.*#", "") %>%
    as.numeric() %>% round(3)
  w2 <-
    stringr::str_extract_all(tr, "Rattus_korinchi_RMNH23151 #[0-9]\\.[0-9]*") %>%
    unlist %>%
    stringr::str_replace("^.*#", "") %>%
    as.numeric() %>% round(3)
  data.frame(w0 = w0, w1 = w1, w2 = w2)
}
##################################################################

#list with output
paths <- list(b0 = b0, b2 = b2,
            concatM0 = concatM0, concatM2 = concatM2,
            partM0 = partM0, partM2 = partM2)
#table with results
out <-
  paths %>%
  lapply(lnl_df) %>% #return df and lnL for each output
    do.call(what = rbind) %>% # bind results
  dplyr::mutate(rn = rownames(.)) %>%
  dplyr::mutate(H = plyr::mapvalues(x = rn,
                                 from = rn,
                                 to = c("t1", "t1", "t2", "t2",
                                        paste0("t", rep(3:15, 2)))
                                 )) %>%
  dplyr::as_tibble() %>%
  dplyr::mutate(H = as.factor(H))

#likelihood ratio test
lrt <-
  plyr::ddply(out, ~H, function(x){
  assertthat::assert_that(nrow(x) == 2) #assert it is a pairwise comparison
  lrt <- abs(2 * (x$lnl[1] - x$lnl[2])) # LRT
  dfree <- abs(x$df[1] - x$df[2]) # degrees of freedom
  p <- pchisq(lrt, df = dfree, lower.tail=FALSE) # p-value
  H0 <- x$rn %>% grep(pattern = "[aA-zZ]0", value = T) # null hypothesis
  H1 <- x$rn %>% grep(pattern = "[aA-zZ]0", value = T, invert = T) # alternative hypothesis
  data.frame(LRT = round(lrt, 3), dfree = dfree, p = round(p, 3), H0 = H0, H1 = H1)
}) %>%
  #arrange by hypothesis
  dplyr::mutate(temp = stringr::str_replace(string = H, "t", "") %>%
                  as.numeric()) %>%
  dplyr::arrange(temp) %>%
  dplyr::select(-temp)

#gene order
genes <- read.table("fulldata/partitioned/gene_order") %>% pull() %>% as.character()

lrt %<>%
  mutate(new =
           ifelse(grepl(pattern = "part", H0),
                  yes = genes[as.numeric(stringr::str_replace(H0, "partM0.", ""))],
                  no = as.character(H0))) %>%
  dplyr::mutate(H = as.character(H), H0 = as.character(H0), H1 = as.character(H1))

####get omega###
omegas <-
  paths %>%
  lapply(function(ome){
    h <- readLines(ome) %>% grep(pattern = "omega",value = T)
    if(length(h) >= 1){
      w0 <- stringr::str_extract(h, "[0-9]\\.[0-9]*") %>% as.numeric() %>% round(3)
      w1 <- -999 %>% round(0)
      w2 <- -999 %>% round(0)
      data.frame(w0 = w0, w1 = w1, w2 = w2)
    } else if(length(h) == 0){
      extract_omegaM2(ome)
    }
  }) %>%
  do.call(what = rbind) %>%
  tibble::rownames_to_column("dataset") %>%
  dplyr::as_tibble()

#combined tables lrt and omega
lrt_omega <-
  dplyr::select(lrt, H, H0, H1) %>%
  reshape2::melt(id = "H") %>%
  dplyr::mutate(order = stringr::str_replace(H, "t", "") %>% as.numeric()) %>%
  dplyr::select(-variable) %>%
  left_join(x = omegas, by = c("dataset" = "value")) %>%
  dplyr::arrange(order, dataset) %>%
  dplyr::left_join(lrt, by = c("H" = "H")) %>%
  dplyr::rename(gene = new) %>%
  dplyr::select(-H0, -H1, -order)

lrt_omega[lrt_omega == -999] <- "-"

#bind size genes
  gene_nt <-
  read.table("fulldata/partitioned/partition.txt") %>%
  dplyr::mutate(startg = stringr::str_replace(V3, "-[0-9]*", "") %>% as.numeric()) %>%
  dplyr::mutate(endg = stringr::str_replace(V3, "^[0-9]*-", "") %>% as.numeric()) %>%
  dplyr::mutate(nt = endg - startg + 1) %>%
  dplyr::select(V1, nt) %>%
  dplyr::rename(gene = V1)
  
#join genes to df
lrt_omega_gene <-
  dplyr::left_join(lrt_omega, gene_nt, by = "gene") %>%
  dplyr::select(gene, w0, w1, w2, LRT, dfree, p, nt)


#write table
write.csv(lrt_omega_gene, "selection.txt")


