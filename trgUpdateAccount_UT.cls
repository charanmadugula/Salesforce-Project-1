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
@isTest
private class trgUpdateAccount_UT {

    static testMethod void myUnitTest() {
        Account thisAccount = new Account();
        thisAccount.Name = 'Test Account';
        //thisAccount.Revenue_Rating__c = '2';
        insert thisAccount;
        
        Satisfaction_Surveys__c thisSS = new Satisfaction_Surveys__c();
        thisSS.Account__c = thisAccount.Id;
        thisSS.Date_of_Survey__c = date.today();
        insert thisSS;
        
        Executive_Review__c thisER = new Executive_Review__c();
        thisER.Account__c = thisAccount.Id;
        thisER.Date__c = date.today();
        thisER.Omnicare_Participants__c = 'Internal Employee';
        insert thisER;
        
        thisAccount.retention_frequencySurvey__c = 'Quarterly';
        //thisAccount.Revenue_Rating__c = '1';
        update thisAccount;
        
        thisAccount.retention_frequencySurvey__c = 'Semi-Annually';
        //thisAccount.Revenue_Rating__c = '2';
        update thisAccount;
        
        thisAccount.retention_frequencySurvey__c = 'Annually';
        //thisAccount.Revenue_Rating__c = '3';
        update thisAccount;
        
        thisAccount.retention_frequencyER__c = 'Quarterly';
        update thisAccount;
        
        thisAccount.retention_frequencyER__c = 'Semi-Annually';
        update thisAccount;
        
        thisAccount.retention_frequencyER__c = 'Annually';
        update thisAccount;
        
        List<Executive_Review__c> lstER = [select id from Executive_Review__c];
        system.assert(lstER.size() > 0,'ER size');
    }
}