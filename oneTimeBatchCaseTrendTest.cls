/************************************************************************

    Name: oneTimeBatchCaseTrendTest.cls
    Purpose: Test class for oneTimeBatchCaseTrend class
    History:  
**********************************************************************
    Version        Created by         Date             Description
       1          TCS Offshore      11/24/2015          Created

*************************************************************************/
@isTest
public class oneTimeBatchCaseTrendTest{
    // Method to Test one Time Batch for Case Trend 
    static testmethod void OneTimeBatchCaseTrendTestMethod()
    {
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
               
        Account ParentAcc=new Account();
        ParentAcc=InsertTestData.createParentAccount('TestParentAccount','OCR Pharmacy','United States',true);
        ParentAcc.RecordTypeId = assoAccRecType.Id; 
        insert ParentAcc;
        
        Account acc=new Account();
        acc=InsertTestData.createAccount('TestAccount','OCR Pharmacy',ParentAcc.Id,'United States',true);
        acc.RecordTypeId = custFacilityRecType.Id; 
        insert acc;
        
        Contact con = new Contact();
        con=InsertTestData.CreateContact('Test Contact',acc.Id,'OH');
        insert con;        
       
       List <Case> caseList = new List<Case>();
        for(integer i = 0; i<50; i++)
        {
             Case c = new Case();
            c.AccountId = acc.Id;
            c.ContactId = con.Id;            
            caseList.add(c);
        }
        insert caseList;
     
        Test.StartTest();
        oneTimeBatchCaseTrend oneTimeBatch= new oneTimeBatchCaseTrend ();
        Database.executeBatch(oneTimeBatch);
        Test.StopTest();
        
          List<Case> lstCase = [select id from Case];
          system.assert(lstCase.size() > 0,'Case size');
        
    }
   
}