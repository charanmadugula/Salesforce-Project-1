//========================================================================
//  Object: methods_PerDiem
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Per_Diem__C Methods
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class methods_PerDiem {
	
	
	//Update Pricing Worksheet
	public static void updatePW(List<Per_Diem__C> pds) {
		
		//Variable
		list<Pricing_Worksheet__c> pwUpdate = new list<Pricing_Worksheet__c>();
		
		//Build Implementation
		for(Per_Diem__c pdm : pds){

			//Update Pricing Worksheet
			Pricing_Worksheet__c pw = new Pricing_Worksheet__c();
				pw.id = pdm.pricing_Worksheet__c;
				pw.Per_Diem__c = pdm.id;

				//Update Standard Exclusions if Applicable
				if (pdm.Exclusions__c == 'Standard List'){
					pw.Per_Diem_Standard_Exclusion__c = true;   
				}
			
			//Populate Container
			pwUpdate.add(pw);
		}
		
		//DML Operations
		try{
			update pwUpdate;
		}
		catch (DMLexception e) {
            system.debug('Method-->updatePW DML Exception: ' + e.getMessage());
        }			
	}


	//Update Standard Exclusion Flag on Pricing Workbook
	public static void populateExculsionFlag(List<Per_Diem__C> pds, Boolean PosNeg){
		
		//Variable
		list<Pricing_Worksheet__c> pwUpdate = new list<Pricing_Worksheet__c>();
		
		//Build Implementation
		for(Per_Diem__c pdb : pds){

			//Update Pricing Worksheet
			Pricing_Worksheet__c pw = new Pricing_Worksheet__c();
				pw.id = pdb.pricing_Worksheet__c;

				//Standard Exclusion Link 
				if(PosNeg){
					pw.Per_Diem_Standard_Exclusion__c = true;
				}
				if(!PosNeg) {
					pw.Per_Diem_Standard_Exclusion__c = false;
				}

			//Populate Container
			pwUpdate.add(pw);
		}
		
		//DML Operations
		try{
			update pwUpdate;
		}
		catch (DMLexception e) {
            system.debug('Method-->populateExculsionFlag DML Exception: ' + e.getMessage());
        }
	}


	//Populate Per Diem State Defaults
	public static void populatePDDefaults(List<Per_Diem__c> pds, Per_Diem__c pdSD){
	
		//Variables
		List<Per_Diem__c> updatePD = new List<Per_Diem__c>();

		//Populate Default Values
		for(Per_Diem__c pd1 : pds){
			
			//Populate Per Diem Defaults
			Per_Diem__c pdu = new Per_Diem__c();
				pdu.Id = pd1.Id;
				pdu.Facility_OTC_Brands__c = pdSD.Facility_OTC_Brands__c;
				pdu.Facility_OTC_Generics_3_Manufacturers__c = pdSD.Facility_OTC_Generics_3_Manufacturers__c;
				pdu.Facility_OTC_Generics_lt3_Manufacturers__c = pdSD.Facility_OTC_Generics_lt3_Manufacturers__c;
				pdu.Facility_RX_Brands__c = pdSD.Facility_RX_Brands__c;
				pdu.Facility_Rx_Generics_3_Manufacturers__c = pdSD.Facility_Rx_Generics_3_Manufacturers__c;
				pdu.Facility_Rx_Generics_lt3_Manufacturers__c = pdSD.Facility_Rx_Generics_lt3_Manufacturers__c;
			System.debug(pdu);
			//Populate Container
			updatePD.add(pdu);
		}

		//DML Operations
		try{
			update updatePD;
		}
		catch (DMLexception e) {
            system.debug('Method-->populatePDDefaults DML Exception: ' + e.getMessage());
        }				

	}
		

	
}