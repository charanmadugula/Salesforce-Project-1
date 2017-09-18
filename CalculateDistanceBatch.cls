/************************************************************************
    Name: CalculateDistanceBatch 
    Purpose: This bach class is to update the distance on Account from OCR record's address to Account record's address. This class calls webservice to calculate the distance.
    History:  
**********************************************************************    
    Version        Created by         Date             Description       
    1             TCS Offshore      11/18/2015          Created
*************************************************************************/
global with sharing class CalculateDistanceBatch implements Database.Batchable<sObject>, Database.AllowsCallouts, Queueable {
    
    Global Set<Id> accId ;
    List<Account> accountFutureList = new List<Account>();
    Map<Id,String> accIdOcrAddressMap= new Map<Id,String>();
    Map<Id,String> accIdAccAddressMap= new Map<Id,String>();
    
    
//  Batch Constructor
    global CalculateDistanceBatch(Set<Id> accId){
        this.accId = accId;        
    }
    
    global CalculateDistanceBatch() {
        
    }
 
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query = 'Select Id,BillingStreet,BillingPostalCode,BillingCity,BillingState,BillingCountry, OCR_Pharmacy_Name__r.Address__c,OCR_Pharmacy_Name__r.City__c,OCR_Pharmacy_Name__r.State_Province__c,OCR_Pharmacy_Name__r.Zip_Postal_Code__c, OCR_Pharmacy_Name__r.Country__c, OCR_Pharmacy_Name__r.Status__c FROM Account WHERE Id IN: accId';
        
        system.debug('===accId'+accId);
        system.debug('===query'+query);
        
        //List<Account> accList = Database.getQueryLocator(query);
        //system.debug('...accList: ' + accList);
        return Database.getQueryLocator(query);
   }
   
  


  
    global void execute (Database.Batchablecontext BC, list<Account> accList){
      
        // Map<Id,String> accIdOcrAddressMap= new Map<Id,String>();
        // Map<Id,String> accIdAccAddressMap= new Map<Id,String>();
        List<Account> accountUpdateList = new List<Account>();
        String addressOCR='';
        String addressACC='';
        
       // system.Assert(false,'acclist size: '+accList.size());
      
        system.debug('CalculateDistanceBatch -> acclist: ' + accList);
        system.debug('CalculateDistanceBatch -> acclist.size(): ' + accList.size());
       
        for(Account accRec : accList){
            addressOCR='';
            addressACC='';
             
            if((accRec.OCR_Pharmacy_Name__r.Address__c!=null || accRec.OCR_Pharmacy_Name__r.City__c!=null || accRec.OCR_Pharmacy_Name__r.State_Province__c!=null ||
                            accRec.OCR_Pharmacy_Name__r.Zip_Postal_Code__c!=null || accRec.OCR_Pharmacy_Name__r.Country__c!=null) && 
                            (accRec.BillingStreet!=null || accRec.BillingPostalCode!=null ||  accRec.BillingCity!=null || accRec.BillingState!=null || accRec.BillingCountry!=null) && accRec.OCR_Pharmacy_Name__r.Status__c != 'Inactive'){
                addressOCR= accRec.OCR_Pharmacy_Name__r.Address__c +
                            accRec.OCR_Pharmacy_Name__r.City__c +
                            accRec.OCR_Pharmacy_Name__r.State_Province__c +
                            accRec.OCR_Pharmacy_Name__r.Zip_Postal_Code__c +
                            accRec.OCR_Pharmacy_Name__r.Country__c;
                addressACC= accRec.BillingStreet +
                            accRec.BillingCity+
                            accRec.BillingState+
                            accRec.BillingPostalCode+
                            accRec.BillingCountry;
                system.debug('addressOCR'+addressOCR);
                system.debug('addressACC'+addressACC);
            }
            if(addressOCR!='' && addressACC!=''){
                accIdOcrAddressMap.put(accRec.Id,addressOCR);
                accIdAccAddressMap.put(accRec.Id,addressACC);
                 if((accIdOcrAddressMap!=null && !accIdOcrAddressMap.isEmpty() && accIdOcrAddressMap.size()>0) && (accIdAccAddressMap!=null && !accIdOcrAddressMap.isEmpty() && accIdOcrAddressMap.size()>0)){
                    
                    if( !(Schema.SObjectType.Account.fields.Distance_to_Service_Facility__c.isUpdateable())) {
                        return;
                    }
                    
                    accRec.Distance_to_Service_Facility__c = getGoogleMaps.getDistance(accIdOcrAddressMap.get(accRec.Id),accIdAccAddressMap.get(accRec.Id));
                    
                    if(accRec.Distance_to_Service_Facility__c <= 0) {
                        //accountFutureList.add(accRec);
                        accRec.Distance_to_Service_Facility__c = NULL;
                        
                        // Try calculating once more
                        // System.enqueueJob(new GetGoogleMaps(accIdOcrAddressMap.get(accRec.Id), accIdAccAddressMap.get(accRec.Id), accRec));
                    
                    } else {
                        accountUpdateList.add(accRec);
                        system.debug('accountUpdateList'+accountUpdateList);
                    }
                }
            
        }
        
        if(accountUpdateList!=null && !accountUpdateList.isEmpty() && accountUpdateList.size()>0 && Schema.SObjectType.Account.isUpdateable()){
            update accountUpdateList;
        }
      }          
    }
    
    public void execute(queueableContext qContext) {
        
        System.debug('...queueable execute');
        System.debug('...queueable accountFutureList: ' + accountFutureList);
        System.debug('...queueable accIdOcrAddressMap: ' + accIdOcrAddressMap);
        System.debug('...queueable accIdAccAddressMap: ' + accIdAccAddressMap);
        
        List<Account> accountUpdateList = new List<Account>();
               
        if( !(Schema.SObjectType.Account.fields.Distance_to_Service_Facility__c.isUpdateable())) {
            return;
        }
        /*
        for(Account accRec: accountFutureList) {
            accRec.Distance_to_Service_Facility__c = getGoogleMaps.getDistance(accIdOcrAddressMap.get(accRec.Id),accIdAccAddressMap.get(accRec.Id));
            
            if(accRec.Distance_to_Service_Facility__c > 0) {
                accRec.Override_Calculate_Miles__c = false;
            } else {
                accRec.Distance_to_Service_Facility__c = NULL;
                accRec.Override_Calculate_Miles__c = true;
            }
            
            accountUpdateList.add(accRec);
        }
        */
        if(Schema.SObjectType.Account.isUpdateable()) {
            update accountUpdateList;
        }
    }

    global void finish(Database.Batchablecontext BC){

    }
}