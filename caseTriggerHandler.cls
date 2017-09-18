/************************************************************************
    Name: caseTriggerHandler.cls
    Purpose: Handler to update Case Trend Fields in Account Object.(To update case trend on Account if a Case is created, edited, deleted or assigned to another account.)
    History:  
**********************************************************************    
    Version        Created by         Date             Description       
    1             TCS Offshore      10/21/2015          Created
*************************************************************************/

public class caseTriggerHandler
{
    Set<Id> listOfAccountIds = new Set<Id>();
    Set<Id> setUpdatedAccountId = new Set<Id>();
   
    
    public void toUpdateCaseTrend(List<Case> listOfNewCases,Map<Id,Case> triggerOldMap)
    {        
        DataUtil_Check.var_StopAccountTriggerfromCase = false;
        system.debug('===Triggeroldmap'+Triggeroldmap);
        for(Case newCase:listOfNewCases)
        {
            listOfAccountIds.add(newCase.AccountId);   
            if(Triggeroldmap != null){
                if(newCase.AccountId != triggerOldMap.get(newCase.Id).AccountId)
                    setUpdatedAccountId.add(triggerOldMap.get(newCase.Id).AccountId);
            }     
        }       
        
        List<Account>listOfAccounts = [Select OCR_Pharmacy_Name__c,All_Related_Cust_Status_Severe__c,All_Related_Cust_Status_Moderate__c,All_Related_Cust_Status_Critical__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Severe__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Critical__c,RecordTypeId,RecordType.Name,ParentId,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c, CreatedDate From Account Where Id in:listOfAccountIds];

        AccountTriggerHandler newHandler = new AccountTriggerHandler();
        System.debug('Before calling method '+listOfAccounts.size());
        newHandler.toUpdateWeekTotal(listOfAccounts,true);
        //        newHandler.toUpdateParentCaseTrends(listOfAccounts);
        ParentAccountCaseTrendUpdates newHandle = new ParentAccountCaseTrendUpdates();
        newHandle.toUpdateCaseTrendParents(listOfAccounts);
        //        newHandler.toUpdatePharmacyTotal(listOfAccounts);
        newHandle.toUpdatePharmacyTotal(listOfAccounts);

        if(!setUpdatedAccountId.isEmpty()){
            List<Account>listOfUpdatedAccounts = [Select OCR_Pharmacy_Name__c,All_Related_Cust_Status_Severe__c,All_Related_Cust_Status_Moderate__c,All_Related_Cust_Status_Critical__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Severe__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Critical__c,RecordTypeId,RecordType.Name,ParentId,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c, CreatedDate From Account Where Id in:setUpdatedAccountId];
            
            newHandler.toUpdateWeekTotal(listOfUpdatedAccounts,true);
            newHandle.toUpdateCaseTrendParents(listOfUpdatedAccounts);
            newHandle.toUpdatePharmacyTotal(listOfUpdatedAccounts);
        }
    }
}