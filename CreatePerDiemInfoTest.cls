@isTest
Public class CreatePerDiemInfoTest{
    public static Profile sysAdmnprof;

    static testMethod void CreatePerDiemInfoTestMethod(){

        System.test.startTest();

        RecordType perDiemStateDefaultRecType= [Select Id from RecordType where Name ='Per Diem State Default'];
        RecordType perDiemWorkSheetRecType = [Select Id from RecordType where Name ='Per Diem Worksheet'];

        sysAdmnprof = [SELECT Id FROM Profile WHERE Name='System Administrator'];

        Account acc= new Account();
        acc=InsertTestData.createParentAccount('Account1','Pharmacy1','US',True);
        acc.BillingState='CA';
        insert acc;

        Pricing_Worksheet__c pricingWork=new Pricing_Worksheet__c();
        pricingWork=InsertTestData.createPricingWorkSheet('WorkBook1');
        pricingWork.Facility_name_DBA__c=acc.id;
        pricingWork.Status__c='Executed';
        pricingWork.Net_Payment_Terms__c='Net 10';
        pricingWork.Default_Interest_Rate_Finance_Charge__c ='Test';
        pricingWork.Scheduled_Deliveries_per_days_M_F__c=10.00;
        pricingWork.Scheduled_deliveries_per_daySat_Sun__c=10.00;
        pricingWork.Dispensing_method__c='Test';
        pricingWork.Dispensing_Frequency__c='Test';
        pricingWork.Dispensing_Type__c='Test';
        
        pricingWork.State__c='CA';
        
        pricingWork.RX_Brands_All_except_1V_TPN_Cost_Basi__c  = 'WAC';
		pricingWork.RX_Brands_All_except_1V_TPN_Ingredient__c = 2.5;
		pricingWork.RX_Brands_All_except_1V_TPN_Disp_fee__c = 10.23;
		pricingWork.RX_Brands_All_except_1V_TPN_unit_dose__c = 10.23;
		pricingWork.RX_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
		pricingWork.RX_3_Generic_ManufacturersIngredient__c = 10.23;
		pricingWork.RX_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
		pricingWork.RX_3_Generic_Manufacturers_Unitdose_fee__c = 10.23;
		pricingWork.RX_le_3_Generic_Manufacturers_Cost_basis__c = 'WAC';
		pricingWork.RX_le_3_Generic_Manufacturers_Ingredient__c = 10.23;
		pricingWork.RX_le_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
		pricingWork.RX_le_3_Generic_Manufacturers_Unit_dose__c = 10.23;
		
		pricingWork.OTC_Brands_Cost_Basis__c ='WAC';
		pricingWork.OTC_Brands_Ingrediant__c = 10.23;
		pricingWork.OTC_Brands_Disp_Fee__c  = 10.23;
		pricingWork.OTC_Brands_Unit_Dose_Fee__c = 10.23;
		
		pricingWork.OTC_g_3_Generic_Manufacturers_Cost_Basis__c = 'AWP';
		pricingWork.OTC_3_g1Generic_Manufacturers_Ingrediant__c = 10.23;
		pricingWork.OTC_g_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
		pricingWork.OTC_3_Generic_Manufacturers_Unit_Dose__c = 10.23;
		
		
		pricingWork.OTC_3_Generic_Manufacturers_Cost_Basis__c = 'WAC';
		pricingWork.OTC_3_Generic_Manufacturers_Ingrediant__c = 10.23;
		pricingWork.OTC_3_Generic_Manufacturers_Disp_Fee__c = 10.23;
		pricingWork.OTC_3_Generic_Manufacturers_Unit_Dose_F__c = 10.23;
		
		pricingWork.Facility_Special_Pricing__c = 'Enoxaparin';
		pricingWork.Minimums_Rx__c = 10.23;  
		pricingWork.Minimums_OTC_per_Rx__c= 10.23;
		pricingWork.Controlled_Substance_Fee_Schedules_2_3__c= 10.23;
		pricingWork.Compound1_Fee_Non_Infusion_Additional_to__c= 'test';
		

		pricingWork.Bulk_OTC_Brands_Cost_Basis__c = 'WAC';
		pricingWork.Bulk_OTC_Brands_Ingrediant__c = 10.23;
		pricingWork.Bulk_OTC_3_Generic_Manufacturers_Cost__c = 'WAC';
		pricingWork.Bulk_OTC_3_Generic_Manufacturers_Ingre__c = 10.23;
		pricingWork.Bulk_OTC_3_Generic_Manufacturers_Cost_B__c = 'WAC';
		pricingWork.Bulk_OTC_3_Generic_Manufacturers_Ingred__c = 10.23;
		pricingWork.Bulk_Vaccine_Brands_Cost_Basis__c = 'WAC';
		pricingWork.Bulk_Vaccine_Brands_Ingrediant__c = 10.23;
		pricingWork.Bulk_Vaccine_3_Generic_Manufacturers_C__c = 'WAC';
		pricingWork.Bulk_Vaccine_3_Generic_Manufacturers_I__c = 10.23;
		pricingWork.Bulk_Vaccine_3_Generic_Manufacturers_Co__c = 'WAC';
		pricingWork.Bulk_Vaccine_3_Generic_Manufacturers_In__c = 10.23;
		
		pricingWork.Rx_Brands_All_Except_IV_TPN_Cost_Ba__c = 'WAC';
		pricingWork.Rx_Brands_All_Except_IV_TPN_Ingredi__c = 10.23;
		pricingWork.Rx_Brands_All_Except_IV_TPN_Disp_Fe__c = 10.23;
		pricingWork.Rx_g3_3_Generic_Manufacturers_All_Except__c = 'WAC';
		pricingWork.Rx_g1_3_Generic_Manufacturers_All_Except__c = 10.23;
		pricingWork.Rx_g2_3_Generic_Manufacturers_All_Except__c = 10.23;
		pricingWork.Rx_l2_3_Generic_Manufacturers_All_Except__c = 'WAC';
		pricingWork.Rx_l_3_Generic_Manufacturers_All_Except__c = 10.23;
		pricingWork.Rx_l1_3_Generic_Manufacturers_All_Except__c = 10.23;
		pricingWork.OTC_Brands_CostBasis1__c = 'WAC';
		pricingWork.OTCg13Cost_Basis__c = 'WAC';
		pricingWork.OTCl3costbasis__c  = 'WAC';
		pricingWork.MinimumsRX1__c = 10.23;
		pricingWork.MinimumsOTCPerRx1__c = 10.23;
		pricingWork.Controlled_substance_fee1__c = 10.23;
		pricingWork.Compound_fee_Infusion1__c = 10.23;
        
        insert pricingWork;

        Per_Diem__c perDiem= new Per_Diem__c();
        perDiem=InsertTestData.createPerDiem();
        perDiem.RecordTypeId=perDiemWorkSheetRecType.Id;
        perDiem.Pricing_Worksheet__c=pricingWork.id;
        perDiem.Exclusions__c='Not Applicable';
        insert perDiem;

        Per_Diem_Exclusion__c diemExclusion= new Per_Diem_Exclusion__c();
        diemExclusion=InsertTestData.createPerDiemExclusion('Exclusion1');
        diemExclusion.Per_Diem__c=perDiem.id;
        insert diemExclusion;

        ApexPages.StandardController sc = new ApexPages.StandardController(pricingWork);
        ApexPages.currentPage().getParameters().put('Id',perDiem.id);
          ApexPages.currentPage().getParameters().put('pwid',pricingWork.id);
        CreatePerDiemInfo diemInfo= new CreatePerDiemInfo(sc);

        acc=diemInfo.acc;
        pricingWork=diemInfo.pricingWorkSheet;

        List<SelectOption> option= new List<SelectOption>();
        option=diemInfo.optionsExclusions;

        diemInfo.addPerDiemExclusion();
        diemInfo.removePerDiemExclusion();
        diemInfo.cancel();
        diemInfo.savePerDiem();
         system.Test.stopTest();
       
       List<Per_Diem__c> lstPerDiem = [select Exclusions__c from Per_Diem__c where id = :perDiem.Id];  
       
       if(lstPerDiem.size() >0)
       {
       	 system.assert(lstPerDiem[0].Exclusions__c == 'Not Applicable','Per Diem');
       }
         

    }
}