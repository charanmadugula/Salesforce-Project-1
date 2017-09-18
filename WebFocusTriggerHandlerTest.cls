/************************************************************************

    Name: WebFocusTriggerHandlerTest.cls
    Purpose: Test class for webFocusTriggerHandler class
    History:  
**********************************************************************
    Version        Created by         Date             Description
       1          TCS Offshore      11/24/2015          Created

*************************************************************************/
@isTest
public class WebFocusTriggerHandlerTest{
    // Method to Test Webfocus
    static testmethod void WebFocusTriggerTestMethod()
    {        
        Account parentAcc=new Account();
        ParentAcc = InsertTestData.createParentAccount('TestParentAccount','OCR Pharmacy','United States',true);
        insert parentAcc;
        
        Account acc=new Account();
        acc=InsertTestData.createAccount('TestAccount','OCR Pharmacy',parentAcc.Id,'United States',true); 
        insert acc;        
        
        Web_Focus__c newWebFocus = new Web_Focus__c();
        newWebFocus  = InsertTestData.createWebFocus(acc.Id);
        newWebFocus.Fac_Medicare_A_Rev__c=1;
        newWebFocus.Fac_Other_Rev__c=2;
        newWebFocus.Fac_Per_Diem_Rev__c=3;
        newWebFocus.Hospice_Rev__c=4;
        newWebFocus.Medicaid_Rev__c=5;
        newWebFocus.Medicare_B_Rev__c=6;
        newWebFocus.Medicare_D_Rev__c=7;
        newWebFocus.Net_Rev__c=8;
        newWebFocus.Pending_Rev__c=9;
        newWebFocus.Private_Rev__c=11;
        newWebFocus.ThirdParty_Rev__c=22;
        newWebFocus.Fac_Medicare_A_Scripts__c=33;
        newWebFocus.Fac_Other_Scripts__c=44;
        newWebFocus.Fac_Per_Diem_Scripts__c=55;
        newWebFocus.Hospice_Scripts__c=66;
        newWebFocus.Medicaid_Scripts__c=77;
        newWebFocus.Medicare_B_Scripts__c=88;
        newWebFocus.Medicare_D_Scripts__c=99;
        newWebFocus.Oper_Scripts__c=111;
        newWebFocus.Pending_Scripts__c=222;
        newWebFocus.Private_Scripts__c=333;
        newWebFocus.ThirdParty_Scripts__c=444;
        insert newWebFocus;
        
        Account acc1=new Account();
        acc1=InsertTestData.createAccount('TestAccount1','OCR Pharmacy',parentAcc.Id,'United States',true); 
        insert acc1;        
        
        Web_Focus__c newWebFocus1 = new Web_Focus__c();
        newWebFocus1  = InsertTestData.createWebFocus(acc1.Id);
        newWebFocus1.Fac_Medicare_A_Rev__c=1;
        newWebFocus1.Fac_Other_Rev__c=2;
        newWebFocus1.Fac_Per_Diem_Rev__c=3;
        newWebFocus1.Hospice_Rev__c=4;
        newWebFocus1.Medicaid_Rev__c=5;
        newWebFocus1.Medicare_B_Rev__c=6;
        newWebFocus1.Medicare_D_Rev__c=7;
        newWebFocus1.Net_Rev__c=8;
        newWebFocus1.Pending_Rev__c=9;
        newWebFocus1.Private_Rev__c=11;
        newWebFocus1.ThirdParty_Rev__c=22;
        newWebFocus1.Fac_Medicare_A_Scripts__c=33;
        newWebFocus1.Fac_Other_Scripts__c=44;
        newWebFocus1.Fac_Per_Diem_Scripts__c=55;
        newWebFocus1.Hospice_Scripts__c=66;
        newWebFocus1.Medicaid_Scripts__c=77;
        newWebFocus1.Medicare_B_Scripts__c=88;
        newWebFocus1.Medicare_D_Scripts__c=99;
        newWebFocus1.Oper_Scripts__c=111;
        newWebFocus1.Pending_Scripts__c=222;
        newWebFocus1.Private_Scripts__c=333;
        newWebFocus1.ThirdParty_Scripts__c=444;
        insert newWebFocus1;  
        
        Account acc2=new Account();
        acc2=InsertTestData.createAccount('TestAccount1','OCR Pharmacy',parentAcc.Id,'United States',true); 
        insert acc2;        
        
        Web_Focus__c newWebFocus2 = new Web_Focus__c();
        newWebFocus2  = InsertTestData.createWebFocus(acc2.Id);
        newWebFocus2.Fac_Medicare_A_Rev__c=1;
        newWebFocus2.Fac_Other_Rev__c=2;
        newWebFocus2.Fac_Per_Diem_Rev__c=3;
        newWebFocus2.Hospice_Rev__c=4;
        newWebFocus2.Medicaid_Rev__c=5;
        newWebFocus2.Medicare_B_Rev__c=6;
        newWebFocus2.Medicare_D_Rev__c=7;
        newWebFocus2.Net_Rev__c=8;
        newWebFocus2.Pending_Rev__c=9;
        newWebFocus2.Private_Rev__c=11;
        newWebFocus2.ThirdParty_Rev__c=22;
        newWebFocus2.Fac_Medicare_A_Scripts__c=33;
        newWebFocus2.Fac_Other_Scripts__c=44;
        newWebFocus2.Fac_Per_Diem_Scripts__c=55;
        newWebFocus2.Hospice_Scripts__c=66;
        newWebFocus2.Medicaid_Scripts__c=77;
        newWebFocus2.Medicare_B_Scripts__c=88;
        newWebFocus2.Medicare_D_Scripts__c=99;
        newWebFocus2.Oper_Scripts__c=111;
        newWebFocus2.Pending_Scripts__c=222;
        newWebFocus2.Private_Scripts__c=333;
        newWebFocus2.ThirdParty_Scripts__c=444;
        insert newWebFocus2;  
        
        
        List<Web_Focus__c> lstWS = [select id from Web_Focus__c];
        system.assert(lstWS.size() > 0,'WS size');  
         
    }
}