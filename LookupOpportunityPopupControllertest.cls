@isTest
private class LookupOpportunityPopupControllertest {

    static testMethod void myUnitTest() {
        // TO DO: implement unit test
         Account accObj = new Account();
        accObj.Name = 'Test';
        accObj.Pharmacy_Name__c = 'Test';
        accObj.BillingCountry = 'Test';
        insert accObj;
        
        Opportunity newOpportunity= new Opportunity();
        newOpportunity.Name='Test';
        newOpportunity.AccountId = accObj.Id;
        newOpportunity.StageName='Signed';
        newOpportunity.CloseDate = System.today();
        newOpportunity.Presented_Value_Prop__c='Test';
        newOpportunity.Beds_Serviced__c = 'SNF,ALF,IL';
        newOpportunity.Presented_Value_Prop__c= 'Retail Acquisition';
        newOpportunity.Probability=30.00;
        insert newOpportunity;
        
       PageReference pageRef = Page.LookupOpportunityPopup;
       system.Test.setCurrentPage(pageRef);
       
       ApexPages.currentPage().getParameters().put('accid',accObj.Id);

       LookupOpportunityPopupController obj = new LookupOpportunityPopupController();
       
        List<Opportunity> lstopp = [select id from Opportunity];
        system.assert(lstopp.size() > 0,'opp size');
      
    }
    
     static testMethod void myUnitTest2() {
        // TO DO: implement unit tes
       LookupOpportunityPopupController obj = new LookupOpportunityPopupController();
       
       List<Opportunity> lstopp = [select id from Opportunity];
        system.assert(lstopp.size() == 0,'opp size');
       
      
    }
}