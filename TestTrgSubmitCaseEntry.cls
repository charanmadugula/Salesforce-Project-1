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
 
 History
 Version 1 - Created by NexGenuser on 12/15/2014
 Version 2 - Updated with CIC Functionality on 19/8/2015 by Vikashkumar Jha - TCS Offshore.
 Version 4: Made Changes to the Event Start and End dates to reflect the Case Entry Form Created Date, made All Day Event False,Removed Activity Date as it is not present on the Page layout  as per Rob Folmar's request 01/10/2017 " INC2884432 " 
 */
@isTest (SeeAllData = true)
private class TestTrgSubmitCaseEntry {

    static testMethod void SubmitCaseEntry() {
        OCR_Pharmacy__c objocr = new OCR_Pharmacy__c(Name = 'OCR Name',Phone__c = '9198341600',City__c='Charlotte',Country__c='US',State_Province__c='NC',Zip_Postal_Code__c='28215-3261');
        insert objocr; 
        RecordType objrt = [select id,Name,DeveloperName from RecordType WHERE SobjectType='Account' and DeveloperName = 'LTC_Associated_Account' limit 1];
        
        Account objacc = new Account(OCR_Pharmacy_Name__c = objocr.id,Name='Sample Name', RecordTypeId = objrt.id);
        insert objacc;
        Case_Entry_Form__c objc = new Case_Entry_Form__c( 
        Account_Name__c = objacc.id,
        Submit__c = true,
        Billing_Accuracy__c = 'Critical',
        Billing_Accuracy_Resolved__c = true,
        Bed_Type__c = 'SNF',
        Billing_Pres_Ease_Use_Resolution_Details__c = 'Text',       
        
   /* Test class changes for CIC functionalty starts */   
        CIC_Accuracy__c = 'Critical',
        CIC_Accuracy_Resolved__c = true,
        CIC_Accuracy_Resolution_Details__c = 'Details',
        CIC_Accuracy_Comments__c ='Comments',
       
  /* CIC ends */  
       
        Clinical__c ='Critical',
        Contract_Renewal_Concerns__c = 'Critical',
        Customer_Req_Training_Inservice__c = 'Critical',
        Clinical_Comments__c = 'Comments',
        Clinical_Resolution_Details__c = 'Details',
        Clinical_Resolved__c = true,
        Delivery__c = 'Critical',
        Equipment__c = 'Critical', 
        Med_Occurrences__c = 'Critical',
        Technology__c = 'Critical',
        Medical_Records__c = 'Critical',
        Medication_Availability_Admission_Meds__c = 'Critical',
        Medication_Availability_Controls__c = 'Critical',
        Billing_Accuracy_Comments__c = 'Comments',
        Billing_Accuracy_Resolution_Details__c  = 'resolution',
        Stats__c = 'Critical',
        Contract_Renewal_Concerns_Comments__c = 'comments',
        Customer_Req_Training_Inservice_Comments__c = 'Comments',
        Med_Availability_Admission_Meds_Comments__c = 'Comemnts',
        Medical_Records_Comments__c = 'Comments',
        Medication_Availability_Controls_Comment__c = 'Comments',
        Delivery_Comments__c = 'Comments',
        Equipment_Comments__c = 'Comments',
        Med_Occurrences_Comments__c = 'Comments',
        Technology_Comments__c = 'Comments',
        Stat_Comments__c = 'Comments',
        Date_of_Visit__c = system.today()
        );
        insert objc;
        
        Case_Entry_Form__c objc2 = new Case_Entry_Form__c( 
        Account_Name__c = objacc.id,
        Submit__c = false,
        Billing_Accuracy__c = 'Critical',
        Billing_Accuracy_Resolved__c = true,
        Bed_Type__c = 'SNF',
        Billing_Pres_Ease_Use_Resolution_Details__c = 'Text',
 
 
  /* Test class changes for CIC functionalty starts */   
        CIC_Accuracy__c = 'Critical',
       CIC_Accuracy_Resolved__c = true,
         CIC_Accuracy_Resolution_Details__c = 'Details',
        CIC_Accuracy_Comments__c ='Comments',    
    /* CIC ends */  
        
        
        
        Clinical__c = 'Critical',
        Contract_Renewal_Concerns__c = 'Critical',
        Customer_Req_Training_Inservice__c = 'Critical',
        Clinical_Comments__c = 'Comments',
        Clinical_Resolution_Details__c = 'Details',
        Clinical_Resolved__c = true,
        Delivery__c = 'Critical',
        Equipment__c = 'Critical', 
        Med_Occurrences__c = 'Critical',
        Technology__c = 'Critical',
        Medical_Records__c = 'Critical',
        Medication_Availability_Admission_Meds__c = 'Critical',
        Medication_Availability_Controls__c = 'Critical',
        Billing_Accuracy_Comments__c = 'Comments',
        Billing_Accuracy_Resolution_Details__c  = 'resolution',
        Stats__c = 'Critical',
        Contract_Renewal_Concerns_Comments__c = 'comments',
        Customer_Req_Training_Inservice_Comments__c = 'Comments',
        Med_Availability_Admission_Meds_Comments__c = 'Comemnts',
        Medical_Records_Comments__c = 'Comments',
        Medication_Availability_Controls_Comment__c = 'Comments',
        Delivery_Comments__c = 'Comments',
        Equipment_Comments__c = 'Comments',
        Med_Occurrences_Comments__c = 'Comments',
        Technology_Comments__c = 'Comments',
        Stat_Comments__c = 'Comments',
        Date_of_Visit__c = system.today()
        );
        insert objc2;
        
        Case_Entry_Form__c objc1 = new Case_Entry_Form__c(
        id= objc2.id,
        Account_Name__c = objacc.id,
        Submit__c = true,
        Billing_Accuracy__c = 'Severe',
        Billing_Accuracy_Resolved__c = true,
        Bed_Type__c = 'SNF',
        Billing_Pres_Ease_Use_Resolution_Details__c = 'Text',
        Clinical__c = 'Severe',
        Contract_Renewal_Concerns__c = 'Severe',
        Customer_Req_Training_Inservice__c = 'Severe',
        Clinical_Comments__c = 'Comments',
        Clinical_Resolution_Details__c = 'Details',
        Clinical_Resolved__c = true,
        Delivery__c = 'Severe',
        Equipment__c = 'Severe', 
        Med_Occurrences__c = 'Severe',
        Technology__c = 'Severe',
        Medical_Records__c = 'Severe',
        Medication_Availability_Admission_Meds__c = 'Severe',
        Medication_Availability_Controls__c = 'Severe',
        Billing_Accuracy_Comments__c = 'Comments',
        Billing_Accuracy_Resolution_Details__c  = 'resolution',
        Stats__c = 'Critical',
        Contract_Renewal_Concerns_Comments__c = 'comments',
        Customer_Req_Training_Inservice_Comments__c = 'Comments',
        Med_Availability_Admission_Meds_Comments__c = 'Comemnts',
        Medical_Records_Comments__c = 'Comments',
        Medication_Availability_Controls_Comment__c = 'Comments',
        Delivery_Comments__c = 'Comments',
        Equipment_Comments__c = 'Comments',
        Med_Occurrences_Comments__c = 'Comments',
        Technology_Comments__c = 'Comments',
        Stat_Comments__c = 'Comments',
        Date_of_Visit__c = system.today()
        );
        
        update objc1;
        
        List<Case_Entry_Form__c> lstCEF = [select id from Case_Entry_Form__c];
        system.assert(lstCEF.size() > 0,'CEF size');
        
    }
}