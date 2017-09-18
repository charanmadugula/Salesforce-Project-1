public class ParentAccountCaseTrendUpdates
{
    public void toUpdateCaseTrendParents(List<Account>listOfnewAccounts)
    {
        Map<Id,List<Account>> mapOfParentIdAndListOfAccounts = new Map<Id,List<Account>>();
        List<Id> listOfParentIds = new List<Id>();
        for(Account newAccount:listOfnewAccounts)
        {
            if(newAccount.parentId !=NULL)
            {
                listOfParentIds.add(newAccount.parentId);
            }
            else
            {
                listOfParentIds.add(newAccount.Id);
            }
        }
        System.debug('!!listOfParent Ids '+listOfParentIds);
        Map<Id,Account> mapOfIdAndItsAccount = new Map<Id,Account>();
        for(Account newAccount:[Select Id,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c,Cust_Facilities_Deviation_Severe__c,Cust_Facilities_Deviation_Moderate__c,Cust_Facilities_Deviation_Critical__c From Account Where Id in:listOfParentIds])
        {
            mapOfIdAndItsAccount.put(newAccount.Id,newAccount);
        }
        for(Account newAccount:[Select Id,ParentId,parent.Cust_Facilities_Curr_Week_Critical__c,parent.Cust_Facilities_Curr_Week_Moderate__c,parent.Cust_Facilities_Curr_Week_Severe__c,parent.Cust_Facilities_Trend_Critical__c,parent.Cust_Facilities_Trend_Moderate__c,parent.Cust_Facilities_Trend_Severe__c,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c From Account Where parentId in:listOfParentIds])
        {
            List<Account> listOfAccounts = new List<Account>();
            if(mapOfParentIdAndListOfAccounts.containsKey(newAccount.ParentId))
            {
                listOfAccounts = mapOfParentIdAndListOfAccounts.get(newAccount.ParentId);
            }
            listOfAccounts.add(newAccount);
            mapOfParentIdAndListOfAccounts.put(newAccount.ParentId,listOfAccounts);
        }
        System.debug('@@map contains '+mapOfParentIdAndListOfAccounts);
        List<Account> listOfAccountToUpdate = new List<Account>();
        Map<Id,String> mapOfIdAndValue = new Map<Id,String>();
            Decimal severeCount,severeCurrentCount,moderateCount,moderateCurrentCount,criticalCount,criticalCurrentCount;
            //severeCount=0;
            //severeCurrentCount=0;
            //moderateCount=0;
            //moderateCurrentCount=0;
            //criticalCount=0;
            //criticalCurrentCount=0;            
        for(Id newAccountId:mapOfParentIdAndListOfAccounts.keySet())
        {   
            severeCount=0;
            severeCurrentCount=0;
            moderateCount=0;
            moderateCurrentCount=0;
            criticalCount=0;
            criticalCurrentCount=0;
            for(Account newAccount:mapOfParentIdAndListOfAccounts.get(newAccountId))
            {
                if(newAccount.Case_Trend_Severe__c !=NULL)
                {
                    severeCount = severeCount+newAccount.Case_Trend_Severe__c;
                }
                if(newAccount.Current_Week_Severe__c !=NULL)
                {
                    severeCurrentCount = severeCurrentCount+newAccount.Current_Week_Severe__c;
                }
                if(newAccount.Case_Trend_Moderate__c != NULL)
                {
                    moderateCount = moderateCount+newAccount.Case_Trend_Moderate__c;
                }
                if(newAccount.Current_Week_Moderate__c != NULL)
                {
                    moderateCurrentCount = moderateCurrentCount+newAccount.Current_Week_Moderate__c;
                }
                if(newAccount.Case_Trend_Critical__c !=NULL)
                {
                    criticalCount = criticalCount+newAccount.Case_Trend_Critical__c;
                }
                if(newAccount.Current_Week_Critical__c != NULL)
                {
                    criticalCurrentCount = criticalCurrentCount+newAccount.Current_Week_Critical__c;                
                }            
            }
//          Account newAccount = mapOfIdAndItsAccount.get(newAccountId);
/*          newAccount.Cust_Facilities_Trend_Severe__c = severeCount;
            newAccount.Cust_Facilities_Trend_Moderate__c = moderateCount;
            newAccount.Cust_Facilities_Trend_Critical__c = criticalCount;
            newAccount.Cust_Facilities_Curr_Week_Severe__c = severeCurrentCount;
            newAccount.Cust_Facilities_Curr_Week_Moderate__c = moderateCurrentCount;
            newAccount.Cust_Facilities_Curr_Week_Critical__c = criticalCurrentCount;*/
/*          if(newAccount.Case_Trend_Severe__c !=NULL)
            {
                severeCount = severeCount +newAccount.Case_Trend_Severe__c;
            }
            if(newAccount.Case_Trend_Moderate__c !=NULL)
            {
                moderateCount= moderatecount +newAccount.Case_Trend_Moderate__c;
            }
            if(newAccount.Case_Trend_Critical__c !=NULL)
            {
                criticalCount= criticalCount +newAccount.Case_Trend_Critical__c;
            }
            if(newAccount.Current_Week_Critical__c !=NULL)
            {
                criticalCurrentCount= criticalCurrentCount +newAccount.Current_Week_Critical__c;
            }
            if(newAccount.Current_Week_Moderate__c !=NULL)
            {
                moderateCurrentCount= moderateCurrentCount +newAccount.Current_Week_Moderate__c;
            }
            if(newAccount.Current_Week_Severe__c !=NULL)
            {
                severeCurrentcount = severeCurrentCount +newAccount.Current_Week_Severe__c;
            }  */
            mapOfIdAndValue.put(newAccountId,''+criticalCurrentCount+','+moderateCurrentCount+','+severeCurrentCount+','+criticalCount+','+moderateCount+','+severeCount);                                                                      
//          listOfAccountToUpdate.add(newAccount);
            System.debug('# map '+mapOfIdAndValue);
        }
        //List<Case_Trend_Analytics__c> listOfTrends = [Select Low_Vol_Negative_Deviation_Critical__c,Low_Vol_Negative_Deviation_Moderate__c,Low_Vol_Negative_Deviation_Severe__c,Low_Volume_Threshold__c,Negative_Deviation_Critical__c,Negative_Deviation_Moderate__c,Negative_Deviation_Severe__c,Trend_Number_of_Weeks__c From Case_Trend_Analytics__c Limit 1];   
        AccountTriggerHandler newHandler = new AccountTriggerHandler();
        for(Account newAccount:[Select Id,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c,Current_Week_Critical__c,Current_Week_Moderate__c,Current_Week_Severe__c,Case_Trend_Critical__c,Case_Trend_Moderate__c,Case_Trend_Severe__c,Cust_Facilities_Deviation_Severe__c,Cust_Facilities_Deviation_Moderate__c,Cust_Facilities_Deviation_Critical__c From Account Where Id in:mapOfIdAndValue.keyset()])
        {
            String countValues = mapOfIdAndValue.get(newAccount.Id);
            List<String> counts = countValues.split(',');
            if(newAccount.Current_Week_Critical__c !=NULL)
            {
            newAccount.Cust_Facilities_Curr_Week_Critical__c = Decimal.valueOf(counts[0])+newAccount.Current_Week_critical__c;
            }
            else
            {
                newAccount.Cust_Facilities_Curr_Week_Critical__c=Decimal.valueOf(counts[0]);
            }
            System.debug('$current Id '+newAccount.Id+'$'+newAccount.Cust_Facilities_Curr_Week_Critical__c);
            if(newAccount.Current_Week_Moderate__c !=NULL)
            {
            newAccount.Cust_Facilities_Curr_Week_Moderate__c = Decimal.valueOf(counts[1])+newAccount.Current_Week_Moderate__c;
            }
            else
            {
                newAccount.Cust_Facilities_Curr_Week_Moderate__c = Decimal.valueOf(counts[1]);
            }
            if(newAccount.Current_Week_Severe__c !=NULL)
            {
            newAccount.Cust_Facilities_Curr_Week_Severe__c = Decimal.valueOf(counts[2])+newAccount.Current_Week_Severe__c;
            }
            else
            {
                newAccount.Cust_Facilities_Curr_Week_Severe__c = Decimal.valueOf(counts[2]);
            }
            if(newAccount.Case_Trend_Critical__c!=NULL)
            {
            newAccount.Cust_Facilities_Trend_Critical__c = Decimal.valueOf(counts[3])+newAccount.Case_Trend_Critical__c;
            }
            else
            {
                newAccount.Cust_Facilities_Trend_Critical__c = Decimal.valueOf(counts[3]);
            }
            if(newAccount.Case_Trend_Moderate__c!=NULL)
            {
            newAccount.Cust_Facilities_Trend_Moderate__c = Decimal.valueOf(counts[4])+newAccount.Case_Trend_Moderate__c;
            }
            else
            {
                newAccount.Cust_Facilities_Trend_Moderate__c = Decimal.valueOf(counts[4]);
            }
            if(newAccount.Case_Trend_Severe__c !=NULL)
            {
            newAccount.Cust_Facilities_Trend_Severe__c = Decimal.valueOf(counts[5])+newAccount.Case_Trend_Severe__c;
            }
            else
            {
                newAccount.Cust_Facilities_Trend_Severe__c = Decimal.valueOf(counts[5]);
            }

            Double deviationPercentage;
            if(newAccount.Cust_Facilities_Trend_Critical__c !=NULL && newAccount.Cust_Facilities_Trend_Critical__c <= decimal.valueOf(Label.Low_Volume_Threshold))
            {
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Critical);
            }
            else
            {
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Critical);
            }
            newAccount.Cust_Facilities_Deviation_Critical__c = newHandler.toCalculateDeviation(newAccount.Cust_Facilities_Curr_Week_Critical__c,newAccount.Cust_Facilities_Trend_Critical__c);
            newAccount.All_Related_Cust_Status_Critical__c = newHandler.toUpdateStatus(newAccount.Cust_Facilities_Curr_Week_Critical__c,newAccount.Cust_Facilities_Trend_Critical__c,deviationPercentage);                        
            if(newAccount.Cust_Facilities_Trend_Moderate__c !=NULL && newAccount.Cust_Facilities_Trend_Moderate__c <= decimal.valueOf(Label.Low_Volume_Threshold))
            {
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Moderate);
            }
            else
            {
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Moderate);
            }
            newAccount.Cust_Facilities_Deviation_Moderate__c = newHandler.toCalculateDeviation(newAccount.Cust_Facilities_Curr_Week_Moderate__c,newAccount.Cust_Facilities_Trend_Moderate__c);
            newAccount.All_Related_Cust_Status_Moderate__c = newHandler.toUpdateStatus(newAccount.Cust_Facilities_Curr_Week_Moderate__c,newAccount.Cust_Facilities_Trend_Moderate__c,deviationPercentage);                        
            if(newAccount.Cust_Facilities_Trend_Severe__c !=NULL && newAccount.Cust_Facilities_Trend_Severe__c <= decimal.valueOf(Label.Low_Volume_Threshold))
            {
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Severe);
            }
            else
            {
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Severe);
            }
            newAccount.Cust_Facilities_Deviation_Severe__c = newHandler.toCalculateDeviation(newAccount.Cust_Facilities_Curr_Week_Severe__c,newAccount.Cust_Facilities_Trend_Severe__c);
            newAccount.All_Related_Cust_Status_Severe__c = newHandler.toUpdateStatus(newAccount.Cust_Facilities_Curr_Week_Severe__c,newAccount.Cust_Facilities_Trend_Severe__c,deviationPercentage);            
            
            listOfAccountToUpdate.add(newAccount);
        }
        System.debug('%% list '+listOfAccountToUpdate);
        update listOfAccountToUpdate;
    }    
    
    public void toUpdatePharmacyTotal(List<Account> listOfNewAccounts)
    {
        Set<Id> listOfPharmacyIds = new Set<Id>();
        for(Account newAccount:listOfNewAccounts)
        {   
            if(newAccount.OCR_Pharmacy_Name__c != NULL){
                listOfPharmacyIds.add(newAccount.OCR_Pharmacy_Name__c);
            }
        }
        system.debug('listOfPharmacyIds=='+listOfPharmacyIds);
        Map<Id,List<Account>> mapOfIdAndListOfAccounts = new Map<Id,List<Account>>();
        for(Account newAccount:[Select Id,ParentId,OCR_Pharmacy_Name__c,parent.Cust_Facilities_Curr_Week_Critical__c,parent.Cust_Facilities_Curr_Week_Moderate__c,parent.Cust_Facilities_Curr_Week_Severe__c,parent.Cust_Facilities_Trend_Critical__c,parent.Cust_Facilities_Trend_Moderate__c,parent.Cust_Facilities_Trend_Severe__c,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c From Account Where OCR_Pharmacy_Name__c in:listOfPharmacyIds])
        {
            List<Account> listOfAccounts = new List<Account>();
            if(mapOfIdAndListOfAccounts.containsKey(newAccount.OCR_Pharmacy_Name__c))
            {
                listOfAccounts = mapOfIdAndListOfAccounts.get(newAccount.OCR_pharmacy_Name__c);
            }
            listOfAccounts.add(newAccount);
            mapOfIdAndListOfAccounts.put(newAccount.OCR_Pharmacy_Name__c,listOfAccounts);
            system.debug('mapOfIdAndListOfAccounts=='+mapOfIdAndListOfAccounts);
        }
        

        List<OCR_Pharmacy__c> listOfOcrToUpdate = new List<OCR_Pharmacy__c>();
        Map<Id,String> mapOfIdAndValue = new Map<Id,String>();
        Decimal severeCount,severeCurrentCount,moderateCount,moderateCurrentCount,criticalCount,criticalCurrentCount;
        //severeCount=0;
       // severeCurrentCount=0;
        //moderateCount=0;
        //moderateCurrentCount=0;
        //criticalCount=0;
       // criticalCurrentCount=0;            
        for(Id newOcrId:mapOfIdAndListOfAccounts.keySet())
        {   system.debug('newOcrId=='+newOcrId);
            severeCount=0;
            severeCurrentCount=0;
            moderateCount=0;
            moderateCurrentCount=0;
            criticalCount=0;
            criticalCurrentCount=0;
            for(Account newAccount:mapOfIdAndListOfAccounts.get(newOcrId))
            {   system.debug('newAccount=='+newAccount);
                if(newAccount.Case_Trend_Severe__c !=NULL)
                {
                    severeCount = severeCount+newAccount.Case_Trend_Severe__c;
                }
                if(newAccount.Current_Week_Severe__c !=NULL)
                {
                    severeCurrentCount = severeCurrentCount+newAccount.Current_Week_Severe__c;
                }
                if(newAccount.Case_Trend_Moderate__c != NULL)
                {
                    moderateCount = moderateCount+newAccount.Case_Trend_Moderate__c;
                }
                if(newAccount.Current_Week_Moderate__c != NULL)
                {
                    moderateCurrentCount = moderateCurrentCount+newAccount.Current_Week_Moderate__c;
                }
                if(newAccount.Case_Trend_Critical__c !=NULL)
                {
                    criticalCount = criticalCount+newAccount.Case_Trend_Critical__c;
                }
                if(newAccount.Current_Week_Critical__c != NULL)
                {
                    criticalCurrentCount = criticalCurrentCount+newAccount.Current_Week_Critical__c;                
                }            
            }
//          Account newAccount = mapOfIdAndItsAccount.get(newAccountId);
/*          newAccount.Cust_Facilities_Trend_Severe__c = severeCount;
            newAccount.Cust_Facilities_Trend_Moderate__c = moderateCount;
            newAccount.Cust_Facilities_Trend_Critical__c = criticalCount;
            newAccount.Cust_Facilities_Curr_Week_Severe__c = severeCurrentCount;
            newAccount.Cust_Facilities_Curr_Week_Moderate__c = moderateCurrentCount;
            newAccount.Cust_Facilities_Curr_Week_Critical__c = criticalCurrentCount;*/
/*            if(newAccount.Case_Trend_Severe__c !=NULL)
            {
                severeCount = severeCount +newAccount.Case_Trend_Severe__c;
            }
            if(newAccount.Case_Trend_Moderate__c !=NULL)
            {
                moderateCount= moderatecount +newAccount.Case_Trend_Moderate__c;
            }
            if(newAccount.Case_Trend_Critical__c !=NULL)
            {
                criticalCount= criticalCount +newAccount.Case_Trend_Critical__c;
            }
            if(newAccount.Current_Week_Critical__c !=NULL)
            {
                criticalCurrentCount= criticalCurrentCount +newAccount.Current_Week_Critical__c;
            }
            if(newAccount.Current_Week_Moderate__c !=NULL)
            {
                moderateCurrentCount= moderateCurrentCount +newAccount.Current_Week_Moderate__c;
            }
            if(newAccount.Current_Week_Severe__c !=NULL)
            {
                severeCurrentcount = severeCurrentCount +newAccount.Current_Week_Severe__c;
            }  */
            mapOfIdAndValue.put(newOcrId,''+criticalCurrentCount+','+moderateCurrentCount+','+severeCurrentCount+','+criticalCount+','+moderateCount+','+severeCount);                                                                      
//          listOfAccountToUpdate.add(newAccount);
            System.debug('# map '+mapOfIdAndValue);
        }
        //List<Case_Trend_Analytics__c> listOfTrends = [Select Low_Vol_Negative_Deviation_Critical__c,Low_Vol_Negative_Deviation_Moderate__c,Low_Vol_Negative_Deviation_Severe__c,Low_Volume_Threshold__c,Negative_Deviation_Critical__c,Negative_Deviation_Moderate__c,Negative_Deviation_Severe__c,Trend_Number_of_Weeks__c From Case_Trend_Analytics__c Limit 1];   
        AccountTriggerHandler newHandler = new AccountTriggerHandler();
        for(OCR_Pharmacy__c newPharmacy: [Select Id,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c,Cust_Facilities_Deviation_Critical__c,Cust_Facilities_Deviation_Moderate__c,Cust_Facilities_Deviation_Severe__c From OCR_Pharmacy__c Where Id In:mapOfIdAndValue.keyset()])
        {
            String countValues = mapOfIdAndValue.get(newPharmacy.Id);
            List<String> counts = countValues.split(',');
            newPharmacy.Cust_Facilities_Curr_Week_Critical__c=Decimal.valueOf(counts[0]);

            newPharmacy.Cust_Facilities_Curr_Week_Moderate__c = Decimal.valueOf(counts[1]);

            newPharmacy.Cust_Facilities_Curr_Week_Severe__c = Decimal.valueOf(counts[2]);

            newPharmacy.Cust_Facilities_Trend_Critical__c = Decimal.valueOf(counts[3]);

            newPharmacy.Cust_Facilities_Trend_Moderate__c = Decimal.valueOf(counts[4]);

            newPharmacy.Cust_Facilities_Trend_Severe__c = Decimal.valueOf(counts[5]);

            Double deviationPercentage;
            if(newPharmacy.Cust_Facilities_Trend_Critical__c !=NULL && newPharmacy.Cust_Facilities_Trend_Critical__c <= decimal.valueOf(Label.Low_Volume_Threshold))
            {
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Critical);
            }
            else
            {
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Critical);
            }
            newPharmacy.Cust_Facilities_Deviation_Critical__c = newHandler.toCalculateDeviation(newPharmacy.Cust_Facilities_Curr_Week_Critical__c,newPharmacy.Cust_Facilities_Trend_Critical__c);
            newPharmacy.All_Related_Cust_Status_Critical__c = newHandler.toUpdateStatus(newPharmacy.Cust_Facilities_Curr_Week_Critical__c,newPharmacy.Cust_Facilities_Trend_Critical__c,deviationPercentage);                        
            if(newPharmacy.Cust_Facilities_Trend_Moderate__c !=NULL && newPharmacy.Cust_Facilities_Trend_Moderate__c <= decimal.valueOf(Label.Low_Volume_Threshold))
            {
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Moderate);
            }
            else
            {
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Moderate);
            }
            
            newPharmacy.Cust_Facilities_Deviation_Moderate__c = newHandler.toCalculateDeviation(newPharmacy.Cust_Facilities_Curr_Week_Moderate__c,newPharmacy.Cust_Facilities_Trend_Moderate__c);
            newPharmacy.All_Related_Cust_Status_Moderate__c = newHandler.toUpdateStatus(newPharmacy.Cust_Facilities_Curr_Week_Moderate__c,newPharmacy.Cust_Facilities_Trend_Moderate__c,deviationPercentage);                        
            if(newPharmacy.Cust_Facilities_Trend_Severe__c !=NULL && newPharmacy.Cust_Facilities_Trend_Severe__c <= decimal.valueOf(Label.Low_Volume_Threshold))
            {
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Severe);
            }
            else
            {
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Severe);
            }
            newPharmacy.Cust_Facilities_Deviation_Severe__c = newHandler.toCalculateDeviation(newPharmacy.Cust_Facilities_Curr_Week_Severe__c,newPharmacy.Cust_Facilities_Trend_Severe__c);
            newPharmacy.All_Related_Cust_Status_Severe__c = newHandler.toUpdateStatus(newPharmacy.Cust_Facilities_Curr_Week_Severe__c,newPharmacy.Cust_Facilities_Trend_Severe__c,deviationPercentage);                                                
            listOfOcrToUpdate.add(newPharmacy);
        }
        System.debug('%% list '+listOfOcrToUpdate );
        update listOfOcrToUpdate ;
    }    
}