@isTest
Public class ext_pwViewTest{
    public static Profile sysAdmnprof;

    static testMethod void ext_pwViewTestMethod(){
    DataUtil_Check.var_StopAccountTriggerfromCase=false;
      system.test.startTest();
      
        
         sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
         
         Account acc= new Account();
         acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
         acc.BillingState='CA';
         insert acc;
          Account accChild = new Account();
      accChild=InsertTestData.createParentAccount('Account2','Pharmacy1','US',True);
      accChild.BillingState='CA';
      accChild.ParentId=acc.Id;
     insert accChild;
         
         Map<String,RecordType> mapPricingRecordType =  new Map<String,RecordType>();
for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                           WHERE SobjectType = 'Pricing_Worksheet__c'])
        mapPricingRecordType.put(recordType.DeveloperName,recordType);
 String stateDefaultId = mapPricingRecordType.get('State_Default').id;
 
Pricing_Worksheet__c objPwDefault = new Pricing_Worksheet__c();
objPwDefault.NAME ='dEFAULT';
objPwDefault.Account__c=acc.id;
objPwDefault.RecordTypeId = stateDefaultId;
objPwDefault.State__c = 'CA';
objPwDefault.Net_Payment_Terms__c='Net 10';
        objPwDefault.Default_Interest_Rate_Finance_Charge__c ='Test';
        objPwDefault.Scheduled_Deliveries_per_days_M_F__c=10.00;
        objPwDefault.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        objPwDefault.Dispensing_method__c='Test';
        objPwDefault.Dispensing_Frequency__c='Test';
        objPwDefault.Dispensing_Type__c='Test';
        
objPwDefault.RX_Brands_All_except_1V_TPN_Cost_Basi__c = 'WAC';
objPwDefault.RX_Brands_All_except_1V_TPN_Ingredient__c = 10.23;
objPwDefault.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
objPwDefault.RX_Brands_All_except_1V_TPN_unit_dose__c  = 10.23;


objPwDefault.CBOther22a__c = 'test';
objPwDefault.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
objPwDefault.RX_3_Generic_ManufacturersIngredient__c = 10.23;
objPwDefault.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;

objPwDefault.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
objPwDefault.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
objPwDefault.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;

objPwDefault.CBOther22c__c = 'Test';
objPwDefault.OTC_Brands_Cost_Basis__c = 'WAC';
objPwDefault.OTC_Brands_Ingrediant__c = 10.23;
objPwDefault.Bulk_OTC_Brands_Ingrediant__c = 10.23;
objPwDefault.OTC_Brands_Disp_Fee__c = 10.23;
objPwDefault.OTC_Brands_Unit_Dose_Fee__c =10.23;
objPwDefault.CBOther22d__c = 'Test';

objPwDefault.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
objPwDefault.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;

objPwDefault.CBOther22f__c = 'Test';
objPwDefault.Facility_Special_Pricing__c = 'Enoxaparin';
objPwDefault.Minimums_Rx__c = 10.23;
objPwDefault.Minimums_OTC_per_Rx__c = 10.23;
objPwDefault.Controlled_Substance_Fee_Schedules_2_3__c = 10.23;
objPwDefault.Compound1_Fee_Non_Infusion_Additional_to__c = 'Test';

objPwDefault.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
objPwDefault.Rx_Brands_All_Except_IV_TPN_Ingredi__c  = 10.23;
objPwDefault.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
objPwDefault.CBOther23a__c = 'Test';
objPwDefault.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';

objPwDefault.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.CBOther23b__c = 'Test';
objPwDefault.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';

objPwDefault.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.Rx_l1_3_Generic_Manufacturers_All_Except__c= 10.23;
objPwDefault.CBOther23c__c = 'Test';
objPwDefault.OTC_Brands_CostBasis1__c = 'WAC';
objPwDefault.OTC_Brands_Ingrediant1__c = 10.23;
objPwDefault.OTC_Brands_DispFee1__c = 10.23;

objPwDefault.CBOther23d__c = 'Test';
objPwDefault.OTCg13Cost_Basis__c = 'WAC';
objPwDefault.OTCg13Ingredient__c = 10.23;
objPwDefault.OTCg13Dispfee__c = 10.23;
objPwDefault.CBOther23e__c = 'Test';
objPwDefault.OTCl3costbasis__c = 'WAC';
objPwDefault.OTCl3Ingredient__c = 10.23;
objPwDefault.OTCl3Disp_fee__c = 10.23;
objPwDefault.CBOther23f__c = 'TEST';
objPwDefault.MinimumsRX1__c = 10.23;

