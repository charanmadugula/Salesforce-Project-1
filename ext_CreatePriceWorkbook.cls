public with sharing class ext_CreatePriceWorkbook {
Private ApexPages.StandardController stdCtrl;
    Public List<Pricing_Worksheet__c>  lstPricingWorksheet {get;set;}
    Public Pricing_Worksheet__c  pricingWorkSheet {get;set;}
    Public Pricing_Worksheet__c  pricingWorkSheetStateDefault {get;set;}
    //List<Pricing_Worksheet__c>  lstPricingWorksheet{get;set;}
    public List<Pricing_Worksheet__c>  lstStateDefaultPricingWorksheet{get;set;}
    public Financial_Info__c fi {get;set;}
    public User usr {get;set;}
    public Account acc {get;set;}
    public string selectedAccount {get;set;}
    public String oppId{get;set;}
    public Map<String,RecordType> mapPricingRecordType {get;set;}
    public String targetField { get; set; }
    //public Map<Id,RecordType> mapAccountRecordType = new Map<Id,RecordType>([SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                       // WHERE SobjectType = 'Account']);

    public ext_CreatePriceWorkbook(ApexPages.StandardController controller) {
    String ID = ApexPages.currentPage().getParameters().get('id');
        oppId = ApexPages.currentPage().getParameters().get('oppId');
        usr = [SELECT id, Name, MobilePhone,Phone FROM User where id = : UserInfo.getUserId()];
        if(usr.phone == null)
            usr.phone = usr.MobilePhone;
        //List<RecordType> lstRecordType = [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                        //WHERE DeveloperName = 'State_default' AND SobjectType = 'Pricing_Worksheet__c'];
        mapPricingRecordType = new Map<String,RecordType>();
        for(RecordType recordType : [SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                        WHERE SobjectType = 'Pricing_Worksheet__c'])
            mapPricingRecordType.put(recordType.DeveloperName,recordType);
        stdCtrl=controller;
                
        fi = (Financial_Info__c ) stdCtrl.getrecord();
        
        system.debug('*************acc'+acc);
        acc = [Select id, name , BillingState,RecordTypeId,SNF_Beds__c,ALF_Beds__c,Other_Beds__c from Account where id = :fi.Pricing_Worksheet__r.Account__c];
        system.debug('*************acc'+acc.id);
        fetch();
    }
    public PageReference fetch(){
        
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
        String accountId = acc.id;
        
        System.debug('*****accountId******'+accountId);
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where Status__c = \'Executed\'';
        //if(mapAccountRecordType.get(acc.RecordTypeId).DeveloperName == 'Pharmacy')
           // query+= 'and Pharmacy__c = :accountId'; 
        
        lstPricingWorksheet = Database.query(query);
        String stateDefaultId = mapPricingRecordType.get('State_Default').id;
        String accountBillingState = acc.BillingState;
        query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where RecordTypeId = :stateDefaultId and State__c = :accountBillingState limit 1';
        lstStateDefaultPricingWorksheet = Database.query(query);
        System.debug('*****lstPricingWorksheet******'+lstPricingWorksheet);
        System.debug('*****lstStateDefaultPricingWorksheet ******'+lstStateDefaultPricingWorksheet);
        if(lstPricingWorksheet.size()>0)
            pricingWorkSheet = lstPricingWorksheet[0];
        else{
            
        }
        if(lstStateDefaultPricingWorksheet.size() > 0)
        {
            pricingWorkSheetStateDefault = new Pricing_Worksheet__c();
            //Populate all the State default values.
            for(String fieldName : lstPricingWritableFields)
                pricingWorkSheetStateDefault.put(fieldName,lstStateDefaultPricingWorksheet[0].get(fieldName));
            
           /* if(mapAccountRecordType.get(acc.RecordTypeId).DeveloperName == 'Pharmacy')
                pricingWorkSheetStateDefault.Account__c= acc.id;
                pricingWorkSheetStateDefault.Facility_name_DBA__c= acc.id;
            else*/
                pricingWorkSheetStateDefault.Account__c = acc.id;
                pricingWorkSheetStateDefault.Facility_name_DBA__c= acc.id;
                pricingWorkSheetStateDefault.Opportunity__c= oppId;
                pricingWorkSheetStateDefault.Status__c = 'New';
                pricingWorkSheetStateDefault.RecordTypeId = mapPricingRecordType.get('PricingWorksheet').id;
            
            
            //Set NA in the below text fields in case of blank.
            if(pricingWorkSheetStateDefault.Dispensing_Type__c == null)
                pricingWorkSheetStateDefault.Dispensing_Type__c = 'N/A';
            if(pricingWorkSheetStateDefault.Dispensing_Frequency__c == null)
                pricingWorkSheetStateDefault.Dispensing_Frequency__c = 'N/A';
            if(pricingWorkSheetStateDefault.Dispensing_method__c == null)
                pricingWorkSheetStateDefault.Dispensing_method__c = 'N/A';
            if(pricingWorkSheetStateDefault.Compound1_Fee_Non_Infusion_Additional_to__c == null)
                pricingWorkSheetStateDefault.Compound1_Fee_Non_Infusion_Additional_to__c = 'N/A';
            if(pricingWorkSheetStateDefault.Contract_initial_Term__c == null)
                pricingWorkSheetStateDefault.Contract_initial_Term__c = 'N/A';                        
        }
        else{
            system.debug('lstStateDefaultPricingWorksheet'+lstStateDefaultPricingWorksheet.size());
            pricingWorkSheetStateDefault = new Pricing_Worksheet__c();
            /*if(mapAccountRecordType.get(acc.RecordTypeId).DeveloperName == 'Pharmacy')
                pricingWorkSheetStateDefault.Account__c= acc.id;
                pricingWorkSheetStateDefault.Facility_name_DBA__c= acc.id;
            else*/
                pricingWorkSheetStateDefault.Account__c = acc.id;
                pricingWorkSheetStateDefault.Facility_name_DBA__c= acc.id;
            pricingWorkSheetStateDefault.RecordTypeId = mapPricingRecordType.get('PricingWorksheet').id;
           // pricingWorkSheetStateDefault.Account__c= acc.id;
            if(oppId!=null)
                pricingWorkSheetStateDefault.Opportunity__c= oppId;
            pricingWorkSheetStateDefault.Status__c = 'New';
            pricingWorkSheetStateDefault.Dispensing_Type__c = 'N/A';
            pricingWorkSheetStateDefault.Dispensing_Frequency__c = 'N/A';
            pricingWorkSheetStateDefault.Dispensing_method__c = 'N/A';
            pricingWorkSheetStateDefault.Compound1_Fee_Non_Infusion_Additional_to__c = 'N/A';
            pricingWorkSheetStateDefault.Contract_initial_Term__c= 'N/A';
            
        }
        return null;
    }
    public Pagereference savePriceBook(){
        //stdCtrl.save();
        //Check whether user updated N/A fields or not. if not then remove N/A from the fields.
        if(pricingWorkSheetStateDefault.Dispensing_Type__c == 'N/A')
                pricingWorkSheetStateDefault.Dispensing_Type__c = '';
            if(pricingWorkSheetStateDefault.Dispensing_Frequency__c == 'N/A')
                pricingWorkSheetStateDefault.Dispensing_Frequency__c = '';
            if(pricingWorkSheetStateDefault.Dispensing_method__c == 'N/A')
                pricingWorkSheetStateDefault.Dispensing_method__c = '';
            if(pricingWorkSheetStateDefault.Compound1_Fee_Non_Infusion_Additional_to__c == 'N/A')
                pricingWorkSheetStateDefault.Compound1_Fee_Non_Infusion_Additional_to__c = '';
            if(pricingWorkSheetStateDefault.Contract_initial_Term__c== 'N/A')
                pricingWorkSheetStateDefault.Contract_initial_Term__c= '';
                
        upsert pricingWorkSheetStateDefault;
        PageReference pg;
        if(oppId==null)
            pg  = new PageReference('/' + acc.Id);
        else
            pg  = new PageReference('/' + oppId);
        return pg ; 
    }
    public PageReference displayFinCalculations() 
    {
        PageReference redirect = new PageReference('/apex/FinancialCalculations');   
        redirect.getParameters().put('id',selectedAccount); 
        return redirect;
    }
}