//========================================================================
//  Object: methods_FinancialInfo
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Financial_Info__c Methods
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class methods_FinancialInfo {
	
	
	//Update Pricing Worksheet
	public static void updatePW(list<Financial_Info__c> fis) {
		
		//Variable
		list<Pricing_Worksheet__c> pwUpdate = new list<Pricing_Worksheet__c>();
		
		//Build Implementation
		for(Financial_Info__c f : fis){

			//Update Pricing Worksheet
			Pricing_Worksheet__c pw = new Pricing_Worksheet__c();
				pw.id = f.pricing_Worksheet__c;
				pw.financial_Info__c = f.id;
			pwUpdate.add(pw);
		}
		
		//DML Operations
		try{
			update pwUpdate;
		}
		catch (DMLexception e) {
            system.debug('Method-->methods_FinancialInfo DML Exception: ' + e.getMessage());
        }			
	}
}