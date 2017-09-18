//========================================================================
//  Object: th_PricingWorksheet
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Pricing_Worksheet__c Object Trigger
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public class th_PricingWorksheet {

    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public th_PricingWorksheet(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

		//Before Insert
	public void OnBeforeInsert(list<Pricing_Worksheet__c> newPWs){
		
		//Validate Other
		for(Pricing_Worksheet__c pw : newPWs){
			v_PricingWorksheet.validatev_PricingWorksheet(pw);
			
			//pw.ownerid=pw.CreatedById;
		}
	}

	//Before Update
	public void OnBeforeUpdate(list<Pricing_Worksheet__c> oldPWs, list<Pricing_Worksheet__c> newPWs, Map<Id, Pricing_Worksheet__c> pwMap){
			
		//Validate Other
		for(Pricing_Worksheet__c pw : newPWs){
			v_PricingWorksheet.validatev_PricingWorksheet(pw);
		}
	}


    public void OnAfterInsert(Pricing_Worksheet__c[] newPWs){
        
        for(Pricing_Worksheet__c pw : newPWs){
            
            //Enoxaparin
            if(!!String.isblank(pw.Special_Pricing__c) && (pw.Facility_Special_Pricing__c == 'Enoxaparin' || pw.Facility_Special_Pricing__c == 'Enoxaparin & Other Special Pricing')) {
                methods_PricingWorksheet.populateEnoxaparin(pw.Special_Pricing__c);
            }
        }
   }
    
    public void OnAfterUpdate(Pricing_Worksheet__c[] oldPWs, Pricing_Worksheet__c[] newPWs, map<Id, Pricing_Worksheet__c> oldMap, map<Id, Pricing_Worksheet__c> newMap){
        
        
        for(Pricing_Worksheet__c pw : newMap.values()){
            //Exoxaparin
            if ((pw.Facility_Special_Pricing__c == 'Enoxaparin' || pw.Facility_Special_Pricing__c == 'Enoxaparin & Other Special Pricing') &&
                (oldMap.get(pw.Id).Facility_Special_Pricing__c != 'Enoxaparin & Other Special Pricing' && oldMap.get(pw.Id).Facility_Special_Pricing__c != 'Enoxaparin' )){
                    methods_PricingWorksheet.populateEnoxaparin(pw.Special_Pricing__c);
            }

            //Ready for Approval
            if (oldMap.get(pw.Id).Status__c != 'In Progress' && newMap.get(pw.Id).Status__c == 'In Progress') {
                methods_PricingWorksheet.readyForApproval(newPWs);                                                                            
            }

            //Set Reject Values
            if (oldMap.get(pw.Id).Status__c != 'Rejected' && newMap.get(pw.Id).Status__c == 'Rejected') {
                methods_PricingWorksheet.setRejectValues(newPWs);                                                                             
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
    
    public void updateCreditAnalysisInPricingWorkSheet(List<Pricing_Worksheet__c> lstPricingWorkSheet){

        methods_PricingWorksheet.updateCreditAnalysisInPricingWorkSheet(lstPricingWorkSheet);
    }
}