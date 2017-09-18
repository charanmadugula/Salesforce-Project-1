//========================================================================
//  Object: ext_InternalIVPricing
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for InternalIVPricing VF Page
//========================================================================
//          Date            Purpose
// Changes: 11/27/2015      Initial Version
//========================================================================

public with sharing class ext_InternalIVPricing {

//Variables
    public Internal_IV_Worksheet__c internalIV {get;set;}
    public Internal_IV_Worksheet__c IVRec {get;set;}
    public Pricing_Worksheet__c pricingWorkSheet {get;set;}
    public id ivId {get;set;}
    public Boolean isError{get;set;}
    public String AccountState {get;set;}
    public Boolean isAdmin {get;set;}   
    public Boolean save {get;set;}
    public User pwUser {get;set;}
     public id curUser {get;set;}
    //public string strpwid;

    //Constructor
    public ext_InternalIVPricing(ApexPages.StandardController stdController) {
    
        //Get Record Id
        ivId = ApexPages.currentPage().getParameters().get('id');
       // strpwid =   ApexPages.currentPage().getParameters().get('pwid');
        //Get Internal IV
        internalIV = globalHelper.getInternalIVFields(ivId);
      system.debug(LoggingLevel.Info,'>>>>>>InternalIV'+internalIV);
        //Get Pricing Worksheet
        if(internalIV.Pricing_Worksheet__c!= null)
        pricingWorkSheet = globalHelper.getPricingWorksheetFields(internalIV.Pricing_Worksheet__c);
      system.debug(LoggingLevel.Info,'>>>>>>pricingWorkSheet'+pricingWorkSheet);
        //Populate AccountState Variable
        AccountState = pricingWorkSheet.State__c;
        system.debug(LoggingLevel.Info,'>>>>>>AccountState'+AccountState);
        system.debug(LoggingLevel.Info,'>>>>>>ActiveSchedule'+internalIV.Active_Schedule__c); 
      //isadmin
      //set initial values
      isadmin = False;
      curUser = Userinfo.getUserId();

      pwUser = globalHelper.getUserFields(CurUser);

      isAdmin = globalHelper.isUserAdmin(pwUser.Id);
      //save
      //set initial values
      save=False;
       if((pricingWorkSheet.status__c == 'New'&&!isadmin) || (pricingWorkSheet.status__c == 'In Progress' && isadmin)||pricingWorkSheet.status__c == 'Rejected' ){
            save = true;
            }   
      
      

    }
    
    public void populateValues(){
        system.debug (LoggingLevel.Info,'>>>>>internalIV.Active_Schedule__c'+internalIV.Active_Schedule__c);
    isError = False;
    if (internalIV.Active_Schedule__c != null){
    IVRec = [SELECT All_IV_Push__c, Active_Schedule__c,All_Other_Classes_Certifications_Trainin__c,All_Other_IV_Therapies_Not_Specified_dr__c,
    Catheter_Declot_Cost__c,Catheter_Declot_Supplies__c,Certifications_16_Hours_Includes_Stat__c,Cert_Basis__c,Cert_Max__c,Cert_Rate__c,
    Clearing_Thrombotic_Occlusions_in_Centra__c,CreatedById,CreatedDate,Diluents__c,Documentation_IV_POS_MAR_Forms__c,Edu_CVAD_Basis__c,Edu_CVAD_Max__c,Edu_CVAD_Rate__c,
    Edu_Hypodermoclysis_Basis__c,Edu_Hypodermoclysis_Max__c,Edu_Hypodermoclysis_Rate__c,Edu_Certification_Basics__c,Edu_Certification_Max__c,Edu_Certification_Rate__c,Edu_Infusion_Fundamentals_Basis__c,Edu_Infusion_Fundamentals_Max__c,
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
    Specialty_Pump_Sigma_Spectrum_CADD_Cu__c,Standard_Pole_Mounted_Pump__c,State__c FROM Internal_IV_Worksheet__c iv 
        where iv.Active_Schedule__c =: internalIV.Active_Schedule__c 
            and iv.State__c = :AccountState
            and iv.Default_Schedule__C =:true LIMIT 1]; 
      system.debug(LoggingLevel.Info,'>>>>>>IVRec'+IVRec);
    try{

        //Populate Default Values
        internalIV.All_IV_Push__c = IVRec.All_IV_Push__c;
        internalIV.All_Other_Classes_Certifications_Trainin__c = IVRec.All_Other_Classes_Certifications_Trainin__c;
        internalIV.All_Other_IV_Therapies_Not_Specified_dr__c = IVRec.All_Other_IV_Therapies_Not_Specified_dr__c;
        internalIV.Catheter_Declot_Cost__c = IVRec.Catheter_Declot_Cost__c;
        internalIV.Catheter_Declot_Supplies__c = IVRec.Catheter_Declot_Supplies__c;
        internalIV.Certifications_16_Hours_Includes_Stat__c = IVRec.Certifications_16_Hours_Includes_Stat__c;
        internalIV.Cert_Basis__c = IVRec.Cert_Basis__c;
        internalIV.Cert_Max__c = IVRec.Cert_Max__c;
        internalIV.Cert_Rate__c = IVRec.Cert_Rate__c;
        internalIV.Clearing_Thrombotic_Occlusions_in_Centra__c = IVRec.Clearing_Thrombotic_Occlusions_in_Centra__c;
        internalIV.Diluents__c = IVRec.Diluents__c;
        internalIV.Documentation_IV_POS_MAR_Forms__c = IVRec.Documentation_IV_POS_MAR_Forms__c;
        internalIV.Edu_CVAD_Basis__c = IVRec.Edu_CVAD_Basis__c;
        internalIV.Edu_CVAD_Max__c = IVRec.Edu_CVAD_Max__c;
        internalIV.Edu_CVAD_Rate__c = IVRec.Edu_CVAD_Rate__c;
        internalIV.Edu_Hypodermoclysis_Basis__c = IVRec.Edu_Hypodermoclysis_Basis__c;
        internalIV.Edu_Hypodermoclysis_Max__c = IVRec.Edu_Hypodermoclysis_Max__c;
        internalIV.Edu_Hypodermoclysis_Rate__c = IVRec.Edu_Hypodermoclysis_Rate__c;
        internalIV.Edu_Certification_Basics__c = IVRec.Edu_Certification_Basics__c;
        internalIV.Edu_Certification_Max__c = IVRec.Edu_Certification_Max__c;
        internalIV.Edu_Certification_Rate__c = IVRec.Edu_Certification_Rate__c;
        internalIV.Edu_Infusion_Fundamentals_Basis__c = IVRec.Edu_Infusion_Fundamentals_Basis__c;
        internalIV.Edu_Infusion_Fundamentals_Max__c = IVRec.Edu_Infusion_Fundamentals_Max__c;
        internalIV.Edu_Infusion_Fundamentals_Rate__c = IVRec.Edu_Infusion_Fundamentals_Rate__c;
        internalIV.Edu_IV_Push_Basis__c = IVRec.Edu_IV_Push_Basis__c;
        internalIV.Edu_IV_Push_Max__c = IVRec.Edu_IV_Push_Max__c;
        internalIV.Edu_IV_Push_Rate__c = IVRec.Edu_IV_Push_Rate__c;
        internalIV.Edu_MAR_Document_Basis__c = IVRec.Edu_MAR_Document_Basis__c;
        internalIV.Edu_MAR_Document_Max__c = IVRec.Edu_MAR_Document_Max__c;
        internalIV.Edu_MAR_Document_Rate__c = IVRec.Edu_MAR_Document_Rate__c;
        internalIV.Edu_Mgmt_Inotropics_Basis__c = IVRec.Edu_Mgmt_Inotropics_Basis__c;
        internalIV.Edu_Mgmt_Inotropics_Max__c = IVRec.Edu_Mgmt_Inotropics_Max__c;
        internalIV.Edu_Mgmt_Inotropics_Rate__c = IVRec.Edu_Mgmt_Inotropics_Rate__c;
        internalIV.Edu_NursCEUs_Basis__c = IVRec.Edu_NursCEUs_Basis__c;
        internalIV.Edu_NursCEUs_Max__c = IVRec.Edu_NursCEUs_Max__c;
        internalIV.Edu_NursCEUs_Rate__c = IVRec.Edu_NursCEUs_Rate__c;
        internalIV.Edu_Other_Basis__c = IVRec.Edu_Other_Basis__c;
        internalIV.Edu_Other_Max__c = IVRec.Edu_Other_Max__c;
        internalIV.Edu_Other_Rate__c = IVRec.Edu_Other_Rate__c;
        internalIV.Edu_Pain_Mgmt_Basis__c = IVRec.Edu_Pain_Mgmt_Basis__c;
        internalIV.Edu_Pain_Mgmt_Max__c = IVRec.Edu_Pain_Mgmt_Max__c;
        internalIV.Edu_Pain_Mgmt_Rate__c = IVRec.Edu_Pain_Mgmt_Rate__c;
        internalIV.Edu_PICC_Removal_Basis__c = IVRec.Edu_PICC_Removal_Basis__c;
        internalIV.Edu_PICC_Removal_Max__c = IVRec.Edu_PICC_Removal_Max__c;
        internalIV.Edu_PICC_Removal_Rate__c = IVRec.Edu_PICC_Removal_Rate__c;
        internalIV.Edu_Thrombotic_Occlusions_Basis__c = IVRec.Edu_Thrombotic_Occlusions_Basis__c;
        internalIV.Edu_Thrombotic_Occlusions_Max__c = IVRec.Edu_Thrombotic_Occlusions_Max__c;
        internalIV.Edu_Thrombotic_Occlusions_Rate__c = IVRec.Edu_Thrombotic_Occlusions_Rate__c;
        internalIV.Edu_TPN_Basis__c = IVRec.Edu_TPN_Basis__c;
        internalIV.Edu_TPN_Max__c = IVRec.Edu_TPN_Max__c;
        internalIV.Edu_TPN_Rate__c = IVRec.Edu_TPN_Rate__c;
        internalIV.Essentials_of_Infusion_Therapy_2_Day_C__c = IVRec.Essentials_of_Infusion_Therapy_2_Day_C__c;
        internalIV.Hypodermoclysis__c = IVRec.Hypodermoclysis__c;
        internalIV.Infusion_Nurse_After_Hours_Fee__c = IVRec.Infusion_Nurse_After_Hours_Fee__c;
        internalIV.Infusion_Nurse_Consulting_Service__c = IVRec.Infusion_Nurse_Consulting_Service__c;
        internalIV.IV_Chemo_Infusion_drug_solution__c = IVRec.IV_Chemo_Infusion_drug_solution__c;
        internalIV.IV_Facility_AB_24hr_Basis__c = IVRec.IV_Facility_AB_24hr_Basis__c;
        internalIV.IV_Facility_AB_24hr_Fee__c = IVRec.IV_Facility_AB_24hr_Fee__c;
        internalIV.IV_Facility_Additives_Basis__c = IVRec.IV_Facility_Additives_Basis__c;
        internalIV.IV_Facility_Additives_Cost__c = IVRec.IV_Facility_Additives_Cost__c;
        internalIV.IV_Facility_Additives_Rate__c = IVRec.IV_Facility_Additives_Rate__c;
        internalIV.IV_Facility_Antibiotics_BID_Basis__c = IVRec.IV_Facility_Antibiotics_BID_Basis__c;
        internalIV.IV_Facility_Antibiotics_BID_Cost__c = IVRec.IV_Facility_Antibiotics_BID_Cost__c;
        internalIV.IV_Facility_Antibiotics_BID_Rate__c = IVRec.IV_Facility_Antibiotics_BID_Rate__c;
        internalIV.IV_Facility_Antibiotics_QD_Basis__c = IVRec.IV_Facility_Antibiotics_QD_Basis__c;
        internalIV.IV_Facility_Antibiotics_QD_Cost__c = IVRec.IV_Facility_Antibiotics_QD_Cost__c;
        internalIV.IV_Facility_Antibiotics_QD_Rate__c = IVRec.IV_Facility_Antibiotics_QD_Rate__c;
        internalIV.IV_Facility_Antibiotics_QID_Basis__c = IVRec.IV_Facility_Antibiotics_QID_Basis__c;
        internalIV.IV_Facility_Antibiotics_QID_Cost__c = IVRec.IV_Facility_Antibiotics_QID_Cost__c;
        internalIV.IV_Facility_Antibiotics_QID_Rate__c = IVRec.IV_Facility_Antibiotics_QID_Rate__c;
        internalIV.IV_Facility_Antibiotics_TID_Basis__c = IVRec.IV_Facility_Antibiotics_TID_Basis__c;
        internalIV.IV_Facility_Antibiotics_TID_Cost__c = IVRec.IV_Facility_Antibiotics_TID_Cost__c;
        internalIV.IV_Facility_Antibiotics_TID_Rate__c = IVRec.IV_Facility_Antibiotics_TID_Rate__c;
        internalIV.IV_Facility_Catheter_Care_Supplies_Basis__c = IVRec.IV_Facility_Catheter_Care_Supplies_Basis__c;
        internalIV.IV_Facility_Catheter_Care_Supplies_Cost__c = IVRec.IV_Facility_Catheter_Care_Supplies_Cost__c;
        internalIV.IV_Facility_Catheter_Care_Supplies_Rate__c = IVRec.IV_Facility_Catheter_Care_Supplies_Rate__c;
        internalIV.IV_Facility_Chemo_Basis__c = IVRec.IV_Facility_Chemo_Basis__c;
        internalIV.IV_Facility_Chemo_Cost__c = IVRec.IV_Facility_Chemo_Cost__c;
        internalIV.IV_Facility_Chemo_Rate__c = IVRec.IV_Facility_Chemo_Rate__c;
        internalIV.IV_Facility_Diluents_Cost__c = IVRec.IV_Facility_Diluents_Cost__c;
        internalIV.IV_Facility_Flush_Cost__c = IVRec.IV_Facility_Flush_Cost__c;
        internalIV.IV_Facility_Hydration_Basis__c = IVRec.IV_Facility_Hydration_Basis__c;
        internalIV.IV_Facility_Hydration_Cost__c = IVRec.IV_Facility_Hydration_Cost__c;
        internalIV.IV_Facility_Hydration_Rate__c = IVRec.IV_Facility_Hydration_Rate__c;
        internalIV.IV_Facility_Hyd_24hr_Bag__c = IVRec.IV_Facility_Hyd_24hr_Bag__c;
        internalIV.IV_Facility_Hyd_24hr_Basis__c = IVRec.IV_Facility_Hyd_24hr_Basis__c;
        internalIV.IV_Facility_Other_Basis__c = IVRec.IV_Facility_Other_Basis__c;
        internalIV.IV_Facility_Other_Cost__c = IVRec.IV_Facility_Other_Cost__c;
        internalIV.IV_Facility_Other_Rate__c = IVRec.IV_Facility_Other_Rate__c;
        internalIV.IV_Facility_Pain_Basis__c = IVRec.IV_Facility_Pain_Basis__c;
        internalIV.IV_Facility_Pain_Cost__c = IVRec.IV_Facility_Pain_Cost__c;
        internalIV.IV_Facility_Pain_Rate__c = IVRec.IV_Facility_Pain_Rate__c;
        internalIV.IV_Facility_Special_Pump_Basis__c = IVRec.IV_Facility_Special_Pump_Basis__c;
        internalIV.IV_Facility_Special_Pump_Cost__c = IVRec.IV_Facility_Special_Pump_Cost__c;
        internalIV.IV_Facility_Special_Pump_Rate__c = IVRec.IV_Facility_Special_Pump_Rate__c;
        internalIV.IV_Facility_Standard_Pump_Basis__c = IVRec.IV_Facility_Standard_Pump_Basis__c;
        internalIV.IV_Facility_Standard_Pump_Cost__c = IVRec.IV_Facility_Standard_Pump_Cost__c;
        internalIV.IV_Facility_Standard_Pump_Rate__c = IVRec.IV_Facility_Standard_Pump_Rate__c;
        internalIV.IV_Facility_TPN_1L_Basis__c = IVRec.IV_Facility_TPN_1L_Basis__c;
        internalIV.IV_Facility_TPN_1L_Cost__c = IVRec.IV_Facility_TPN_1L_Cost__c;
        internalIV.IV_Facility_TPN_1L_Rate__c = IVRec.IV_Facility_TPN_1L_Rate__c;
        internalIV.IV_Facility_TPN_2L_Basis__c = IVRec.IV_Facility_TPN_2L_Basis__c;
        internalIV.IV_Facility_TPN_2L_Cost__c = IVRec.IV_Facility_TPN_2L_Cost__c;
        internalIV.IV_Facility_TPN_2L_Rate__c = IVRec.IV_Facility_TPN_2L_Rate__c;
        internalIV.IV_Facility_TPN_3L_Basis__c = IVRec.IV_Facility_TPN_3L_Basis__c;
        internalIV.IV_Facility_TPN_3L_Cost__c = IVRec.IV_Facility_TPN_3L_Cost__c;
        internalIV.IV_Facility_TPN_3L_Rate__c = IVRec.IV_Facility_TPN_3L_Rate__c;
        internalIV.IV_Flushes__c = IVRec.IV_Flushes__c;
        internalIV.IV_House_Pump_Basis__c = IVRec.IV_House_Pump_Basis__c;
        internalIV.IV_House_Pump_Cost__c = IVRec.IV_House_Pump_Cost__c;
        internalIV.IV_House_Pump_Rate__c = IVRec.IV_House_Pump_Rate__c;
        internalIV.IV_House_Supplies_Cost__c = IVRec.IV_House_Supplies_Cost__c;
        internalIV.IV_Pain_Infusion_continuous_infusion__c = IVRec.IV_Pain_Infusion_continuous_infusion__c;
        internalIV.IV_Private_Pay_Pricing__c = IVRec.IV_Private_Pay_Pricing__c;
        internalIV.IV_Push_Administration__c = IVRec.IV_Push_Administration__c;
        internalIV.Management_of_Inotropics_in_the_Heart_Fa__c = IVRec.Management_of_Inotropics_in_the_Heart_Fa__c;
        internalIV.Midline_IV_Insertion_Cost__c = IVRec.Midline_IV_Insertion_Cost__c;
        internalIV.Midline_IV_Insertion_Supplies__c = IVRec.Midline_IV_Insertion_Supplies__c;
        internalIV.Midline_IV_Insertion_wUS_Cost__c = IVRec.Midline_IV_Insertion_wUS_Cost__c;
        internalIV.Midline_IV_Insertion_wUS_Supplies__c = IVRec.Midline_IV_Insertion_wUS_Supplies__c;
        internalIV.Nurse_AfterHours_Fee__c = IVRec.Nurse_AfterHours_Fee__c;
        internalIV.Nurse_Consulting_Fee__c = IVRec.Nurse_Consulting_Fee__c;
        internalIV.Nursing_CEUs__c = IVRec.Nursing_CEUs__c;
        internalIV.Pain_Management_Patient_Controlled_Ana__c = IVRec.Pain_Management_Patient_Controlled_Ana__c;
        internalIV.Parenteral_Nutrition_TPN_PPN__c = IVRec.Parenteral_Nutrition_TPN_PPN__c;
        internalIV.Peripheral_IV_Insertion_Cost__c = IVRec.Peripheral_IV_Insertion_Cost__c;
        internalIV.Peripheral_IV_Insertion_Supplies__c = IVRec.Peripheral_IV_Insertion_Supplies__c;
        internalIV.PICC_Insertion_Cost__c = IVRec.PICC_Insertion_Cost__c;
        internalIV.PICC_Insertion_Supplies__c = IVRec.PICC_Insertion_Supplies__c;
        internalIV.PICC_Insertion_wUS_Cost__c = IVRec.PICC_Insertion_wUS_Cost__c;
        internalIV.PICC_Insertion_wUS_Supplies__c = IVRec.PICC_Insertion_wUS_Supplies__c;
        internalIV.PICC_Removal_Cost__c = IVRec.PICC_Removal_Cost__c;
        internalIV.PICC_Removal_Non_Tunneled_Catheter__c = IVRec.PICC_Removal_Non_Tunneled_Catheter__c;
        internalIV.PICC_Removal_Supplies__c = IVRec.PICC_Removal_Supplies__c;
        internalIV.Private_Pay_Pricing__c = IVRec.Private_Pay_Pricing__c;
        internalIV.Specialty_Pump_Sigma_Spectrum_CADD_Cu__c = IVRec.Specialty_Pump_Sigma_Spectrum_CADD_Cu__c;
        internalIV.Standard_Pole_Mounted_Pump__c = IVRec.Standard_Pole_Mounted_Pump__c;
        internalIV.State__c = IVRec.State__c;
        
        


    } catch(exception ex){
        isError = true;
        ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter Account site'));
    }
           
    }
    }
    public Pagereference saveIVinfo(){
         //List<Pricing_Worksheet__c> lstpw = [select id , Status__c from Pricing_Worksheet__c where id = :strpwid] ;
          // system.debug(LoggingLevel.Info,'>>>>>>objPw'+lstpw);
           /*if(lstpw.size() > 0 && (lstpw[0].Status__c == 'In Progress' || lstpw[0].Status__c == 'Approved') )
           {
            isError=true;
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Internal IV Pricing Worksheet once submitted cannot be edited unless Approved'));
             return null;
           }
           else
          {*/  
          try{
              
          update internalIV ;
          system.debug(LoggingLevel.Info,'>>>>>>internalIV.Active_Schedule__c'+internalIV.Active_Schedule__c);
          system.debug('IVRec'+IVRec );
            PageReference pg;
            pg  = new PageReference('/' + pricingWorkSheet.id);
        return pg ;
         
       }catch(exception ex){
        system.debug(LoggingLevel.Info,'>>>>>>internalIV.Active_Schedule__c'+internalIV.Active_Schedule__c);
        isError = true;
        //ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,ex.getmessage()));
        ApexPages.addMessages(ex);
        return null;
      }
    }
        public Pagereference cancel(){

        PageReference pg;
            pg  = new PageReference('/' + pricingWorkSheet.id);
            return pg ; 
     }
   
}