objPwDefault.MinimumsOTCPerRx1__c = 10.23;
objPwDefault.Controlled_substance_fee1__c = 10.23;
objPwDefault.Compound_fee_Infusion1__c = 10.23;
objPwDefault.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
objPwDefault.CBOther24a__c = 'Test';

objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
objPwDefault.CBOther24b__c = 'Text';
objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';

objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
objPwDefault.CBOther24c__c = 'Test';
objPwDefault.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
objPwDefault.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
objPwDefault.CBOther25a__c= 'Test';

objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
objPwDefault.CBOther25b__c = 'Text';
objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';

objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
objPwDefault.CBOther25c__c = 'Test';
objPwDefault.Medical_Records_Serviced_Patients__c = 'Test';
objPwDefault.Medical_Records_Fee_Non_Serviced_Patien__c = 'Test';

objPwDefault.Consulting_Pharmacist_Required_Services__c = 'Test';
objPwDefault.Consulting_Pharmacist_Optional_Services__c = 'Test';
objPwDefault.iMRR_Medication_Regimen_Review_SNF_O__c = 'Test';

objPwDefault.Anticoagulation_Management_Services_SNF__c= 'Test';
objPwDefault.Consulting_Nurse_Charge_Non_1V__c = 'Test';
objPwDefault.Onsite_Consulting_Non_SNF__c = 'Test';
objPwDefault.Remote_Consulting_Non_SNF__c  = 'Test';
objPwDefault.Restocking_fee_Rx_specific__c = 'Test';

objPwDefault.Monthly_No_Med_fee_per_resident_Non_serv__c = 'Test';
objPwDefault.Non_Scheduled_Deliver_fee__c = 'Test';
objPwDefault.Automated_Dispensing_Unit__c = True;
objPwDefault.Automated_Dispensing_Unit_Type__c = 'Omnicell';

objPwDefault.Monthly_ADU_Fee__c = 'Test';
objPwDefault.E_Prescribing_Credit_SNF_Only_per_lic__c = 0.10;
objPwDefault.E_Prescribing_Vendor__c = 'ALMSA Corp';
objPwDefault.E_Prescribing_Vendor_Other__c = 'Test';
objPwDefault.Prompt_Pay_Discount__c = 'Test';

objPwDefault.Net_Payment_Terms__c = 'Net 10';
objPwDefault.Default_Interest_Rate_Finance_Charge__c = 'Test';
objPwDefault.Scheduled_Deliveries_per_days_M_F__c = 7;
objPwDefault.Scheduled_deliveries_per_daySat_Sun__c = 7;

objPwDefault.Dispensing_method__c = 'Test'; 
objPwDefault.Dispensing_Frequency__c = 'Test';
objPwDefault.Dispensing_Type__c = 'Test';
objPwDefault.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
objPwDefault.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
objPwDefault.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;

