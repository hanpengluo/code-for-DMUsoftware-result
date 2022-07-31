# @ edited by Luohanpeng 20201022
# @ written for calculating DRP from EBV result
# @ ebv_result shoud include three column: ID,EBV,reliabilty of EBV (keep order)
# @ ped should include three column:ID, sire, dam (keep this order)
ebv_result<-read.csv('C:\\Users\\lhp\\Desktop\\2020SNP\\表型性状\\3-ge-all-pe-THI\\dmu_result_DRP_trait 1 .csv')
drp_ebv<-function(ebv_result,ped,h2,outname){
  names(ebv_result)<-c('id','i_EBV','i_reli')
  ebv_result$i_reli[ebv_result$i_reli<0 | ebv_result$i_reli>1]=0
  names(ped)<-c('id','sire','dam')
  ebv_result_ped<-merge(ebv_result,ped,by='id')
  ebv_result[nrow(ebv_result)+1,]<-c(0,0,0)
  ebv_result_ped_sire<-merge(ebv_result_ped,ebv_result,by.x = 'sire',by.y = 'id',sort = F,all.x = T)
  ebv_result_ped_dam<-merge(ebv_result_ped_sire,ebv_result,by.x = 'dam',by.y = 'id',sort = F,all.x = T)
  ebv_result_ped_dam$h2<-h2
  ebv_drp<-ebv_result_ped_dam[,c(3,2,1,4:10)]
  names(ebv_drp)<-c('id','sire','dam',"i_EBV","i_reli","sire_EBV","sire_reli","dam_EBV","dam_reli",'h2')
  ebv_drp$pa_ebv<-(ebv_drp$sire_EBV+ebv_drp$dam_EBV)/2
  ebv_drp$pa_reli<-(ebv_drp$sire_reli+ebv_drp$dam_reli)/4
  ebv_drp$ERC_pa<-((1-ebv_drp$h2)/ebv_drp$h2)*ebv_drp$pa_reli/(1-ebv_drp$pa_reli)
  ebv_drp$ERC_ind_pa<-(((1-ebv_drp$h2)/ebv_drp$h2)*ebv_drp$i_reli/(1-ebv_drp$i_reli))-ebv_drp$ERC_pa
  #ebv_drp$ri<-ebv_drp$ERC_ind_pa/(ebv_drp$ERC_ind_pa+ebv_drp$ERC_pa+1)
  ebv_drp$DRP<-(ebv_drp$pa_ebv)+((ebv_drp$i_EBV-ebv_drp$pa_ebv)/(ebv_drp$ERC_ind_pa/(ebv_drp$ERC_ind_pa+ebv_drp$ERC_pa+1)))
  ebv_drp$DRP[ebv_drp$DRP=='NaN' | ebv_drp$DRP=='Inf' | ebv_drp$DRP=='-Inf'] =NA
  ebv_drp_result<-ebv_drp[,c(1:5,15)]
  write.csv(ebv_drp_result,paste(outname,'.csv'),row.names = F)
}

