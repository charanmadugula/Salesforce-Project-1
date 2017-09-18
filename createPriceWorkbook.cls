public with sharing class createPriceWorkbook{

    Public ApexPages.StandardController stdCtrl;
    Public List<Pricing_Worksheet__c>  lstPricingWorksheet {get;set;}
    Public Pricing_Worksheet__c  pricingWorkSheet {get;set;}
    Public Pricing_Worksheet__c  pricingWorkSheetStateDefault {get;set;}
    //List<Pricing_Worksheet__c>  lstPricingWorksheet{get;set;}
    public List<Pricing_Worksheet__c>  lstStateDefaultPricingWorksheet{get;set;}
    public User usr {get;set;}
    public Account acc {get;set;}
    public string selectedAccount {get;set;}
    public String oppId{get;set;}
    public Map<String,RecordType> mapPricingRecordType {get;set;}
    public String targetField { get; set; }
    public Boolean rSNF {get;set;}
    public Boolean rNONSNF {get;set;}
    // 1/06/2016 Added variables for custom lookup(Opportunity)
    public String opportunityName {get; set;}
    public Id opportunityId {get; set;}

    //public Map<Id,RecordType> mapAccountRecordType = new Map<Id,RecordType>([SELECT DeveloperName,Id,IsActive,Name,SobjectType FROM RecordType 
                       // WHERE SobjectType = 'Account']);
    Public createPriceWorkbook(ApexPages.StandardController controller)
    {
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
        
        acc = (Account) stdCtrl.getrecord();
        system.debug('*************acc'+acc);
        acc = [Select id, name ,OCR_Pharmacy_Name__r.name,OCR_Pharmacy_Name__r.Pharmacy_Box_Company__c,OCR_Pharmacy_Name__r.Pharmacy_Dispensing_System__c, ParentId, BillingState,BillingStreet,BillingPostalCode,BillingCity,RecordTypeId,
                    MEM_Beds__c, mrdd_beds__c, psych_beds__c, hsp_beds__c, num_of_IL_beds__c,SNF_Beds__c,ALF_Beds__c,Other_Beds__c, total_beds__c,Parent_Account_Name__c,Distance_to_Service_Facility__c from Account where id = :acc.id];
        system.debug('*************acc'+acc.id);


            //SNF
            if(acc.SNF_Beds__c > 0 ) { 
                rSNF = true;
            }
            else {
                rSNF = false;
            }
        
         //NONSNF
            if((acc.SNF_Beds__c > 0 && acc.SNF_Beds__c!= acc.Total_Beds__c)||(acc.SNF_Beds__c== 0)||(acc.SNF_Beds__c== null)) {
                rNONSNF = true;
            }
            else {
                rNONSNF = false;
            }
         //Added for autopopulating opportunity name 06/02/2016
         if(oppId !=null)
         {
            Opportunity objOpportunity = [select id,Name from Opportunity where Id=:oppId];
            if(objOpportunity !=null) opportunityName = objOpportunity.Name; opportunityId = objOpportunity.Id;
         }
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where Status__c = \'Approved\' and Facility_name_DBA__c = :accountId'; //Mamta please add account filter
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

                //Please Fix.  Values aren't populating.
        //pricingWorkSheetStateDefault.Box_Company__c = pricingWorkSheet.Box_Company__c;
        //pricingWorkSheetStateDefault.Submission_Source__c = pricingWorkSheet.Submission_Source__c;
        //pricingWorkSheetStateDefault.Proposal_Type__c = pricingWorkSheet.Proposal_Type__c;
        //pricingWorkSheetStateDefault.Dispensing_System__c = pricingWorkSheet.Dispensing_System__c;
        //pricingWorkSheetStateDefault.Opportunity__c = pricingWorkSheet.Opportunity__c;
        //pricingWorkSheetStateDefault.OCR_Pharmacy__c = pricingWorkSheet.OCR_Pharmacy__c;             
        //pricingWorkSheetStateDefault.Band__c = pricingWorkSheet.Band__c;

        try {
            pricingWorkSheetStateDefault.Opportunity__c = opportunityId;
            system.debug(LoggingLevel.Info,'>>>pricingWorkSheetStateDefault>'+pricingWorkSheetStateDefault.Minimums_Rx__c);
            system.debug(LoggingLevel.Info,'>>>pricingWorkSheetStateDefault>'+pricingWorkSheetStateDefault.Minimums_OTC_per_Rx__c);
            
            //12/21/2016 To set the current user as a owner id
            pricingWorkSheetStateDefault.OwnerId = userinfo.getUserId();
            
            upsert pricingWorkSheetStateDefault;
            PageReference pg;
            if(oppId==null)
                pg  = new PageReference('/' + pricingWorkSheetStateDefault.Id);
            else
                pg  = new PageReference('/' + pricingWorkSheetStateDefault.Id);
            return pg ;         
        }
        catch (DMLexception e) {
           
            return null;
        }


    }
     //Cancel
    public PageReference cancel() {
       pagereference pr = new pagereference('/' + pricingWorkSheetStateDefault.Account__c);
            pr.setredirect(true);
        return pr;  
      }



    public PageReference displayFinCalculations() 
    {
        PageReference redirect = new PageReference('/apex/FinancialCalculations');   
        redirect.getParameters().put('id',selectedAccount); 
        return redirect;
    }
}