insert objPwDefault;
         
         
        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Account__c=accChild.id;
        
        priceWorkSheet.Status__c='Executed';
        priceWorkSheet.Facility_name_DBA__c=accChild.id;
        priceWorkSheet.State__c='CA';
        priceWorkSheet.Net_Payment_Terms__c='Net 10';
        priceWorkSheet.Default_Interest_Rate_Finance_Charge__c ='Test';
        priceWorkSheet.Scheduled_Deliveries_per_days_M_F__c=10.00;
        priceWorkSheet.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        priceWorkSheet.Dispensing_method__c='Test';
        priceWorkSheet.Dispensing_Frequency__c='Test';
        priceWorkSheet.Dispensing_Type__c='Test';
        
        priceWorkSheet.RX_Brands_All_except_1V_TPN_Cost_Basi__c  = 'WAC';
    priceWorkSheet.RX_Brands_All_except_1V_TPN_Ingredient__c = 2.5;
    priceWorkSheet.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
    priceWorkSheet.RX_Brands_All_except_1V_TPN_unit_dose__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
    priceWorkSheet.RX_3_Generic_ManufacturersIngredient__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;
    
    priceWorkSheet.OTC_Brands_Cost_Basis__c ='WAC';
    priceWorkSheet.OTC_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_Brands_Disp_Fee__c  = 10.23;
    priceWorkSheet.OTC_Brands_Unit_Dose_Fee__c = 10.23;
    
    priceWorkSheet.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
    priceWorkSheet.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
    
    
    priceWorkSheet.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
    priceWorkSheet.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;
    
    priceWorkSheet.Facility_Special_Pricing__c = 'Enoxaparin';
    priceWorkSheet.Minimums_Rx__c = 10.23;  
    priceWorkSheet.Minimums_OTC_per_Rx__c= 10.23;
    priceWorkSheet.Controlled_Substance_Fee_Schedules_2_3__c= 10.23;
    priceWorkSheet.Compound1_Fee_Non_Infusion_Additional_to__c= 'test';
    

    priceWorkSheet.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
    priceWorkSheet.Bulk_OTC_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
    
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Ingredi__c = 10.23;
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
    priceWorkSheet.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';
    priceWorkSheet.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';
    priceWorkSheet.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_l1_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.OTC_Brands_CostBasis1__c = 'WAC';
    priceWorkSheet.OTCg13Cost_Basis__c = 'WAC';
    priceWorkSheet.OTCl3costbasis__c  = 'WAC';
    priceWorkSheet.MinimumsRX1__c = 10.23;
    priceWorkSheet.MinimumsOTCPerRx1__c = 10.23;
    priceWorkSheet.Controlled_substance_fee1__c = 10.23;
    priceWorkSheet.Compound_fee_Infusion1__c = 10.23;

        insert priceWorkSheet;
         
         ApexPages.StandardController sc = new ApexPages.StandardController(priceWorkSheet);
          ApexPages.currentPage().getParameters().put('Id',priceWorkSheet.id);
         
         ext_pwView pwView= new ext_pwView(sc);
         pwView.pricingWorkSheet = priceWorkSheet;
         ApexPages.currentPage().getParameters().put('Id',accChild.id);
         pwView.save();
         pwView.cancel();
         pwView.clonePW();
         pwView.cancelWorksheet();
         pwView.submitApproval();
         pwView.aCredit();
         pwView.aCAC();
         pwView.aLegal();
         pwView.aDOP();
         pwView.aCP();
         pwView.aAH();
         pwView.aPA();
         pwView.aVPO();
         pwView.aIVP();
         pwView.aIVR();
         pwView.aIVS();
         pwView.aEP();
         pwView.rjCredit();
         pwView.rjDOP();
         pwView.rjCP();
         pwView.rjAH();
         pwView.rjLegal();
         pwView.rjCAC();
         pwView.rjPA();
         pwView.rjVPO();
         pwView.rjIVP();
         pwView.rjIVR();
         pwView.rjIVP();
         pwView.rjIVS();
         pwView.rjEP();
         //pwView.approveBand();
         pwView.abCredit();
         pwView.abDOP();
         pwView.abCP();
         pwView.abLegal();
         pwView.abCAC();
         pwView.abPA();
         pwView.abVPO();
         pwView.abIVP();
         pwView.abIVR();
         //pwView.abIVS();
         //pwView.abEP();
    // pwView.abEP();
     pwView.changeStateDefaults();
     
     //acc.BillingState='TX';
         //update acc;
         
         //pwView.changeStateDefaults();
     
     
     //pwView.submitChain();
    
     List<Pricing_Worksheet__c> lstpw = [select id from Pricing_Worksheet__c];
        system.assert(lstpw.size() > 0,'pw size');
         }
     
    static testMethod void ext_pwViewTestSubmitChainMethod(){

      system.test.startTest();
      
        
         sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
         
         Account acc= new Account();
         acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
         acc.BillingState='CA';
         insert acc;
          Account accChild = new Account();
      accChild=InsertTestData.createParentAccount('Account2','Pharmacy1','US',True);
      accChild.BillingState='CA';
      accChild.ParentId=acc.Id;
     insert accChild;
         
         Map<String,RecordType> mapPricingRecordType =  new Map<String,RecordType>();
for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                           WHERE SobjectType = 'Pricing_Worksheet__c'])
        mapPricingRecordType.put(recordType.DeveloperName,recordType);
 String stateDefaultId = mapPricingRecordType.get('State_Default').id;
 
