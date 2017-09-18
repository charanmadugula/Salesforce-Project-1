//=================================================================================================
//  Object: v_PricingWorksheet
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Pricing Worksheet validations class 
//=================================================================================================
//          Date            Purpose
// Changes: 02/23/2014      Initial Version
//=================================================================================================


public with sharing class v_PricingWorksheet {
	
	public static void validatev_PricingWorksheet(Pricing_Worksheet__c pw){

	//Validate Others
	
		//Line 22a
		if (pw.RX_Brands_All_except_1V_TPN_Cost_Basi__c == 'Other' && String.isBlank(pw.CBOther22a__c)) {
			pw.Adderror('Please fill out other field for Line 22a');
		}

		//Line 22b
		if (pw.RX_3_Generic_Manufacturers_Cost_basis__c == 'Other' && String.isBlank(pw.CBOther22b__c)) {
			pw.Adderror('Please fill out other field for Line 22b');
		}

		//Line 22c
		if (pw.RX_le_3_Generic_Manufacturers_Cost_basis__c == 'Other' && String.isBlank(pw.CBOther22c__c)) {
			pw.Adderror('Please fill out other field for Line 22c');
		}

		//Line 22d
		if (pw.OTC_Brands_Cost_Basis__c == 'Other' && String.isBlank(pw.CBOther22d__c)) {
			pw.Adderror('Please fill out other field for Line 22d');
		}

		//Line 22e
		if (pw.OTC_g_3_Generic_Manufacturers_Cost_Basis__c == 'Other' && String.isBlank(pw.CBOther22e__c)) {
			pw.Adderror('Please fill out other field for Line 22e');
		}

		//Line 22f
		if (pw.OTC_3_Generic_Manufacturers_Cost_Basis__c == 'Other' && String.isBlank(pw.CBOther22f__c)) {
			pw.Adderror('Please fill out other field for Line 22f');
		}
		//Line 23a
		if (pw.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c == 'Other' && String.isBlank(pw.CBOther23a__c)) {
			pw.Adderror('Please fill out other field for Line 23a');
		}

		//Line 23b
		if (pw.Rx_g3_3_Generic_Manufacturers_All_Except__c == 'Other' && String.isBlank(pw.CBOther23b__c)) {
			pw.Adderror('Please fill out other field for Line 23b');
		}

		//Line 23c
		if (pw.Rx_l2_3_Generic_Manufacturers_All_Except__c == 'Other' && String.isBlank(pw.CBOther23c__c)) {
			pw.Adderror('Please fill out other field for Line 23c');
		}

		//Line 23d
		if (pw.OTC_Brands_CostBasis1__c == 'Other' && String.isBlank(pw.CBOther23d__c)) {
			pw.Adderror('Please fill out other field for Line 23d');
		}

		//Line 23e
		if (pw.OTCg13Cost_Basis__c == 'Other' && String.isBlank(pw.CBOther23e__c)) {
			pw.Adderror('Please fill out other field for Line 23e');
		}

		//Line 23f
		if (pw.OTCl3costbasis__c == 'Other' && String.isBlank(pw.CBOther23f__c)) {
			pw.Adderror('Please fill out other field for Line 23f');
		}

		//Line 24a
		if (pw.Bulk_OTC_Brands_Cost_Basis__c == 'Other' && String.isBlank(pw.CBOther24a__c)) {
			pw.Adderror('Please fill out other field for Line 24a');
		}

		//Line 24b
		if (pw.Bulk_OTC_3_Generic_Manufacturers_Cost__c == 'Other' && String.isBlank(pw.CBOther24b__c)) {
			pw.Adderror('Please fill out other field for Line 24b');
		}

		//Line 24c
		if (pw.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c == 'Other' && String.isBlank(pw.CBOther24c__c)) {
			pw.Adderror('Please fill out other field for Line 24c');
		}

		//Line 25a
		if (pw.Bulk_Vaccine_Brands_Cost_Basis__c == 'Other' && String.isBlank(pw.CBOther25a__c)) {
			pw.Adderror('Please fill out other field for Line 25a');
		}

		//Line 25b
		if (pw.Bulk_Vaccine_3_Generic_Manufacturers_C__c == 'Other' && String.isBlank(pw.CBOther25b__c)) {
			pw.Adderror('Please fill out other field for Line 25b');
		}

		//Line 25c
		if (pw.Bulk_Vaccine_3_Generic_Manufacturers_Co__c == 'Other' && String.isBlank(pw.CBOther25c__c)) {
			pw.Adderror('Please fill out other field for Line 25c');
		}


	}
}