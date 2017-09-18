/************************************************************************
    Name: webFocusTriggerHandler
    Purpose: To update 'Summarized WebFocus Data' section on Parent-Account record. It sums up the latest created webfocus record values from all the associated Account records.
    History:  
**********************************************************************    
    Version        Created by         Date             Description       
    1             TCS Offshore      11/20/2015          Created
*************************************************************************/
public class webFocusTriggerHandler{
   
    Transient Map<String,List<Web_Focus__c>> maplistFocus= new  Map<String,List<Web_Focus__c>>();
    Transient List<Account> accToUpdate =new List<Account>();
    public void updateParentAccount(List<Web_Focus__c> triggerNew){
        Transient Set<Id> accountIdSet = new Set<Id>();
        Transient Set<Id> parentaccountIdSet = new Set<Id>();
        for(Web_Focus__c wf : triggerNew){
            accountIdSet.add(wf.Account_ID__c);
            
        }
        
        for(Account a: [select id,parentId from Account where Id In:accountIdSet and parentId!=null]){
            parentaccountIdSet.add(a.parentId);
        }
        List<Account> lstAccount =new List<Account>();
       // lstAccount=[Select id,Total_Fac_Medicare_A_Rev__c,Total_Net_Rev__c,Total_Fac_Per_Diem_Rev__c,Total_Fac_Other_Rev__c,Total_Private_Rev__c,Total_Medicare_D_Rev__c,Total_Medicaid_Rev__c, ParentId,Total_Third_Party_Rev__c,Total_Medicare_B_Rev__c,Total_Hospice_Rev__c,Total_Pending_Rev__c,Total_Fac_Medicare_A_Scripts__c,Total_Fac_Other_Scripts__c,Total_Fac_Per_Diem_Scripts__c,Total_Hospice_Scripts__c,Total_Medicaid_Scripts__c,Total_Medicare_B_Scripts__c,Total_Medicare_D_Scripts__c,Total_Oper_Scripts__c,Total_Pending_Scripts__c,Total_Private_Scripts__c,Total_Third_Party_Scripts__c, (Select Id,Fac_Medicare_A_Rev__c,Net_Rev__c,Fac_Per_Diem_Rev__c,Fac_Other_Rev__c,Private_Rev__c,                              ThirdParty_Rev__c,Medicare_B_Rev__c,Hospice_Rev__c,Pending_Rev__c,Medicare_D_Rev__c,Medicaid_Rev__c,Fac_Medicare_A_Scripts__c,Fac_Other_Scripts__c,Fac_Per_Diem_Scripts__c,Hospice_Scripts__c,Medicaid_Scripts__c,Medicare_B_Scripts__c,Medicare_D_Scripts__c,Oper_Scripts__c,Pending_Scripts__c,Private_Scripts__c,ThirdParty_Scripts__c from Web_Focuses__r order by CreatedDate desc limit 1) from Account where ParentId In: parentaccountIdSet order by ParentId];
        String parentAcc='';
        list<Web_Focus__c>lstwebf =new list<Web_Focus__c>();
        for(Account acc:[Select id,Total_Fac_Medicare_A_Rev__c,Total_Net_Rev__c,Total_Fac_Per_Diem_Rev__c,Total_Fac_Other_Rev__c,Total_Private_Rev__c,Total_Medicare_D_Rev__c,Total_Medicaid_Rev__c, ParentId,Total_Third_Party_Rev__c,Total_Medicare_B_Rev__c,Total_Hospice_Rev__c,Total_Pending_Rev__c,Total_Fac_Medicare_A_Scripts__c,Total_Fac_Other_Scripts__c,Total_Fac_Per_Diem_Scripts__c,Total_Hospice_Scripts__c,Total_Medicaid_Scripts__c,Total_Medicare_B_Scripts__c,Total_Medicare_D_Scripts__c,Total_Oper_Scripts__c,Total_Pending_Scripts__c,Total_Private_Scripts__c,Total_Third_Party_Scripts__c, (Select Id,Fac_Medicare_A_Rev__c,Net_Rev__c,Fac_Per_Diem_Rev__c,Fac_Other_Rev__c,Private_Rev__c,
                                 ThirdParty_Rev__c,Medicare_B_Rev__c,Hospice_Rev__c,Pending_Rev__c,Medicare_D_Rev__c,Medicaid_Rev__c,Fac_Medicare_A_Scripts__c,Fac_Other_Scripts__c,Fac_Per_Diem_Scripts__c,Hospice_Scripts__c,Medicaid_Scripts__c,Medicare_B_Scripts__c,Medicare_D_Scripts__c,Oper_Scripts__c,Pending_Scripts__c,Private_Scripts__c,ThirdParty_Scripts__c from Web_Focuses__r order by CreatedDate desc limit 1) from Account where ParentId In: parentaccountIdSet order by ParentId]){
            if(parentAcc==''|| parentAcc==acc.parentId){
                if(acc.Web_Focuses__r.size()>0){
                    lstwebf.add(acc.Web_Focuses__r[0]);
                    maplistFocus.put(acc.parentId,lstwebf );
                }
                parentAcc=acc.parentId;
                
            }
            else{
                lstwebf =new list<Web_Focus__c>();
                if(acc.Web_Focuses__r.size()>0){
                    lstwebf.add(acc.Web_Focuses__r[0]);
                    maplistFocus.put(acc.parentId,lstwebf );
                }
                parentAcc=acc.parentId;
            }        
            
            
        }
        if(maplistFocus.size()>0){
            for(String pmap:maplistFocus.keyset() ){
                Account acc =new Account(id=pmap);
                
                Transient Decimal Fac_Medicare=0;
                Transient Decimal Net_Rev =0;
                Transient Decimal Fac_Per_Diem_Rev =0;
                Transient Decimal Fac_Other_Rev=0;
                Transient Decimal Private_Rev=0;
                Transient Decimal Medicare_D_Rev=0;
                Transient Decimal Medicaid_Rev=0;
                Transient Decimal Third_Party_Rev =0;
                Transient Decimal Medicare_B_Rev=0;
                Transient Decimal Hospice_Rev =0;
                Transient Decimal Pending_Rev=0;
                Transient Decimal Fac_Medicare_A_Scripts=0;
                Transient Decimal Fac_Other_Scripts=0;
                Transient Decimal Fac_Per_Diem_Scripts=0;
                Transient Decimal Hospice_Scripts=0;
                Transient Decimal Medicaid_Scripts=0;
                Transient Decimal Medicare_B_Scripts=0;
                Transient Decimal Medicare_D_Scripts=0;
                Transient Decimal Oper_Scripts=0;
                Transient Decimal Pending_Scripts=0;
                Transient Decimal Private_Scripts=0;
                Transient Decimal ThirdParty_Scripts=0;
                
                
                for(Web_Focus__c wfocus:maplistFocus.get(pmap)){
                    system.debug('===wfocus'+wfocus);
                    if(wfocus != NULL){
                        Fac_Medicare=Fac_Medicare+wfocus.Fac_Medicare_A_Rev__c;
                        Net_Rev =Net_Rev +wfocus.Net_Rev__c;
                        Fac_Per_Diem_Rev =Fac_Per_Diem_Rev +wfocus.Fac_Per_Diem_Rev__c;
                        Fac_Other_Rev=Fac_Other_Rev+wfocus.Fac_Other_Rev__c;
                        Private_Rev=Private_Rev+wfocus.Private_Rev__c;
                        Medicare_D_Rev=Medicare_D_Rev+wfocus.Medicare_D_Rev__c;
                        Medicaid_Rev=Medicaid_Rev+wfocus.Medicaid_Rev__c;
                        Third_Party_Rev =Third_Party_Rev+wfocus.ThirdParty_Rev__c;
                        Medicare_B_Rev=Medicare_B_Rev+wfocus.Medicare_B_Rev__c;
                        Hospice_Rev =Hospice_Rev+wfocus.Hospice_Rev__c;
                        Pending_Rev=Pending_Rev+wfocus.Pending_Rev__c;
                        Fac_Medicare_A_Scripts=Fac_Medicare_A_Scripts+wfocus.Fac_Medicare_A_Scripts__c;
                        Fac_Other_Scripts=Fac_Other_Scripts+wfocus.Fac_Other_Scripts__c;
                        Fac_Per_Diem_Scripts=Fac_Per_Diem_Scripts+wfocus.Fac_Per_Diem_Scripts__c;
                        Hospice_Scripts=Hospice_Scripts+wfocus.Hospice_Scripts__c;
                        Medicaid_Scripts=Medicaid_Scripts+wfocus.Medicaid_Scripts__c;
                        Medicare_B_Scripts=Medicare_B_Scripts+wfocus.Medicare_B_Scripts__c;
                        Medicare_D_Scripts=Medicare_D_Scripts+wfocus.Medicare_D_Scripts__c;
                        Oper_Scripts=Oper_Scripts+wfocus.Oper_Scripts__c;
                        Pending_Scripts=Pending_Scripts+wfocus.Pending_Scripts__c;
                        Private_Scripts=Private_Scripts+wfocus.Private_Scripts__c;
                        ThirdParty_Scripts=ThirdParty_Scripts+wfocus.ThirdParty_Scripts__c;
                       
                        

                    }
                        
                } 
                    acc.Total_Fac_Medicare_A_Rev__c=Fac_Medicare ;
                    acc.Total_Net_Rev__c=Net_Rev ;
                    acc.Total_Fac_Per_Diem_Rev__c=Fac_Per_Diem_Rev ;
                    acc.Total_Fac_Other_Rev__c=Fac_Other_Rev;
                    acc.Total_Private_Rev__c=Private_Rev;
                    acc.Total_Medicare_D_Rev__c=Medicare_D_Rev;
                    acc.Total_Medicaid_Rev__c=Medicaid_Rev;                       
                    acc.Total_Third_Party_Rev__c=Third_Party_Rev;
                    acc.Total_Medicare_B_Rev__c=Medicare_B_Rev;
                    acc.Total_Hospice_Rev__c=Hospice_Rev ;
                    acc.Total_Pending_Rev__c=Pending_Rev;
                    acc.Total_Fac_Medicare_A_Scripts__c=Fac_Medicare_A_Scripts;
                    acc.Total_Fac_Other_Scripts__c=Fac_Other_Scripts;
                    acc.Total_Fac_Per_Diem_Scripts__c=Fac_Per_Diem_Scripts;
                    acc.Total_Hospice_Scripts__c=Hospice_Scripts;
                    acc.Total_Medicaid_Scripts__c=Medicaid_Scripts;
                    acc.Total_Medicare_B_Scripts__c=Medicare_B_Scripts;
                    acc.Total_Medicare_D_Scripts__c=Medicare_D_Scripts;
                    acc.Total_Oper_Scripts__c=Oper_Scripts;
                    acc.Total_Pending_Scripts__c=Pending_Scripts;
                    acc.Total_Private_Scripts__c=Private_Scripts;
                    acc.Total_Third_Party_Scripts__c=ThirdParty_Scripts;
                    
                    accToUpdate.add(acc);   
            }
            if(!accToUpdate.isEmpty()){
                DataUtil_Check.var_StopAccountTriggerFromWebFocus = false; 
                system.debug('==wb=='+DataUtil_Check.var_StopAccountTriggerFromWebFocus); 
                update accToUpdate;
            }
       }     
    }
}