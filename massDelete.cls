public with sharing class massDelete {
    public integer PurchaseToDelete = 0;
    public integer ContractToDelete = 0;

    public boolean getCanDeletePurchase() {
        
        MassDelete__c MD = MassDelete__c.getInstance();
        return MD.Can_delete_purchases__c;
    }
    
    public boolean getCanDeleteContracts() {
        
        MassDelete__c MD = MassDelete__c.getInstance();
        return MD.Can_delete_contracts__c;
         
    }
    public void deletePurchase() {
        
        String q = 'Select Id from Purchase__c';
        id batchinstanceid = database.executeBatch(new massDeleteBatchClass(q)); 
        
    }
    
    public void deleteAccumedContract() {
        
        String q = 'Select Id from Accumed_Contracts__c';
        id batchinstanceid = database.executeBatch(new massDeleteBatchClass(q)); 
        
    }
    /*
    public integer getPurchaseToDeleteCount(){
        //PurchaseToDelete = [Select Count() from Purchase__c];
        return  PurchaseToDelete;
    }
    
    public integer getContractToDeleteCount(){
        //ContractToDelete = [Select Count() from Accumed_Contracts__c];
        return  ContractToDelete;
    }
    */
    /* USED FOR TESTING. ADDS A BUNCH OF PURCHASES TO TEST DELETE. NOT NEEDED IN PRODUCTION.
    public void createPurchase() {
        
        Account nA = new Account();
        na.Name = 'Test';
        insert na;
        
        for (Integer ij = 0; ij < 15; ij++) {

            List<Purchase__c> npForInsert = new List<Purchase__c>();

            for (Integer i = 0; i < 99; i++) {
            
                Purchase__c nP = new Purchase__c();
                nP.Member__c = na.id;
                npForInsert.add(nP);
            
            }

            insert npForInsert;
        }
        
    }
    */

    
    
    //////////////////////////////////////////////////////////////////////////////
    //
    //  UNIT TESTS
    //
    /////////////////////////////////////////////////////////////////////////////////
    static testMethod void massDelete_unitTest() {
    
        Account newAccount = new Account();
        newAccount.Name = 'Test Account 1';
        insert newAccount;
        
        
        //for (Integer ij = 0; ij < 3; ij++) {

            List<Purchase__c> npForInsert = new List<Purchase__c>();

            for (Integer i = 0; i < 99; i++) {
            
                Purchase__c nP = new Purchase__c();
                nP.Member__c = newAccount.id;
                nP.Report_Date__c = date.today();
                nP.Amount__c = 100;
                nP.Report_Total__c = 100;
                nP.Write_Off__c = 100;
                npForInsert.add(nP);
            
            }

            insert npForInsert;
        //}
        
        //for (Integer ij = 0; ij < 3; ij++) {

            List<Accumed_Contracts__c> nspForInsert = new List<Accumed_Contracts__c>();

            for (Integer i = 0; i < 99; i++) {
            
                Accumed_Contracts__c nP = new Accumed_Contracts__c();
                nP.Account__c = newAccount.id;
                nspForInsert.add(nP);
            
            }

            insert nspForInsert;
    //  }
        
        
        PageReference pageRef =  Page.MassDelete;
        Test.setCurrentPage(pageRef);
        
        massDelete controller = new massDelete();
        controller = new massDelete(); 
        controller.getCanDeletePurchase();
        controller.deletePurchase();
        controller.deleteAccumedContract();
        controller.getCanDeleteContracts();
        
        String q = 'Select Id from Purchase__c Limit 200';
        massDeleteBatchClass t = new massDeleteBatchClass(q); 
        t.Query = q;  
        
        Test.startTest();
        Integer MAX_BATCHES = 5;
        Integer runningBatchJobs = [SELECT COUNT() FROM AsyncApexJob WHERE JobType = 'BatchApex' AND status in ('Queued','Processing','Preparing')];
        if(runningBatchJobs < MAX_BATCHES){ 
            id batchinstanceid = database.executeBatch(t,200);
        } 
        Test.stopTest();
        
         List<Accumed_Contracts__c> lstAC = [select id from Accumed_Contracts__c];
        system.assert(lstAC.size() == 0,'AC size');
    }
    
 }