Pricing_Worksheet__c objPwDefault = new Pricing_Worksheet__c();
objPwDefault.NAME ='dEFAULT';
objPwDefault.Account__c=acc.id;
objPwDefault.RecordTypeId = stateDefaultId;
objPwDefault.State__c = 'CA';
objPwDefault.Net_Payment_Terms__c='Net 10';
        objPwDefault.Default_Interest_Rate_Finance_Charge__c ='Test';
        objPwDefault.Scheduled_Deliveries_per_days_M_F__c=10.00;
        objPwDefault.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        objPwDefault.Dispensing_method__c='Test';
        objPwDefault.Dispensing_Frequency__c='Test';
        objPwDefault.Dispensing_Type__c='Test';
        
objPwDefault.RX_Brands_All_except_1V_TPN_Cost_Basi__c = 'WAC';
objPwDefault.RX_Brands_All_except_1V_TPN_Ingredient__c = 10.23;
objPwDefault.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
objPwDefault.RX_Brands_All_except_1V_TPN_unit_dose__c  = 10.23;


objPwDefault.CBOther22a__c = 'test';
objPwDefault.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
objPwDefault.RX_3_Generic_ManufacturersIngredient__c = 10.23;
objPwDefault.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;

objPwDefault.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
objPwDefault.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
objPwDefault.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;

objPwDefault.CBOther22c__c = 'Test';
objPwDefault.OTC_Brands_Cost_Basis__c = 'WAC';
objPwDefault.OTC_Brands_Ingrediant__c = 10.23;
objPwDefault.Bulk_OTC_Brands_Ingrediant__c = 10.23;
objPwDefault.OTC_Brands_Disp_Fee__c = 10.23;
objPwDefault.OTC_Brands_Unit_Dose_Fee__c =10.23;
objPwDefault.CBOther22d__c = 'Test';

objPwDefault.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
objPwDefault.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;

objPwDefault.CBOther22f__c = 'Test';
objPwDefault.Facility_Special_Pricing__c = 'Enoxaparin';
objPwDefault.Minimums_Rx__c = 10.23;
objPwDefault.Minimums_OTC_per_Rx__c = 10.23;
objPwDefault.Controlled_Substance_Fee_Schedules_2_3__c = 10.23;
objPwDefault.Compound1_Fee_Non_Infusion_Additional_to__c = 'Test';

objPwDefault.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
objPwDefault.Rx_Brands_All_Except_IV_TPN_Ingredi__c  = 10.23;
objPwDefault.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
objPwDefault.CBOther23a__c = 'Test';
objPwDefault.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';

objPwDefault.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.CBOther23b__c = 'Test';
objPwDefault.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';

objPwDefault.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.Rx_l1_3_Generic_Manufacturers_All_Except__c= 10.23;
objPwDefault.CBOther23c__c = 'Test';
objPwDefault.OTC_Brands_CostBasis1__c = 'WAC';
objPwDefault.OTC_Brands_Ingrediant1__c = 10.23;
objPwDefault.OTC_Brands_DispFee1__c = 10.23;

objPwDefault.CBOther23d__c = 'Test';
objPwDefault.OTCg13Cost_Basis__c = 'WAC';
objPwDefault.OTCg13Ingredient__c = 10.23;
objPwDefault.OTCg13Dispfee__c = 10.23;
objPwDefault.CBOther23e__c = 'Test';
objPwDefault.OTCl3costbasis__c = 'WAC';
objPwDefault.OTCl3Ingredient__c = 10.23;
objPwDefault.OTCl3Disp_fee__c = 10.23;
objPwDefault.CBOther23f__c = 'TEST';
objPwDefault.MinimumsRX1__c = 10.23;

objPwDefault.MinimumsOTCPerRx1__c = 10.23;
objPwDefault.Controlled_substance_fee1__c = 10.23;
objPwDefault.Compound_fee_Infusion1__c = 10.23;
objPwDefault.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
objPwDefault.CBOther24a__c = 'Test';

objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
objPwDefault.CBOther24b__c = 'Text';
objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';

objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
objPwDefault.CBOther24c__c = 'Test';
objPwDefault.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
objPwDefault.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
objPwDefault.CBOther25a__c= 'Test';

objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
objPwDefault.CBOther25b__c = 'Text';
objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';

objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
objPwDefault.CBOther25c__c = 'Test';
objPwDefault.Medical_Records_Serviced_Patients__c = 'Test';
objPwDefault.Medical_Records_Fee_Non_Serviced_Patien__c = 'Test';

objPwDefault.Consulting_Pharmacist_Required_Services__c = 'Test';
objPwDefault.Consulting_Pharmacist_Optional_Services__c = 'Test';
objPwDefault.iMRR_Medication_Regimen_Review_SNF_O__c = 'Test';

objPwDefault.Anticoagulation_Management_Services_SNF__c= 'Test';
objPwDefault.Consulting_Nurse_Charge_Non_1V__c = 'Test';
objPwDefault.Onsite_Consulting_Non_SNF__c = 'Test';
objPwDefault.Remote_Consulting_Non_SNF__c  = 'Test';
objPwDefault.Restocking_fee_Rx_specific__c = 'Test';

objPwDefault.Monthly_No_Med_fee_per_resident_Non_serv__c = 'Test';
objPwDefault.Non_Scheduled_Deliver_fee__c = 'Test';
objPwDefault.Automated_Dispensing_Unit__c = True;
objPwDefault.Automated_Dispensing_Unit_Type__c = 'Omnicell';

objPwDefault.Monthly_ADU_Fee__c = 'Test';
objPwDefault.E_Prescribing_Credit_SNF_Only_per_lic__c = 0.10;
objPwDefault.E_Prescribing_Vendor__c = 'ALMSA Corp';
objPwDefault.E_Prescribing_Vendor_Other__c = 'Test';
objPwDefault.Prompt_Pay_Discount__c = 'Test';

objPwDefault.Net_Payment_Terms__c = 'Net 10';
objPwDefault.Default_Interest_Rate_Finance_Charge__c = 'Test';
objPwDefault.Scheduled_Deliveries_per_days_M_F__c = 7;
objPwDefault.Scheduled_deliveries_per_daySat_Sun__c = 7;

objPwDefault.Dispensing_method__c = 'Test'; 
objPwDefault.Dispensing_Frequency__c = 'Test';
objPwDefault.Dispensing_Type__c = 'Test';
objPwDefault.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
objPwDefault.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
objPwDefault.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;

