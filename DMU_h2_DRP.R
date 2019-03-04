rm(list=ls())
#set path-------------- =.=
setwd("H:\\testdata\\example")#�Ŵ�������·��
source("DMU_h2_DRP-function.txt")#�����Ŵ����Լ�DRP����Ľű�
file_name<-"w_birth_test"#dir�ļ������ֽ�ʲô
#system.time(system(paste("run_dmuai ",file_name,sep = "")))#����DMU���Ҽ�������ʱ��
dmu_parout<-read.table(paste(file_name,".PAROUT",sep = ""),header = F,
                       col.names = paste("V",1:4,sep = ""),
                       fill = T,stringsAsFactors = F)
dmu_paroutstd<-read.table(paste(file_name,".PAROUT_STD",sep = ""),header = F,
                          col.names = paste("V",1:4,sep = ""),
                          fill = T,stringsAsFactors = F)
dmu_h2(dmu_parout,dmu_paroutstd)
###--------------�������DRP��ʹ��dmu_DRP��function--------------------
file_name<-"w_birth_test"#dir�ļ������ֽ�ʲô
ped<-read.table("ped.txt",header = F)#��ȡped�ļ�
names(ped)<-c("id","sire","dam","date")
dmu_result<-read.table(paste(file_name,".SOL",sep = ""),header=F,sep="")#��ȡEBV��SQL�ļ�
system.time(dmu_DRP(dmu_parout,dmu_result,ped))