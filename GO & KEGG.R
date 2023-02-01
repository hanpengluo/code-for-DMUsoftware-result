go_function <- function(genelist,outname){
  
  ego_rnaseq <- enrichGO(gene = genelist,
                         OrgDb = 'org.Mm.eg.db', # http://bioconductor.org/packages/release/BiocViews.html#___OrgDb
                         ont = 'ALL',
                         pAdjustMethod = 'BH',
                         pvalueCutoff = 0.05)
  
  ego_result_rnaseq <- ego_rnaseq@result
  
  if(nrow(ego_result_rnaseq)==0) stop('No GO term')
  
  ego_result_rnaseq_sig <- ego_result_rnaseq[which(ego_result_rnaseq$pvalue<0.05),]
  write.csv(ego_result_rnaseq_sig,paste0(outname,'_go_result_sig.csv'))
  
  ego_result_rnaseq_sig$order <- 1:nrow(ego_result_rnaseq_sig)
  ego_result_rnaseq_sig$ONTOLOGY <- factor(ego_result_rnaseq_sig$ONTOLOGY,labels=unique(ego_result_rnaseq_sig$ONTOLOGY))
  ego_result_rnaseq_sig$Ontology <- ifelse(ego_result_rnaseq_sig$ONTOLOGY=='BP','Biological Process',
                                           ifelse(ego_result_rnaseq_sig$ONTOLOGY=='MF','Molecular function','Cellular component'))
  
  #barplot(ego_rnaseq, split="ONTOLOGY")+facet_grid(ONTOLOGY~., scale="free")
  #enrichplot::cnetplot(go,circular=TRUE,colorEdge = TRUE)
  #enrichplot::heatplot(go,showCategory = 50)
  
  COLS <- c('#E64B35FF','#4DBBD5FF','#00A087FF')
  
  ego_plot <- ggplot(data=ego_result_rnaseq_sig, aes(x=order,y=Count,fill=Ontology)) +
    geom_bar(stat="identity", width=0.8)  + facet_wrap(~Ontology,scale="free",ncol = 1)+
    scale_x_continuous(breaks = ego_result_rnaseq_sig$order,labels=ego_result_rnaseq_sig$Description)+
    scale_fill_manual(values = COLS) + labs(x='GO term',y="Num of Genes",title = "The Most Enriched GO Terms")+
    coord_flip()+
    #theme_bw()+
    theme(
      legend.position = 'none',
      axis.line = element_line(size = 1), 
      axis.ticks = element_line(colour = "black", size = 1), 
      axis.title = element_text(size = 15, hjust = 0.5), 
      axis.text = element_text(size = 13,hjust = 0.5),#label of axis
      #axis.text.x = element_text(size = 18, colour = "black"), 
      axis.text.x=element_text(color="black",vjust = 1, hjust = 1 ),
      axis.text.y = element_text(size = 18, colour = "black"), 
      plot.title = element_text(size = 20, colour = "black",hjust = 0.5),
      panel.background = element_rect(fill = NA),#backgroud
      plot.background = element_rect(colour = NA))
  ggsave(paste0(outname,'go_plot.png'),ego_plot,width = 18,height = 18)

}

kegg_function <- function(genelist,outname){
  #genelist <- gene_list_ENTREZID$ENTREZID
  kegg <- enrichKEGG(genelist,#KEGG¸»¼¯·ÖÎö
             organism = 'mmu',
             pvalueCutoff = 0.05,
             #qvalueCutoff = 0.05,
             pAdjustMethod = 'BH')
  
  kegg_rnaseq_result_sig <- kegg@result
  kegg_rnaseq_result_sig <- kegg_rnaseq_result_sig[which(kegg_rnaseq_result_sig$pvalue<0.05),]
  
  if(nrow(kegg_rnaseq_result_sig)==0) stop('No KEGG term')
  
  write.csv(kegg_rnaseq_result_sig,paste0(outname,'_kegg_result_sig.csv'))
  
  kegg_plot <- ggplot(kegg_rnaseq_result_sig,aes(x=Count,y=Description)) + 
    geom_point(aes(color=pvalue),size=9)+
    scale_colour_gradient(low="red",high="green")+
    labs(
      color=expression(pvalue),
      size="GeneRatio",
      x="Count",
      y="Pathway name"
      # title="Pathway enrichment")
    )+
    theme_bw()+theme(
      plot.subtitle = element_text(vjust = 1), 
      plot.caption = element_text(vjust = 1),                                            
      axis.line = element_line(size = 1), 
      axis.ticks = element_line(colour = "black", size = 1), 
      axis.title = element_text(size = 15, hjust = 0.5), 
      axis.text = element_text(colour = "black", hjust = 0.5),#label of axis
      axis.text.x = element_text(size = 18, colour = "black"), 
      axis.text.y = element_text(size = 18, colour = "black"), 
      panel.background = element_rect(fill = NA),#backgroud
      plot.background = element_rect(colour = NA)) #background
  
  ggsave(paste0(outname,'kegg_plot.png'),kegg_plot,width = 18,height = 18)
}