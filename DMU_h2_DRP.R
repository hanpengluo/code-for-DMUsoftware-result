rm(list=ls())
#set path-------------- =.=
setwd("H:\\testdata\\example")
source("DMU_h2_DRP-function.txt")#import function for calculating heritability,SE and DRP
file_name<-"w_birth_test"#set the name of dir file for DMU 
#system.time(system(paste("run_dmuai ",file_name,sep = "")))#run DMU，calculate the running time 
dmu_parout<-read.table(paste(file_name,".PAROUT",sep = ""),header = F,
                       col.names = paste("V",1:4,sep = ""),
                       fill = T,stringsAsFactors = F)
dmu_paroutstd<-read.table(paste(file_name,".PAROUT_STD",sep = ""),header = F,
                          col.names = paste("V",1:4,sep = ""),
                          fill = T,stringsAsFactors = F)
dmu_h2(dmu_parout,dmu_paroutstd)#calculate heritability and SE for DMU results
###--------------如果计算DRP，使用dmu_DRP的function--------------------
file_name<-"w_birth_test"#set the name of dir file for DMU 
ped<-read.table("ped.txt",header = F)# import pedigree file used in DMU
names(ped)<-c("id","sire","dam","date")
dmu_result<-read.table(paste(file_name,".SOL",sep = ""),header=F,sep="")#import EBV file
system.time(dmu_DRP(dmu_parout,dmu_result,ped))