insert objPwDefault;
         
         
        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Account__c=accChild.id;
        
        priceWorkSheet.Status__c='Executed';
        priceWorkSheet.Facility_name_DBA__c=accChild.id;
        priceWorkSheet.State__c='CA';
        priceWorkSheet.Net_Payment_Terms__c='Net 10';
        priceWorkSheet.Default_Interest_Rate_Finance_Charge__c ='Test';
        priceWorkSheet.Scheduled_Deliveries_per_days_M_F__c=10.00;
        priceWorkSheet.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        priceWorkSheet.Dispensing_method__c='Test';
        priceWorkSheet.Dispensing_Frequency__c='Test';
        priceWorkSheet.Dispensing_Type__c='Test';
        
        
        priceWorkSheet.RX_Brands_All_except_1V_TPN_Cost_Basi__c  = 'WAC';
    priceWorkSheet.RX_Brands_All_except_1V_TPN_Ingredient__c = 2.5;
    priceWorkSheet.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
    priceWorkSheet.RX_Brands_All_except_1V_TPN_unit_dose__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
    priceWorkSheet.RX_3_Generic_ManufacturersIngredient__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;
    
    priceWorkSheet.OTC_Brands_Cost_Basis__c ='WAC';
    priceWorkSheet.OTC_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_Brands_Disp_Fee__c  = 10.23;
    priceWorkSheet.OTC_Brands_Unit_Dose_Fee__c = 10.23;
    
    priceWorkSheet.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
    priceWorkSheet.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
    
    
    priceWorkSheet.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
    priceWorkSheet.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;
    
    priceWorkSheet.Facility_Special_Pricing__c = 'Enoxaparin';
    priceWorkSheet.Minimums_Rx__c = 10.23;  
    priceWorkSheet.Minimums_OTC_per_Rx__c= 10.23;
    priceWorkSheet.Controlled_Substance_Fee_Schedules_2_3__c= 10.23;
    priceWorkSheet.Compound1_Fee_Non_Infusion_Additional_to__c= 'test';
    

    priceWorkSheet.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
    priceWorkSheet.Bulk_OTC_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
    
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Ingredi__c = 10.23;
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
    priceWorkSheet.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';
    priceWorkSheet.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';
    priceWorkSheet.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_l1_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.OTC_Brands_CostBasis1__c = 'WAC';
    priceWorkSheet.OTCg13Cost_Basis__c = 'WAC';
    priceWorkSheet.OTCl3costbasis__c  = 'WAC';
    priceWorkSheet.MinimumsRX1__c = 10.23;
    priceWorkSheet.MinimumsOTCPerRx1__c = 10.23;
    priceWorkSheet.Controlled_substance_fee1__c = 10.23;
    priceWorkSheet.Compound_fee_Infusion1__c = 10.23;

        insert priceWorkSheet;
         
         ApexPages.StandardController sc = new ApexPages.StandardController(priceWorkSheet);
          ApexPages.currentPage().getParameters().put('Id',priceWorkSheet.id);
         
         ext_pwView pwView= new ext_pwView(sc);
         pwView.pricingWorkSheet = priceWorkSheet;
         ApexPages.currentPage().getParameters().put('Id',accChild.id);
         pwView.save();
         pwView.cancel();
     pwView.submitChain();
     pwView.rlVPO();
     pwView.rlCP();
     pwView.rlCAC();
     pwView.rlIVP();
     pwView.rlIVS();
     pwView.rlDOP();
     pwView.rlEP();
         pwView.abIVS();
         pwView.abEP();
         pwView.rlPA();
         pwview.rlIVR();
         pwview.rlAH();
         pwview.rlCredit();
         
         List<Pricing_Worksheet__c> lstpw = [select id from Pricing_Worksheet__c];
        system.assert(lstpw.size() > 0,'pw size');
         
         } 
     static testMethod void ext_pwviewtest3(){
     
     

      system.test.startTest();
      
        
         sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
         
         Account acc= new Account();
         acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
         acc.BillingState='CA';
         insert acc;
          Account accChild = new Account();
      accChild=InsertTestData.createParentAccount('Account2','Pharmacy1','US',True);
      accChild.BillingState='CA';
      accChild.ParentId=acc.Id;
     insert accChild;
         
         Map<String,RecordType> mapPricingRecordType =  new Map<String,RecordType>();
for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                           WHERE SobjectType = 'Pricing_Worksheet__c'])
        mapPricingRecordType.put(recordType.DeveloperName,recordType);
 String stateDefaultId = mapPricingRecordType.get('State_Default').id;
 
Pricing_Worksheet__c objPwDefault = new Pricing_Worksheet__c();
objPwDefault.NAME ='dEFAULT';
objPwDefault.Account__c=acc.id;
objPwDefault.RecordTypeId = stateDefaultId;
objPwDefault.State__c = 'CA';
objPwDefault.Net_Payment_Terms__c='Net 10';
        objPwDefault.Default_Interest_Rate_Finance_Charge__c ='Test';
        objPwDefault.Scheduled_Deliveries_per_days_M_F__c=10.00;
        objPwDefault.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        objPwDefault.Dispensing_method__c='Test';
        objPwDefault.Dispensing_Frequency__c='Test';
        objPwDefault.Dispensing_Type__c='Test';
        
objPwDefault.RX_Brands_All_except_1V_TPN_Cost_Basi__c = 'WAC';
objPwDefault.RX_Brands_All_except_1V_TPN_Ingredient__c = 10.23;
objPwDefault.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
objPwDefault.RX_Brands_All_except_1V_TPN_unit_dose__c  = 10.23;


objPwDefault.CBOther22a__c = 'test';
objPwDefault.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
objPwDefault.RX_3_Generic_ManufacturersIngredient__c = 10.23;
objPwDefault.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;

objPwDefault.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
objPwDefault.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
objPwDefault.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;

objPwDefault.CBOther22c__c = 'Test';
objPwDefault.OTC_Brands_Cost_Basis__c = 'WAC';
objPwDefault.OTC_Brands_Ingrediant__c = 10.23;
objPwDefault.Bulk_OTC_Brands_Ingrediant__c = 10.23;
objPwDefault.OTC_Brands_Disp_Fee__c = 10.23;
objPwDefault.OTC_Brands_Unit_Dose_Fee__c =10.23;
objPwDefault.CBOther22d__c = 'Test';

objPwDefault.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
objPwDefault.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;

