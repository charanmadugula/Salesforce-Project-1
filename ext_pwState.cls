//========================================================================
//  Object: ext_pwState
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for pwState VF Page
//========================================================================
//          Date            Purpose
// Changes: 11/27/2015      Initial Version
//========================================================================

public with sharing class ext_pwState {
    
    //Variables
    public Pricing_Worksheet__c pricingWorkSheet{get;set;}
    public id pwid {get;set;}
	public Boolean renderSave {get;Set;}

    //Constructor
    public ext_pwState(ApexPages.StandardController stdController) {

        //Get Record Id
        pwid = ApexPages.currentPage().getParameters().get('id');
        
        //Populate Variables
        pricingWorkSheet = globalHelper.getPricingWorksheetFields(pwId);
		renderSave = globalHelper.isUserAdmin(UserInfo.getUserId());

         
    }

    
}