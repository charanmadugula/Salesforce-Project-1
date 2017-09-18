//========================================================================
//  Object: ext_ViewPricingWorksheet
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for viewPricingWorksheet VF Page
//========================================================================
//          Date            Purpose
// Changes: 11/27/2015      Initial Version
//========================================================================

public with sharing class ext_ViewPricingWorksheet {
    
    //Variables
    public Pricing_Worksheet__c pws{get;set;}
    public id pwid {get;set;}
    public PageReference pr;

    //Constructor
    public ext_ViewPricingWorksheet(ApexPages.StandardController stdController) {

        //Get Record Id
        pwid = ApexPages.currentPage().getParameters().get('id');
        
        //Populate Variables
        pws = globalHelper.getPricingWorksheetFields(pwId);
        
    }

    public PageReference autoRun()  {
        
        //Redirect based on Status

        if (pws.Status__c == 'State'){
            pr = new PageReference('/apex/pwState?Id=' + pwid);
        }
        else if (pws.Status__c == 'Approved' || pws.Status__c == 'Cancelled'){
            pr = new PageReference('/apex/pwExecuted?Id=' + pwid);
        } else {
            pr = new PageReference('/apex/pwView?Id=' + pwid);
        }

        pr.setredirect(true);
        return pr;
    }    
    
}