objPwDefault.CBOther22f__c = 'Test';
objPwDefault.Facility_Special_Pricing__c = 'Enoxaparin';
objPwDefault.Minimums_Rx__c = 10.23;
objPwDefault.Minimums_OTC_per_Rx__c = 10.23;
objPwDefault.Controlled_Substance_Fee_Schedules_2_3__c = 10.23;
objPwDefault.Compound1_Fee_Non_Infusion_Additional_to__c = 'Test';

objPwDefault.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
objPwDefault.Rx_Brands_All_Except_IV_TPN_Ingredi__c  = 10.23;
objPwDefault.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
objPwDefault.CBOther23a__c = 'Test';
objPwDefault.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';

objPwDefault.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.CBOther23b__c = 'Test';
objPwDefault.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';

objPwDefault.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
objPwDefault.Rx_l1_3_Generic_Manufacturers_All_Except__c= 10.23;
objPwDefault.CBOther23c__c = 'Test';
objPwDefault.OTC_Brands_CostBasis1__c = 'WAC';
objPwDefault.OTC_Brands_Ingrediant1__c = 10.23;
objPwDefault.OTC_Brands_DispFee1__c = 10.23;

objPwDefault.CBOther23d__c = 'Test';
objPwDefault.OTCg13Cost_Basis__c = 'WAC';
objPwDefault.OTCg13Ingredient__c = 10.23;
objPwDefault.OTCg13Dispfee__c = 10.23;
objPwDefault.CBOther23e__c = 'Test';
objPwDefault.OTCl3costbasis__c = 'WAC';
objPwDefault.OTCl3Ingredient__c = 10.23;
objPwDefault.OTCl3Disp_fee__c = 10.23;
objPwDefault.CBOther23f__c = 'TEST';
objPwDefault.MinimumsRX1__c = 10.23;

objPwDefault.MinimumsOTCPerRx1__c = 10.23;
objPwDefault.Controlled_substance_fee1__c = 10.23;
objPwDefault.Compound_fee_Infusion1__c = 10.23;
objPwDefault.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
objPwDefault.CBOther24a__c = 'Test';

objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
objPwDefault.CBOther24b__c = 'Text';
objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';

objPwDefault.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
objPwDefault.CBOther24c__c = 'Test';
objPwDefault.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
objPwDefault.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
objPwDefault.CBOther25a__c= 'Test';

objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
objPwDefault.CBOther25b__c = 'Text';
objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';

objPwDefault.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
objPwDefault.CBOther25c__c = 'Test';
objPwDefault.Medical_Records_Serviced_Patients__c = 'Test';
objPwDefault.Medical_Records_Fee_Non_Serviced_Patien__c = 'Test';

objPwDefault.Consulting_Pharmacist_Required_Services__c = 'Test';
objPwDefault.Consulting_Pharmacist_Optional_Services__c = 'Test';
objPwDefault.iMRR_Medication_Regimen_Review_SNF_O__c = 'Test';

objPwDefault.Anticoagulation_Management_Services_SNF__c= 'Test';
objPwDefault.Consulting_Nurse_Charge_Non_1V__c = 'Test';
objPwDefault.Onsite_Consulting_Non_SNF__c = 'Test';
objPwDefault.Remote_Consulting_Non_SNF__c  = 'Test';
objPwDefault.Restocking_fee_Rx_specific__c = 'Test';

objPwDefault.Monthly_No_Med_fee_per_resident_Non_serv__c = 'Test';
objPwDefault.Non_Scheduled_Deliver_fee__c = 'Test';
objPwDefault.Automated_Dispensing_Unit__c = True;
objPwDefault.Automated_Dispensing_Unit_Type__c = 'Omnicell';

objPwDefault.Monthly_ADU_Fee__c = 'Test';
objPwDefault.E_Prescribing_Credit_SNF_Only_per_lic__c = 0.10;
objPwDefault.E_Prescribing_Vendor__c = 'ALMSA Corp';
objPwDefault.E_Prescribing_Vendor_Other__c = 'Test';
objPwDefault.Prompt_Pay_Discount__c = 'Test';

objPwDefault.Net_Payment_Terms__c = 'Net 10';
objPwDefault.Default_Interest_Rate_Finance_Charge__c = 'Test';
objPwDefault.Scheduled_Deliveries_per_days_M_F__c = 7;
objPwDefault.Scheduled_deliveries_per_daySat_Sun__c = 7;

