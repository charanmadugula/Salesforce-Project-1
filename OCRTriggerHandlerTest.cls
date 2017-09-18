@istest
public class OCRTriggerHandlerTest{
    static testmethod void OCRTestMethod(){       
        
        RecordType custFacilityRecType = [Select Id from RecordType where Name ='LTC Customer Facility'];
        RecordType assoAccRecType = [Select Id from RecordType where Name ='LTC Associated Account'];
        
        OCR_Pharmacy__c OCR = new OCR_Pharmacy__c ();
        OCR = InsertTestData.createOCRPharmacy('Test OCR Pharmacy','9874563214','San Mateo','CA','65123','USA');
        insert OCR;
        
        Account ParentAcc=new Account();
        ParentAcc=InsertTestData.createParentAccount('TestParentAccount','OCR Pharmacy','United States',true);
        ParentAcc.RecordTypeId = assoAccRecType.Id;
        insert ParentAcc;
        
        Account acc=new Account();
        acc.Name = 'Test Acc';
        acc.Pharmacy_Name__c ='OCR Pharmacy';
        acc.ParentId = ParentAcc.Id;
        acc.RecordTypeId = custFacilityRecType.Id; 
        acc.OCR_Pharmacy_Name__c = OCR.Id;
        acc.BillingCity = 'Cincinnati';
        acc.BillingState= 'OH';
        acc.BillingCountry = 'United States';
        acc.BillingPostalCode= '45215';
        acc.Test_Class_Reference__c=true;
        insert acc;
                
        Test.starttest();
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());
        getGoogleMaps.getAccOCRDistance(acc.id);
        test.stoptest();  
        
        OCR.Country__c = 'US';
        update OCR;      
        
        List<OCR_Pharmacy__c> lstOCR = [select id from OCR_Pharmacy__c];
        system.assert(lstOCR.size() > 0,'OCR size');
        
    }
}