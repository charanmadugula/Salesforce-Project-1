/************************************************************************
    Name: OCRTriggerHandler
    Purpose: To update the Account records associated with an OCR record when address on OCR record is changed. (Distance between OCR's address and Account's address is re-calculated for all the associated Account records)
    History:  
**********************************************************************    
    Version        Created by         Date             Description       
    1             TCS Offshore      11/18/2015          Created
*************************************************************************/
public class OCRTriggerHandler{

    public void UpdateAccountOnAddressChange(List<OCR_Pharmacy__c> OCRList, Map<Id,OCR_Pharmacy__c> TriggerOldMap){
    
        Set<Id> ocrIdSet = new Set<Id>();
        List<Account> accountToUpdateList = new List<Account>();
    
        for(OCR_Pharmacy__c OCR : OCRList){
            if((OCR.Address__c != TriggerOldMap.get(OCR.id).Address__c || OCR.City__c!= TriggerOldMap.get(OCR.id).City__c|| 
            OCR.State_Province__c != TriggerOldMap.get(OCR.id).State_Province__c ||
            OCR.Zip_Postal_Code__c != TriggerOldMap.get(OCR.id).Zip_Postal_Code__c || 
            OCR.Country__c!= TriggerOldMap.get(OCR.id).Country__c) && OCR.Status__c != 'Inactive'){
                ocrIdSet.add(OCR.Id);
            }
        }
        
        if(!ocrIdSet.isEmpty()){
            List<OCR_Pharmacy__c> ocrAccList = [
                Select Id,Address__c
                     , City__c
                     , State_Province__c
                     , Zip_Postal_Code__c
                     , Country__c
                     , (Select Id
                             , Distance_to_Service_Facility__c 
                          from Accounts__r
                         where (RecordType.Name = 'LTC Prospect Facility'
                         OR
                         RecordType.Name='LTC Customer Facility'       
                         ) 
                           
                       )
                  from OCR_Pharmacy__c where Id IN : ocrIdSet
            ];
            
            
            for(OCR_Pharmacy__c OCR : ocrAccList){
                //system.assert(false, '(OCR.Accounts__r.size()' + OCR.Accounts__r.size());
                if(OCR.Accounts__r.size()>0){
                    for(Account acc : OCR.Accounts__r){
                        //if(acc.Distance_to_Service_Facility__c <= 0 || String.isBlank(String.valueOf(acc.Distance_to_Service_Facility__c))) {                         
                                acc.Distance_to_Service_Facility__c = NULL;
                                acc.Override_Calculate_Miles__c = false;
                                accountToUpdateList.add(acc);
                            }
                            
                        }
                    }
                }    
            
            if(!accountToUpdateList.isEmpty()){
                try{
                	DataUtil_Check.var_AddressCheck = false;
                update accountToUpdateList ;
                }catch(exception e){
                 system.debug(e+'Test');
                }
            }
        }
        
    }