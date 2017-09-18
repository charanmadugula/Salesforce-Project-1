//========================================================================
//  Object: th_SpecialPricing
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Speci Trigger Handler
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class th_SpecialPricing {

    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public th_SpecialPricing(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnAfterInsert(Special_Pricing__c[] newSPs){
        
        for(Special_Pricing__c sp : newSPs){
            
            //Update PW
            methods_SpecialPricing.updatePW(newSPs);

			//Populate if Enoxaparin
			if (sp.Enoxaparin__c) {
				//methods_SpecialPricing.populateEnoxaparin(sp.Id);
			}

        }
    }
    
    
    public boolean IsTriggerContext{
        get{ return m_isExecuting;}
    }
    
    public boolean IsVisualforcePageContext{
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsWebServiceContext{
        get{ return !IsTriggerContext;}
    }
    
    public boolean IsExecuteAnonymousContext{
        get{ return !IsTriggerContext;}
    }
}