//========================================================================
//  Object: ext_pwView
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for viewPricingWorksheet VF Page
//========================================================================
//          Date            Purpose
// Changes: 11/27/2015      Initial Version
//========================================================================

public with sharing class ext_pwView {
    
    //Variables
    public Pricing_Worksheet__c pricingWorkSheet{get;set;}
    public list<Pricing_Worksheet__c> pwList;
    public Pricing_Worksheet__c pricingWorkSheetExec{get;set;}
    public list<Pricing_Worksheet__c> pwListExec;
    public Account pwAccount {get;set;}
    public Account pwa2 {get;set;}
    public List<Attachment> attahments {get;set;}
    public Id acctId;
    public User pwUser {get;set;}
    public Boolean ExecExists {get;set;}
    public id pwid {get;set;}
    public id curUser {get;set;}
    public User cUser {get;set;}
    public Boolean approved {get;set;}
    public Boolean edit {get;set;}
    public Boolean state {get;set;}
    public Boolean CurPW {get;set;}
    public Boolean userIsApprover {get;set;}
    public Boolean isAdmin {get;set;}   
    public Boolean save {get;set;}
     // 1/06/2016 Added variables for custom lookup(Opportunity)
    public String opportunityName {get; set;}
    public Id opportunityId {get; set;}  
    //7/21/2016 
    public string strStyle{get;set;}
    public string strStyleInprog{get;set;}
    //render booleans
    public Boolean renderApprove {get;set;}
    public Boolean renderEdit {get;set;}
    public Boolean rIV {get;set;}
    public Boolean rPD {get;set;}
    public Boolean rS3 {get;set;}
    public Boolean rSP {get;set;}
    public Boolean rSE {get;set;}
    public Boolean rSNF {get;set;}
    public Boolean rNONSNF {get;set;}
    public Boolean rCA {get;set;} //Credit Analysis

    //render Approval Booleans
    public Boolean raC {get;set;}
    public Boolean raDOP {get;set;}
    public Boolean raCP {get;set;}
    public Boolean raAH {get;set;}
    public Boolean raL {get;set;}
    public Boolean raCAC {get;set;}
    public Boolean raPA {get;set;}
    public Boolean raAH2 {get;set;}
    public Boolean raEP {get;set;}
    public Boolean raVPO {get;set;}
    public Boolean raIVS {get;set;}
    public Boolean raIVR {get;set;}
    public Boolean raIVP {get;set;}
    
    //render Recall Booleans
    public Boolean rllVPO {get;set;}
   
    //7/06/2016
    public string strAccountID{get;set;}
    /*public string strBillingStreet{get;set;}
    public string strBillingCity{get;set;}
    public string strBillingState{get;set;}
    public string strBillingPostalCode{get;set;}*/
    List<Pricing_Worksheet__c>  lstStateDefaultPricingWorksheet;
    public string strAccountOldState;
    public boolean ischanged;
    public integer intcnt = 0;
    // Changing state defaults
    public void changeStateDefaults()
    {
        boolean blnchange;
        List<Account> lstAccc = [Select id,BillingState from Account where id = :pricingWorkSheet.Account__c];
        system.debug(LoggingLevel.Info,'>>>>pwa2'+pwa2);   
        if(lstAccc.size() >0)
        {
            if(strAccountOldState == lstAccc[0].BillingState) blnchange = false;
            else
            {
              strAccountOldState =lstAccc[0].BillingState;  blnchange = true;
            }
        }
        
        if(blnchange)
        {
        if(pricingWorkSheet.Account__c != null)
        {
            //pwAccount = globalHelper.getAccountFields(Id.valueof(strAccountID));
        string SobjectApiName = 'Pricing_Worksheet__c';
            String commaSepratedFields = 'RX_Brands_All_except_1V_TPN_Cost_Basi__c,RX_Brands_All_except_1V_TPN_Ingredient__c,RX_Brands_All_except_1V_TPN_Disp_fee__c,RX_Brands_All_except_1V_TPN_unit_dose__c '+
        ',CBOther22a__c,RX_3_Generic_Manufacturers_Cost_basis__c,RX_3_Generic_ManufacturersIngredient__c,RX_3_Generic_Manufacturers_Disp_Fee__c,RX_3_Generic_Manufacturers_Unitdose_fee__c'+
        ',RX_le_3_Generic_Manufacturers_Cost_basis__c,RX_le_3_Generic_Manufacturers_Ingredient__c,RX_le_3_Generic_Manufacturers_Disp_Fee__c,RX_le_3_Generic_Manufacturers_Unit_dose__c'+
        ',CBOther22c__c,OTC_Brands_Cost_Basis__c,OTC_Brands_Ingrediant__c,Bulk_OTC_Brands_Ingrediant__c,OTC_Brands_Disp_Fee__c,OTC_Brands_Unit_Dose_Fee__c,CBOther22d__c'+
        ',OTC_3_Generic_Manufacturers_Cost_Basis__c,OTC_3_Generic_Manufacturers_Ingrediant__c,OTC_3_Generic_Manufacturers_Disp_Fee__c,OTC_3_Generic_Manufacturers_Unit_Dose_F__c'+
        ',CBOther22f__c,Facility_Special_Pricing__c,Minimums_Rx__c,Minimums_OTC_per_Rx__c,Controlled_Substance_Fee_Schedules_2_3__c,Compound1_Fee_Non_Infusion_Additional_to__c'+
        ',Rx_Brands_All_Except_IV_TPN_Cost_Ba__c,Rx_Brands_All_Except_IV_TPN_Ingredi__c,Rx_Brands_All_Except_IV_TPN_Disp_Fe__c,CBOther23a__c,Rx_g3_3_Generic_Manufacturers_All_Except__c'+
        ',Rx_g1_3_Generic_Manufacturers_All_Except__c,Rx_g2_3_Generic_Manufacturers_All_Except__c,CBOther23b__c,Rx_l2_3_Generic_Manufacturers_All_Except__c'+
        ',Rx_l_3_Generic_Manufacturers_All_Except__c,Rx_l1_3_Generic_Manufacturers_All_Except__c,CBOther23c__c,OTC_Brands_CostBasis1__c,OTC_Brands_Ingrediant1__c,OTC_Brands_DispFee1__c'+
        ',CBOther23d__c,OTCg13Cost_Basis__c,OTCg13Ingredient__c,OTCg13Dispfee__c,CBOther23e__c,OTCl3costbasis__c,OTCl3Ingredient__c,OTCl3Disp_fee__c,CBOther23f__c,MinimumsRX1__c'+
        ',MinimumsOTCPerRx1__c,Controlled_substance_fee1__c,Compound_fee_Infusion1__c,Bulk_OTC_Brands_Cost_Basis__c,CBOther24a__c'+
        ',Bulk_OTC_3_Generic_Manufacturers_Cost__c,Bulk_OTC_3_Generic_Manufacturers_Ingre__c,CBOther24b__c,Bulk_OTC_3_Generic_Manufacturers_Cost_B__c'+
        ',Bulk_OTC_3_Generic_Manufacturers_Ingred__c,CBOther24c__c,Bulk_Vaccine_Brands_Cost_Basis__c,Bulk_Vaccine_Brands_Ingrediant__c,CBOther25a__c'+
        ',Bulk_Vaccine_3_Generic_Manufacturers_C__c,Bulk_Vaccine_3_Generic_Manufacturers_I__c,CBOther25b__c,Bulk_Vaccine_3_Generic_Manufacturers_Co__c'+
        ',Bulk_Vaccine_3_Generic_Manufacturers_In__c,CBOther25c__c,Medical_Records_Serviced_Patients__c,Medical_Records_Fee_Non_Serviced_Patien__c'+
        ',Consulting_Pharmacist_Required_Services__c,Consulting_Pharmacist_Optional_Services__c,iMRR_Medication_Regimen_Review_SNF_O__c'+
        ',Anticoagulation_Management_Services_SNF__c,Consulting_Nurse_Charge_Non_1V__c,Onsite_Consulting_Non_SNF__c,Remote_Consulting_Non_SNF__c,Restocking_fee_Rx_specific__c'+
        ',Monthly_No_Med_fee_per_resident_Non_serv__c,Non_Scheduled_Deliver_fee__c,Automated_Dispensing_Unit__c,Automated_Dispensing_Unit_Type__c'+
        ',Monthly_ADU_Fee__c,E_Prescribing_Credit_SNF_Only_per_lic__c,E_Prescribing_Vendor__c,E_Prescribing_Vendor_Other__c,Prompt_Pay_Discount__c'+
        ',Net_Payment_Terms__c,Default_Interest_Rate_Finance_Charge__c,Scheduled_Deliveries_per_days_M_F__c,Scheduled_deliveries_per_daySat_Sun__c'+
        ',Dispensing_method__c,Dispensing_Frequency__c,Dispensing_Type__c';
        
         Map<String,RecordType> mapPricingRecordType =  new Map<String,RecordType>();
            for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                        WHERE SobjectType = 'Pricing_Worksheet__c'])
            mapPricingRecordType.put(recordType.DeveloperName,recordType);
            
            String stateDefaultId = mapPricingRecordType.get('State_Default').id;
            pwa2 = [Select id,BillingStreet,BillingCity,BillingPostalCode, name ,OCR_Pharmacy_Name__r.name,OCR_Pharmacy_Name__r.Pharmacy_Box_Company__c,OCR_Pharmacy_Name__r.Pharmacy_Dispensing_System__c, ParentID,BillingState,RecordTypeId,SNF_Beds__c,ALF_Beds__c,Other_Beds__c from Account where id = :pricingWorkSheet.Account__c];
            system.debug(LoggingLevel.Info,'>>>>pwa2'+pwa2);
            String accountBillingState = pwa2.BillingState;
            strAccountOldState =  pwa2.BillingState;
           /* strBillingStreet = pwa2.BillingStreet;
            strBillingCity = pwa2.BillingCity;
            strBillingPostalCode = pwa2.BillingPostalCode;
            strBillingState = pwa2.BillingState;*/
            
            String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where RecordTypeId = :stateDefaultId and State__c = :accountBillingState limit 1';
            lstStateDefaultPricingWorksheet = Database.query(query);
            system.debug(LoggingLevel.Info,'>>'+accountBillingState);
            system.debug(LoggingLevel.Info,'lstStateDefaultPricingWorksheet>>'+lstStateDefaultPricingWorksheet.size());
            if(lstStateDefaultPricingWorksheet.size() > 0)
            {
               pricingWorkSheet.RX_Brands_All_except_1V_TPN_Cost_Basi__c = lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_Cost_Basi__c;
                pricingWorkSheet.RX_Brands_All_except_1V_TPN_Ingredient__c = lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_Ingredient__c;
                pricingWorkSheet.RX_Brands_All_except_1V_TPN_Disp_fee__c = lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_Disp_fee__c;
                pricingWorkSheet.RX_Brands_All_except_1V_TPN_unit_dose__c = lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_unit_dose__c;
                pricingWorkSheet.CBOther22a__c = lstStateDefaultPricingWorksheet[0].CBOther22a__c; 
                pricingWorkSheet.RX_3_Generic_Manufacturers_Cost_basis__c = lstStateDefaultPricingWorksheet[0].RX_3_Generic_Manufacturers_Cost_basis__c;
                pricingWorkSheet.RX_3_Generic_ManufacturersIngredient__c = lstStateDefaultPricingWorksheet[0].RX_3_Generic_ManufacturersIngredient__c;
                pricingWorkSheet.RX_3_Generic_Manufacturers_Disp_Fee__c = lstStateDefaultPricingWorksheet[0].RX_3_Generic_Manufacturers_Disp_Fee__c;
                pricingWorkSheet.RX_3_Generic_Manufacturers_Unitdose_fee__c = lstStateDefaultPricingWorksheet[0].RX_3_Generic_Manufacturers_Unitdose_fee__c;
                pricingWorkSheet.RX_le_3_Generic_Manufacturers_Cost_basis__c = lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Cost_basis__c;
                pricingWorkSheet.RX_le_3_Generic_Manufacturers_Ingredient__c = lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Ingredient__c;
                pricingWorkSheet.RX_le_3_Generic_Manufacturers_Disp_Fee__c = lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Disp_Fee__c;
                pricingWorkSheet.RX_le_3_Generic_Manufacturers_Unit_dose__c = lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Unit_dose__c;
                pricingWorkSheet.CBOther22c__c = lstStateDefaultPricingWorksheet[0].CBOther22c__c;
                pricingWorkSheet.OTC_Brands_Cost_Basis__c = lstStateDefaultPricingWorksheet[0].OTC_Brands_Cost_Basis__c;
                pricingWorkSheet.OTC_Brands_Ingrediant__c = lstStateDefaultPricingWorksheet[0].OTC_Brands_Ingrediant__c;
                pricingWorkSheet.Bulk_OTC_Brands_Ingrediant__c  =lstStateDefaultPricingWorksheet[0].Bulk_OTC_Brands_Ingrediant__c;
                pricingWorkSheet.OTC_Brands_Disp_Fee__c =lstStateDefaultPricingWorksheet[0].OTC_Brands_Disp_Fee__c;
                pricingWorkSheet.OTC_Brands_Unit_Dose_Fee__c =lstStateDefaultPricingWorksheet[0].OTC_Brands_Unit_Dose_Fee__c;
                pricingWorkSheet.CBOther22d__c =lstStateDefaultPricingWorksheet[0].CBOther22d__c;
                pricingWorkSheet.OTC_3_Generic_Manufacturers_Cost_Basis__c =lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Cost_Basis__c;
                pricingWorkSheet.OTC_3_Generic_Manufacturers_Ingrediant__c  =lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Ingrediant__c;
                pricingWorkSheet.OTC_3_Generic_Manufacturers_Disp_Fee__c =lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Disp_Fee__c;
                pricingWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose_F__c =lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Unit_Dose_F__c;
                pricingWorkSheet.CBOther22f__c =lstStateDefaultPricingWorksheet[0].CBOther22f__c;
                pricingWorkSheet.Facility_Special_Pricing__c =lstStateDefaultPricingWorksheet[0].Facility_Special_Pricing__c;
                pricingWorkSheet.Minimums_Rx__c =lstStateDefaultPricingWorksheet[0].Minimums_Rx__c;
                pricingWorkSheet.Minimums_OTC_per_Rx__c =lstStateDefaultPricingWorksheet[0].Minimums_OTC_per_Rx__c;
                pricingWorkSheet.Controlled_Substance_Fee_Schedules_2_3__c =lstStateDefaultPricingWorksheet[0].Controlled_Substance_Fee_Schedules_2_3__c;
                pricingWorkSheet.Compound1_Fee_Non_Infusion_Additional_to__c =lstStateDefaultPricingWorksheet[0].Compound1_Fee_Non_Infusion_Additional_to__c;
                pricingWorkSheet.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c =lstStateDefaultPricingWorksheet[0].Rx_Brands_All_Except_IV_TPN_Cost_Ba__c;
                pricingWorkSheet.Rx_Brands_All_Except_IV_TPN_Ingredi__c =lstStateDefaultPricingWorksheet[0].Rx_Brands_All_Except_IV_TPN_Ingredi__c;
                pricingWorkSheet.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c =lstStateDefaultPricingWorksheet[0].Rx_Brands_All_Except_IV_TPN_Disp_Fe__c;
                pricingWorkSheet.CBOther23a__c =lstStateDefaultPricingWorksheet[0].CBOther23a__c;
                pricingWorkSheet.Rx_g3_3_Generic_Manufacturers_All_Except__c =lstStateDefaultPricingWorksheet[0].Rx_g3_3_Generic_Manufacturers_All_Except__c;
                pricingWorkSheet.Rx_g1_3_Generic_Manufacturers_All_Except__c =lstStateDefaultPricingWorksheet[0].Rx_g1_3_Generic_Manufacturers_All_Except__c;
                pricingWorkSheet.Rx_g2_3_Generic_Manufacturers_All_Except__c =lstStateDefaultPricingWorksheet[0].Rx_g2_3_Generic_Manufacturers_All_Except__c;
                pricingWorkSheet.CBOther23b__c =lstStateDefaultPricingWorksheet[0].CBOther23b__c;
                pricingWorkSheet.Rx_l2_3_Generic_Manufacturers_All_Except__c =lstStateDefaultPricingWorksheet[0].Rx_l2_3_Generic_Manufacturers_All_Except__c;
                pricingWorkSheet.Rx_l_3_Generic_Manufacturers_All_Except__c =lstStateDefaultPricingWorksheet[0].Rx_l_3_Generic_Manufacturers_All_Except__c;
                pricingWorkSheet.Rx_l1_3_Generic_Manufacturers_All_Except__c =lstStateDefaultPricingWorksheet[0].Rx_l1_3_Generic_Manufacturers_All_Except__c;
                pricingWorkSheet.CBOther23c__c =lstStateDefaultPricingWorksheet[0].CBOther23c__c;
                pricingWorkSheet.OTC_Brands_CostBasis1__c =lstStateDefaultPricingWorksheet[0].OTC_Brands_CostBasis1__c;
                pricingWorkSheet.OTC_Brands_Ingrediant1__c =lstStateDefaultPricingWorksheet[0].OTC_Brands_Ingrediant1__c;
                pricingWorkSheet.OTC_Brands_DispFee1__c =lstStateDefaultPricingWorksheet[0].OTC_Brands_DispFee1__c;
                pricingWorkSheet.CBOther23d__c =lstStateDefaultPricingWorksheet[0].CBOther23d__c;
                pricingWorkSheet.OTCg13Cost_Basis__c =lstStateDefaultPricingWorksheet[0].OTCg13Cost_Basis__c;
                pricingWorkSheet.OTCg13Ingredient__c =lstStateDefaultPricingWorksheet[0].OTCg13Ingredient__c;
                pricingWorkSheet.OTCg13Dispfee__c =lstStateDefaultPricingWorksheet[0].OTCg13Dispfee__c;
                pricingWorkSheet.CBOther23e__c =lstStateDefaultPricingWorksheet[0].CBOther23e__c;
                pricingWorkSheet.OTCl3costbasis__c =lstStateDefaultPricingWorksheet[0].OTCl3costbasis__c;
                pricingWorkSheet.OTCl3Ingredient__c =lstStateDefaultPricingWorksheet[0].OTCl3Ingredient__c;
                pricingWorkSheet.OTCl3Disp_fee__c =lstStateDefaultPricingWorksheet[0].OTCl3Disp_fee__c;
                pricingWorkSheet.CBOther23f__c =lstStateDefaultPricingWorksheet[0].CBOther23f__c;
                pricingWorkSheet.MinimumsRX1__c =lstStateDefaultPricingWorksheet[0].MinimumsRX1__c;
                pricingWorkSheet.MinimumsOTCPerRx1__c =lstStateDefaultPricingWorksheet[0].MinimumsOTCPerRx1__c;
                pricingWorkSheet.Controlled_substance_fee1__c =lstStateDefaultPricingWorksheet[0].Controlled_substance_fee1__c;
                pricingWorkSheet.Compound_fee_Infusion1__c =lstStateDefaultPricingWorksheet[0].Compound_fee_Infusion1__c;
              //pricingWorkSheet.Bulk_OTC_Brands_Cost_Basis__c =lstStateDefaultPricingWorksheet[0].Bulk_OTC_Brands_Cost_Basis__c;
              //pricingWorkSheet.Bulk_OTC_Brands_Ingrediant__c =lstStateDefaultPricingWorksheet[0].Bulk_OTC_Brands_Ingrediant__c;
                pricingWorkSheet.CBOther24a__c =lstStateDefaultPricingWorksheet[0].CBOther24a__c;
              //pricingWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost__c =lstStateDefaultPricingWorksheet[0].Bulk_OTC_3_Generic_Manufacturers_Cost__c;
              //pricingWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingre__c =lstStateDefaultPricingWorksheet[0].Bulk_OTC_3_Generic_Manufacturers_Ingre__c;
                pricingWorkSheet.CBOther24b__c =lstStateDefaultPricingWorksheet[0].CBOther24b__c;
              //pricingWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c =lstStateDefaultPricingWorksheet[0].Bulk_OTC_3_Generic_Manufacturers_Cost_B__c;
              //pricingWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingred__c =lstStateDefaultPricingWorksheet[0].Bulk_OTC_3_Generic_Manufacturers_Ingred__c;
                pricingWorkSheet.CBOther24c__c =lstStateDefaultPricingWorksheet[0].CBOther24c__c;
              //pricingWorkSheet.Bulk_Vaccine_Brands_Cost_Basis__c  =lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_Brands_Cost_Basis__c;
              //pricingWorkSheet.Bulk_Vaccine_Brands_Ingrediant__c =lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_Brands_Ingrediant__c;
                pricingWorkSheet.CBOther25a__c =lstStateDefaultPricingWorksheet[0].CBOther25a__c;
              //pricingWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_C__c =lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_3_Generic_Manufacturers_C__c;
                //pricingWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_I__c =lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_3_Generic_Manufacturers_I__c;
                //pricingWorkSheet.CBOther25b__c =lstStateDefaultPricingWorksheet[0].CBOther25b__c;
                //pricingWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_Co__c =lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_3_Generic_Manufacturers_Co__c;
                pricingWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_In__c =lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_3_Generic_Manufacturers_In__c;
                pricingWorkSheet.CBOther25c__c =lstStateDefaultPricingWorksheet[0].CBOther25c__c;
              //pricingWorkSheet.Medical_Records_Serviced_Patients__c =lstStateDefaultPricingWorksheet[0].Medical_Records_Serviced_Patients__c;
              //pricingWorkSheet.Medical_Records_Fee_Non_Serviced_Patien__c =lstStateDefaultPricingWorksheet[0].Medical_Records_Fee_Non_Serviced_Patien__c;
              //pricingWorkSheet.Consulting_Pharmacist_Required_Services__c =lstStateDefaultPricingWorksheet[0].Consulting_Pharmacist_Required_Services__c;
              //pricingWorkSheet.Consulting_Pharmacist_Optional_Services__c =lstStateDefaultPricingWorksheet[0].Consulting_Pharmacist_Optional_Services__c;
              //pricingWorkSheet.iMRR_Medication_Regimen_Review_SNF_O__c =lstStateDefaultPricingWorksheet[0].iMRR_Medication_Regimen_Review_SNF_O__c;
              //pricingWorkSheet.Anticoagulation_Management_Services_SNF__c =lstStateDefaultPricingWorksheet[0].Anticoagulation_Management_Services_SNF__c;
              //pricingWorkSheet.Consulting_Nurse_Charge_Non_1V__c =lstStateDefaultPricingWorksheet[0].Consulting_Nurse_Charge_Non_1V__c;
              //pricingWorkSheet.Onsite_Consulting_Non_SNF__c =lstStateDefaultPricingWorksheet[0].Onsite_Consulting_Non_SNF__c;
              //pricingWorkSheet.Remote_Consulting_Non_SNF__c =lstStateDefaultPricingWorksheet[0].Remote_Consulting_Non_SNF__c;
              //pricingWorkSheet.Restocking_fee_Rx_specific__c =lstStateDefaultPricingWorksheet[0].Restocking_fee_Rx_specific__c;
              //pricingWorkSheet.Monthly_No_Med_fee_per_resident_Non_serv__c =lstStateDefaultPricingWorksheet[0].Monthly_No_Med_fee_per_resident_Non_serv__c;
              //pricingWorkSheet.Non_Scheduled_Deliver_fee__c =lstStateDefaultPricingWorksheet[0].Non_Scheduled_Deliver_fee__c;
              //pricingWorkSheet.Automated_Dispensing_Unit__c =lstStateDefaultPricingWorksheet[0].Automated_Dispensing_Unit__c;
              //pricingWorkSheet.Automated_Dispensing_Unit_Type__c =lstStateDefaultPricingWorksheet[0].Automated_Dispensing_Unit_Type__c;
              //pricingWorkSheet.Monthly_ADU_Fee__c =lstStateDefaultPricingWorksheet[0].Monthly_ADU_Fee__c;
              //pricingWorkSheet.E_Prescribing_Credit_SNF_Only_per_lic__c =lstStateDefaultPricingWorksheet[0].E_Prescribing_Credit_SNF_Only_per_lic__c;
              //pricingWorkSheet.E_Prescribing_Vendor__c =lstStateDefaultPricingWorksheet[0].E_Prescribing_Vendor__c;
              //pricingWorkSheet.E_Prescribing_Vendor_Other__c =lstStateDefaultPricingWorksheet[0].E_Prescribing_Vendor_Other__c;
              //pricingWorkSheet.Prompt_Pay_Discount__c =lstStateDefaultPricingWorksheet[0].Prompt_Pay_Discount__c;
              //pricingWorkSheet.Net_Payment_Terms__c =lstStateDefaultPricingWorksheet[0].Net_Payment_Terms__c;
              //pricingWorkSheet.Default_Interest_Rate_Finance_Charge__c =lstStateDefaultPricingWorksheet[0].Default_Interest_Rate_Finance_Charge__c;
              //pricingWorkSheet.Scheduled_Deliveries_per_days_M_F__c =lstStateDefaultPricingWorksheet[0].Scheduled_Deliveries_per_days_M_F__c;
              //pricingWorkSheet.Scheduled_deliveries_per_daySat_Sun__c =lstStateDefaultPricingWorksheet[0].Scheduled_deliveries_per_daySat_Sun__c;
              //pricingWorkSheet.Dispensing_method__c =lstStateDefaultPricingWorksheet[0].Dispensing_method__c;
              //pricingWorkSheet.Dispensing_Frequency__c =lstStateDefaultPricingWorksheet[0].Dispensing_Frequency__c;
              //pricingWorkSheet.Dispensing_Type__c =lstStateDefaultPricingWorksheet[0].Dispensing_Type__c; 
            }
        }
        }
    }
    //Constructor
    public ext_pwView(ApexPages.StandardController stdController) {
        userIsApprover = true;
        isAdmin = false;
        ischanged = false;
        //Get Record Id
        pwid = ApexPages.currentPage().getParameters().get('id');
        
        //Populate Variables
        if(pwId!=null)
          pricingWorkSheet = globalHelper.getPricingWorksheetFields(pwId);
          pwAccount = globalHelper.getAccountFields(pricingWorkSheet.Account__c);
        if(pwAccount != null)
        strAccountOldState = pwAccount.BillingState;
        
        
        //20160615-BWY:  Adding new variable to get current user
        curUser = Userinfo.getUserId();
        cUser = globalHelper.getUserFields(curUser);
        /*strBillingStreet = pwAccount.BillingStreet;
            strBillingCity = pwAccount.BillingCity;
            strBillingPostalCode = pwAccount.BillingPostalCode;
            strBillingState = pwAccount.BillingState;*/
        List<Account> lstAcc = [Select id, name ,OCR_Pharmacy_Name__r.name,OCR_Pharmacy_Name__r.Pharmacy_Box_Company__c,OCR_Pharmacy_Name__r.Pharmacy_Dispensing_System__c, ParentID,BillingState,RecordTypeId,SNF_Beds__c,ALF_Beds__c,Other_Beds__c from Account where id = :pricingWorkSheet.Account__c];
        if(lstAcc.size() > 0)
        pwa2 = lstAcc[0];
        pwUser = globalHelper.getUserFields(CurUser);
        isAdmin = globalHelper.isUserAdmin(pwUser.Id);
        attahments = [Select Id, Name From Attachment where ParentId = :pwid limit 1];
                // Added for autopopulating Opportunity Name 02/06/2016  <start>
         if(pricingWorkSheet.Opportunity__c !=null)
         { 
            Opportunity objOpportunity = [select id,Name from Opportunity where Id=:pricingWorkSheet.Opportunity__c];
            if(objOpportunity !=null) opportunityName = objOpportunity.Name; opportunityId = objOpportunity.Id;
         }
                                                              // <End>
        //Populate Approved Pricing Worksheet
        acctId = pricingWorkSheet.Account__c;
        
        String SobjectApiName2 = 'Pricing_Worksheet__c';
        Map<String, Schema.SObjectType> schemaMap2 = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap2 = schemaMap2.get(SobjectApiName2).getDescribe().fields.getMap();
        String commaSepratedFields2 = '';
        for(String fieldName2 : fieldMap2.keyset()){
            if(commaSepratedFields2 == null || commaSepratedFields2 == ''){
                commaSepratedFields2 = fieldName2;
            }else{
                commaSepratedFields2 = commaSepratedFields2 + ', ' + fieldName2;
            }
        }
        String query2 = 'select ' + commaSepratedFields2 + ' from ' + SobjectApiName2 + ' where Account__c = :pwId and Status__c = \'Approved\' limit 1';
        pwListExec = Database.query(query2);
        if(pwListExec.size() > 0) {
            pricingWorkSheetExec = pwListExec[0];
            CurPW = true;
        }
        else {
            CurPW = false;
        }


        //Set Render
        renderApprove = false;
        renderEdit = false;
        
        if(pricingWorkSheet.Status__c == 'In Progress'||pricingWorkSheet.Status__c == 'CANCELLED'){
            renderApprove = true;
        }
        
        if (pricingWorkSheet.Status__c == 'In Progress' && (isAdmin)){
            renderEdit = true;
        }
  
            
             
            /* if( (pricingWorkSheet.status__c == 'In Progress' && !isAdmin)  || pricingWorkSheet.status__c == 'Rejected' || !(globalHelper.isUserApprover(pwUser.Id, 'Legal') && pricingWorkSheet.status__c == 'In Progress' ) )
             {
                strStyle = 'table-layout:fixed';
             }
             else if((globalHelper.isUserApprover(pwUser.Id, 'Legal') && pricingWorkSheet.status__c == 'In Progress' ))
              strStyle = 'table-layout:fixed');
             */
             
                     
         Id profileId=userinfo.getProfileId();
        String profileName=[Select Id,Name from Profile where Id=:profileId].Name;
  
            if(!renderEdit) strStyle = 'table-layout:fixed';
            else if((globalHelper.isUserApprover(pwUser.Id,'Legal')|| 
                     globalHelper.isUserApprover(pwUser.Id, 'VPO')|| 
                     globalHelper.isUserApprover(pwUser.Id, 'Contract Pricing')|| 
                     globalHelper.isUserApprover(pwUser.Id, 'Director of Pricing')||
                     globalHelper.isUserApprover(pwUser.Id, 'Capital Assets and Compliance' )||
                     globalHelper.isUserApprover(pwUser.Id, 'Pricing Analysis')||
                     globalHelper.isUserApprover(pwUser.Id, 'Credit')||
                     globalHelper.isUserApprover(pwUser.Id, 'IV: Pricing')||
                     globalHelper.isUserApprover(pwUser.Id, 'IV: Rx Claim')||
                     globalHelper.isUserApprover(pwUser.Id, 'IV: Senior Director')||
                     globalHelper.isUserApprover(pwUser.Id, 'E Prescribe'))&& profileName !='System Administrator') strStyle = 'table-layout:fixed';
             
           
         
        //Set View
            //Inital Variables
            approved = false;
            edit = false;
            state = false;
            save = false;
            
            //Populate Variables
            
            if((pricingWorkSheet.status__c == 'New'&&!isadmin) || (pricingWorkSheet.status__c == 'In Progress' && isadmin)||pricingWorkSheet.status__c == 'Rejected' ){
            save = true;
            } 
           
            
            
         if(pricingWorkSheet.status__c == 'Approved'){
                approved = true;
            }
            if(pricingWorkSheet.status__c == 'New' || (pricingWorkSheet.status__c == 'In Progress' && isadmin) ){
                edit = true;
            }
            if(pricingWorkSheet.status__c == 'State'){
                edit = false;
                approved = false;
                state = true;
            }
             
        //Set Booleans
            //Special Pricing
            if (!String.isBlank(pricingWorkSheet.Special_Pricing__c)){
                rSP = true;
            }
            else {
                rSP = false;
            }
            //IV Worksheet
            if (!String.isBlank(pricingWorkSheet.Internal_IV_Worksheet__c)) {
                rIV = true;
            }
            else {
                rIV = false;
            }
            //Per Diem
            if (!String.isBlank(pricingWorkSheet.Per_Diem__c)) {
                rPD = true;
                
            }
            else {  
                rPD = false;
            }
            //Schedule 3.1
            if (pricingWorkSheet.Approval_Date_DOP__c!=null ||pricingWorkSheet.Rejected_By_Legal__c!=null ) {
                rS3 = true;
            }
            else {
                rS3 = false;
            }
            //Standard Exclusion
            if(pricingWorkSheet.Per_Diem_Standard_Exclusion__c){
                rSE = true;
            }
            else {
                rSE = false;
            }
            //SNF
            if(pwAccount.SNF_Beds__c > 0 ) {
                rSNF = true;
            }
            else {
                rSNF = false;
            }
            //NONSNF
            if((pwAccount.SNF_Beds__c > 0 && pwAccount.SNF_Beds__c!= pwAccount.Total_Beds__c)||(pwAccount.SNF_Beds__c== 0)||(pwAccount.SNF_Beds__c==null)) {
                rNONSNF = true;
            }
            else {
                rNONSNF = false;
            }
            
            //rCA
            if (!String.isBlank(pricingWorkSheet.Credit_Analysis__c)) {
                rCA = true;
            }
            else {
                rCA = false;
            }


      


        //render Approvals
            //Initial Variables
            raC = false;
            raDOP = false;
            raCP = false;
            raAH = false;
            raL = false;
            raCAC = false;
            raPA = false;
            raAH2 = false;
            raEP = false;
            raVPO = false;
            raIVS = false;
            raIVR = false;
            raIVP = false;      
             
            //Approvals
             if (pricingWorkSheet.Status__c == 'In Progress') {
            
                //Director of Pricing
                raDOP = globalHelper.isUserApprover(pwUser.Id, 'Director of Pricing');
                if (raDOP){
                    raAH = true;            
                }
                //VPO
                raVPO = globalHelper.isUserApprover(pwUser.Id, 'VPO');
                //Contract Pricing
                raCP = globalHelper.isUserApprover(pwUser.Id, 'Contract Pricing');
                //Legal
                raL = globalHelper.isUserApprover(pwUser.Id, 'Legal');
                
                //Ad Hoc
                if (pricingWorkSheet.Approver_Ad_Hoc__c != null && (pricingWorkSheet.Approver_Ad_Hoc__c == pwUser.id || raAH == true)) {
                    raAH2 = true;
                }

                //Contracts and C-something
                if (pricingWorkSheet.approveCAC__c) {
                    raCAC = globalHelper.isUserApprover(pwUser.Id, 'Capital Assets and Compliance');
                }
                //12-17-2015 Requirements given WRONG
                //Pricing Analysis
                raPA = globalHelper.isUserApprover(pwUser.Id, 'Pricing Analysis');
                //Credit
                if (pricingWorkSheet.approveCredit__c) {
                    raC = globalHelper.isUserApprover(pwUser.Id, 'Credit');
                }
                //IV Approvals
                if (pricingWorkSheet.Approve_IV__c) {
                    raIVP = globalHelper.isUserApprover(pwUser.Id, 'IV: Pricing');
                    raIVR = globalHelper.isUserApprover(pwUser.Id, 'IV: Rx Claim');
                    raIVS = globalHelper.isUserApprover(pwUser.Id, 'IV: Senior Director');
                }
                //E Prescribe
                if (pricingWorkSheet.Approve_EP__c) {
                    raVPO = globalHelper.isUserApprover(pwUser.Id, 'E Prescribe');
                }
            }
    }                //This code was implemented for clone functionality 05/27/2016 and Record lock feature was implemeted
    //Save Action
    
    public PageReference save() {
        
        /*if((pricingWorkSheet.Status__c == 'In Progress' && !isadmin) || pricingWorkSheet.Status__c == 'Approved')
        {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot modify submitted pricing worksheet until Approved'));
             return null;
        }
        else*/
        { 
        try {
                system.debug(LoggingLevel.info,'>>>>went here'+lstStateDefaultPricingWorksheet); 
                /*if(pricingWorkSheet.Account__c != null)
        {
          //pwAccount = globalHelper.getAccountFields(Id.valueof(strAccountID));
          
          string SobjectApiName = 'Pricing_Worksheet__c';
          String commaSepratedFields = 'RX_Brands_All_except_1V_TPN_Cost_Basi__c,RX_Brands_All_except_1V_TPN_Ingredient__c,RX_Brands_All_except_1V_TPN_Disp_fee__c,RX_Brands_All_except_1V_TPN_unit_dose__c '+
        ',CBOther22a__c,RX_3_Generic_Manufacturers_Cost_basis__c,RX_3_Generic_ManufacturersIngredient__c,RX_3_Generic_Manufacturers_Disp_Fee__c,RX_3_Generic_Manufacturers_Unitdose_fee__c'+
        ',RX_le_3_Generic_Manufacturers_Cost_basis__c,RX_le_3_Generic_Manufacturers_Ingredient__c,RX_le_3_Generic_Manufacturers_Disp_Fee__c,RX_le_3_Generic_Manufacturers_Unit_dose__c'+
        ',CBOther22c__c,OTC_Brands_Cost_Basis__c,OTC_Brands_Ingrediant__c,Bulk_OTC_Brands_Ingrediant__c,OTC_Brands_Disp_Fee__c,OTC_Brands_Unit_Dose_Fee__c,CBOther22d__c'+
        ',OTC_3_Generic_Manufacturers_Cost_Basis__c,OTC_3_Generic_Manufacturers_Ingrediant__c,OTC_3_Generic_Manufacturers_Disp_Fee__c,OTC_3_Generic_Manufacturers_Unit_Dose_F__c'+
        ',CBOther22f__c,Facility_Special_Pricing__c,Minimums_Rx__c,Minimums_OTC_per_Rx__c,Controlled_Substance_Fee_Schedules_2_3__c,Compound1_Fee_Non_Infusion_Additional_to__c'+
        ',Rx_Brands_All_Except_IV_TPN_Cost_Ba__c,Rx_Brands_All_Except_IV_TPN_Ingredi__c,Rx_Brands_All_Except_IV_TPN_Disp_Fe__c,CBOther23a__c,Rx_g3_3_Generic_Manufacturers_All_Except__c'+
        ',Rx_g1_3_Generic_Manufacturers_All_Except__c,Rx_g2_3_Generic_Manufacturers_All_Except__c,CBOther23b__c,Rx_l2_3_Generic_Manufacturers_All_Except__c'+
        ',Rx_l_3_Generic_Manufacturers_All_Except__c,Rx_l1_3_Generic_Manufacturers_All_Except__c,CBOther23c__c,OTC_Brands_CostBasis1__c,OTC_Brands_Ingrediant1__c,OTC_Brands_DispFee1__c'+
        ',CBOther23d__c,OTCg13Cost_Basis__c,OTCg13Ingredient__c,OTCg13Dispfee__c,CBOther23e__c,OTCl3costbasis__c,OTCl3Ingredient__c,OTCl3Disp_fee__c,CBOther23f__c,MinimumsRX1__c'+
        ',MinimumsOTCPerRx1__c,Controlled_substance_fee1__c,Compound_fee_Infusion1__c,Bulk_OTC_Brands_Cost_Basis__c,CBOther24a__c'+
        ',Bulk_OTC_3_Generic_Manufacturers_Cost__c,Bulk_OTC_3_Generic_Manufacturers_Ingre__c,CBOther24b__c,Bulk_OTC_3_Generic_Manufacturers_Cost_B__c'+
        ',Bulk_OTC_3_Generic_Manufacturers_Ingred__c,CBOther24c__c,Bulk_Vaccine_Brands_Cost_Basis__c,Bulk_Vaccine_Brands_Ingrediant__c,CBOther25a__c'+
        ',Bulk_Vaccine_3_Generic_Manufacturers_C__c,Bulk_Vaccine_3_Generic_Manufacturers_I__c,CBOther25b__c,Bulk_Vaccine_3_Generic_Manufacturers_Co__c'+
        ',Bulk_Vaccine_3_Generic_Manufacturers_In__c,CBOther25c__c,Medical_Records_Serviced_Patients__c,Medical_Records_Fee_Non_Serviced_Patien__c'+
        ',Consulting_Pharmacist_Required_Services__c,Consulting_Pharmacist_Optional_Services__c,iMRR_Medication_Regimen_Review_SNF_O__c'+
        ',Anticoagulation_Management_Services_SNF__c,Consulting_Nurse_Charge_Non_1V__c,Onsite_Consulting_Non_SNF__c,Remote_Consulting_Non_SNF__c,Restocking_fee_Rx_specific__c'+
        ',Monthly_No_Med_fee_per_resident_Non_serv__c,Non_Scheduled_Deliver_fee__c,Automated_Dispensing_Unit__c,Automated_Dispensing_Unit_Type__c'+
        ',Monthly_ADU_Fee__c,E_Prescribing_Credit_SNF_Only_per_lic__c,E_Prescribing_Vendor__c,E_Prescribing_Vendor_Other__c,Prompt_Pay_Discount__c'+
        ',Net_Payment_Terms__c,Default_Interest_Rate_Finance_Charge__c,Scheduled_Deliveries_per_days_M_F__c,Scheduled_deliveries_per_daySat_Sun__c'+
        ',Dispensing_method__c,Dispensing_Frequency__c,Dispensing_Type__c';
        
         Map<String,RecordType> mapPricingRecordType =  new Map<String,RecordType>();
            for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                        WHERE SobjectType = 'Pricing_Worksheet__c'])
            mapPricingRecordType.put(recordType.DeveloperName,recordType);
            
            String stateDefaultId = mapPricingRecordType.get('State_Default').id;
            pwa2 = [Select id,BillingStreet,BillingCity,BillingPostalCode, name ,OCR_Pharmacy_Name__r.name,OCR_Pharmacy_Name__r.Pharmacy_Box_Company__c,OCR_Pharmacy_Name__r.Pharmacy_Dispensing_System__c, ParentID,BillingState,RecordTypeId,SNF_Beds__c,ALF_Beds__c,Other_Beds__c from Account where id = :pricingWorkSheet.Account__c];
            system.debug(LoggingLevel.Info,'>>>>pwa2'+pwa2);
            String accountBillingState = pwa2.BillingState;
           
            String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where RecordTypeId = :stateDefaultId and State__c = :accountBillingState limit 1';
            lstStateDefaultPricingWorksheet = Database.query(query);*/
            
                                               
           /* if(lstStateDefaultPricingWorksheet !=null && lstStateDefaultPricingWorksheet.size() > 0)
            {
                
                lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_Cost_Basi__c = pricingWorkSheet.RX_Brands_All_except_1V_TPN_Cost_Basi__c;
                lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_Ingredient__c = pricingWorkSheet.RX_Brands_All_except_1V_TPN_Ingredient__c;
                lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_Disp_fee__c = pricingWorkSheet.RX_Brands_All_except_1V_TPN_Disp_fee__c;
                lstStateDefaultPricingWorksheet[0].RX_Brands_All_except_1V_TPN_unit_dose__c = pricingWorkSheet.RX_Brands_All_except_1V_TPN_unit_dose__c;
                lstStateDefaultPricingWorksheet[0].CBOther22a__c = pricingWorkSheet.CBOther22a__c; 
                lstStateDefaultPricingWorksheet[0].RX_3_Generic_Manufacturers_Cost_basis__c = pricingWorkSheet.RX_3_Generic_Manufacturers_Cost_basis__c;
                lstStateDefaultPricingWorksheet[0].RX_3_Generic_ManufacturersIngredient__c = pricingWorkSheet.RX_3_Generic_ManufacturersIngredient__c;
                lstStateDefaultPricingWorksheet[0].RX_3_Generic_Manufacturers_Disp_Fee__c = pricingWorkSheet.RX_3_Generic_Manufacturers_Disp_Fee__c;
                lstStateDefaultPricingWorksheet[0].RX_3_Generic_Manufacturers_Unitdose_fee__c = pricingWorkSheet.RX_3_Generic_Manufacturers_Unitdose_fee__c;
                lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Cost_basis__c = pricingWorkSheet.RX_le_3_Generic_Manufacturers_Cost_basis__c;
                lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Ingredient__c = pricingWorkSheet.RX_le_3_Generic_Manufacturers_Ingredient__c;
                lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Disp_Fee__c = pricingWorkSheet.RX_le_3_Generic_Manufacturers_Disp_Fee__c;
                lstStateDefaultPricingWorksheet[0].RX_le_3_Generic_Manufacturers_Unit_dose__c = pricingWorkSheet.RX_le_3_Generic_Manufacturers_Unit_dose__c;
                lstStateDefaultPricingWorksheet[0].CBOther22c__c = pricingWorkSheet.CBOther22c__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_Cost_Basis__c = pricingWorkSheet.OTC_Brands_Cost_Basis__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_Ingrediant__c = pricingWorkSheet.OTC_Brands_Ingrediant__c;
                lstStateDefaultPricingWorksheet[0].Bulk_OTC_Brands_Ingrediant__c  =pricingWorkSheet.Bulk_OTC_Brands_Ingrediant__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_Disp_Fee__c =pricingWorkSheet.OTC_Brands_Disp_Fee__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_Unit_Dose_Fee__c =pricingWorkSheet.OTC_Brands_Unit_Dose_Fee__c;
                lstStateDefaultPricingWorksheet[0].CBOther22d__c =pricingWorkSheet.CBOther22d__c;
                lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Cost_Basis__c =pricingWorkSheet.OTC_3_Generic_Manufacturers_Cost_Basis__c;
                lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Ingrediant__c  =pricingWorkSheet.OTC_3_Generic_Manufacturers_Ingrediant__c;
                lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Disp_Fee__c =pricingWorkSheet.OTC_3_Generic_Manufacturers_Disp_Fee__c;
                lstStateDefaultPricingWorksheet[0].OTC_3_Generic_Manufacturers_Unit_Dose_F__c =pricingWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose_F__c;
                lstStateDefaultPricingWorksheet[0].CBOther22f__c =pricingWorkSheet.CBOther22f__c;
                lstStateDefaultPricingWorksheet[0].Facility_Special_Pricing__c =pricingWorkSheet.Facility_Special_Pricing__c;
                lstStateDefaultPricingWorksheet[0].Minimums_Rx__c =pricingWorkSheet.Minimums_Rx__c;
                lstStateDefaultPricingWorksheet[0].Minimums_OTC_per_Rx__c =pricingWorkSheet.Minimums_OTC_per_Rx__c;
                lstStateDefaultPricingWorksheet[0].Controlled_Substance_Fee_Schedules_2_3__c =pricingWorkSheet.Controlled_Substance_Fee_Schedules_2_3__c;
                lstStateDefaultPricingWorksheet[0].Compound1_Fee_Non_Infusion_Additional_to__c =pricingWorkSheet.Compound1_Fee_Non_Infusion_Additional_to__c;
                lstStateDefaultPricingWorksheet[0].Rx_Brands_All_Except_IV_TPN_Cost_Ba__c =pricingWorkSheet.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c;
                lstStateDefaultPricingWorksheet[0].Rx_Brands_All_Except_IV_TPN_Ingredi__c =pricingWorkSheet.Rx_Brands_All_Except_IV_TPN_Ingredi__c;
                lstStateDefaultPricingWorksheet[0].Rx_Brands_All_Except_IV_TPN_Disp_Fe__c =pricingWorkSheet.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c;
                lstStateDefaultPricingWorksheet[0].CBOther23a__c =pricingWorkSheet.CBOther23a__c;
                lstStateDefaultPricingWorksheet[0].Rx_g3_3_Generic_Manufacturers_All_Except__c =pricingWorkSheet.Rx_g3_3_Generic_Manufacturers_All_Except__c;
                lstStateDefaultPricingWorksheet[0].Rx_g1_3_Generic_Manufacturers_All_Except__c =pricingWorkSheet.Rx_g1_3_Generic_Manufacturers_All_Except__c;
                lstStateDefaultPricingWorksheet[0].Rx_g2_3_Generic_Manufacturers_All_Except__c =pricingWorkSheet.Rx_g2_3_Generic_Manufacturers_All_Except__c;
                lstStateDefaultPricingWorksheet[0].CBOther23b__c =pricingWorkSheet.CBOther23b__c;
                lstStateDefaultPricingWorksheet[0].Rx_l2_3_Generic_Manufacturers_All_Except__c =pricingWorkSheet.Rx_l2_3_Generic_Manufacturers_All_Except__c;
                lstStateDefaultPricingWorksheet[0].Rx_l_3_Generic_Manufacturers_All_Except__c =pricingWorkSheet.Rx_l_3_Generic_Manufacturers_All_Except__c;
                lstStateDefaultPricingWorksheet[0].Rx_l1_3_Generic_Manufacturers_All_Except__c =pricingWorkSheet.Rx_l1_3_Generic_Manufacturers_All_Except__c;
                lstStateDefaultPricingWorksheet[0].CBOther23c__c =pricingWorkSheet.CBOther23c__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_CostBasis1__c =pricingWorkSheet.OTC_Brands_CostBasis1__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_Ingrediant1__c =pricingWorkSheet.OTC_Brands_Ingrediant1__c;
                lstStateDefaultPricingWorksheet[0].OTC_Brands_DispFee1__c =pricingWorkSheet.OTC_Brands_DispFee1__c;
                lstStateDefaultPricingWorksheet[0].CBOther23d__c =pricingWorkSheet.CBOther23d__c;
                lstStateDefaultPricingWorksheet[0].OTCg13Cost_Basis__c =pricingWorkSheet.OTCg13Cost_Basis__c;
                lstStateDefaultPricingWorksheet[0].OTCg13Ingredient__c =pricingWorkSheet.OTCg13Ingredient__c;
                lstStateDefaultPricingWorksheet[0].OTCg13Dispfee__c =pricingWorkSheet.OTCg13Dispfee__c;
                lstStateDefaultPricingWorksheet[0].CBOther23e__c =pricingWorkSheet.CBOther23e__c;
                lstStateDefaultPricingWorksheet[0].OTCl3costbasis__c =pricingWorkSheet.OTCl3costbasis__c;
                lstStateDefaultPricingWorksheet[0].OTCl3Ingredient__c =pricingWorkSheet.OTCl3Ingredient__c;
                lstStateDefaultPricingWorksheet[0].OTCl3Disp_fee__c =pricingWorkSheet.OTCl3Disp_fee__c;
                lstStateDefaultPricingWorksheet[0].CBOther23f__c =pricingWorkSheet.CBOther23f__c;
                lstStateDefaultPricingWorksheet[0].MinimumsRX1__c =pricingWorkSheet.MinimumsRX1__c;
                lstStateDefaultPricingWorksheet[0].MinimumsOTCPerRx1__c =pricingWorkSheet.MinimumsOTCPerRx1__c;
                lstStateDefaultPricingWorksheet[0].Controlled_substance_fee1__c =pricingWorkSheet.Controlled_substance_fee1__c;
                lstStateDefaultPricingWorksheet[0].Compound_fee_Infusion1__c =pricingWorkSheet.Compound_fee_Infusion1__c;              
                lstStateDefaultPricingWorksheet[0].CBOther24a__c =pricingWorkSheet.CBOther24a__c;              
                lstStateDefaultPricingWorksheet[0].CBOther24b__c =pricingWorkSheet.CBOther24b__c;            
                lstStateDefaultPricingWorksheet[0].CBOther24c__c =pricingWorkSheet.CBOther24c__c;              
                lstStateDefaultPricingWorksheet[0].CBOther25a__c =pricingWorkSheet.CBOther25a__c;
                lstStateDefaultPricingWorksheet[0].Bulk_Vaccine_3_Generic_Manufacturers_In__c =pricingWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_In__c;
                lstStateDefaultPricingWorksheet[0].CBOther25c__c =pricingWorkSheet.CBOther25c__c;
                
                update lstStateDefaultPricingWorksheet;*/
                
             
            
             
            pricingWorkSheet.Opportunity__c = opportunityId;
            update pricingWorkSheet;
             system.debug(LoggingLevel.Info,'>>>>>>pricingWorkSheet.Opportunity__c'+pricingWorkSheet.Opportunity__c);
            pagereference pr = new pagereference('/' + pwid);
                pr.setredirect(true);
            return pr;                  
        }
        catch (DMLexception e) {
            system.debug('DML Exception: ' + e.getMessage());
              ApexPages.addMessages(e);
            return null;
        }
        }
    }
                                                                        //<END>
    //Cancel
    public PageReference cancel() {
       pagereference pr = new pagereference('/' + pricingWorkSheet.Account__c);
            pr.setredirect(true);
        return pr;  
      }
                           //This code was implemented for clone functionality 
                                               //<start>                                   
    //Clone
    public PageReference clonePW() {
     //State Defaults
       /* Map<String,RecordType> mapPricingRecordType = new Map<String,RecordType>();
        for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                        WHERE SobjectType = 'Pricing_Worksheet__c'])
         mapPricingRecordType.put(recordType.DeveloperName,recordType);
        String stateDefaultId = mapPricingRecordType.get('State_Default').id;
        String accountBillingState = pwaccount.BillingState;
        String SobjectApiName = 'Pricing_Worksheet__c';
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
        String commaSepratedFields = '';
        List<String> lstPricingWritableFields = new List<String>();
        for(String fieldName : fieldMap.keyset()){
           
            Schema.SObjectField field = fieldMap.get(fieldName);
            Schema.DescribeFieldResult F = field.getDescribe();
            if(F.isCreateable())
                lstPricingWritableFields.add(fieldName);
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where RecordTypeId = :stateDefaultId and State__c = :accountBillingState limit 1';
        
        //Clone Record 
        List<Pricing_Worksheet__c>  lstStateDefaultPricingWorksheet = Database.query(query);
        
         */
        Pricing_Worksheet__c pwClone = pricingWorkSheet.clone(false,false,false,false);
       /* if(lstStateDefaultPricingWorksheet.size() > 0)
         {
            for(String fieldName : lstPricingWritableFields)
             {  
                pwClone.put(fieldName,lstStateDefaultPricingWorksheet[0].get(fieldName));
             }
         }*/
         pwClone.Net_Payment_Terms__c = pricingWorkSheet.Net_Payment_Terms__c;
         pwClone.Default_Interest_Rate_Finance_Charge__c = pricingWorkSheet.Default_Interest_Rate_Finance_Charge__c;
         pwClone.Scheduled_Deliveries_per_days_M_F__c = pricingWorkSheet.Scheduled_Deliveries_per_days_M_F__c;
         pwClone.Scheduled_deliveries_per_daySat_Sun__c = pricingWorkSheet.Scheduled_deliveries_per_daySat_Sun__c;
         pwClone.Dispensing_method__c = pricingWorkSheet.Dispensing_method__c;
         pwClone.Dispensing_Frequency__c = pricingWorkSheet.Dispensing_Frequency__c;
         pwClone.Dispensing_Type__c = pricingWorkSheet.Dispensing_Type__c;
         pwClone.Account__c = pricingWorkSheet.Account__c;
         pwClone.Other_Bed_Type__c = pricingWorkSheet.Other_Bed_Type__c;
         pwClone.Opportunity__c = pricingWorkSheet.Opportunity__c;
         pwClone.Name = 'Pricing Worksheet: '+pwClone.Proposal_Id__c + 1;
         pwClone.Clone_Off__c = pricingWorkSheet.Name;                                               
                                                                                               //END
        system.debug(Logginglevel.info,'>>>>>pwClone'+pwClone.Proposal_Id__c+'>>>'+pwClone.Name);
        //Set Null Fields
            //Pricing Worksheet Fields
            pwClone.Status__c = 'New';
            pwClone.Submitted_By__c = null;
            pwClone.Date_Submitted__c = null;
            
            //Notes Tab
            
            pwClone.Notes__c = null;

            //Approval Date
            pwClone.Approval_Date_VPO__c = null;
            pwClone.Approval_Date_Ad_Hoc__c = null;
            pwClone.Approval_Date_CAC__c = null;
            pwClone.Approval_Date_CP__c = null;
            pwClone.Approval_Date_Credit__c = null;
            pwClone.Approval_Date_DOP__c = null;
            pwClone.Approval_Date_Legal__c = null;
            pwClone.Approval_Date_PA__c = null;
            pwClone.Approval_Date_IV_P__c = null;
            pwClone.Approval_Date_IV_R__c = null;
            pwClone.Approval_Date_IV_SD__c = null;

            //Approval Notes
            pwClone.Approval_Notes_VPO__c = null;
            pwClone.Approval_Notes_Ad_Hoc__c = null;
            pwClone.Approval_Notes_CAC__c = null;
            pwClone.Approval_Notes_CP__c = null;
            pwClone.Approval_Notes_Credit__c = null;
            pwClone.Approval_Notes_DOP__c = null;
            pwClone.Approval_Notes_Legal__c = null;
            pwClone.Approval_Notes_PA__c = null;
            pwClone.Approval_Notes_IV_P__c = null;
            pwClone.Approval_Notes_IV_R__c = null;
            pwClone.Approval_Notes_IV_S__c = null;

            //Approvers
            pwClone.Approver_VPO__c = null;
            pwClone.Approver_Ad_Hoc__c = null;
            pwClone.Approver_Capital_Assets_and_Compliance__c = null;
            pwClone.Approver_Contract_Pricing__c = null;
            pwClone.Approver_Credit__c = null;
            pwClone.Approver_Director_of_Pricing__c = null;
            pwClone.Approver_Legal__c = null;
            pwClone.Approver_Pricing_Analysis__c = null;
            pwClone.Approver_IV_Pricing__c = null;
            pwClone.Approver_IV_Rx__c = null;
            pwClone.Approver_IV_SD__c = null;
        
           // 10/06/2016
           //vpo
            pwclone.Approver_VPO__c = null;
            pwclone.Approval_Date_VPO__c = null;
            pwclone.Recalled_by_VPO__c = null;
           //credit
           pwclone.Approver_Credit__c = null;
           pwclone.Approval_Date_Credit__c = null;
           pwclone.Recalled_by_Credit__c = null;
           // IV: Pricing
           pwclone.Approver_IV_Pricing__c= null;
           pwclone.Approval_Date_IV_P__c= null;
           pwclone.Recalled_by_IVP__c = null;
           //IV: Rx Claim
           pwclone.Approver_IV_Rx__c = null;
           pwclone.Approval_Date_IV_R__c = null;
           pwclone.Recalled_by_IVR__c = null;
           //IV: Senior Director
           pwclone.Approver_IV_SD__c = null;
           pwclone.Approval_Date_IV_SD__c = null;
           pwclone.Recalled_by_IVS__c = null;
           //Contract Pricing
           pwclone.Approver_Contract_Pricing__c = null;
           pwclone.Approval_Date_CP__c = null;
           pwclone.Recalled_by_CP__c = null;
           //Director of Pricing
           pwclone.Approver_Director_of_Pricing__c = null;
           pwclone.Approval_Date_DOP__c = null;
           pwclone.Recalled_by_DOP__c = null;
           //Agreement Drafted
           pwclone.Approver_Legal__c = null;
           pwclone.Approval_Date_Legal__c = null;
            
        try
        {
            insert pwClone;
        
            List<Internal_IV_Worksheet__c> lstIV = getIvWorkSheet(pricingWorkSheet.Id);
            List<Internal_IV_Worksheet__c> lstIVforClone = getIvWorkSheet(pwclone.Id);
       
            if(lstIV.size() > 0 && lstIVforClone.size() > 0)
            {
          lstIVforClone[0].Active_Schedule__c = lstIV[0].Active_Schedule__c;
        lstIVforClone[0].All_IV_Push__c = lstIV[0].All_IV_Push__c;
        lstIVforClone[0].All_Other_Classes_Certifications_Trainin__c = lstIV[0].All_Other_Classes_Certifications_Trainin__c;
        lstIVforClone[0].All_Other_IV_Therapies_Not_Specified_dr__c = lstIV[0].All_Other_IV_Therapies_Not_Specified_dr__c;
        lstIVforClone[0].Catheter_Declot_Cost__c = lstIV[0].Catheter_Declot_Cost__c;
        lstIVforClone[0].Catheter_Declot_Supplies__c = lstIV[0].Catheter_Declot_Supplies__c;
        lstIVforClone[0].Certifications_16_Hours_Includes_Stat__c = lstIV[0].Certifications_16_Hours_Includes_Stat__c;
        lstIVforClone[0].Cert_Basis__c = lstIV[0].Cert_Basis__c;
        lstIVforClone[0].Cert_Max__c = lstIV[0].Cert_Max__c;
        lstIVforClone[0].Cert_Rate__c = lstIV[0].Cert_Rate__c;
        lstIVforClone[0].Clearing_Thrombotic_Occlusions_in_Centra__c = lstIV[0].Clearing_Thrombotic_Occlusions_in_Centra__c;
        lstIVforClone[0].Diluents__c = lstIV[0].Diluents__c;
        lstIVforClone[0].Documentation_IV_POS_MAR_Forms__c = lstIV[0].Documentation_IV_POS_MAR_Forms__c;
        lstIVforClone[0].Edu_CVAD_Basis__c = lstIV[0].Edu_CVAD_Basis__c;
        lstIVforClone[0].Edu_CVAD_Max__c = lstIV[0].Edu_CVAD_Max__c;
        lstIVforClone[0].Edu_CVAD_Rate__c = lstIV[0].Edu_CVAD_Rate__c;
        lstIVforClone[0].Edu_Hypodermoclysis_Basis__c = lstIV[0].Edu_Hypodermoclysis_Basis__c;
        lstIVforClone[0].Edu_Hypodermoclysis_Max__c = lstIV[0].Edu_Hypodermoclysis_Max__c;
        lstIVforClone[0].Edu_Hypodermoclysis_Rate__c = lstIV[0].Edu_Hypodermoclysis_Rate__c;
        lstIVforClone[0].Edu_Certification_Basics__c = lstIV[0].Edu_Certification_Basics__c;
        lstIVforClone[0].Edu_Certification_Max__c = lstIV[0].Edu_Certification_Max__c;
        lstIVforClone[0].Edu_Certification_Rate__c = lstIV[0].Edu_Certification_Rate__c;
        lstIVforClone[0].Edu_Infusion_Fundamentals_Basis__c = lstIV[0].Edu_Infusion_Fundamentals_Basis__c;
        lstIVforClone[0].Edu_Infusion_Fundamentals_Max__c = lstIV[0].Edu_Infusion_Fundamentals_Max__c;
        lstIVforClone[0].Edu_Infusion_Fundamentals_Rate__c = lstIV[0].Edu_Infusion_Fundamentals_Rate__c;
        lstIVforClone[0].Edu_IV_Push_Basis__c = lstIV[0].Edu_IV_Push_Basis__c;
        lstIVforClone[0].Edu_IV_Push_Max__c = lstIV[0].Edu_IV_Push_Max__c;
        lstIVforClone[0].Edu_IV_Push_Rate__c = lstIV[0].Edu_IV_Push_Rate__c;
        lstIVforClone[0].Edu_MAR_Document_Basis__c = lstIV[0].Edu_MAR_Document_Basis__c;
        lstIVforClone[0].Edu_MAR_Document_Max__c = lstIV[0].Edu_MAR_Document_Max__c;
        lstIVforClone[0].Edu_MAR_Document_Rate__c = lstIV[0].Edu_MAR_Document_Rate__c;
        lstIVforClone[0].Edu_Mgmt_Inotropics_Basis__c = lstIV[0].Edu_Mgmt_Inotropics_Basis__c;
        lstIVforClone[0].Edu_Mgmt_Inotropics_Max__c = lstIV[0].Edu_Mgmt_Inotropics_Max__c;
        lstIVforClone[0].Edu_Mgmt_Inotropics_Rate__c = lstIV[0].Edu_Mgmt_Inotropics_Rate__c;
        lstIVforClone[0].Edu_NursCEUs_Basis__c = lstIV[0].Edu_NursCEUs_Basis__c;
        lstIVforClone[0].Edu_NursCEUs_Max__c = lstIV[0].Edu_NursCEUs_Max__c;
        lstIVforClone[0].Edu_NursCEUs_Rate__c = lstIV[0].Edu_NursCEUs_Rate__c;
        lstIVforClone[0].Edu_Other_Basis__c = lstIV[0].Edu_Other_Basis__c;
        lstIVforClone[0].Edu_Other_Max__c = lstIV[0].Edu_Other_Max__c;
        lstIVforClone[0].Edu_Other_Rate__c = lstIV[0].Edu_Other_Rate__c;
        lstIVforClone[0].Edu_Pain_Mgmt_Basis__c = lstIV[0].Edu_Pain_Mgmt_Basis__c;
        lstIVforClone[0].Edu_Pain_Mgmt_Max__c = lstIV[0].Edu_Pain_Mgmt_Max__c;
        lstIVforClone[0].Edu_Pain_Mgmt_Rate__c = lstIV[0].Edu_Pain_Mgmt_Rate__c;
        lstIVforClone[0].Edu_PICC_Removal_Basis__c = lstIV[0].Edu_PICC_Removal_Basis__c;
        lstIVforClone[0].Edu_PICC_Removal_Max__c = lstIV[0].Edu_PICC_Removal_Max__c;
        lstIVforClone[0].Edu_PICC_Removal_Rate__c = lstIV[0].Edu_PICC_Removal_Rate__c;
        lstIVforClone[0].Edu_Thrombotic_Occlusions_Basis__c = lstIV[0].Edu_Thrombotic_Occlusions_Basis__c;
        lstIVforClone[0].Edu_Thrombotic_Occlusions_Max__c = lstIV[0].Edu_Thrombotic_Occlusions_Max__c;
        lstIVforClone[0].Edu_Thrombotic_Occlusions_Rate__c = lstIV[0].Edu_Thrombotic_Occlusions_Rate__c;
        lstIVforClone[0].Edu_TPN_Basis__c = lstIV[0].Edu_TPN_Basis__c;
        lstIVforClone[0].Edu_TPN_Max__c = lstIV[0].Edu_TPN_Max__c;
        lstIVforClone[0].Edu_TPN_Rate__c = lstIV[0].Edu_TPN_Rate__c;
        lstIVforClone[0].Essentials_of_Infusion_Therapy_2_Day_C__c = lstIV[0].Essentials_of_Infusion_Therapy_2_Day_C__c;
        lstIVforClone[0].Hypodermoclysis__c = lstIV[0].Hypodermoclysis__c;
        lstIVforClone[0].Infusion_Nurse_After_Hours_Fee__c = lstIV[0].Infusion_Nurse_After_Hours_Fee__c;
        lstIVforClone[0].Infusion_Nurse_Consulting_Service__c = lstIV[0].Infusion_Nurse_Consulting_Service__c;
        lstIVforClone[0].IV_Chemo_Infusion_drug_solution__c = lstIV[0].IV_Chemo_Infusion_drug_solution__c;
        lstIVforClone[0].IV_Facility_AB_24hr_Basis__c = lstIV[0].IV_Facility_AB_24hr_Basis__c;
        lstIVforClone[0].IV_Facility_AB_24hr_Fee__c = lstIV[0].IV_Facility_AB_24hr_Fee__c;
        lstIVforClone[0].IV_Facility_Additives_Basis__c = lstIV[0].IV_Facility_Additives_Basis__c;
        lstIVforClone[0].IV_Facility_Additives_Cost__c = lstIV[0].IV_Facility_Additives_Cost__c;
        lstIVforClone[0].IV_Facility_Additives_Rate__c = lstIV[0].IV_Facility_Additives_Rate__c;
        lstIVforClone[0].IV_Facility_Antibiotics_BID_Basis__c = lstIV[0].IV_Facility_Antibiotics_BID_Basis__c;
        lstIVforClone[0].IV_Facility_Antibiotics_BID_Cost__c = lstIV[0].IV_Facility_Antibiotics_BID_Cost__c;
        lstIVforClone[0].IV_Facility_Antibiotics_BID_Rate__c = lstIV[0].IV_Facility_Antibiotics_BID_Rate__c;
        lstIVforClone[0].IV_Facility_Antibiotics_QD_Basis__c = lstIV[0].IV_Facility_Antibiotics_QD_Basis__c;
        lstIVforClone[0].IV_Facility_Antibiotics_QD_Cost__c = lstIV[0].IV_Facility_Antibiotics_QD_Cost__c;
        lstIVforClone[0].IV_Facility_Antibiotics_QD_Rate__c = lstIV[0].IV_Facility_Antibiotics_QD_Rate__c;
        lstIVforClone[0].IV_Facility_Antibiotics_QID_Basis__c = lstIV[0].IV_Facility_Antibiotics_QID_Basis__c;
        lstIVforClone[0].IV_Facility_Antibiotics_QID_Cost__c = lstIV[0].IV_Facility_Antibiotics_QID_Cost__c;
        lstIVforClone[0].IV_Facility_Antibiotics_QID_Rate__c = lstIV[0].IV_Facility_Antibiotics_QID_Rate__c;
        lstIVforClone[0].IV_Facility_Antibiotics_TID_Basis__c = lstIV[0].IV_Facility_Antibiotics_TID_Basis__c;
        lstIVforClone[0].IV_Facility_Antibiotics_TID_Cost__c = lstIV[0].IV_Facility_Antibiotics_TID_Cost__c;
        lstIVforClone[0].IV_Facility_Antibiotics_TID_Rate__c = lstIV[0].IV_Facility_Antibiotics_TID_Rate__c;
        lstIVforClone[0].IV_Facility_Catheter_Care_Supplies_Basis__c = lstIV[0].IV_Facility_Catheter_Care_Supplies_Basis__c;
        lstIVforClone[0].IV_Facility_Catheter_Care_Supplies_Cost__c = lstIV[0].IV_Facility_Catheter_Care_Supplies_Cost__c;
        lstIVforClone[0].IV_Facility_Catheter_Care_Supplies_Rate__c = lstIV[0].IV_Facility_Catheter_Care_Supplies_Rate__c;
        lstIVforClone[0].IV_Facility_Chemo_Basis__c = lstIV[0].IV_Facility_Chemo_Basis__c;
        lstIVforClone[0].IV_Facility_Chemo_Cost__c = lstIV[0].IV_Facility_Chemo_Cost__c;
        lstIVforClone[0].IV_Facility_Chemo_Rate__c = lstIV[0].IV_Facility_Chemo_Rate__c;
        lstIVforClone[0].IV_Facility_Diluents_Cost__c = lstIV[0].IV_Facility_Diluents_Cost__c;
        lstIVforClone[0].IV_Facility_Flush_Cost__c = lstIV[0].IV_Facility_Flush_Cost__c;
        lstIVforClone[0].IV_Facility_Hydration_Basis__c = lstIV[0].IV_Facility_Hydration_Basis__c;
        lstIVforClone[0].IV_Facility_Hydration_Cost__c = lstIV[0].IV_Facility_Hydration_Cost__c;
        lstIVforClone[0].IV_Facility_Hydration_Rate__c = lstIV[0].IV_Facility_Hydration_Rate__c;
        lstIVforClone[0].IV_Facility_Hyd_24hr_Bag__c = lstIV[0].IV_Facility_Hyd_24hr_Bag__c;
        lstIVforClone[0].IV_Facility_Hyd_24hr_Basis__c = lstIV[0].IV_Facility_Hyd_24hr_Basis__c;
        lstIVforClone[0].IV_Facility_Other_Basis__c = lstIV[0].IV_Facility_Other_Basis__c;
        lstIVforClone[0].IV_Facility_Other_Cost__c = lstIV[0].IV_Facility_Other_Cost__c;
        lstIVforClone[0].IV_Facility_Other_Rate__c = lstIV[0].IV_Facility_Other_Rate__c;
        lstIVforClone[0].IV_Facility_Pain_Basis__c = lstIV[0].IV_Facility_Pain_Basis__c;
        lstIVforClone[0].IV_Facility_Pain_Cost__c = lstIV[0].IV_Facility_Pain_Cost__c;
        lstIVforClone[0].IV_Facility_Pain_Rate__c = lstIV[0].IV_Facility_Pain_Rate__c;
        lstIVforClone[0].IV_Facility_Special_Pump_Basis__c = lstIV[0].IV_Facility_Special_Pump_Basis__c;
        lstIVforClone[0].IV_Facility_Special_Pump_Cost__c = lstIV[0].IV_Facility_Special_Pump_Cost__c;
        lstIVforClone[0].IV_Facility_Special_Pump_Rate__c = lstIV[0].IV_Facility_Special_Pump_Rate__c;
        lstIVforClone[0].IV_Facility_Standard_Pump_Basis__c = lstIV[0].IV_Facility_Standard_Pump_Basis__c;
        lstIVforClone[0].IV_Facility_Standard_Pump_Cost__c = lstIV[0].IV_Facility_Standard_Pump_Cost__c;
        lstIVforClone[0].IV_Facility_Standard_Pump_Rate__c = lstIV[0].IV_Facility_Standard_Pump_Rate__c;
        lstIVforClone[0].IV_Facility_TPN_1L_Basis__c = lstIV[0].IV_Facility_TPN_1L_Basis__c;
        lstIVforClone[0].IV_Facility_TPN_1L_Cost__c = lstIV[0].IV_Facility_TPN_1L_Cost__c;
        lstIVforClone[0].IV_Facility_TPN_1L_Rate__c = lstIV[0].IV_Facility_TPN_1L_Rate__c;
        lstIVforClone[0].IV_Facility_TPN_2L_Basis__c = lstIV[0].IV_Facility_TPN_2L_Basis__c;
        lstIVforClone[0].IV_Facility_TPN_2L_Cost__c = lstIV[0].IV_Facility_TPN_2L_Cost__c;
        lstIVforClone[0].IV_Facility_TPN_2L_Rate__c = lstIV[0].IV_Facility_TPN_2L_Rate__c;
        lstIVforClone[0].IV_Facility_TPN_3L_Basis__c = lstIV[0].IV_Facility_TPN_3L_Basis__c;
        lstIVforClone[0].IV_Facility_TPN_3L_Cost__c = lstIV[0].IV_Facility_TPN_3L_Cost__c;
        lstIVforClone[0].IV_Facility_TPN_3L_Rate__c = lstIV[0].IV_Facility_TPN_3L_Rate__c;
        lstIVforClone[0].IV_Flushes__c = lstIV[0].IV_Flushes__c;
        lstIVforClone[0].IV_House_Pump_Basis__c = lstIV[0].IV_House_Pump_Basis__c;
        lstIVforClone[0].IV_House_Pump_Cost__c = lstIV[0].IV_House_Pump_Cost__c;
        lstIVforClone[0].IV_House_Pump_Rate__c = lstIV[0].IV_House_Pump_Rate__c;
        lstIVforClone[0].IV_House_Supplies_Cost__c = lstIV[0].IV_House_Supplies_Cost__c;
        lstIVforClone[0].IV_Pain_Infusion_continuous_infusion__c = lstIV[0].IV_Pain_Infusion_continuous_infusion__c;
        lstIVforClone[0].IV_Private_Pay_Pricing__c = lstIV[0].IV_Private_Pay_Pricing__c;
        lstIVforClone[0].IV_Push_Administration__c = lstIV[0].IV_Push_Administration__c;
        lstIVforClone[0].Management_of_Inotropics_in_the_Heart_Fa__c = lstIV[0].Management_of_Inotropics_in_the_Heart_Fa__c;
        lstIVforClone[0].Midline_IV_Insertion_Cost__c = lstIV[0].Midline_IV_Insertion_Cost__c;
        lstIVforClone[0].Midline_IV_Insertion_Supplies__c = lstIV[0].Midline_IV_Insertion_Supplies__c;
        lstIVforClone[0].Midline_IV_Insertion_wUS_Cost__c = lstIV[0].Midline_IV_Insertion_wUS_Cost__c;
        lstIVforClone[0].Midline_IV_Insertion_wUS_Supplies__c = lstIV[0].Midline_IV_Insertion_wUS_Supplies__c;
        lstIVforClone[0].Nurse_AfterHours_Fee__c = lstIV[0].Nurse_AfterHours_Fee__c;
        lstIVforClone[0].Nurse_Consulting_Fee__c = lstIV[0].Nurse_Consulting_Fee__c;
        lstIVforClone[0].Nursing_CEUs__c = lstIV[0].Nursing_CEUs__c;
        lstIVforClone[0].Pain_Management_Patient_Controlled_Ana__c = lstIV[0].Pain_Management_Patient_Controlled_Ana__c;
        lstIVforClone[0].Parenteral_Nutrition_TPN_PPN__c = lstIV[0].Parenteral_Nutrition_TPN_PPN__c;
        lstIVforClone[0].Peripheral_IV_Insertion_Cost__c = lstIV[0].Peripheral_IV_Insertion_Cost__c;
        lstIVforClone[0].Peripheral_IV_Insertion_Supplies__c = lstIV[0].Peripheral_IV_Insertion_Supplies__c;
        lstIVforClone[0].PICC_Insertion_Cost__c = lstIV[0].PICC_Insertion_Cost__c;
        lstIVforClone[0].PICC_Insertion_Supplies__c = lstIV[0].PICC_Insertion_Supplies__c;
        lstIVforClone[0].PICC_Insertion_wUS_Cost__c = lstIV[0].PICC_Insertion_wUS_Cost__c;
        lstIVforClone[0].PICC_Insertion_wUS_Supplies__c = lstIV[0].PICC_Insertion_wUS_Supplies__c;
        lstIVforClone[0].PICC_Removal_Cost__c = lstIV[0].PICC_Removal_Cost__c;
        lstIVforClone[0].PICC_Removal_Non_Tunneled_Catheter__c = lstIV[0].PICC_Removal_Non_Tunneled_Catheter__c;
        lstIVforClone[0].PICC_Removal_Supplies__c = lstIV[0].PICC_Removal_Supplies__c;
        lstIVforClone[0].Private_Pay_Pricing__c = lstIV[0].Private_Pay_Pricing__c;
        lstIVforClone[0].Specialty_Pump_Sigma_Spectrum_CADD_Cu__c = lstIV[0].Specialty_Pump_Sigma_Spectrum_CADD_Cu__c;
        lstIVforClone[0].Standard_Pole_Mounted_Pump__c = lstIV[0].Standard_Pole_Mounted_Pump__c;
        lstIVforClone[0].State__c = lstIV[0].State__c;
                
                update lstIVforClone;
        
            }
        
        List<Financial_Info__c> lstPwFI = getFinancialInfo(pricingWorkSheet.Id);
        List<Financial_Info__c> lstClonePwFI = getFinancialInfo(pwclone.Id);
        
        /*if(lstPwFI.size() > 0 && lstClonePwFI.size() > 0)
        {
               // lstClonePwFI[0].Total_Annual_Revenue_All_Payor_Types_cu__c =lstPwFI[0].Total_Annual_Revenue_All_Payor_Types_cu__c;
                //lstClonePwFI[0].Total_Annual_Revenue1_All_payor_types__c =lstPwFI[0].Total_Annual_Revenue1_All_payor_types__c;
                //lstClonePwFI[0].Total_Annual_Facility_Revenue_Projected__c =lstPwFI[0].Total_Annual_Facility_Revenue_Projected__c;
                //lstClonePwFI[0].Total_Annual_Facility_Revenue_Current__c=lstPwFI[0].Total_Annual_Facility_Revenue_Current__c;
                lstClonePwFI[0].Revenue_Expected_Projected__c =lstPwFI[0].Revenue_Expected_Projected__c;
                lstClonePwFI[0].Revenue_Expected_Current__c =lstPwFI[0].Revenue_Expected_Current__c;
                //lstClonePwFI[0].Pricing_Worksheet__r.Account__c =lstPwFI[0].Pricing_Worksheet__r.Account__c ;
                //lstClonePwFI[0].Pricing_Worksheet__c =lstPwFI[0].Pricing_Worksheet__c;
                lstClonePwFI[0].Name =lstPwFI[0].Name;
                lstClonePwFI[0].Gross_Margin_Percentage_Projected__c =lstPwFI[0].Gross_Margin_Percentage_Projected__c;
                lstClonePwFI[0].Gross_Margin_Percentage_Current__c =lstPwFI[0].Gross_Margin_Percentage_Current__c;
                lstClonePwFI[0].Facility_Gross_Margin_Percentage_Project__c =lstPwFI[0].Facility_Gross_Margin_Percentage_Project__c;
                lstClonePwFI[0].Facility_Gross_Margin_Percentage_Current__c =lstPwFI[0].Facility_Gross_Margin_Percentage_Current__c;
                lstClonePwFI[0].Facility_A_R_Information_Projected__c =lstPwFI[0].Facility_A_R_Information_Projected__c;
                lstClonePwFI[0].Facility_A_R_Information_Current__c =lstPwFI[0].Facility_A_R_Information_Current__c;
                lstClonePwFI[0].Facility_A_R_Balance_Owed_than_Existing__c =lstPwFI[0].Facility_A_R_Balance_Owed_than_Existing__c;
                lstClonePwFI[0].Facility_A_R_Balance_DSO_calculated_Cu__c =lstPwFI[0].Facility_A_R_Balance_DSO_calculated_Cu__c;
                lstClonePwFI[0].FP_A_Chain_Info__c =lstPwFI[0].FP_A_Chain_Info__c;
                lstClonePwFI[0].Estimated_Payroll_Projected__c =lstPwFI[0].Estimated_Payroll_Projected__c;
                lstClonePwFI[0].Estimated_Payroll_Current__c =lstPwFI[0].Estimated_Payroll_Current__c;
                lstClonePwFI[0].Estimated_Other_Cost_of_Sales_Projected__c =lstPwFI[0].Estimated_Other_Cost_of_Sales_Projected__c;
                lstClonePwFI[0].Estimated_Other_Cost_of_Sales_Current__c =lstPwFI[0].Estimated_Other_Cost_of_Sales_Current__c;
                lstClonePwFI[0].Estimated_Operating_Profit_Projected__c =lstPwFI[0].Estimated_Operating_Profit_Projected__c;
                lstClonePwFI[0].Estimated_Operating_Profit_Current__c =lstPwFI[0].Estimated_Operating_Profit_Current__c;
                lstClonePwFI[0].Estimated_Gross_Margin_Projected__c =lstPwFI[0].Estimated_Gross_Margin_Projected__c;
                lstClonePwFI[0].Estimated_Gross_Margin_Percent_Projected__c =lstPwFI[0].Estimated_Gross_Margin_Percent_Projected__c;
                lstClonePwFI[0].Estimated_Gross_Margin_Percent_Current__c =lstPwFI[0].Estimated_Gross_Margin_Percent_Current__c;
                lstClonePwFI[0].Estimated_Gross_Margin_Current__c =lstPwFI[0].Estimated_Gross_Margin_Current__c;
                lstClonePwFI[0].Estimated_G_A_Projected__c =lstPwFI[0].Estimated_G_A_Projected__c;
                lstClonePwFI[0].Estimated_G_A_Current__c =lstPwFI[0].Estimated_G_A_Current__c;
                lstClonePwFI[0].Estimated_Delivery_Projected__c =lstPwFI[0].Estimated_Delivery_Projected__c;
                lstClonePwFI[0].Estimated_Delivery_Current__c =lstPwFI[0].Estimated_Delivery_Current__c;
                lstClonePwFI[0].Band_Designation__c =lstPwFI[0].Band_Designation__c;
                lstClonePwFI[0].Annual_Third_Party_Insurance_Revenue_Pro__c =lstPwFI[0].Annual_Third_Party_Insurance_Revenue_Pro__c;
                lstClonePwFI[0].Annual_Third_Party_Insurance_Revenue_Cur__c =lstPwFI[0].Annual_Third_Party_Insurance_Revenue_Cur__c;
                lstClonePwFI[0].Annual_Private_Pay_Revenue_Projected__c =lstPwFI[0].Annual_Private_Pay_Revenue_Projected__c;
                lstClonePwFI[0].Annual_Private_Pay_Revenue_Current__c = lstPwFI[0].Annual_Private_Pay_Revenue_Current__c;
                lstClonePwFI[0].Annual_Medicare_Part_D_Revenue_Projected__c =lstPwFI[0].Annual_Medicare_Part_D_Revenue_Projected__c;
                lstClonePwFI[0].Annual_Medicare_Part_D_Revenue_Current__c =lstPwFI[0].Annual_Medicare_Part_D_Revenue_Current__c;
                lstClonePwFI[0].Annual_Medicaid_Revenue_Projected__c =lstPwFI[0].Annual_Medicaid_Revenue_Projected__c;
                lstClonePwFI[0].Annual_Medicaid_Revenue_Current__c =lstPwFI[0].Annual_Medicaid_Revenue_Current__c;
                lstClonePwFI[0].Annual_Facility_Revenue_RX_Projected__c =lstPwFI[0].Annual_Facility_Revenue_RX_Projected__c;
                lstClonePwFI[0].Annual_Facility_Revenue_RX_Current__c =lstPwFI[0].Annual_Facility_Revenue_RX_Current__c;
                lstClonePwFI[0].Annual_Facility_Revenue_Other_See_Com__c =lstPwFI[0].Annual_Facility_Revenue_Other_See_Com__c;
                lstClonePwFI[0].Annual_Facility_Revenue_Medical_Record__c =lstPwFI[0].Annual_Facility_Revenue_Medical_Record__c;
                lstClonePwFI[0].Annual_Facility_Revenue_IV_Projected__c =lstPwFI[0].Annual_Facility_Revenue_IV_Projected__c;
                lstClonePwFI[0].Annual_Facility_Revenue_IV_Current__c =lstPwFI[0].Annual_Facility_Revenue_IV_Current__c;
                lstClonePwFI[0].Annual_Facility_Revenue_Consulting_Pha__c =lstPwFI[0].Annual_Facility_Revenue_Consulting_Pha__c;
                lstClonePwFI[0].Annual_Facility_Revenue1_Other_See_Com__c =lstPwFI[0].Annual_Facility_Revenue1_Other_See_Com__c;
                lstClonePwFI[0].Annual_Facility_Revenue1_Medical_Record__c =lstPwFI[0].Annual_Facility_Revenue1_Medical_Record__c;
                lstClonePwFI[0].Annual_Facility_Revenue1_Consulting_Pha__c =lstPwFI[0].Annual_Facility_Revenue1_Consulting_Pha__c;
                lstClonePwFI[0].Account__c =lstPwFI[0].Account__c;
                lstClonePwFI[0].Account__r.SNF_Beds__c =lstPwFI[0].Account__r.SNF_Beds__c;
                lstClonePwFI[0].Account__r.ALF_Beds__c =lstPwFI[0].Account__r.ALF_Beds__c;
                lstClonePwFI[0].Account__r.Other_Beds__c =lstPwFI[0].Account__r.Other_Beds__c;
                
                update lstClonePwFI;*/
        
        
        //redirect to new record
        pagereference pr = new pagereference('/' + pwClone.Id);
        pr.setredirect(true);
        return pr;   
        }catch(Exception ex)
        {
            ApexPages.addMessages(ex);
            return null;    
        }     
    }
    
    
    private List<Financial_Info__c> getFinancialInfo(Id pwId)
    {
        return [Select    Total_Annual_Revenue_All_Payor_Types_cu__c, Total_Annual_Revenue1_All_payor_types__c, Total_Annual_Facility_Revenue_Projected__c, 
                            Total_Annual_Facility_Revenue_Current__c, Revenue_Expected_Projected__c, Revenue_Expected_Current__c, Pricing_Worksheet__r.Account__c, 
                            Pricing_Worksheet__c, Name, Id, Gross_Margin_Percentage_Projected__c, Gross_Margin_Percentage_Current__c, Facility_Gross_Margin_Percentage_Project__c, 
                            Facility_Gross_Margin_Percentage_Current__c, Facility_A_R_Information_Projected__c, Facility_A_R_Information_Current__c, Facility_A_R_Balance_Owed_than_Existing__c, 
                            Facility_A_R_Balance_DSO_calculated_Cu__c, FP_A_Chain_Info__c, Estimated_Payroll_Projected__c, Estimated_Payroll_Current__c, 
                            Estimated_Other_Cost_of_Sales_Projected__c, Estimated_Other_Cost_of_Sales_Current__c, Estimated_Operating_Profit_Projected__c, 
                            Estimated_Operating_Profit_Current__c, Estimated_Gross_Margin_Projected__c, Estimated_Gross_Margin_Percent_Projected__c, 
                            Estimated_Gross_Margin_Percent_Current__c, Estimated_Gross_Margin_Current__c, Estimated_G_A_Projected__c, Estimated_G_A_Current__c, 
                            Estimated_Delivery_Projected__c, Estimated_Delivery_Current__c, Band_Designation__c, Annual_Third_Party_Insurance_Revenue_Pro__c, 
                            Annual_Third_Party_Insurance_Revenue_Cur__c, Annual_Private_Pay_Revenue_Projected__c, Annual_Private_Pay_Revenue_Current__c, 
                            Annual_Medicare_Part_D_Revenue_Projected__c, Annual_Medicare_Part_D_Revenue_Current__c, Annual_Medicaid_Revenue_Projected__c, 
                            Annual_Medicaid_Revenue_Current__c, Annual_Facility_Revenue_RX_Projected__c, Annual_Facility_Revenue_RX_Current__c, 
                            Annual_Facility_Revenue_Other_See_Com__c, Annual_Facility_Revenue_Medical_Record__c, Annual_Facility_Revenue_IV_Projected__c, 
                            Annual_Facility_Revenue_IV_Current__c, Annual_Facility_Revenue_Consulting_Pha__c, Annual_Facility_Revenue1_Other_See_Com__c, 
                            Annual_Facility_Revenue1_Medical_Record__c, Annual_Facility_Revenue1_Consulting_Pha__c, Account__c, Account__r.SNF_Beds__c, 
                            Account__r.ALF_Beds__c, Account__r.Other_Beds__c
                    From Financial_Info__c f
                    where Pricing_Worksheet__c = :pwId limit 1]; 
        
    }
    
    private List<Internal_IV_Worksheet__c> getIvWorkSheet(Id pwId)
    {
     return [SELECT All_IV_Push__c, Active_Schedule__c,All_Other_Classes_Certifications_Trainin__c,All_Other_IV_Therapies_Not_Specified_dr__c,
    Catheter_Declot_Cost__c,Catheter_Declot_Supplies__c,Certifications_16_Hours_Includes_Stat__c,Cert_Basis__c,Cert_Max__c,Cert_Rate__c,
    Clearing_Thrombotic_Occlusions_in_Centra__c,CreatedById,CreatedDate,Diluents__c,Documentation_IV_POS_MAR_Forms__c,Edu_CVAD_Basis__c,Edu_CVAD_Max__c,Edu_CVAD_Rate__c,
    Edu_Hypodermoclysis_Basis__c,Edu_Hypodermoclysis_Max__c,Edu_Hypodermoclysis_Rate__c,Edu_Certification_Basics__c,Edu_Certification_Rate__c,Edu_Certification_Max__c,Edu_Infusion_Fundamentals_Basis__c,Edu_Infusion_Fundamentals_Max__c,
    Edu_Infusion_Fundamentals_Rate__c,Edu_IV_Push_Basis__c,Edu_IV_Push_Max__c,Edu_IV_Push_Rate__c,Edu_MAR_Document_Basis__c,Edu_MAR_Document_Max__c,
    Edu_MAR_Document_Rate__c,Edu_Mgmt_Inotropics_Basis__c,Edu_Mgmt_Inotropics_Max__c,Edu_Mgmt_Inotropics_Rate__c,Edu_NursCEUs_Basis__c,Edu_NursCEUs_Max__c,
    Edu_NursCEUs_Rate__c,Edu_Other_Basis__c,Edu_Other_Max__c,Edu_Other_Rate__c,Edu_Pain_Mgmt_Basis__c,Edu_Pain_Mgmt_Max__c,Edu_Pain_Mgmt_Rate__c,
    Edu_PICC_Removal_Basis__c,Edu_PICC_Removal_Max__c,Edu_PICC_Removal_Rate__c,Edu_Thrombotic_Occlusions_Basis__c,Edu_Thrombotic_Occlusions_Max__c,
    Edu_Thrombotic_Occlusions_Rate__c,Edu_TPN_Basis__c,Edu_TPN_Max__c,Edu_TPN_Rate__c,Essentials_of_Infusion_Therapy_2_Day_C__c,Hypodermoclysis__c,
    Infusion_Nurse_After_Hours_Fee__c,Infusion_Nurse_Consulting_Service__c,IV_Chemo_Infusion_drug_solution__c,IV_Facility_AB_24hr_Basis__c,
    IV_Facility_AB_24hr_Fee__c,IV_Facility_Additives_Basis__c,IV_Facility_Additives_Cost__c,IV_Facility_Additives_Rate__c,IV_Facility_Antibiotics_BID_Basis__c,
    IV_Facility_Antibiotics_BID_Cost__c,IV_Facility_Antibiotics_BID_Rate__c,IV_Facility_Antibiotics_QD_Basis__c,IV_Facility_Antibiotics_QD_Cost__c,
    IV_Facility_Antibiotics_QD_Rate__c,IV_Facility_Antibiotics_QID_Basis__c,IV_Facility_Antibiotics_QID_Cost__c,IV_Facility_Antibiotics_QID_Rate__c,
    IV_Facility_Antibiotics_TID_Basis__c,IV_Facility_Antibiotics_TID_Cost__c,IV_Facility_Antibiotics_TID_Rate__c,IV_Facility_Catheter_Care_Supplies_Basis__c,
    IV_Facility_Catheter_Care_Supplies_Cost__c,IV_Facility_Catheter_Care_Supplies_Rate__c,IV_Facility_Chemo_Basis__c,IV_Facility_Chemo_Cost__c,
    IV_Facility_Chemo_Rate__c,IV_Facility_Diluents_Cost__c,IV_Facility_Flush_Cost__c,IV_Facility_Hydration_Basis__c,IV_Facility_Hydration_Cost__c,
    IV_Facility_Hydration_Rate__c,IV_Facility_Hyd_24hr_Bag__c,IV_Facility_Hyd_24hr_Basis__c,IV_Facility_Other_Basis__c,IV_Facility_Other_Cost__c,
    IV_Facility_Other_Rate__c,IV_Facility_Pain_Basis__c,IV_Facility_Pain_Cost__c,IV_Facility_Pain_Rate__c,IV_Facility_Special_Pump_Basis__c,
    IV_Facility_Special_Pump_Cost__c,IV_Facility_Special_Pump_Rate__c,IV_Facility_Standard_Pump_Basis__c,IV_Facility_Standard_Pump_Cost__c,
    IV_Facility_Standard_Pump_Rate__c,IV_Facility_TPN_1L_Basis__c,IV_Facility_TPN_1L_Cost__c,IV_Facility_TPN_1L_Rate__c,IV_Facility_TPN_2L_Basis__c,
    IV_Facility_TPN_2L_Cost__c,IV_Facility_TPN_2L_Rate__c,IV_Facility_TPN_3L_Basis__c,IV_Facility_TPN_3L_Cost__c,IV_Facility_TPN_3L_Rate__c,IV_Flushes__c,
    IV_House_Pump_Basis__c,IV_House_Pump_Cost__c,IV_House_Pump_Rate__c,IV_House_Supplies_Cost__c,IV_Pain_Infusion_continuous_infusion__c,IV_Private_Pay_Pricing__c,
    IV_Push_Administration__c, Management_of_Inotropics_in_the_Heart_Fa__c, Midline_IV_Insertion_Cost__c,Midline_IV_Insertion_Supplies__c,Midline_IV_Insertion_wUS_Cost__c,
    Midline_IV_Insertion_wUS_Supplies__c,Name,Notes__c, Nurse_AfterHours_Fee__c,Nurse_Consulting_Fee__c,Nursing_CEUs__c,OwnerId,Pain_Management_Patient_Controlled_Ana__c,
    Parenteral_Nutrition_TPN_PPN__c, Peripheral_IV_Insertion_Cost__c,Peripheral_IV_Insertion_Supplies__c,PICC_Insertion_Cost__c,PICC_Insertion_Supplies__c,
    PICC_Insertion_wUS_Cost__c, PICC_Insertion_wUS_Supplies__c,PICC_Removal_Cost__c,PICC_Removal_Non_Tunneled_Catheter__c,PICC_Removal_Supplies__c, Private_Pay_Pricing__c,
    Specialty_Pump_Sigma_Spectrum_CADD_Cu__c,Standard_Pole_Mounted_Pump__c,State__c FROM Internal_IV_Worksheet__c  where Pricing_Worksheet__c = :pwId ];
    
    }
                           //Record lock Feature was implemented for this code 05/2016
    //Cancel Action
    public PageReference cancelWorksheet() {
        /* if(pricingWorkSheet.Status__c == 'In Progress' )
      {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'You cannot modify submitted pricing worksheet until Approved'));
            return null;
      }
        else*/
      { 
        pricingWorkSheet.Status__c = 'Cancelled';
        

        try {
            
            update pricingWorkSheet;
            pagereference pr = new pagereference('/' + pwid);
                pr.setredirect(true);
            return pr;          
        }
        catch (DMLexception e) {
            system.debug('DML Exception: ' + e.getMessage());
            
            return null;
        }
        
    }
    }
    //This code was implemnted for submit chain button 05/23/2016 (start)
     public PageReference submitChain() {
      if(pricingWorkSheet.Band__c == null)
      {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Submit chain Action cannot be performed when the chain field is blank'));
            return null;
      }
        else
      {
       system.debug('>>>>>>>>>pwAccount.ParentId'+pwAccount.ParentId);
        if(pwAccount.Id !=null)
        {
            List<Pricing_Worksheet__c> pwList = [select Id,Status__c from Pricing_Worksheet__c where Account__r.Parent_Account_Name__c = :pwAccount.Parent_Account_Name__c AND Status__c !='Approved'];
            system.debug('>>>>>>>pwList'+pwList);
            List<Pricing_Worksheet__c> pwListUpdate = new List<Pricing_Worksheet__c>();
            For(Pricing_Worksheet__c objPwList : pwList)
            {
                objPwList.Status__c = 'In Progress';
                pwListUpdate.add(objPwList);
            }
             
            system.debug('>>>>>>>pwListUpdate'+pwListUpdate);
            
            if(pwListUpdate.size() > 0)
            {
                try {
                    update pwListUpdate;
                    
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(new String[] {Userinfo.getUserEmail()});
                    mail.setReplyTo(Userinfo.getUserEmail());
                    mail.setSenderDisplayName('Pricing worksheet submitted ');
                    mail.setSubject('Pricing worksheet submitted for ('+ pricingWorkSheet.Band__c +') chain');
                    string strEmailbody = 'Greeting!'+'<br>'+
                                      'Below pricing worksheets are submitted for approval.'+'<br>'+
                                      'All the below pricingworksheets belong to'+'<br>'+
                                      'Parent account name:'+ pwAccount.Parent_Account_Name__c +'<br>';
                                      
                    For(Pricing_Worksheet__c objPwList: pwListUpdate)   
                    {
                      strEmailbody+= System.Url.getSalesforceBaseUrl().toExternalForm() + '/apex/pwView?Id=' + objPwList.Id +'<br>'; 
                    }       
                    strEmailbody += 'Thanks,' + '<br>';             
                    mail.setHtmlBody('<html><body><p>'+strEmailbody+'</p></body></html>');  
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });                   
                }
                catch (DMLexception e) {
                    system.debug('DML Exception: ' + e.getMessage());    
                    return null;
                }
            }
        }
        pagereference pr = new pagereference('/' + pwid);
        pr.setredirect(true);
        return pr;

       
              
        }
     }                                                       //(END)
        
    //Submit Approval
    public PageReference submitApproval() {
     
    
       
       
        //Set Values
        pricingWorkSheet.Status__c = 'In Progress';
        pricingWorkSheet.Date_Submitted__c = Date.today();
        pricingWorkSheet.Submitted_By__c = curUser;

        try {
            update pricingWorkSheet;
            pagereference pr = new pagereference('/' + pwid);
                pr.setredirect(true);
            return pr;          
        }
        catch (DMLexception e) {
            system.debug('DML Exception: ' + e.getMessage());
            
            return null;
         }
       
    }   
    //Approve PW
        //Approve Credit    
        public PageReference aCredit() {
            pricingWorkSheet.Approval_Date_Credit__c = Date.today();
            pricingWorkSheet.Approver_Credit__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                        
                system.debug('DML Exception: ' + e.getMessage());
                /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        

        }
        //Approve CAC
        public PageReference aCAC() {
            pricingWorkSheet.Approval_Date_CAC__c = Date.today();
            pricingWorkSheet.Approver_Capital_Assets_and_Compliance__c =curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
                /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve Legal
        public PageReference aLegal() {
            pricingWorkSheet.Approval_Date_Legal__c = Date.today();
            pricingWorkSheet.Approver_Legal__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                /*pricingWorkSheet.Approval_Date_Legal__c = null;
                pricingWorkSheet.Approver_Legal__c = null;*/
                
                system.debug('DML Exception: ' + e.getMessage());
                /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve DOP
        public PageReference aDOP() {

            pricingWorkSheet.Approval_Date_DOP__c = Date.today();
            pricingWorkSheet.Approver_Director_of_Pricing__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
            /*pricingWorkSheet.Approval_Date_DOP__c = null;
            pricingWorkSheet.Approver_Director_of_Pricing__c = null;*/
                
                system.debug('DML Exception: ' + e.getMessage());
                /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve CP
        public PageReference aCP() {

            pricingWorkSheet.Approval_Date_CP__c = Date.today();
            pricingWorkSheet.Approver_Contract_Pricing__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
                /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve Ad Hoc
        public PageReference aAH() {

            pricingWorkSheet.Approval_Date_Ad_Hoc__c = Date.today();

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
              /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve Pricing Analysis
        public PageReference aPA() {

            pricingWorkSheet.Approval_Date_PA__c = Date.today();
            pricingWorkSheet.Approver_Pricing_Analysis__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
                ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,e.getMessage()));
                return null;
            }
        }
        //Approve VPO
        public PageReference aVPO() {

            pricingWorkSheet.Approval_Date_VPO__c = Date.today();               
            pricingWorkSheet.Approver_VPO__c = curUser;

            try {                               
                 update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                /*pricingWorkSheet.Approval_Date_VPO__c = null;
                pricingWorkSheet.Approver_VPO__c = null;*/
                
                system.debug('DML Exception: ' + e.getMessage());
                /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve Ad Hoc
        public PageReference aIVP() {

            pricingWorkSheet.Approval_Date_IV_P__c = Date.today();
            pricingWorkSheet.Approver_IV_Pricing__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
              /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve IV: Rx
        public PageReference aIVR() {

            pricingWorkSheet.Approval_Date_IV_R__c = Date.today();
            pricingWorkSheet.Approver_IV_Rx__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
               /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve IV: Senior Director
        public PageReference aIVS() {

            pricingWorkSheet.Approval_Date_IV_SD__c= Date.today();
            pricingWorkSheet.Approver_IV_SD__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
             /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }
        //Approve E Prescribe
        public PageReference aEP() {

            pricingWorkSheet.Approval_Date_EP__c = Date.today();
            pricingWorkSheet.Approver_E_Prescribe__c = curUser;

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            /*ApexPages.addMessage(new Apexpages.Message(ApexPages.severity.Error,'Proposal type and Submission Source are required'));*/
                return null;
            }
        }

    //Reject
        //Credit
        public PageReference rjCredit() { 
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'Credit';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_Credit__c;
            pricingWorkSheet.Rejected_by_Credit__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //DOP
        public PageReference rjDOP() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'Director of Pricing';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_DOP__c;          
            pricingWorkSheet.Rejected_by_DOP__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }   
        }
        //Contract Pricing
        public PageReference rjCP() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'Contract Pricing';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_CP__c;
            pricingWorkSheet.Rejected_by_CP__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //Ad Hoc
        public PageReference rjAH() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = string.ValueOf(pricingWorkSheet.AdHocName__c);
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_Ad_Hoc__c;
            pricingWorkSheet.Rejected_by_ADHOC__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //Legal
        public PageReference rjLegal() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'Legal';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_Legal__c;
            pricingWorkSheet.Rejected_By_Legal__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
                
                return null;
            }   
        }
        //Capital Assets and Compliance
        public PageReference rjCAC() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'Capital Assets and Compliance';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_CAC__c;
            pricingWorkSheet.Rejected_by_CAC__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();

            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //Pricing Analysis
        public PageReference rjPA() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'Pricing Analysis';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_PA__c;
            pricingWorkSheet.Rejected_by_PA__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //VPO
        public PageReference rjVPO() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'VPO';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_VPO__c;
            pricingWorkSheet.Rejected_by_VPO__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
                   
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }

        //IV: Pricing
        public PageReference rjIVP() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'IV: Pricing';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_IV_P__c;
            pricingWorkSheet.Rejected_by_IVP__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //IV: Rx
        public PageReference rjIVR() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'IV: Rx Claim';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_IV_R__c;
            pricingWorkSheet.Rejected_by_IVR__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //IV: Senior Director
        public PageReference rjIVS() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'IV: Senior Director';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_IV_S__c;
            pricingWorkSheet.Rejected_by_IVS__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
                    
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
        //E Prescribe
        public PageReference rjEP() {
            pricingWorkSheet.Status__c = 'REJECTED';
            pricingWorkSheet.Reject_Department__c = 'E Prescribe';
            pricingWorkSheet.Reject_Notes__c = pricingWorkSheet.Approval_Notes_EP__c;
            pricingWorkSheet.Rejected_by_EP__c = cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
        
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }

    //Recall operation
    //VPO
    public PageReference rlVPO() {
         pricingWorkSheet.Approval_Date_VPO__c =null;
         pricingWorkSheet.Approver_VPO__c = null;
         pricingWorkSheet.Recalled_by_VPO__c=cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
                         
         
         try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
         
     } 
     //Credit
    public PageReference rlCredit() {
         pricingWorkSheet.Approval_Date_Credit__c =null;
         pricingWorkSheet.Approver_Credit__c = null;
         pricingWorkSheet.Recalled_by_Credit__c=cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
                
                        
         
         try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
         
     } 
     //Contract Pricing
     public PageReference rlCP() {
         pricingWorkSheet.Approval_Date_CP__c  =null;
         pricingWorkSheet.Approver_Contract_Pricing__c = null;
         pricingWorkSheet.Recalled_by_CP__c=cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
                
                        
         
         try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
    } 
      
    //Director of Pricing
     public PageReference rlDOP() {
         pricingWorkSheet.Approver_Director_of_Pricing__c  =null;
         pricingWorkSheet.Approval_Date_DOP__c = null;
         pricingWorkSheet.Recalled_by_DOP__c=cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
                
                        
         
         try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
                
                return null;
            }
    }
    //Adhoc
    public PageReference rlAH() {
    pricingWorkSheet.Approval_Date_Ad_Hoc__c = null;
    pricingWorkSheet.Approver_Ad_Hoc__c =null;
    pricingWorkSheet.Recalled_by_ADHOC__c =null;
    
       try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
    }
    //Capital Assets and Compliances
    public PageReference rlCAC() {
    pricingWorkSheet.Approval_Date_CAC__c = null;
    pricingWorkSheet.Approver_Capital_Assets_and_Compliance__c =null;
    pricingWorkSheet.Recalled_by_CAC__c =cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
    
       try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
    }
    
    //E Prescribe
    public PageReference rlEP() {
    pricingWorkSheet.Approval_Date_EP__c = null;
    pricingWorkSheet.Approver_E_Prescribe__c = null;
    pricingWorkSheet.Recalled_by_EP__c =cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
    
      try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
    }
    
    //IV Pricing
    public PageReference rlIVP() {
    pricingWorkSheet.Approval_Date_IV_P__c = null;
    pricingWorkSheet.Approver_IV_Pricing__c = null;
    pricingWorkSheet.Recalled_by_IVP__c =cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
    //IV Pricing:RX
    public PageReference rlIVR() {
    pricingWorkSheet.Approval_Date_IV_R__c = null;
    pricingWorkSheet.Approver_IV_Rx__c = null;
    pricingWorkSheet.Recalled_by_IVR__c =cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
      //IV Pricing:Senior Director
      public PageReference rlIVS() { 
      pricingWorkSheet.Approval_Date_IV_SD__c= null;
      pricingWorkSheet.Approver_IV_SD__c = null;
      pricingWorkSheet.Recalled_by_IVS__c =cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW();
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        } 
    
      //Pricing Analyst
      public PageReference rlPA() {

            pricingWorkSheet.Approval_Date_PA__c = null;
            pricingWorkSheet.Approver_Pricing_Analysis__c = null;
            pricingWorkSheet.Recalled_by_PA__c =cUser.Firstname+cUser.Lastname+ ' ' +SYSTEM.NOW(); 
            try {
                update pricingWorkSheet;
                pagereference pr = new pagereference('/' + pwid);
                    pr.setredirect(true);
                return pr;          
            }
            catch (DMLexception e) {
                system.debug('DML Exception: ' + e.getMessage());
            
                return null;
            }
        }
      

    //Approve Band
    public void approveBand(String Band, String Department) {
   

        List<Pricing_Worksheet__c> bList = new List<Pricing_Worksheet__c>();
        List<Pricing_Worksheet__c> bandUpdate = new List<Pricing_Worksheet__c>();

        blist = [select Id, band__c from Pricing_Worksheet__c where band__c =: Band];
         system.debug(LoggingLevel.info,'>>>>>>blist'+blist);
        if (blist.size()>0){
            for (Pricing_Worksheet__c pw2 : blist) {
             system.debug(LoggingLevel.info,'<<<<<<<pw2'+pw2);
                Pricing_Worksheet__c pwBand = new Pricing_Worksheet__c();
                    pwBand.id = pw2.id;

                    if (Department == 'Credit'){
                        pwBand.Approval_Notes_Credit__c = pricingWorkSheet.Approval_Notes_Credit__c;
                        pwBand.Approval_Date_Credit__c = Date.today();
                        pwBand.Approver_Credit__c = curUser;                  
                    }
                    if (Department == 'Pricing Analysis'){
                        pwBand.Approval_Notes_PA__c = pricingWorkSheet.Approval_Notes_PA__c;
                        pwBand.Approval_Date_PA__c = Date.today();
                        pwBand.Approver_Pricing_Analysis__c = curUser;            
                    }
                    if (Department == 'Capital Assets and Compliance'){
                        pwBand.Approval_Notes_CAC__c = pricingWorkSheet.Approval_Notes_CAC__c;
                        pwBand.Approval_Date_CAC__c = Date.today();
                        pwBand.Approver_Capital_Assets_and_Compliance__c =curUser;                        
                    }
                    if (Department == 'Legal'){
                        pwBand.Approval_Notes_Legal__c = pricingWorkSheet.Approval_Notes_Legal__c;
                        pwBand.Approval_Date_Legal__c = Date.today();
                        pwBand.Approver_Legal__c = curUser;       
                    }
                    if (Department == 'Contract Pricing'){
                        pwBand.Approval_Notes_CP__c = pricingWorkSheet.Approval_Notes_CP__c;
                        pwBand.Approval_Date_CP__c = Date.today();
                        pwBand.Approver_Contract_Pricing__c = curUser;
                    }
                    if (Department == 'VPO'){
                        system.debug(LoggingLevel.info,'*******Department'+Department);
                        pwBand.Approval_Notes_VPO__c = pricingWorkSheet.Approval_Notes_VPO__c;
                        pwBand.Approval_Date_VPO__c = Date.today();
                     // pwBand.Approver_Director_of_Pricing__c = curUser; 
                        pwBand.Approver_VPO__c = curUser;
                        
                    }
                    if (Department == 'Director of Pricing'){                       
                        pwBand.Approval_Notes_DOP__c = pricingWorkSheet.Approval_Notes_DOP__c;
                        pwBand.Approval_Date_DOP__c = Date.today();
                        pwBand.Approver_Director_of_Pricing__c = curUser; 
                        
                        
                    }

                    if (Department == 'IV: Pricing'){
                        pwBand.Approval_Notes_IV_P__c = pricingWorkSheet.Approval_Notes_IV_P__c;
                        pwBand.Approval_Date_CAC__c = Date.today();
                        pwBand.Approver_Capital_Assets_and_Compliance__c = curUser;                        
                    }

                    if (Department == 'IV: Rx Claim'){
                        pwBand.Approval_Notes_IV_R__c = pricingWorkSheet.Approval_Notes_IV_R__c;
                        pwBand.Approval_Date_Legal__c = Date.today();
                        pwBand.Approver_Legal__c = curUser;       
                    }

                    if (Department == 'IV: Senior Director'){
                        pwBand.Approval_Notes_IV_S__c = pricingWorkSheet.Approval_Notes_IV_S__c;
                        pwBand.Approval_Date_CP__c = Date.today();
                        pwBand.Approver_Contract_Pricing__c = curUser;
                    }

                    if (Department == 'E Prescribe'){
                        pwBand.Approval_Notes_EP__c = pricingWorkSheet.Approval_Notes_EP__c;
                        pwBand.Approval_Date_DOP__c = Date.today();
                        pwBand.Approver_Director_of_Pricing__c = curUser; 
                    }                   
                bandUpdate.add(pwBand);
            }
   
        //DML Operations
        try{
            if (bandUpdate.size()>0) {
           //     update bList;
           update bandUpdate;
            }
        }
        catch (DMLexception e) {
            system.debug('Method-->approveBand DML Exception: ' + e.getMessage());
        }
            
        }
    }

    public PageReference abCredit() { 
        approveBand(pricingWorksheet.Band__c, 'Credit');

        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;          
    }

    public PageReference abDOP() {
        approveBand(pricingWorksheet.Band__c, 'Director of Pricing');   
        
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;  
    }

    public PageReference abCP() {
        approveBand(pricingWorksheet.Band__c, 'Contract Pricing');

        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;  
    }

    public PageReference abLegal() {
        approveBand(pricingWorksheet.Band__c, 'Legal');
       
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;  
    }

    public PageReference abCAC() {
        approveBand(pricingWorksheet.Band__c, 'Capital Assets and Compliance');

        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }

    public PageReference abPA() {
        approveBand(pricingWorksheet.Band__c, 'Pricing Analysis');
    
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }

    public PageReference abVPO() {
        system.debug(LoggingLevel.info,'>>>>abVPO CALL'+pricingWorksheet.Band__c);
        approveBand(pricingWorksheet.Band__c, 'VPO');
    
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }

    public PageReference abIVP() {
        approveBand(pricingWorksheet.Band__c, 'IV: Pricing');
    
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }

    public PageReference abIVR() {
        approveBand(pricingWorksheet.Band__c, 'IV: Rx Claim');
    
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }

    public PageReference abIVS() {
        approveBand(pricingWorksheet.Band__c, 'IV: Senior Director');
    
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }

    public PageReference abEP() {
        approveBand(pricingWorksheet.Band__c, 'E Prescribe');
    
        pagereference pr = new pagereference('/' + pwid);
            pr.setredirect(true);
        return pr;      
    }


}