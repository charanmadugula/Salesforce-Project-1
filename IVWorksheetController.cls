public with sharing class IVWorksheetController {

    public Internal_IV_Worksheet__c IVObj{get;set;}
    public ApexPages.StandardController stdCtrl {get; set;}
    public List<Internal_IV_Worksheet__c> IVRec = new List<Internal_IV_Worksheet__c>();
    public Boolean isError {get;set;}
    
    public IVWorksheetController(ApexPages.StandardController controller) {
        stdCtrl=controller;
        IVObj=(Internal_IV_Worksheet__c )stdCtrl.getRecord();
        system.debug('IVObj=='+IVObj);
        
    }
    
    public void populateValues(){
        isError = False;
        //system.debug('IVObj.Active_Schedule__c=='+IVObj.Active_Schedule__c);
        IVRec = [SELECT Account__c,Active_Schedule__c,All_IV_Push__c,All_Other_Classes_Certifications_Trainin__c,All_Other_IV_Therapies_Not_Specified_dr__c,
        Catheter_Declot_Cost__c,Catheter_Declot_Supplies__c,Certifications_16_Hours_Includes_Stat__c,Cert_Basis__c,Cert_Max__c,Cert_Rate__c,
        Clearing_Thrombotic_Occlusions_in_Centra__c,CreatedById,CreatedDate,Diluents__c,Documentation_IV_POS_MAR_Forms__c,Edu_CVAD_Basis__c,Edu_CVAD_Max__c,Edu_CVAD_Rate__c,
        Edu_Hypodermoclysis_Basis__c,Edu_Hypodermoclysis_Max__c,Edu_Hypodermoclysis_Rate__c,Edu_Infusion_Fundamentals_Basis__c,Edu_Infusion_Fundamentals_Max__c,
        Edu_Infusion_Fundamentals_Rate__c,Edu_IV_Push_Basis__c,Edu_IV_Push_Max__c,Edu_IV_Push_Rate__c,Edu_MAR_Document_Basis__c,Edu_MAR_Document_Max__c,
        Edu_MAR_Document_Rate__c,Edu_Mgmt_Inotropics_Basis__c,Edu_Mgmt_Inotropics_Max__c,Edu_Mgmt_Inotropics_Rate__c,Edu_NursCEUs_Basis__c,Edu_NursCEUs_Max__c,
        Edu_NursCEUs_Rate__c,Edu_Other_Basis__c,Edu_Other_Max__c,Edu_Other_Rate__c,Edu_Pain_Mgmt_Basis__c,Edu_Pain_Mgmt_Max__c,Edu_Pain_Mgmt_Rate__c,
        Edu_PICC_Removal_Basis__c,Edu_PICC_Removal_Max__c,Edu_PICC_Removal_Rate__c,Edu_Thrombotic_Occlusions_Basis__c,Edu_Thrombotic_Occlusions_Max__c,
        Edu_Thrombotic_Occlusions_Rate__c,Edu_TPN_Basis__c,Edu_TPN_Max__c,Edu_TPN_Rate__c,Essentials_of_Infusion_Therapy_2_Day_C__c,Hypodermoclysis__c,
        Id,Infusion_Nurse_After_Hours_Fee__c,Infusion_Nurse_Consulting_Service__c,IsDeleted,IV_Chemo_Infusion_drug_solution__c,IV_Facility_AB_24hr_Basis__c,
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
        IV_Push_Administration__c,LastModifiedById,LastModifiedDate,/*LastReferencedDate,LastViewedDate,*/Management_of_Inotropics_in_the_Heart_Fa__c,
        Midline_IV_Insertion_Cost__c,Midline_IV_Insertion_Supplies__c,Midline_IV_Insertion_wUS_Cost__c,Midline_IV_Insertion_wUS_Supplies__c,Name,Notes__c,
        Nurse_AfterHours_Fee__c,Nurse_Consulting_Fee__c,Nursing_CEUs__c,OwnerId,Pain_Management_Patient_Controlled_Ana__c,Parenteral_Nutrition_TPN_PPN__c,
        Peripheral_IV_Insertion_Cost__c,Peripheral_IV_Insertion_Supplies__c,Per_Diem__c,PICC_Insertion_Cost__c,PICC_Insertion_Supplies__c,PICC_Insertion_wUS_Cost__c,
        PICC_Insertion_wUS_Supplies__c,PICC_Removal_Cost__c,PICC_Removal_Non_Tunneled_Catheter__c,PICC_Removal_Supplies__c,Pricing_Worksheet__c,Private_Pay_Pricing__c
        ,Specialty_Pump_Sigma_Spectrum_CADD_Cu__c,Standard_Pole_Mounted_Pump__c,SystemModstamp FROM Internal_IV_Worksheet__c where Active_Schedule__c =: IVObj.Active_Schedule__c]; 
   
        /*system.debug('===IVRec[0].All_IV_Push__c=='+IVRec[0].IV_Facility_Hydration_Cost__c);*/
       
       /* IVObj.IV_Facility_Hydration_Cost__c = IVRec[0].IV_Facility_Hydration_Cost__c;
        IVObj.All_IV_Push__c = IVRec[0].All_IV_Push__c;
        IVObj.IV_Facility_Hydration_Basis__c = IVRec[0].IV_Facility_Hydration_Basis__c;
        IVObj.IV_Facility_Hydration_Rate__c = IVRec[0].IV_Facility_Hydration_Rate__c;
        IVObj.IV_Facility_Hyd_24hr_Basis__c = IVRec[0].IV_Facility_Hyd_24hr_Basis__c;
        IVObj.IV_Facility_Hyd_24hr_Bag__c = IVRec[0].IV_Facility_Hyd_24hr_Bag__c;
        IVObj.IV_Facility_TPN_1L_Cost__c = IVRec[0].IV_Facility_TPN_1L_Cost__c;
        IVObj.IV_Facility_TPN_1L_Basis__c = IVRec[0].IV_Facility_TPN_1L_Basis__c;
        IVObj.IV_Facility_TPN_1L_Rate__c = IVRec[0].IV_Facility_TPN_1L_Rate__c;
        IVObj.IV_Facility_TPN_2L_Cost__c = IVRec[0].IV_Facility_TPN_2L_Cost__c;
        IVObj.IV_Facility_TPN_2L_Basis__c = IVRec[0].IV_Facility_TPN_2L_Basis__c;
        IVObj.IV_Facility_TPN_3L_Cost__c = IVRec[0].IV_Facility_TPN_3L_Cost__c;
        IVObj.IV_Facility_TPN_3L_Basis__c = IVRec[0].IV_Facility_TPN_3L_Basis__c;
        IVObj.IV_Facility_TPN_3L_Rate__c = IVRec[0].IV_Facility_TPN_3L_Rate__c;
        IVObj.IV_Facility_TPN_2L_Cost__c = IVRec[0].IV_Facility_TPN_2L_Cost__c;
        IVObj.IV_Facility_TPN_2L_Basis__c = IVRec[0].IV_Facility_TPN_2L_Basis__c;
        IVObj.IV_Facility_TPN_2L_Rate__c = IVRec[0].IV_Facility_TPN_2L_Rate__c;
        IVObj.IV_Facility_Additives_Cost__c = IVRec[0].IV_Facility_Additives_Cost__c;
        IVObj.IV_Facility_Additives_Basis__c = IVRec[0].IV_Facility_Additives_Basis__c;
        IVObj.IV_Facility_Additives_Rate__c = IVRec[0].IV_Facility_Additives_Rate__c;
        IVObj.IV_Facility_Antibiotics_QD_Cost__c = IVRec[0].IV_Facility_Antibiotics_QD_Cost__c;
        IVObj.IV_Facility_Antibiotics_QD_Basis__c = IVRec[0].IV_Facility_Antibiotics_QD_Basis__c;
        IVObj.IV_Facility_Antibiotics_QD_Rate__c = IVRec[0].IV_Facility_Antibiotics_QD_Rate__c;
        IVObj.IV_Facility_Antibiotics_BID_Cost__c = IVRec[0].IV_Facility_Antibiotics_BID_Cost__c;
        IVObj.IV_Facility_Antibiotics_BID_Basis__c = IVRec[0].IV_Facility_Antibiotics_BID_Basis__c;
        IVObj.IV_Facility_Antibiotics_BID_Rate__c = IVRec[0].IV_Facility_Antibiotics_BID_Rate__c;
        IVObj.IV_Facility_Antibiotics_TID_Cost__c = IVRec[0].IV_Facility_Antibiotics_TID_Cost__c;
        IVObj.IV_Facility_Antibiotics_TID_Basis__c = IVRec[0].IV_Facility_Antibiotics_TID_Basis__c;
        IVObj.IV_Facility_Antibiotics_TID_Rate__c = IVRec[0].IV_Facility_Antibiotics_TID_Rate__c;
        IVObj.IV_Facility_Antibiotics_QID_Cost__c = IVRec[0].IV_Facility_Antibiotics_QID_Cost__c;
        IVObj.IV_Facility_Antibiotics_QID_Basis__c = IVRec[0].IV_Facility_Antibiotics_QID_Basis__c;
        IVObj.IV_Facility_Antibiotics_QID_Rate__c = IVRec[0].IV_Facility_Antibiotics_QID_Rate__c;
        IVObj.IV_Facility_AB_24hr_Basis__c = IVRec[0].IV_Facility_AB_24hr_Basis__c;
        IVObj.IV_Facility_AB_24hr_Fee__c = IVRec[0].IV_Facility_AB_24hr_Fee__c;
        IVObj.IV_Facility_Pain_Cost__c = IVRec[0].IV_Facility_Pain_Cost__c;
        IVObj.IV_Facility_Pain_Basis__c = IVRec[0].IV_Facility_Pain_Basis__c;
        IVobj.IV_Facility_Pain_Rate__c  = IVRec[0].IV_Facility_Pain_Rate__c ;
        IVobj.IV_Facility_Chemo_Cost__c = IVRec[0].IV_Facility_Chemo_Cost__c;
        IVObj.IV_Facility_Chemo_Basis__c =IVRec[0].IV_Facility_Chemo_Basis__c;
        IVObj.IV_Facility_Chemo_Rate__c = IVRec[0].IV_Facility_Chemo_Rate__c;
        IVObj.IV_Facility_Other_Cost__c = IVRec[0].IV_Facility_Other_Cost__c;
        IVObj.IV_Facility_Other_Basis__c =IVRec[0].IV_Facility_Other_Basis__c;
        IVObj.IV_Facility_Other_Rate__c = IVRec[0].IV_Facility_Other_Rate__c;
        IVObj.IV_Facility_Flush_Cost__c = IVRec[0].IV_Facility_Flush_Cost__c;
        IVObj.IV_Facility_Diluents_Cost__c = IVRec[0].IV_Facility_Diluents_Cost__c;
        IVObj.IV_Facility_Special_Pump_Cost__c = IVRec[0].IV_Facility_Special_Pump_Cost__c;
        IVObj.IV_Facility_Special_Pump_Basis__c = IVRec[0].IV_Facility_Special_Pump_Basis__c;
        IVObj.IV_Facility_Special_Pump_Rate__c = IVRec[0].IV_Facility_Special_Pump_Rate__c;
        IVObj.IV_Facility_Standard_Pump_Cost__c = IVRec[0].IV_Facility_Standard_Pump_Cost__c;
        IVObj.IV_Facility_Standard_Pump_Basis__c = IVRec[0].IV_Facility_Standard_Pump_Basis__c;
        IVObj.IV_Facility_Standard_Pump_Rate__c = IVRec[0].IV_Facility_Standard_Pump_Rate__c;
        IVObj.IV_Facility_Catheter_Care_Supplies_Cost__c = IVRec[0].IV_Facility_Catheter_Care_Supplies_Cost__c;
        IVObj.IV_Facility_Catheter_Care_Supplies_Basis__c = IVRec[0].IV_Facility_Catheter_Care_Supplies_Basis__c;
        IVObj.IV_Facility_Catheter_Care_Supplies_Rate__c = IVRec[0].IV_Facility_Catheter_Care_Supplies_Rate__c;
        IVObj.IV_House_Supplies_Cost__c = IVRec[0].IV_House_Supplies_Cost__c;
        IVObj.IV_House_Pump_Cost__c = IVRec[0].IV_House_Pump_Cost__c;
        IVObj.IV_House_Pump_Basis__c = IVRec[0].IV_House_Pump_Basis__c;
        IVObj.IV_House_Pump_Rate__c = IVRec[0].IV_House_Pump_Rate__c;
        IVObj.Peripheral_IV_Insertion_Cost__c = IVRec[0].Peripheral_IV_Insertion_Cost__c;
        IVObj.Peripheral_IV_Insertion_Supplies__c = IVRec[0].Peripheral_IV_Insertion_Supplies__c;
        IVObj.Midline_IV_Insertion_Cost__c = IVRec[0].Midline_IV_Insertion_Cost__c;
        IVObj.Midline_IV_Insertion_Supplies__c = IVRec[0].Midline_IV_Insertion_Supplies__c;
        IVObj.Midline_IV_Insertion_wUS_Cost__c = IVRec[0].Midline_IV_Insertion_wUS_Cost__c;
        IVObj.Midline_IV_Insertion_wUS_Supplies__c = IVRec[0].Midline_IV_Insertion_wUS_Supplies__c;
        IVObj.PICC_Insertion_Cost__c = IVRec[0].PICC_Insertion_Cost__c;
        IVObj.PICC_Insertion_Supplies__c = IVRec[0].PICC_Insertion_Supplies__c;
        IVObj.PICC_Insertion_wUS_Cost__c = IVRec[0].PICC_Insertion_wUS_Cost__c;
        IVObj.PICC_Insertion_wUS_Supplies__c = IVRec[0].PICC_Insertion_wUS_Supplies__c;
        IVObj.PICC_Removal_Cost__c = IVRec[0].PICC_Removal_Cost__c;
        IVObj.PICC_Removal_Supplies__c = IVRec[0].PICC_Removal_Supplies__c;
        IVObj.Catheter_Declot_Cost__c = IVRec[0].Catheter_Declot_Cost__c;
        IVObj.Catheter_Declot_Supplies__c = IVRec[0].Catheter_Declot_Supplies__c;
        IVObj.Nurse_AfterHours_Fee__c = IVRec[0].Nurse_AfterHours_Fee__c;
        IVObj.Nurse_Consulting_Fee__c = IVRec[0].Nurse_Consulting_Fee__c;
        IVObj.Edu_TPN_Basis__c = IVRec[0].Edu_TPN_Basis__c;
        IVObj.Edu_TPN_Rate__c = IVRec[0].Edu_TPN_Rate__c;
        IVObj.Edu_TPN_Max__c = IVRec[0].Edu_TPN_Max__c;
        IVObj.Edu_CVAD_Basis__c = IVRec[0].Edu_CVAD_Basis__c;
        IVObj.Edu_CVAD_Rate__c = IVRec[0].Edu_CVAD_Rate__c;
        IVObj.Edu_CVAD_Max__c = IVRec[0].Edu_CVAD_Max__c;
        IVObj.Edu_Pain_Mgmt_Basis__c = IVRec[0].Edu_Pain_Mgmt_Basis__c;
        IVObj.Edu_Pain_Mgmt_Rate__c = IVRec[0].Edu_Pain_Mgmt_Rate__c;
        IVObj.Edu_Pain_Mgmt_Max__c = IVRec[0].Edu_Pain_Mgmt_Max__c;
        IVObj.Edu_Mgmt_Inotropics_Basis__c = IVRec[0].Edu_Mgmt_Inotropics_Basis__c;
        IVObj.Edu_Mgmt_Inotropics_Rate__c = IVRec[0].Edu_Mgmt_Inotropics_Rate__c;
        IVObj.Edu_Mgmt_Inotropics_Max__c = IVRec[0].Edu_Mgmt_Inotropics_Max__c;
        IVObj.Edu_Thrombotic_Occlusions_Basis__c = IVRec[0].Edu_Thrombotic_Occlusions_Basis__c;
        IVObj.Edu_Thrombotic_Occlusions_Rate__c = IVRec[0].Edu_Thrombotic_Occlusions_Rate__c;
        IVObj.Edu_Thrombotic_Occlusions_Max__c = IVRec[0].Edu_Thrombotic_Occlusions_Max__c;
        IVObj.Edu_IV_Push_Basis__c = IVRec[0].Edu_IV_Push_Basis__c;
        IVObj.Edu_IV_Push_Rate__c = IVRec[0].Edu_IV_Push_Rate__c;
        IVObj.Edu_IV_Push_Max__c = IVRec[0].Edu_IV_Push_Max__c;
        IVObj.Edu_Hypodermoclysis_Basis__c = IVRec[0].Edu_Hypodermoclysis_Basis__c;
        IVObj.Edu_Hypodermoclysis_Rate__c = IVRec[0].Edu_Hypodermoclysis_Rate__c;
        IVObj.Edu_Hypodermoclysis_Max__c = IVRec[0].Edu_Hypodermoclysis_Max__c;
        IVObj.Edu_PICC_Removal_Basis__c = IVRec[0].Edu_PICC_Removal_Basis__c;
        IVObj.Edu_PICC_Removal_Rate__c = IVRec[0].Edu_PICC_Removal_Rate__c;
        IVObj.Edu_PICC_Removal_Max__c = IVRec[0].Edu_PICC_Removal_Max__c;
        IVObj.Edu_MAR_Document_Basis__c = IVRec[0].Edu_MAR_Document_Basis__c;
        IVObj.Edu_MAR_Document_Rate__c = IVRec[0].Edu_MAR_Document_Rate__c;
        IVObj.Edu_MAR_Document_Max__c = IVRec[0].Edu_MAR_Document_Max__c;
        IVObj.Edu_Infusion_Fundamentals_Basis__c = IVRec[0].Edu_Infusion_Fundamentals_Basis__c;
        IVObj.Edu_Infusion_Fundamentals_Rate__c = IVRec[0].Edu_Infusion_Fundamentals_Rate__c;
        IVObj.Edu_Infusion_Fundamentals_Max__c = IVRec[0].Edu_Infusion_Fundamentals_Max__c;
        IVObj.Edu_NursCEUs_Basis__c = IVRec[0].Edu_NursCEUs_Basis__c;
        IVObj.Edu_NursCEUs_Rate__c = IVRec[0].Edu_NursCEUs_Rate__c;
        IVObj.Edu_NursCEUs_Max__c = IVRec[0].Edu_NursCEUs_Max__c;
        IVObj.Edu_Other_Basis__c = IVRec[0].Edu_Other_Basis__c;
        IVObj.Edu_Other_Rate__c = IVRec[0].Edu_Other_Rate__c;
        IVObj.Edu_Other_Max__c = IVRec[0].Edu_Other_Max__c;
        IVObj.IV_Private_Pay_Pricing__c = IVRec[0].IV_Private_Pay_Pricing__c;
        IVObj.Id= IVRec[0].Id;*/
        
        try{
            IVObj= IVRec[0];
        } catch(exception ex){
            isError = true;
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter Account site'));
        }
           
    }
    public Pagereference saveIVinfo(){
         IVRec[0] = IVObj;
          update IVRec[0] ;
         
          system.debug('IVRec'+IVRec );
            PageReference pg;
            pg  = new PageReference('/' + IVRec[0].Id);
        return pg ; 
     }

}