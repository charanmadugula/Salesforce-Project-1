public with sharing class UpdateAccountData {

    public static void ProcessOpptyUpdate(List<Opportunity> opptysToProcess){ //process passed opptys
        
        boolean IdExist = FALSE;
        
        //set related account field 'curr pharmacy provider' = omnicare when oppty is won
        //get accts related oppty ids
        Set<Id> acctIDs = new Set<Id>();
        
        for (Opportunity aid : opptysToProcess) {
            acctIDs.add(aid.AccountId);
        }
        
        //query related accts that will be updated
        List<Account> acctData = [Select Id, Curr_Pharmacy_Provider__c From Account where Id in:acctIDs];
        List<Account> acctToUpdate = new List<Account>();
        
        
        for (Integer i = 0; i < opptysToProcess.size(); i++) { //loop through passed opptys
            
            //ensure that an account is only added once to the acctToUpdate list (no contains() method for lists thus the loop check)
            //done to accomodate for the error that is generated during the geocode batch process
            for(Account oaid : acctToUpdate){
                if(opptysToProcess[i].AccountId == oaid.Id){
                    IdExist = TRUE;
                }
            }
            
            if(IdExist == FALSE){
                for(Integer colIndex=0; colIndex<acctData.size(); colIndex++) { //loop through related accts
                    
                    if(acctData[colIndex].Id == opptysToProcess[i].AccountId){
                        account updateAcct = new account(Id = acctData[colIndex].Id, 
                                                                       Curr_Pharmacy_Provider__c = '001C0000012vvjl' //001C000000ytapBIAQ = Omnicare Competitor account                                                      
                                                                       // SB Curr_Pharmacy_Provider__c = '001L0000004XRYZIA4' 
                                                                       );
                    acctToUpdate.add(updateAcct);                                                          
                    } //end of acct id match if
                }   
            } //end of acct loop
        } //end of oppty loop
        
        System.Debug('NUMBER OF ACCTS TO UPDATE: ' + acctToUpdate.size());
        
        try{ //update related accts
            if(acctToUpdate.size() > 0) update acctToUpdate;
            } catch(DmlException e) {  //catch errors
            for (Opportunity oppty : opptysToProcess) {
                oppty.addError( 'Error - Account Current Pharmacy Provider not updated: ' + e.getMessage());
            }               
            return; 
        }   
        
    } //end of method

} //end of class