objPwDefault.Dispensing_method__c = 'Test'; 
objPwDefault.Dispensing_Frequency__c = 'Test';
objPwDefault.Dispensing_Type__c = 'Test';
objPwDefault.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
objPwDefault.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
objPwDefault.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
objPwDefault.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;

insert objPwDefault;
         
         
        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Account__c=accChild.id;
        
        priceWorkSheet.Status__c='Executed';
        priceWorkSheet.Facility_name_DBA__c=accChild.id;
        priceWorkSheet.State__c='CA';
        priceWorkSheet.Net_Payment_Terms__c='Net 10';
        priceWorkSheet.Default_Interest_Rate_Finance_Charge__c ='Test';
        priceWorkSheet.Scheduled_Deliveries_per_days_M_F__c=10.00;
        priceWorkSheet.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        priceWorkSheet.Dispensing_method__c='Test';
        priceWorkSheet.Dispensing_Frequency__c='Test';
        priceWorkSheet.Dispensing_Type__c='Test';
        
        
        priceWorkSheet.RX_Brands_All_except_1V_TPN_Cost_Basi__c  = 'WAC';
    priceWorkSheet.RX_Brands_All_except_1V_TPN_Ingredient__c = 2.5;
    priceWorkSheet.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
    priceWorkSheet.RX_Brands_All_except_1V_TPN_unit_dose__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
    priceWorkSheet.RX_3_Generic_ManufacturersIngredient__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;
    
    priceWorkSheet.OTC_Brands_Cost_Basis__c ='WAC';
    priceWorkSheet.OTC_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_Brands_Disp_Fee__c  = 10.23;
    priceWorkSheet.OTC_Brands_Unit_Dose_Fee__c = 10.23;
    
    priceWorkSheet.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
    priceWorkSheet.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
    
    
    priceWorkSheet.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
    priceWorkSheet.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
    priceWorkSheet.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;
    
    priceWorkSheet.Facility_Special_Pricing__c = 'Enoxaparin';
    priceWorkSheet.Minimums_Rx__c = 10.23;  
    priceWorkSheet.Minimums_OTC_per_Rx__c= 10.23;
    priceWorkSheet.Controlled_Substance_Fee_Schedules_2_3__c= 10.23;
    priceWorkSheet.Compound1_Fee_Non_Infusion_Additional_to__c= 'test';
    

    priceWorkSheet.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
    priceWorkSheet.Bulk_OTC_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';
    priceWorkSheet.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';
    priceWorkSheet.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
    
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Ingredi__c = 10.23;
    priceWorkSheet.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
    priceWorkSheet.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';
    priceWorkSheet.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';
    priceWorkSheet.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.Rx_l1_3_Generic_Manufacturers_All_Except__c = 10.23;
    priceWorkSheet.OTC_Brands_CostBasis1__c = 'WAC';
    priceWorkSheet.OTCg13Cost_Basis__c = 'WAC';
    priceWorkSheet.OTCl3costbasis__c  = 'WAC';
    priceWorkSheet.MinimumsRX1__c = 10.23;
    priceWorkSheet.MinimumsOTCPerRx1__c = 10.23;
    priceWorkSheet.Controlled_substance_fee1__c = 10.23;
    priceWorkSheet.Compound_fee_Infusion1__c = 10.23;

        insert priceWorkSheet;
         
         ApexPages.StandardController sc = new ApexPages.StandardController(priceWorkSheet);
          ApexPages.currentPage().getParameters().put('Id',priceWorkSheet.id);
         
         ext_pwView pwView= new ext_pwView(sc);
         pwView.pricingWorkSheet = priceWorkSheet;
         ApexPages.currentPage().getParameters().put('Id',accChild.id);
         pwView.save();
         pwView.cancel();
     pwView.submitChain();
     
     pwView.changeStateDefaults();
     
    // acc.BillingState='TX';
        // update acc;
         pwView.strAccountOldState = 'TX';
         priceWorkSheet.State__c='TX';
         update priceWorkSheet;
         pwView.changeStateDefaults();
         
     List<Pricing_Worksheet__c> lstpw = [select id from Pricing_Worksheet__c];
        system.assert(lstpw.size() > 0,'pw size');
       
     }
     
     
     
         }