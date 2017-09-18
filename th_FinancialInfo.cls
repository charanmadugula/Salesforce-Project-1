//========================================================================
//  Object: th_FinancialInfo
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Financial_Info__c Trigger Handler
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class th_FinancialInfo {

    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public th_FinancialInfo(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnAfterInsert(Financial_Info__c[] newFIs){
        
        for(Financial_Info__c fi : newFis){
            
            //Update PW
            methods_FinancialInfo.updatePW(newFIs);

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