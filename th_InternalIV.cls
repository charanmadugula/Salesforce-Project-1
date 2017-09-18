//========================================================================
//  Object: th_InternalIV
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Internal_IV_Worksheet__c Trigger Handler
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class th_InternalIV {

    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public th_InternalIV(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnAfterInsert(Internal_IV_Worksheet__c[] newIVs){
        
        for(Internal_IV_Worksheet__c iv : newIVs){
            
            //Update PW
            methods_InternalIV.updatePW(newIVs);

			//Check Default
			if (iv.Active_Schedule__c != 'Not Applicable' && iv.Active_Schedule__c != null)	{
				methods_InternalIV.approveIV(newIVs, iv.Active_Schedule__c);
			}

        }
    }

    public void OnAfterUpdate(Internal_IV_Worksheet__c[] oldIVs, Internal_IV_Worksheet__c[] newIVs, map<Id, Internal_IV_Worksheet__c> oldMap, map<Id, Internal_IV_Worksheet__c> newMap){

		for(Internal_IV_Worksheet__c iv : newMap.values()){
			
			//Check Default
			if ((oldMap.get(iv.Id).Active_Schedule__c !=  newMap.get(iv.Id).Active_Schedule__c) && newMap.get(iv.Id).Active_Schedule__c != 'Not Applicable' && newMap.get(iv.Id).Active_Schedule__c != null) {
				methods_InternalIV.approveIV(newIVs, iv.Active_Schedule__c);
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