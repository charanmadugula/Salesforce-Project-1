@isTest
Public class PricingWorksheetTriggerTest{

    public static Profile sysAdmnprof;

    static testMethod void PricingWorksheetTriggerTestMethod(){
        Test.startTest();

        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        
        Special_Pricing__c specialPricing= new Special_Pricing__c();
        specialPricing=InsertTestData.createSpecialPricing('Pricing1');
        insert specialPricing;
        
        Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
        priceWorkSheet=InsertTestData.createPricingWorkSheet('WorkSheet1');
        priceWorkSheet.Special_Pricing__c=specialPricing.id;
        priceWorkSheet.Facility_Special_Pricing__c='Enoxaparin';
        priceWorkSheet.Status__c='In Progress';
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
        
        th_PricingWorksheet pricingWorksheet= new th_PricingWorksheet(True,10);
        Boolean IsTriggerContext=pricingWorksheet.IsTriggerContext;
        Boolean IsVisualforcePageContext=pricingWorksheet.IsVisualforcePageContext;
        Boolean IsWebServiceContext=pricingWorksheet.IsWebServiceContext;
        Boolean IsExecuteAnonymousContext=pricingWorksheet.IsExecuteAnonymousContext;
        
        List<Pricing_Worksheet__c> lstpw = [select id from Pricing_Worksheet__c];
         system.assert(lstpw.size() > 0,'pw size');
        
        }
        }