ancestral_reconstruction <- function(tr = NULL, plotname, sizze = 4, fsizze = .8){
  #drop very close related lineages as they seem to overweight some branches, biasing results in Ancestral state reconstruction
  lgroups <- 2
  #as a threshold I select the distance of Rattus_tiomanicus_NH_2015 to the closest tip.
  tr_co <- ape::cophenetic.phylo(tr)["Rattus_tiomanicus_NH_2015", ] %>% sort %>% .[2]*.99
  #loop to crop tree
  while (lgroups > 1){
    #cophenetic distance
    h <- ape::cophenetic.phylo(tr)
    #groups of tips with a distance below threshold
    groups <-
      tr$tip.label %>% lapply(function(x){
        names(h[,x][(h[,x] < tr_co)])
      }) %>% setNames(tr$tip.label)
    #drop all individuals from the largest group except 1 if there is a group
    max_groups <- sapply(groups, length) %>% which.max()
    if(max_groups > 1){
      to_drop <- groups[[max_groups]][-1]
      tr <- ape::drop.tip(tr, to_drop)
      lgroups <- 2
    } else {lgroups <- 1}
  }


  ##ROOT tree using outgroups
  #outgroups
  outg <- tr$tip.label[grep("Rattus", tr$tip.label, invert = T)]

  #node id for the most recent common ancestor of outgroup
  mrca_outgroup <-
    phytools::findMRCA(tr, tips = outg)

  #half distance of the position from the node to root from
  position <- 0.5 * tr$edge.length[which(tr$edge[,2] == mrca_outgroup)]

  #I drop tips with missing data for the ancestral state reconstruction.
  tips_to_drop <- c(outg, grep("Rattus_R3", tr$tip.label, value = T))

  #reroot tree
  tr_rooted <-
    phytools::reroot(tr, mrca_outgroup, position = position) %>% #reroot
    ape::drop.tip(tips_to_drop) #drop tips

  #######

  #read current states
  cs <- xlsx::read.xlsx("ancestral_states/current_states.xlsx",
                        sheetIndex = 1, header = F, colClasses = "character") %>%
    setNames(c("sp","state")) %>%
    dplyr::filter(stringr::str_count(sp) > 5)

  #create vector for tips with ancestral states
  tr_rooted$tip.label %<>% stringr::str_replace("QUERY___(.*$)", "\\1*")

  tips_cs <-
    tr_rooted$tip.label %>%
    stringr::str_split("_") %>%
    sapply(function(x) paste(x[1], x[2], sep = "_")) %>%
    stringr::str_replace("'", "") %>%
    {data.frame(sp = .)} %>%
    dplyr::left_join(cs, by = "sp") %>%
    {setNames(as.character(.$state), tr_rooted$tip.label)}

  #marginal ancestral state reconstructions
  fitER <- phytools::rerootingMethod(tr_rooted, tips_cs, model = "ER")

  #plot results
  pdf(file = paste0(plotname, ".pdf"), width = sizze, height = sizze*1.3)
  plotTree(tr_rooted, setEnv = TRUE, offset = 0.5, fsize = fsizze)
  mycols <- c(grey(0.6), grey(0.99), grey(0.1), grey(0.25))
  nodelabels(node = as.numeric(rownames(fitER$marginal.anc)),
             pie = fitER$marginal.anc,
             piecol = mycols,
             cex = 1)
  tiplabels(pie = to.matrix(tips_cs, sort(unique(tips_cs))),
            piecol = mycols,
            cex = .5)
  dev.off()
  #ape::write.tree(phy = tr_rooted, file = paste0(plotname, ".nex"))
}
