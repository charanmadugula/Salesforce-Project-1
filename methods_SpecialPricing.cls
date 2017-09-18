//========================================================================
//  Object: methods_SpecialPricing
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Special_Pricing__c Methods
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class methods_SpecialPricing {

	//Update Pricing Worksheet
	public static void updatePW(list<Special_Pricing__c> spl) {
		
		//Variable
		list<Pricing_Worksheet__c> pwUpdate = new list<Pricing_Worksheet__c>();
		
		//Build Implementation
		for(Special_Pricing__c sp : spl){

			//Update Pricing Worksheet
			Pricing_Worksheet__c pw = new Pricing_Worksheet__c();
				pw.id = sp.pricing_Worksheet__c;
				pw.Special_Pricing__c = sp.id;
			pwUpdate.add(pw);
		}
		
		//DML Operations
		try{
			update pwUpdate;
		}
		catch (DMLexception e) {
            system.debug('Method-->methods_SpecialPricing DML Exception: ' + e.getMessage());
        }			
	}

	//Populate Enoxaparin
	public static void populateEnoxaparin(id spId){

		//Containers
		list<Special_Pricing_Detail__c> eList;
		list<Special_Pricing__c> spList;
		list<Special_Pricing_Detail__c> spdInsert;
		List<Special_Pricing__c> spUpdate;

		//Get Enoxaparin Values
		eList = [select Price_Per_Unit_GM_ML_and_Each__c, Name, NDC__c, Dispensing_Fee__c from Special_Pricing_Detail__c where DEFAULT_VALUE__C = true];

		//Populate Special Pricing
		for(Special_Pricing_Detail__c enox : eList){
			
			//Build Special Pricing Detail Record
			Special_Pricing_Detail__c addspd = new Special_Pricing_Detail__c();
				addspd.Special_Pricing_ID__c = spId;
				//addspd.Name = enox.Name;
				addspd.Price_Per_Unit_GM_ML_and_Each__c = enox.Price_Per_Unit_GM_ML_and_Each__c;
				addspd.NDC__c = enox.NDC__c;
				addspd.Dispensing_Fee__c = enox.Dispensing_Fee__c;
				addspd.Enoxaparin__c = true;
			
			//Populate Container
			spdInsert.add(addspd);
		}

		//DML Operations
		try{
			insert spdInsert;
		}
		catch (DMLexception e) {
            system.debug('Method-->invocableMethods_PricingWorksheet DML Exception: ' + e.getMessage());
        }
		
		
	}

}