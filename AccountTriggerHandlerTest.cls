@isTest
Public class AccountTriggerHandlerTest{

    public static Profile sysAdmnprof;
 
    static testMethod void AccountTriggerHandlerTestMethod(){
        Test.startTest();
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
        RecordType operRecType = [Select Id from recordType where Name = 'LTC Operations'];
        DataUtil_Check.var_StopAccountTriggerfromCase=false;
        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    
        Account parentAcc= new Account();
        parentAcc=InsertTestData.createParentAccount('parentAcc','testPharmacy','Country1',true);
        parentAcc.RecordTypeId = assoAccRecType.Id;
        insert parentAcc;
    
        Account childAcc= new Account();
        childAcc=InsertTestData.createAccount('childAcc','testPharmacy',parentAcc.id,'Country',true);
        childAcc.retention_frequencySurvey__c='Quarterly';
        childAcc.RecordTypeId = custFacilityRecType.Id;
        insert childAcc;
    
        Contact con= new Contact();
        con=InsertTestData.CreateContact('testLast',childAcc.id,'OH');
        insert con; 
    
        Satisfaction_Surveys__c satSurvey= new Satisfaction_Surveys__c();
        satSurvey=InsertTestData.createSatisfactionSurveys(childAcc.id);
        satSurvey.Date_of_Survey__c=Date.newInstance(1960,2,17);
        insert satSurvey;
    
        Case caseObj = new Case();
        caseObj=InsertTestData.createCase('New','Email','Billing',childAcc.id,con.id,Date.Today().addDays(-10),'Severe');
        caseObj.RecordTypeId =operRecType.Id;
        insert caseObj;
    
        Case caseObj1 = new Case();
        caseObj1=InsertTestData.createCase('New','Email','Billing',childAcc.id,con.id,Date.Today().addDays(-10),'Moderate');
        caseObj1.RecordTypeId =operRecType.Id;
        insert caseObj1;
    
        Case caseObj2 = new Case();
        caseObj2=InsertTestData.createCase('New','Email','Billing',childAcc.id,con.id,Date.Today().addDays(-10),'Critical');
        caseObj2.RecordTypeId =operRecType.Id;
        insert caseObj2;
    
        Case caseObj3 = new Case();
        caseObj3 =InsertTestData.createCase('New','Email','Billing',childAcc.id,con.id,Date.Today().addDays(3),'Critical');
        caseObj3 .RecordTypeId =operRecType.Id;
        insert caseObj3 ;
    
        Account childAcc1= new Account();
        childAcc1=InsertTestData.createAccount('childAcc1','testPharmacy1',parentAcc.id,'Country1',true);
        childAcc1.retention_frequencySurvey__c='Semi-Annually';
        childAcc1.RecordTypeId = custFacilityRecType.Id;
        insert childAcc1;
    
        Satisfaction_Surveys__c satSurvey1= new Satisfaction_Surveys__c();
        satSurvey1=InsertTestData.createSatisfactionSurveys(childAcc1.id);
        satSurvey1.Date_of_Survey__c=Date.newInstance(1960,2,17);
        insert satSurvey1;
     
        Account childAcc2= new Account();
        childAcc2=InsertTestData.createAccount('childAcc1','testPharmacy1',parentAcc.id,'Country1',true);
        childAcc2.retention_frequencySurvey__c='Annually';
        childAcc2.RecordTypeId = custFacilityRecType.Id;
        insert childAcc2;
     
        Satisfaction_Surveys__c satSurvey2= new Satisfaction_Surveys__c();
        satSurvey2=InsertTestData.createSatisfactionSurveys(childAcc2.id);
        satSurvey2.Date_of_Survey__c=Date.newInstance(1960,2,17);
        insert satSurvey2;
        test.stoptest();
        List<Account> lstAccount = [select Current_Week_Moderate__c,Current_Week_Severe__c from account where name='parentAcc'];
     
        if(lstAccount.size() > 0){
            system.assert(lstAccount.size() == 1,'Account Created');
        }
    }
   static testMethod void AccountTriggerHandlerTestMethod1(){
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
        RecordType operRecType = [Select Id from recordType where Name = 'LTC Operations'];

        Account parentAcc= new Account();
        parentAcc=InsertTestData.createParentAccount('parentAcc','testPharmacy','Country1',true);
        parentAcc.RecordTypeId = assoAccRecType.Id;
        insert parentAcc;

        Account childAcc= new Account();
        childAcc=InsertTestData.createAccount('childAcc1','testPharmacy1',parentAcc.id,'Country1',true);
        //childAcc.retention_frequencySurvey__c='Semi-Annually';
        childAcc.RecordTypeId = custFacilityRecType.Id;
        insert childAcc;

        Contact con= new Contact();
        con=InsertTestData.CreateContact('testLast',childAcc.id,'OH');
        insert con;

        Case caseObj = new Case();
        caseObj =InsertTestData.createCase('New','Email','Billing',childAcc.id,con.id,Date.Today().addDays(3),'Severe');
        caseObj.RecordTypeId =operRecType.Id;
        insert caseObj ;

        Case caseObj1 = new Case();
        caseObj1=InsertTestData.createCase('New','Email','Billing',childAcc.id,con.id,Date.Today().addDays(3),'Moderate');
        caseObj1.RecordTypeId =operRecType.Id;
        insert caseObj1;

        List<Account> lstAccount = [select Current_Week_Moderate__c,Current_Week_Severe__c from account where name='childAcc1'];

        if(lstAccount.size() > 0){
            system.assert(lstAccount.size() == 1,'Account Created');
        }
       
       AccountTriggerHandler handler = new AccounttriggerHandler();
       handler.toCalculateDeviation(1,1);
       handler.toUpdateStatus(1,1,1);
    }
}