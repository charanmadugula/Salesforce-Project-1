@isTest
global class CalculateDistanceBatchTest{

  public static Profile sysAdmnprof;
  
  static testMethod void CalculateDistanceBatchTest(){
    Test.startTest();
    RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
    RecordType ProsFacilityRecType = [Select Id from RecordType where Name ='LTC Prospect Facility'];
    RecordType FormFacilityRecType = [Select Id from recordType where Name = 'LTC Former Facility'];
      
    sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
    
    Account parentAcc= new Account();
    parentAcc=InsertTestData.createParentAccount('parentAcc','testPharmacy','Country1',true);
    parentAcc.RecordTypeId = custFacilityRecType.Id;
    insert parentAcc;
    
    Account childAcc= new Account();
    childAcc=InsertTestData.createAccount('childAcc','testPharmacy',parentAcc.id,'Country',true);
    childAcc.RecordTypeId = custFacilityRecType.Id;
    insert childAcc;
    
    Account childAcc1= new Account();
    childAcc1=InsertTestData.createAccount('childAcc1','testPharmacy1',parentAcc.id,'Country1',true);
    childAcc1.RecordTypeId = ProsFacilityRecType.Id;
    insert childAcc1;
    
    Account childAcc2= new Account();
    childAcc2=InsertTestData.createAccount('childAcc1','testPharmacy1',parentAcc.id,'Country1',true);
    childAcc2.RecordTypeId = FormFacilityRecType .Id;
    insert childAcc2;
    
        List<Account > lstAcc = [select id from Account ];
        system.assert(lstAcc.size() > 0,'ACC size');
        
        CalculateDistanceBatch k = new CalculateDistanceBatch();
        k.execute(null);
        Test.stopTest();
    
    }
    
  

    
}