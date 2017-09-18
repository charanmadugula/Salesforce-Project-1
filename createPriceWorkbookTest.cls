@isTest
Public class createPriceWorkbookTest{
    public static Profile sysAdmnprof;

    static testMethod void createPriceWorkbookTestMethod(){

        Test.startTest();

        RecordType pricingWorkSheetRecType = [Select Id from RecordType where Name ='Pricing Worksheet'];
        RecordType stateDefaultRecType = [Select Id from RecordType where Name ='State Default'];

        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        Account acc= new Account();
        acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
        acc.BillingState='CA';
        insert acc;
        
        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Account__c=acc.id;
        priceWorkSheet.RecordTypeId=stateDefaultRecType.id;
        priceWorkSheet.Status__c='Executed';
        priceWorkSheet.Facility_name_DBA__c=acc.id;
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


        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        createPriceWorkbook priceBook= new createPriceWorkbook(sc);
        String field=priceBook.targetField;
        
        priceBook.savePriceBook();
        priceBook.displayFinCalculations();
         priceBook.cancel();
        Pricing_Worksheet__c priceWorkSheet1= new Pricing_Worksheet__c();
        priceWorkSheet1=InsertTestData.createPricingWorkSheet('WorkSheet2');
        priceWorkSheet1.Account__c=acc.id;
        priceWorkSheet1.RecordTypeId=pricingWorkSheetRecType.id;
        priceWorkSheet1.Dispensing_Type__c='N/A';
        priceWorkSheet1.Dispensing_Frequency__c='N/A';
        priceWorkSheet1.Dispensing_method__c='N/A';
        priceWorkSheet1.Compound1_Fee_Non_Infusion_Additional_to__c='N/A';
        priceWorkSheet1.Contract_initial_Term__c='N/A';
        priceWorkSheet1.Net_Payment_Terms__c='Net 10';
         priceWorkSheet1.Default_Interest_Rate_Finance_Charge__c ='Test';
         priceWorkSheet1.Scheduled_Deliveries_per_days_M_F__c=10.00;
         priceWorkSheet1.Scheduled_deliveries_per_daySat_Sun__c=10.00;
         priceWorkSheet1.Dispensing_method__c='Test';
         priceWorkSheet1.Dispensing_Frequency__c='Test';
         priceWorkSheet1.Dispensing_Type__c='Test';
        
         priceWorkSheet1.State__c='CA';
        
         priceWorkSheet1.RX_Brands_All_except_1V_TPN_Cost_Basi__c  = 'WAC';
         priceWorkSheet1.RX_Brands_All_except_1V_TPN_Ingredient__c = 2.5;
         priceWorkSheet1.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
         priceWorkSheet1.RX_Brands_All_except_1V_TPN_unit_dose__c = 10.23;
         priceWorkSheet1.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
         priceWorkSheet1.RX_3_Generic_ManufacturersIngredient__c = 10.23;
         priceWorkSheet1.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
         priceWorkSheet1.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;
         priceWorkSheet1.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
         priceWorkSheet1.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
         priceWorkSheet1.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
         priceWorkSheet1.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;
        
         priceWorkSheet1.OTC_Brands_Cost_Basis__c ='WAC';
         priceWorkSheet1.OTC_Brands_Ingrediant__c = 10.23;
         priceWorkSheet1.OTC_Brands_Disp_Fee__c  = 10.23;
         priceWorkSheet1.OTC_Brands_Unit_Dose_Fee__c = 10.23;
        
         priceWorkSheet1.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
         priceWorkSheet1.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
         priceWorkSheet1.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
         priceWorkSheet1.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
        
        
         priceWorkSheet1.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
         priceWorkSheet1.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
         priceWorkSheet1.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
         priceWorkSheet1.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;
        
         priceWorkSheet1.Facility_Special_Pricing__c = 'Enoxaparin';
         priceWorkSheet1.Minimums_Rx__c = 10.23;  
         priceWorkSheet1.Minimums_OTC_per_Rx__c= 10.23;
         priceWorkSheet1.Controlled_Substance_Fee_Schedules_2_3__c= 10.23;
         priceWorkSheet1.Compound1_Fee_Non_Infusion_Additional_to__c= 'test';
        

         priceWorkSheet1.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
         priceWorkSheet1.Bulk_OTC_Brands_Ingrediant__c = 10.23;
         priceWorkSheet1.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
         priceWorkSheet1.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
         priceWorkSheet1.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';
         priceWorkSheet1.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
         priceWorkSheet1.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
         priceWorkSheet1.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
         priceWorkSheet1.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
         priceWorkSheet1.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
         priceWorkSheet1.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';
         priceWorkSheet1.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
        
         priceWorkSheet1.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
         priceWorkSheet1.Rx_Brands_All_Except_IV_TPN_Ingredi__c = 10.23;
         priceWorkSheet1.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
         priceWorkSheet1.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';
         priceWorkSheet1.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
         priceWorkSheet1.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
         priceWorkSheet1.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';
         priceWorkSheet1.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
         priceWorkSheet1.Rx_l1_3_Generic_Manufacturers_All_Except__c = 10.23;
         priceWorkSheet1.OTC_Brands_CostBasis1__c = 'WAC';
         priceWorkSheet1.OTCg13Cost_Basis__c = 'WAC';
         priceWorkSheet1.OTCl3costbasis__c  = 'WAC';
         priceWorkSheet1.MinimumsRX1__c = 10.23;
         priceWorkSheet1.MinimumsOTCPerRx1__c = 10.23;
         priceWorkSheet1.Controlled_substance_fee1__c = 10.23;
         priceWorkSheet1.Compound_fee_Infusion1__c = 10.23;
        
        insert priceWorkSheet1;  
        
        List<Pricing_Worksheet__c> lstPW = [select id from Pricing_Worksheet__c];
        system.assert(lstPW.size() > 0,'PW size');
        Test.StopTest();
    }

    static testMethod void createPriceWorkbookTestMethod1(){

        Test.startTest();

        RecordType pricingWorkSheetRecType = [Select Id from RecordType where Name ='Pricing Worksheet'];
        RecordType stateDefaultRecType = [Select Id from RecordType where Name ='State Default'];

        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        Account acc= new Account();
        acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
        acc.BillingState='CA';
        insert acc;

        Opportunity opp= new Opportunity();
        opp=InsertTestData.createOpportunity('opp1',acc.id);
        opp.StageName='Prospecting';
        opp.CloseDate=system.today();
        insert opp;

        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        createPriceWorkbook priceBook= new createPriceWorkbook(sc);

        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Account__c=acc.id;
        priceWorkSheet.RecordTypeId=pricingWorkSheetRecType.id;
        priceWorkSheet.Status__c='Executed';
        priceWorkSheet.Facility_name_DBA__c=acc.id;
        priceWorkSheet.Opportunity__c=opp.id;
         priceWorkSheet.Net_Payment_Terms__c='Net 10';
        priceWorkSheet.Default_Interest_Rate_Finance_Charge__c ='Test';
        priceWorkSheet.Scheduled_Deliveries_per_days_M_F__c=10.00;
        priceWorkSheet.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        priceWorkSheet.Dispensing_method__c='Test';
        priceWorkSheet.Dispensing_Frequency__c='Test';
        priceWorkSheet.Dispensing_Type__c='Test';
        
        priceWorkSheet.State__c='CA';
        
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
        
        List<Pricing_Worksheet__c> lstPW = [select id from Pricing_Worksheet__c];
        system.assert(lstPW.size() > 0,'PW size');

        Financial_Info__c fi = new Financial_Info__c();
            fi.Pricing_Worksheet__c = priceWorkSheet.Id;
        insert fi;
    }

    
    
    static testMethod void createPriceWorkbookTestMethod_2(){

        Test.startTest();

        RecordType pricingWorkSheetRecType = [Select Id from RecordType where Name ='Pricing Worksheet'];
        RecordType stateDefaultRecType = [Select Id from RecordType where Name ='State Default'];

        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        Account acc= new Account();
        acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
        acc.BillingState='CA';
        insert acc;
        
        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Account__c=acc.id;
        priceWorkSheet.RecordTypeId=stateDefaultRecType.id;
        priceWorkSheet.Status__c='Executed';
        priceWorkSheet.Facility_name_DBA__c=acc.id;
        priceWorkSheet.State__c='CA';
        priceWorkSheet.Net_Payment_Terms__c='Net 10';
        priceWorkSheet.Default_Interest_Rate_Finance_Charge__c ='Test';
        priceWorkSheet.Scheduled_Deliveries_per_days_M_F__c=10.00;
        priceWorkSheet.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        priceWorkSheet.Dispensing_method__c='N/A';
        priceWorkSheet.Dispensing_Frequency__c='N/A';
        priceWorkSheet.Dispensing_Type__c='N/A';
        
      
        
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
        priceWorkSheet.Compound1_Fee_Non_Infusion_Additional_to__c= 'N/A';
        priceWorkSheet.Contract_initial_Term__c='N/A';
        

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


        ApexPages.StandardController sc = new ApexPages.StandardController(acc);
        createPriceWorkbook priceBook= new createPriceWorkbook(sc);
        String field=priceBook.targetField;
        
        priceBook.savePriceBook();
        priceBook.displayFinCalculations();
        
        Test.StopTest();
        
        List<Pricing_Worksheet__c> lstPW = [select id from Pricing_Worksheet__c];
        system.assert(lstPW.size() > 0,'PW size');
    }
}