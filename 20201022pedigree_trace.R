#-追溯大系谱往上追溯
rm(list = ls())
setwd("D:\\2-test\\test-trace\\")#设置路径
library(data.table)
ped_all<-fread("ped-fid.txt",header = F)#大系谱4列“个体，父亲，母亲，出生日期（无title）
names(ped_all)<-c("id","sire","dam","date")
ped_small<-fread("id.txt",header = F)#需要追溯的个体ID：一列（无title）
names(ped_small)<-c("id")
##-----------------以下为function---------------------------
ped_trace<-function(ped_all,ped_small){
  a<-1
  b<-2
  i<-0
  ped_in<-merge(ped_small,ped_all,by="id",all.x = T,sort = F)
  ped_out<-ped_in[is.na(ped_in$sire),]
  ped_out[is.na(ped_out)]=0
  ped_tem<-ped_small
  while (b>a) {
    a<-length(ped_tem[,1])
    ped_tem<-merge(ped_tem,ped_all,by="id")
    id<-unique(c(as.character(ped_tem$id),as.character(ped_tem$sire),as.character(ped_tem$dam)))
    ped_tem<-as.data.frame(id)
    b<-length(ped_tem$id)
    i=i+1
  }
  ped_final<-merge(ped_tem,ped_all,by="id")
  print(paste("loop times:",i,sep = ""))
  #combine all individuals
  ped_final<-rbind(ped_final,ped_out)
  id_all<-unique(c(as.character(ped_final$id),as.character(ped_final$sire),as.character(ped_final$dam)))
  #delete o
  id_all<-id_all[which(id_all!=0)]
  n_all<-length(id_all)
  print(paste("Totle individuals in pedigree: ",n_all,sep = ""))
  n_small<-length(ped_small$id)
  print(paste("Number individuals with phenotype: ",n_small,sep = ""))
  # number of no genotype 
  ped_id<-c(id_all[!(id_all %in% ped_small$id )],as.character(ped_small$id))
  #
  id_recode<-as.data.frame(ped_id)
  #renum of id
  id_recode$reid<-c(1:nrow(id_recode))
  #merge pedigree
  ped_new<-merge(id_recode,ped_final,by.x = "ped_id",by.y = "id",sort = F,all.x = T)
  ped_new<-merge(ped_new,id_recode,by.x = "sire",by.y = "ped_id",sort = F,all.x = T)
  ped_new<-merge(ped_new,id_recode,by.x = "dam",by.y = "ped_id",sort = F,all.x = T)
  #creat a new ped
  new_ped<-ped_new[,c(4,6,7,3,2,1,5)]
  names(new_ped)[1:3]<-c("reid","reid_sire","reid_dam")
  new_ped<-as.data.frame(new_ped[order(new_ped$reid),])
  #set . to NA
  new_ped[is.na(new_ped)]="."
  #id need to be traced
  ped_small_p<-new_ped[c((n_all-n_small+1):nrow(new_ped)),]
  ped_small_p_id<-ped_small_p$reid
  #set the dam to .
  for(j in 1:nrow(new_ped)){
    new_ped$reid_dam[j]<-ifelse(new_ped$reid_dam[j] %in% ped_small_p_id,".",new_ped$reid_dam[j])
  }
  #output
  fwrite(new_ped[,1:3],"sas_ped.csv",row.names = F)
  fwrite(new_ped,"ped_trace.csv",row.names = F)
  fwrite(ped_small_p,"ped_small.csv",row.names = F)
}
ped_trace(ped_all = ped_all,ped_small = ped_small)#运行function即可