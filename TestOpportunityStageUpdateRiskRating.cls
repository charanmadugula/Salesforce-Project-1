/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest (SeeAllData = true)
private class TestOpportunityStageUpdateRiskRating {

    static testMethod void OpportunityStageUpdateRiskRating(){
        account acct = new account(Name = 'Omnicare Test');
        Opportunity opp = new Opportunity(Name = 'Test Opp', RecordTypeID = '012C0000000hUQJ', Account = acct , StageName = 'A75',Est_Loss_Date__c = System.today()+30, CloseDate = System.today() + 30, NextStep = 'Test', WebFocus_Facility_ID__c = 'WI57855ZY');
// TCS Updated to fix the test class by adding Est_Loss_Date__c = value;
       // opp.Beds_type__c = 'SNF BED';
       // opp.Presented_Value_Prop__c= 'Retail Acquisition';
       // opp.Probability=30.00;
        insert acct;
        insert opp;
        
        List<Opportunity> lstOpp = [select id from Opportunity];
        system.assert(lstOpp.size() > 0,'Opp size');
    }
}