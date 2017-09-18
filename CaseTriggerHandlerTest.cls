@isTest(SeeAllData=true)
public class CaseTriggerHandlerTest{
    static testmethod void CaseTestMethod(){
    
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
        RecordType operRecType = [Select Id from recordType where Name = 'LTC Operations'];
        
        OCR_Pharmacy__c orcPhar = new OCR_Pharmacy__c();
        orcPhar=InsertTestData.createOCRPharmacy('Pharmacy1','9854711256','City1','St','1254','Country1');
        insert orcPhar;
        
        Account ParentAcc=new Account();
        ParentAcc=InsertTestData.createParentAccount('TestParentAccount','OCR Pharmacy','United States',true);
        ParentAcc.RecordTypeId = assoAccRecType.Id; 
        insert ParentAcc;
        
        Account acc=new Account();
        acc=InsertTestData.createAccount('TestAccount','OCR Pharmacy',ParentAcc.Id,'United States',true);
        acc.RecordTypeId = custFacilityRecType.Id; 
        acc.OCR_Pharmacy_Name__c=orcPhar.id;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        insert acc;
        
        Account acc1=new Account();
        acc1=InsertTestData.createAccount('TestAccount1','OCR Pharmacy',ParentAcc.Id,'United States',true);
        acc1.RecordTypeId = custFacilityRecType.Id; 
        insert acc1;
        
        Contact con = new Contact();
        con=InsertTestData.CreateContact('Test Contact',acc.Id,'OH');
        insert con;        
        
        Case caseObj = new Case();
        caseObj=InsertTestData.createCase('Reported','Case Entry Form','Billing',acc.Id,con.Id,System.now(),'Moderate');
        caseObj.RecordTypeId =operRecType.Id;
        insert caseObj;
        
        caseObj.AccountId = acc1.Id;
        update caseObj;
        
        delete caseObj;
        
    }
    static testmethod void CaseTestMethod1()
    {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
        RecordType operRecType = [Select Id from recordType where Name = 'LTC Operations'];
      
        OCR_Pharmacy__c orcPhar = new OCR_Pharmacy__c();
        orcPhar=InsertTestData.createOCRPharmacy('Pharmacy1','9854711256','City1','St','1254','Country1');
        insert orcPhar;
        
        system.debug('==date==='+system.today().adddays(-42));
        
        Account ParentAcc=new Account();
        ParentAcc=InsertTestData.createParentAccount('TestParentAccount','OCR Pharmacy','United States',true);
        ParentAcc.RecordTypeId = assoAccRecType.Id; 
        insert ParentAcc;
        
        Account acc1=new Account();
        acc1=InsertTestData.createAccount('TestAccount1','OCR Pharmacy',ParentAcc.Id,'United States',true);
        acc1.RecordTypeId = custFacilityRecType.Id; 
        acc1.ParentId = null;
        insert acc1;
       
        Account acc=([select id,billingcity,billingstate,billingcountry from Account where CreatedDate<=:system.today().adddays(-42) and recordtypeid =:custFacilityRecType.Id limit 1]);
        acc.OCR_Pharmacy_Name__c = orcPhar.Id;
        //acc.ParentId = ParentAcc.Id;
        acc.Test_Class_Reference__c=true;
        update acc;
        system.debug('==accTest==='+acc);
        
        Contact con = new Contact();
        con=InsertTestData.CreateContact('Test Contact',acc.Id,'OH');
        insert con;       
        
        Case caseObj = new Case();
        caseObj=InsertTestData.createCase('Reported','Case Entry Form','Billing',acc.Id,con.Id,System.now(),'Severe');
        caseObj.RecordTypeId =operRecType.Id;
        insert caseObj;
    
        Case caseObj1 = new Case();
        caseObj1=InsertTestData.createCase('Reported','Case Entry Form','Billing',acc1.Id,con.Id,System.now(),'Critical');
        caseObj1.RecordTypeId =operRecType.Id;
        insert caseObj1;   
    
    }
    
    
    static testmethod void CaseTestMethod_2(){
    
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
        RecordType operRecType = [Select Id from recordType where Name = 'LTC Operations'];
        
        OCR_Pharmacy__c orcPhar = new OCR_Pharmacy__c();
        orcPhar=InsertTestData.createOCRPharmacy('Pharmacy1','9854711256','City1','St','1254','Country1');
        insert orcPhar;
        
        Account ParentAcc=new Account();
        ParentAcc=InsertTestData.createParentAccount('TestParentAccount','OCR Pharmacy','United States',true);
        ParentAcc.RecordTypeId = assoAccRecType.Id; 
        insert ParentAcc;
        
        Account acc=new Account();
        acc=InsertTestData.createAccount('TestAccount','OCR Pharmacy',ParentAcc.Id,'United States',true);
        acc.RecordTypeId = custFacilityRecType.Id; 
        acc.OCR_Pharmacy_Name__c=orcPhar.id;
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        insert acc;
        
        Account acc1=new Account();
        acc1=InsertTestData.createAccount('TestAccount1','OCR Pharmacy',ParentAcc.Id,'United States',true);
        acc1.RecordTypeId = custFacilityRecType.Id; 
        insert acc1;
        
        Contact con = new Contact();
        con=InsertTestData.CreateContact('Test Contact',acc.Id,'OH');
        insert con;        
        
        Case caseObj = new Case();
        caseObj=InsertTestData.createCase('Reported','Case Entry Form','Billing',acc.Id,con.Id,System.now(),'Moderate');
        caseObj.RecordTypeId =operRecType.Id;
        caseObj.AccountId = acc.Id;
        insert caseObj;
        
        caseObj.AccountId = acc1.Id;
        update caseObj;
        
        delete caseObj;
        
    }
    
}