@isTest
Public class ext_CreateViewSceduleTest{
    public static Profile sysAdmnprof;

    static testMethod void ext_pwStateTestMethod(){

        system.Test.startTest();

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
        priceWorkSheet.Status__c='In Process';
        priceWorkSheet.Facility_name_DBA__c=acc.id;
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
        
        Internal_IV_Worksheet__c objIVPricing= new Internal_IV_Worksheet__c();
        objIVPricing = InsertTestData.createInternalWorkSheet();
        objIVPricing.Pricing_Worksheet__c= priceWorkSheet.id;
        objIVPricing.Account__c=acc.id;
        insert objIVPricing;
        
        Per_Diem__c obj = new Per_Diem__c();
        obj.Pricing_Worksheet__c = priceWorkSheet.Id;
        insert obj;
        system.debug('priceWorkSheet---->'+priceWorkSheet);
        ApexPages.StandardController sc1 = new ApexPages.StandardController(priceWorkSheet);
        ApexPages.currentPage().getParameters().put('Id',objIVPricing.id);
        ApexPages.currentPage().getParameters().put('Id',priceWorkSheet.id);
        
        ApexPages.currentPage().getParameters().put('perdimid',obj.Id);
        Ext_ViewCreateSchedule objcreateSchedule = new Ext_ViewCreateSchedule(sc1);
        objcreateSchedule.pricingWorkSheet = priceWorkSheet;
        objcreateSchedule.internalIVWorkSheet = objIVPricing;
        objcreateSchedule.deliverAsPDF();
        ApexPages.StandardController sc = new ApexPages.StandardController(priceWorkSheet);
        ApexPages.currentPage().getParameters().put('Id',priceWorkSheet.id);
        
        ext_ViewPricingWorksheet objViewPricingWorksheet = new ext_ViewPricingWorksheet(sc);
        objViewPricingWorksheet.autoRun();
        
          ApexPages.StandardController sc3 = new ApexPages.StandardController(priceWorkSheet);
           ApexPages.currentPage().getParameters().put('iwsId',objIVPricing.id);
            ApexPages.currentPage().getParameters().put('accId',acc.id);
          
          Ext_SchedulePagepdf objPDF  = new Ext_SchedulePagepdf(sc3);
          objPDF.deliverAsPDF();
        system.Test.StopTest();
        
        List<Pricing_Worksheet__c> lstPW = [select id from Pricing_Worksheet__c];
        system.assert(lstPW.size() > 0,'PW size');
    }

}