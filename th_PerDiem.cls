//========================================================================
//  Object: th_PerDiem
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Per_Diem__c Object Trigger
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public class th_PerDiem {

    private boolean m_isExecuting = false;
    private integer BatchSize = 0;
    
    public th_PerDiem(boolean isExecuting, integer size){
        m_isExecuting = isExecuting;
        BatchSize = size;
    }

    public void OnAfterInsert(Per_Diem__c[] newPDs){
 
        //Get State Default Values
                List<Per_Diem__c> stateDefaults = new List<Per_Diem__c>();

        Map<String,Per_Diem__c> stateMap = new Map<String,Per_Diem__c>();
        stateDefaults = [select id, State__c, Facility_Rx_Generics_lt3_Manufacturers__c, Facility_Rx_Generics_3_Manufacturers__c, 
                                Facility_RX_Brands__c, Facility_OTC_Generics_lt3_Manufacturers__c, Facility_OTC_Generics_3_Manufacturers__c, 
                                Facility_OTC_Brands__c,Pricing_Worksheet__r.Account_State__c
                            from Per_Diem__c p
                            where State__c != null];
        for (Per_Diem__c pd : stateDefaults) {
            stateMap.put(pd.State__c, pd);
        }
               
        for(Per_Diem__c pd : newPDs){
            
            //Update PW
            methods_PerDiem.updatePW(newPDs);

            //Update State Defaults
                Per_Diem__c pdSd;  //Per Diem State Default Record
                //Get State Default Record from map where PerDiem State = Pricing_Worksheet__r.Account_State__c
                //if(stateMap.containsKey(Pricing_Worksheet__r.Account_State__c))
                    //if(stateMap.get(Pricing_Worksheet__r.Account_State__c).size()>0)
                //}
                //methods_PerDiem.populatePDDefaults(newPDs, pdSd);
        }
    }
        
    public void OnAfterUpdate(Per_Diem__c[] oldPDs, Per_Diem__c[] newPDs, map<Id, Per_Diem__c> oldMap, map<Id, Per_Diem__c> newMap){


        for(Per_Diem__c pd : newMap.values()){

            //Per Diem Exclusion Change (Positive and Negative)
                //Positve - Add
                if (pd.Exclusions__c == 'Standard List' && oldMap.get(pd.Id).Exclusions__c != 'Standard List') {
                    methods_PerDiem.populateExculsionFlag(newPDs,true);
                }
                //Negative - Remove
                if (pd.Exclusions__c != 'Standard List' && oldMap.get(pd.Id).Exclusions__c == 'Standard List') {
                    methods_PerDiem.populateExculsionFlag(newPDs,false);
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