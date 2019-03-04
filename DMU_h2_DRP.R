rm(list=ls())
#set path-------------- =.=
setwd("H:\\testdata\\example")#遗传评估的路径
source("DMU_h2_DRP-function.txt")#导入遗传力以及DRP计算的脚本
file_name<-"w_birth_test"#dir文件的名字叫什么
#system.time(system(paste("run_dmuai ",file_name,sep = "")))#启动DMU，且计算运行时间
dmu_parout<-read.table(paste(file_name,".PAROUT",sep = ""),header = F,
                       col.names = paste("V",1:4,sep = ""),
                       fill = T,stringsAsFactors = F)
dmu_paroutstd<-read.table(paste(file_name,".PAROUT_STD",sep = ""),header = F,
                          col.names = paste("V",1:4,sep = ""),
                          fill = T,stringsAsFactors = F)
dmu_h2(dmu_parout,dmu_paroutstd)
###--------------如果计算DRP，使用dmu_DRP的function--------------------
file_name<-"w_birth_test"#dir文件的名字叫什么
ped<-read.table("ped.txt",header = F)#读取ped文件
names(ped)<-c("id","sire","dam","date")
dmu_result<-read.table(paste(file_name,".SOL",sep = ""),header=F,sep="")#读取EBV的SQL文件
system.time(dmu_DRP(dmu_parout,dmu_result,ped))