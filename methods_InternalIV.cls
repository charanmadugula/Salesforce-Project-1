//========================================================================
//  Object: methods_InternalIV
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Internal_IV_Worksheet__c Methods
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public with sharing class methods_InternalIV {
	
	//Update Per Diem
	public static void updatePD(list<Internal_IV_Worksheet__c> ivs) {
		
		//Variable
		list<Per_Diem__c> pdUpdate = new list<Per_Diem__c>();
		
		//Build Implementation
		for(Internal_IV_Worksheet__c iv : ivs){

			//Update Pricing Worksheet
			Per_Diem__c pd = new Per_Diem__c();
				pd.Id = iv.Per_Diem__c;
				pd.Internal_IV_Worksheet__c = iv.Id;
			pdUpdate.add(pd);
		}
		
		//DML Operations
		try{
			update pdUpdate;
		}
		catch (DMLexception e) {
            system.debug('Method-->updatePD DML Exception: ' + e.getMessage());
        }			
	}


	//Update Pricing Worksheet
	public static void updatePW(list<Internal_IV_Worksheet__c> ivs) {
		
		//Variable
		list<Pricing_Worksheet__c> pwUpdate = new list<Pricing_Worksheet__c>();
		
		//Build Implementation
		for(Internal_IV_Worksheet__c iv : ivs){

			//Update Pricing Worksheet
			Pricing_Worksheet__c pw = new Pricing_Worksheet__c();
				pw.id = iv.pricing_Worksheet__c;
				pw.internal_IV_Worksheet__c = iv.id;
			pwUpdate.add(pw);
		}
		
		//DML Operations
		try{
			update pwUpdate;
		}
		catch (DMLexception e) {
            system.debug('Method-->methods_InternalIV DML Exception: ' + e.getMessage());
        }			
	}

	//Check Against Default
	public static void approveIV(list<Internal_IV_Worksheet__c> ivs, String dS) {

		//Variables & Collections
		Internal_IV_Worksheet__c ivDefault;
		Map<Id, Pricing_Worksheet__c> pwUpdate = new Map<Id, Pricing_Worksheet__c>();

		//Get Default Schedule Record
		ivDefault = globalHelper.getInternalIVDefault(dS);

		// Cycle Through List
		for (Internal_IV_Worksheet__c ivRecord : ivs) {
			
			Boolean isDiff = false;

			// For each field.. I know it is much but couldn't think of a better way.
			if (ivrecord.All_IV_Push__c != ivDefault.All_IV_Push__c || ivrecord.All_Other_Classes_Certifications_Trainin__c != ivDefault.All_Other_Classes_Certifications_Trainin__c || ivrecord.All_Other_IV_Therapies_Not_Specified_dr__c != ivDefault.All_Other_IV_Therapies_Not_Specified_dr__c || ivrecord.Catheter_Declot_Cost__c != ivDefault.Catheter_Declot_Cost__c || 
				ivrecord.Catheter_Declot_Supplies__c != ivDefault.Catheter_Declot_Supplies__c || ivrecord.Central_Venous_Access_Devices__c != ivDefault.Central_Venous_Access_Devices__c || ivrecord.Cert_Basis__c != ivDefault.Cert_Basis__c || ivrecord.Cert_Max__c != ivDefault.Cert_Max__c || 
				ivrecord.Cert_Rate__c != ivDefault.Cert_Rate__c || ivrecord.Certifications_16_Hours_Includes_Stat__c != ivDefault.Certifications_16_Hours_Includes_Stat__c || ivrecord.Clearing_Thrombotic_Occlusions_in_Centra__c != ivDefault.Clearing_Thrombotic_Occlusions_in_Centra__c || ivrecord.Diluents__c != ivDefault.Diluents__c || ivrecord.Documentation_IV_POS_MAR_Forms__c != ivDefault.Documentation_IV_POS_MAR_Forms__c || 
				ivrecord.Edu_CVAD_Basis__c != ivDefault.Edu_CVAD_Basis__c || ivrecord.Edu_CVAD_Max__c != ivDefault.Edu_CVAD_Max__c || ivrecord.Edu_CVAD_Rate__c != ivDefault.Edu_CVAD_Rate__c || ivrecord.Edu_Hypodermoclysis_Basis__c != ivDefault.Edu_Hypodermoclysis_Basis__c || 
				ivrecord.Edu_Hypodermoclysis_Max__c != ivDefault.Edu_Hypodermoclysis_Max__c || ivrecord.Edu_Hypodermoclysis_Rate__c != ivDefault.Edu_Hypodermoclysis_Rate__c || ivrecord.Edu_Infusion_Fundamentals_Basis__c != ivDefault.Edu_Infusion_Fundamentals_Basis__c || 
				ivrecord.Edu_Infusion_Fundamentals_Max__c != ivDefault.Edu_Infusion_Fundamentals_Max__c || ivrecord.Edu_Infusion_Fundamentals_Rate__c != ivDefault.Edu_Infusion_Fundamentals_Rate__c || ivrecord.Edu_IV_Push_Basis__c != ivDefault.Edu_IV_Push_Basis__c || 
				ivrecord.Edu_IV_Push_Max__c != ivDefault.Edu_IV_Push_Max__c || ivrecord.Edu_IV_Push_Rate__c != ivDefault.Edu_IV_Push_Rate__c || ivrecord.Edu_MAR_Document_Basis__c != ivDefault.Edu_MAR_Document_Basis__c || ivrecord.Edu_MAR_Document_Max__c != ivDefault.Edu_MAR_Document_Max__c || 
				ivrecord.Edu_MAR_Document_Rate__c != ivDefault.Edu_MAR_Document_Rate__c || ivrecord.Edu_Mgmt_Inotropics_Basis__c != ivDefault.Edu_Mgmt_Inotropics_Basis__c || ivrecord.Edu_Mgmt_Inotropics_Max__c != ivDefault.Edu_Mgmt_Inotropics_Max__c || 
				ivrecord.Edu_Mgmt_Inotropics_Rate__c != ivDefault.Edu_Mgmt_Inotropics_Rate__c || ivrecord.Edu_NursCEUs_Basis__c != ivDefault.Edu_NursCEUs_Basis__c || ivrecord.Edu_NursCEUs_Max__c != ivDefault.Edu_NursCEUs_Max__c || ivrecord.Edu_NursCEUs_Rate__c != ivDefault.Edu_NursCEUs_Rate__c || 
				ivrecord.Edu_Other_Basis__c != ivDefault.Edu_Other_Basis__c || ivrecord.Edu_Other_Max__c != ivDefault.Edu_Other_Max__c || ivrecord.Edu_Other_Rate__c != ivDefault.Edu_Other_Rate__c || ivrecord.Edu_Pain_Mgmt_Basis__c != ivDefault.Edu_Pain_Mgmt_Basis__c || 
				ivrecord.Edu_Pain_Mgmt_Max__c != ivDefault.Edu_Pain_Mgmt_Max__c || ivrecord.Edu_Pain_Mgmt_Rate__c != ivDefault.Edu_Pain_Mgmt_Rate__c || ivrecord.Edu_PICC_Removal_Basis__c != ivDefault.Edu_PICC_Removal_Basis__c || ivrecord.Edu_PICC_Removal_Max__c != ivDefault.Edu_PICC_Removal_Max__c || 
				ivrecord.Edu_PICC_Removal_Rate__c != ivDefault.Edu_PICC_Removal_Rate__c || ivrecord.Edu_Thrombotic_Occlusions_Basis__c != ivDefault.Edu_Thrombotic_Occlusions_Basis__c || ivrecord.Edu_Thrombotic_Occlusions_Max__c != ivDefault.Edu_Thrombotic_Occlusions_Max__c || 
				ivrecord.Edu_Thrombotic_Occlusions_Rate__c != ivDefault.Edu_Thrombotic_Occlusions_Rate__c || ivrecord.Edu_TPN_Basis__c != ivDefault.Edu_TPN_Basis__c || ivrecord.Edu_TPN_Max__c != ivDefault.Edu_TPN_Max__c || ivrecord.Edu_TPN_Rate__c != ivDefault.Edu_TPN_Rate__c || 
				ivrecord.Essentials_of_Infusion_Therapy_2_Day_C__c != ivDefault.Essentials_of_Infusion_Therapy_2_Day_C__c || ivrecord.Hypodermoclysis__c != ivDefault.Hypodermoclysis__c || ivrecord.Infusion_Nurse_After_Hours_Fee__c != ivDefault.Infusion_Nurse_After_Hours_Fee__c || 
				ivrecord.Infusion_Nurse_Consulting_Service__c != ivDefault.Infusion_Nurse_Consulting_Service__c || ivrecord.IV_Facility_AB_24hr_Basis__c != ivDefault.IV_Facility_AB_24hr_Basis__c || ivrecord.IV_Facility_AB_24hr_Fee__c != ivDefault.IV_Facility_AB_24hr_Fee__c || 
				ivrecord.IV_Facility_Additives_Basis__c != ivDefault.IV_Facility_Additives_Basis__c || ivrecord.IV_Facility_Additives_Cost__c != ivDefault.IV_Facility_Additives_Cost__c || ivrecord.IV_Facility_Additives_Rate__c != ivDefault.IV_Facility_Additives_Rate__c || 
				ivrecord.IV_Facility_Antibiotics_BID_Basis__c != ivDefault.IV_Facility_Antibiotics_BID_Basis__c || ivrecord.IV_Facility_Antibiotics_BID_Cost__c != ivDefault.IV_Facility_Antibiotics_BID_Cost__c || ivrecord.IV_Facility_Antibiotics_BID_Rate__c != ivDefault.IV_Facility_Antibiotics_BID_Rate__c || 
				ivrecord.IV_Facility_Antibiotics_QD_Basis__c != ivDefault.IV_Facility_Antibiotics_QD_Basis__c || ivrecord.IV_Facility_Antibiotics_QD_Cost__c != ivDefault.IV_Facility_Antibiotics_QD_Cost__c || ivrecord.IV_Facility_Antibiotics_QD_Rate__c != ivDefault.IV_Facility_Antibiotics_QD_Rate__c || 
				ivrecord.IV_Facility_Antibiotics_QID_Basis__c != ivDefault.IV_Facility_Antibiotics_QID_Basis__c || ivrecord.IV_Facility_Antibiotics_QID_Cost__c != ivDefault.IV_Facility_Antibiotics_QID_Cost__c || ivrecord.IV_Facility_Antibiotics_QID_Rate__c != ivDefault.IV_Facility_Antibiotics_QID_Rate__c || 
				ivrecord.IV_Facility_Antibiotics_TID_Basis__c != ivDefault.IV_Facility_Antibiotics_TID_Basis__c || ivrecord.IV_Facility_Antibiotics_TID_Cost__c != ivDefault.IV_Facility_Antibiotics_TID_Cost__c || ivrecord.IV_Facility_Antibiotics_TID_Rate__c != ivDefault.IV_Facility_Antibiotics_TID_Rate__c || 
				ivrecord.IV_Facility_Catheter_Care_Supplies_Basis__c != ivDefault.IV_Facility_Catheter_Care_Supplies_Basis__c || ivrecord.IV_Facility_Catheter_Care_Supplies_Cost__c != ivDefault.IV_Facility_Catheter_Care_Supplies_Cost__c || 
				ivrecord.IV_Facility_Catheter_Care_Supplies_Rate__c != ivDefault.IV_Facility_Catheter_Care_Supplies_Rate__c || ivrecord.IV_Facility_Chemo_Basis__c != ivDefault.IV_Facility_Chemo_Basis__c || ivrecord.IV_Facility_Chemo_Cost__c != ivDefault.IV_Facility_Chemo_Cost__c || 
				ivrecord.IV_Facility_Chemo_Rate__c != ivDefault.IV_Facility_Chemo_Rate__c || ivrecord.IV_Facility_Diluents_Cost__c != ivDefault.IV_Facility_Diluents_Cost__c || ivrecord.IV_Facility_Flush_Cost__c != ivDefault.IV_Facility_Flush_Cost__c || 
				ivrecord.IV_Facility_Hyd_24hr_Bag__c != ivDefault.IV_Facility_Hyd_24hr_Bag__c || ivrecord.IV_Facility_Hyd_24hr_Basis__c != ivDefault.IV_Facility_Hyd_24hr_Basis__c || ivrecord.IV_Facility_Hydration_Basis__c != ivDefault.IV_Facility_Hydration_Basis__c || 
				ivrecord.IV_Facility_Hydration_Cost__c != ivDefault.IV_Facility_Hydration_Cost__c || ivrecord.IV_Facility_Hydration_Rate__c != ivDefault.IV_Facility_Hydration_Rate__c || ivrecord.IV_Facility_Other_Basis__c != ivDefault.IV_Facility_Other_Basis__c || 
				ivrecord.IV_Facility_Other_Cost__c != ivDefault.IV_Facility_Other_Cost__c || ivrecord.IV_Facility_Other_Rate__c != ivDefault.IV_Facility_Other_Rate__c || ivrecord.IV_Facility_Pain_Basis__c != ivDefault.IV_Facility_Pain_Basis__c || ivrecord.IV_Facility_Pain_Cost__c != ivDefault.IV_Facility_Pain_Cost__c || 
				ivrecord.IV_Facility_Pain_Rate__c != ivDefault.IV_Facility_Pain_Rate__c || ivrecord.IV_Facility_Special_Pump_Basis__c != ivDefault.IV_Facility_Special_Pump_Basis__c || ivrecord.IV_Facility_Special_Pump_Cost__c != ivDefault.IV_Facility_Special_Pump_Cost__c || 
				ivrecord.IV_Facility_Special_Pump_Rate__c != ivDefault.IV_Facility_Special_Pump_Rate__c || ivrecord.IV_Facility_Standard_Pump_Basis__c != ivDefault.IV_Facility_Standard_Pump_Basis__c || ivrecord.IV_Facility_Standard_Pump_Cost__c != ivDefault.IV_Facility_Standard_Pump_Cost__c || 
				ivrecord.IV_Facility_Standard_Pump_Rate__c != ivDefault.IV_Facility_Standard_Pump_Rate__c || ivrecord.IV_Facility_TPN_1L_Basis__c != ivDefault.IV_Facility_TPN_1L_Basis__c || ivrecord.IV_Facility_TPN_1L_Cost__c != ivDefault.IV_Facility_TPN_1L_Cost__c || 
				ivrecord.IV_Facility_TPN_1L_Rate__c != ivDefault.IV_Facility_TPN_1L_Rate__c || ivrecord.IV_Facility_TPN_2L_Basis__c != ivDefault.IV_Facility_TPN_2L_Basis__c || ivrecord.IV_Facility_TPN_2L_Cost__c != ivDefault.IV_Facility_TPN_2L_Cost__c || 
				ivrecord.IV_Facility_TPN_2L_Rate__c != ivDefault.IV_Facility_TPN_2L_Rate__c || ivrecord.IV_Facility_TPN_3L_Basis__c != ivDefault.IV_Facility_TPN_3L_Basis__c || ivrecord.IV_Facility_TPN_3L_Cost__c != ivDefault.IV_Facility_TPN_3L_Cost__c || 
				ivrecord.IV_Facility_TPN_3L_Rate__c != ivDefault.IV_Facility_TPN_3L_Rate__c || ivrecord.IV_Chemo_Infusion_drug_solution__c != ivDefault.IV_Chemo_Infusion_drug_solution__c || ivrecord.IV_Flushes__c != ivDefault.IV_Flushes__c || 
				ivrecord.IV_House_Pump_Basis__c != ivDefault.IV_House_Pump_Basis__c || ivrecord.IV_House_Pump_Cost__c != ivDefault.IV_House_Pump_Cost__c || ivrecord.IV_House_Pump_Rate__c != ivDefault.IV_House_Pump_Rate__c || ivrecord.IV_House_Supplies_Cost__c != ivDefault.IV_House_Supplies_Cost__c || 
				ivrecord.IV_Pain_Infusion_continuous_infusion__c != ivDefault.IV_Pain_Infusion_continuous_infusion__c || ivrecord.IV_Private_Pay_Pricing__c != ivDefault.IV_Private_Pay_Pricing__c || ivrecord.IV_Push_Administration__c != ivDefault.IV_Push_Administration__c || 
				ivrecord.Management_of_Inotropics_in_the_Heart_Fa__c != ivDefault.Management_of_Inotropics_in_the_Heart_Fa__c || ivrecord.Midline_IV_Insertion_wUS_Supplies__c != ivDefault.Midline_IV_Insertion_wUS_Supplies__c || ivrecord.Midline_IV_Insertion_Cost__c != ivDefault.Midline_IV_Insertion_Cost__c || 
				ivrecord.Midline_IV_Insertion_Supplies__c != ivDefault.Midline_IV_Insertion_Supplies__c || ivrecord.Midline_IV_Insertion_wUS_Cost__c != ivDefault.Midline_IV_Insertion_wUS_Cost__c || ivrecord.Nurse_AfterHours_Fee__c != ivDefault.Nurse_AfterHours_Fee__c || 
				ivrecord.Nurse_Consulting_Fee__c != ivDefault.Nurse_Consulting_Fee__c || ivrecord.Nursing_CEUs__c != ivDefault.Nursing_CEUs__c || ivrecord.Pain_Management_Patient_Controlled_Ana__c != ivDefault.Pain_Management_Patient_Controlled_Ana__c || ivrecord.Parenteral_Nutrition_TPN_PPN__c != ivDefault.Parenteral_Nutrition_TPN_PPN__c || 
				ivrecord.Peripheral_IV_Insertion_Cost__c != ivDefault.Peripheral_IV_Insertion_Cost__c || ivrecord.Peripheral_IV_Insertion_Supplies__c != ivDefault.Peripheral_IV_Insertion_Supplies__c || ivrecord.PICC_Insertion_Cost__c != ivDefault.PICC_Insertion_Cost__c || 
				ivrecord.PICC_Insertion_Supplies__c != ivDefault.PICC_Insertion_Supplies__c || ivrecord.PICC_Insertion_wUS_Cost__c != ivDefault.PICC_Insertion_wUS_Cost__c || ivrecord.PICC_Insertion_wUS_Supplies__c != ivDefault.PICC_Insertion_wUS_Supplies__c || 
				ivrecord.PICC_Removal_Non_Tunneled_Catheter__c != ivDefault.PICC_Removal_Non_Tunneled_Catheter__c || ivrecord.PICC_Removal_Cost__c != ivDefault.PICC_Removal_Cost__c || ivrecord.PICC_Removal_Supplies__c != ivDefault.PICC_Removal_Supplies__c || 
				ivrecord.Private_Pay_Pricing__c != ivDefault.Private_Pay_Pricing__c || ivrecord.Specialty_Pump_Sigma_Spectrum_CADD_Cu__c != ivDefault.Specialty_Pump_Sigma_Spectrum_CADD_Cu__c || ivrecord.Standard_Pole_Mounted_Pump__c != ivDefault.Standard_Pole_Mounted_Pump__c)
				{
					isDiff = true;
				}

				if (isDiff) {

					//Update Pricing Worksheet
					Pricing_Worksheet__c pw = new Pricing_Worksheet__c();
						pw.id = ivRecord.Pricing_Worksheet__c;
						pw.Approve_IV__c = true;
					pwUpdate.put(pw.Id,pw);
				}
			}
		
		
		//DML Operations
		try{
			if (pwUpdate.size()>0){
				update pwUpdate.values();
			}
		}
		catch (DMLexception e) {
            system.debug('Method-->updatePD DML Exception: ' + e.getMessage());
        }				
	}

}