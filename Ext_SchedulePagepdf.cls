public with sharing class Ext_SchedulePagepdf
{
    public Pricing_Worksheet__c pricingWorkSheet {get;set;}
    public Internal_IV_Worksheet__c internalIVWorkSheet {get;set;}
    public Account acc{get;set;}
    public String accId;
    public String internalWorkSheetId;
    public Boolean pdTrueUp {get;set;}
    public User pwUser {get;set;}
       
    public Ext_SchedulePagepdf(ApexPages.StandardController stdController) {
        pricingWorkSheet = (Pricing_Worksheet__c)stdController.getRecord();
        pricingWorkSheet = globalHelper.getPricingWorksheetFields(pricingWorkSheet.id);
        internalWorkSheetId = ApexPages.currentPage().getParameters().get('iwsId');
        if(internalWorkSheetId!= null){
        internalIVWorkSheet = globalHelper.getInternalIVFields(internalWorkSheetId);
        }
        accId = ApexPages.currentPage().getParameters().get('accId');
        acc = globalHelper.getAccountFields(pricingWorkSheet.Account__c);
        //if(accId!= null){
       // acc = globalHelper.getAccountFields(accId);
        //}
         pwUser = globalHelper.getUserFields(pricingWorkSheet.CreatedById);
        //Per Diem True Up
        if (pricingWorkSheet.Facility_Pricing_Contract_terms_Patient__c == 'Per Diem') {
            pdTrueUp = true;
        }
        else {
            pdTrueUp = false;
        }
    }
    
    
    public PageReference deliverAsPDF() {
  PageReference pdf =  Page.SchedulePagepdf;
  pdf.getParameters().put('id',pricingWorkSheet.Id);
  return pdf;
  }
 public PageReference deliverAsWORDDOC() {
  PageReference word =  Page.Schedulepageword;
  word.getParameters().put('id',pricingWorkSheet.Id);
  return word;
  }  
}