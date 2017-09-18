//========================================================================
//  Object: ext_pwExec
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for pwExec VF Page
//========================================================================
//          Date            Purpose
// Changes: 11/27/2015      Initial Version
//========================================================================

public with sharing class ext_pwExec {
    
    //Variables
    public Pricing_Worksheet__c pricingWorkSheet{get;set;}
    public id pwid {get;set;}
    public Boolean renderSave {get;Set;}
    public User pwUser {get;set;}
    public Account pwAccount {get;set;}
    
   
    //Constructor
    public ext_pwExec(ApexPages.StandardController stdController) {

        //Get Record Id
        pwid = ApexPages.currentPage().getParameters().get('id');
        
        //Populate Variables
        pricingWorkSheet = globalHelper.getPricingWorksheetFields(pwId);
        pwUser = globalHelper.getUserFields(pricingWorkSheet.CreatedById);
        pwAccount = [Select id, name ,OCR_Pharmacy_Name__r.name, BillingState,RecordTypeId,SNF_Beds__c,ALF_Beds__c,Other_Beds__c from Account where id = :pricingWorkSheet.Account__c];
    }
    
   

    //Cancel
    public PageReference cancel() {

        pagereference pr = new pagereference('/' + pricingWorkSheet.Account__c);
            pr.setredirect(true);
        return pr;  
    }

    //Clone
    public PageReference clonePW() {

        //Clone Record 
        Pricing_Worksheet__c pwClone = pricingWorkSheet.clone(false,false,false,false);
        
        //Set Null Fields
            //Pricing Worksheet Fields
            pwClone.Status__c = 'New';
            pwClone.Submitted_By__c = null;
            pwClone.Date_Submitted__c = null;
            
            
            
    
            //Approval Date
            Pwclone.Approval_Date_VPO__c = null;
            pwClone.Approval_Date_Ad_Hoc__c = null;
            pwClone.Approval_Date_CAC__c = null;
            pwClone.Approval_Date_CP__c = null;
            pwClone.Approval_Date_Credit__c = null;
            pwClone.Approval_Date_DOP__c = null;
            pwClone.Approval_Date_Legal__c = null;
            pwClone.Approval_Date_PA__c = null;
            pwClone.Approval_Date_IV_P__c = null;
            pwClone.Approval_Date_IV_R__c = null;
            pwClone.Approval_Date_IV_SD__c = null;
           
             
            //Approval Notes
            pwclone.Approval_Notes_VPO__c = null;
            pwClone.Approval_Notes_Ad_Hoc__c = null;
            pwClone.Approval_Notes_CAC__c = null;
            pwClone.Approval_Notes_CP__c = null;
            pwClone.Approval_Notes_Credit__c = null;
            pwClone.Approval_Notes_DOP__c = null;
            pwClone.Approval_Notes_Legal__c = null;
            pwClone.Approval_Notes_PA__c = null;
            pwClone.Approval_Notes_IV_P__c = null;
            pwClone.Approval_Notes_IV_R__c = null;
            pwClone.Approval_Notes_IV_S__c = null;
           
            //Approvers
            
            pwClone.Approver_VPO__c = null;
            pwClone.Approver_Ad_Hoc__c = null;
            pwClone.Approver_Capital_Assets_and_Compliance__c = null;
            pwClone.Approver_Contract_Pricing__c = null;
            pwClone.Approver_Credit__c = null;
            pwClone.Approver_Director_of_Pricing__c = null;
            pwClone.Approver_Legal__c = null;
            pwClone.Approver_Pricing_Analysis__c = null;
            pwClone.Approver_IV_Pricing__c = null;
            pwClone.Approver_IV_Rx__c = null;
            pwClone.Approver_IV_SD__c = null;
                        
        insert pwClone;

        //redirect to new record
        pagereference pr = new pagereference('/' + pwClone.Id);
            pr.setredirect(true);
        return pr;   
    }

   }