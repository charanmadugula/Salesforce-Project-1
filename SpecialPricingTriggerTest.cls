@isTest
Public class SpecialPricingTriggerTest{

    public static Profile sysAdmnprof;

    static testMethod void SpecialPricingTriggerTestMethod(){
        Test.startTest();

        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        Special_Pricing__c specialPricing= new Special_Pricing__c();
        specialPricing=InsertTestData.createSpecialPricing('Pricing1');
        insert specialPricing;

        th_SpecialPricing pricing= new th_SpecialPricing (True,10);
        Boolean IsTriggerContext=pricing.IsTriggerContext;
        Boolean IsVisualforcePageContext=pricing.IsVisualforcePageContext;
        Boolean IsWebServiceContext=pricing.IsWebServiceContext;
        Boolean IsExecuteAnonymousContext=pricing.IsExecuteAnonymousContext;
    }
}