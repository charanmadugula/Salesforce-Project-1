//========================================================================
//  Object: ext_FinacnialInfo
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for ext_FinacnialInfo VF Page
//========================================================================
//          Date            Purpose
// Changes: 11/27/2015      Initial Version
//========================================================================


public with sharing class ext_FinacnialInfo {
    
    //Variables
    public Pricing_Worksheet__c pricingWorkSheet{get;set;}
    public list<Pricing_Worksheet__c> pwList;
    public id pwid {get;set;}
    public Account acc {get;set;}
    public Financial_Info__c  financialInfo {get;set;}
    public id fiid {get;set;}
    public list<Financial_Info__c> fiList;
    public Financial_Info__c lstFinInfoInserted{get;set;}
    public Boolean isAdmin {get;set;}   
    public Boolean save {get;set;}
    public List<Pricing_Worksheet__c> lstpw {get;set;}
    public User pwUser {get;set;}
     public id curUser {get;set;}
     
    public ext_FinacnialInfo(ApexPages.StandardController stdController) {
        
        //Get Record Id
        
        pwid = ApexPages.currentPage().getParameters().get('pwid');
        
        lstFinInfoInserted = new Financial_Info__c();
        //isadmin
      //set initial values
      isadmin = False;
      curUser = Userinfo.getUserId();

      pwUser = globalHelper.getUserFields(CurUser);

      isAdmin = globalHelper.isUserAdmin(pwUser.Id);
      //save
      //set initial values
      save=False;
      
      List<Pricing_Worksheet__c> lstpw = [select id , Status__c from Pricing_Worksheet__c where id = :pwid] ;
       if((lstpw[0].status__c == 'New'&&!isadmin) || (lstpw[0].status__c == 'In Progress' && isadmin)||lstpw[0].status__c == 'Rejected' ){
            save = true;
            }   
        
        //Populate Pricing Worksheet
        String SobjectApiName = 'Pricing_Worksheet__c';
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> fieldMap = schemaMap.get(SobjectApiName).getDescribe().fields.getMap();
        String commaSepratedFields = '';
        for(String fieldName : fieldMap.keyset()){
            if(commaSepratedFields == null || commaSepratedFields == ''){
                commaSepratedFields = fieldName;
            }else{
                commaSepratedFields = commaSepratedFields + ', ' + fieldName;
            }
        }
        String query = 'select ' + commaSepratedFields + ',Account__r.SNF_Beds__c,Account__r.ALF_Beds__c,Account__r.Other_Beds__c from ' + SobjectApiName + ' where id = :pwid limit 1';
        pwList = Database.query(query);
        pricingWorkSheet = pwList[0];       
        
        //Populate Financial Info
        fiList = [Select    Total_Annual_Revenue_All_Payor_Types_cu__c, Total_Annual_Revenue1_All_payor_types__c, Total_Annual_Facility_Revenue_Projected__c, 
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
                    where Pricing_Worksheet__c = :pwid limit 1];
        financialInfo = fiList[0];          
       if(pwid != null){
       lstFinInfoInserted.Pricing_Worksheet__c = pwid;
       } 
        
    }
     public Pagereference saveFinInfo(){
      //List<Pricing_Worksheet__c> lstpw = [select id , Status__c from Pricing_Worksheet__c where id = :pwid] ;
      // system.debug(LoggingLevel.Info,'>>>>>>objPw'+lstpw);
      /* if(lstpw.size() > 0 && (lstpw[0].Status__c == 'In Progress' || lstpw[0].Status__c == 'Approved') )
       {
         ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Financial Info once submitted cannot be edited unless approved'));
         return null;
       }
       else
      {*/
            try{
            update financialInfo;
            system.debug('lstFinInfoInserted '+lstFinInfoInserted );
            PageReference pg;
            pg  = new PageReference('/' + pwid);
            return pg ; 
            }
            catch(exception ex){system.debug('>>>>>exception'+ex);
            return null;}
      }
     

     public Pagereference cancel(){

        PageReference pg;
            pg  = new PageReference('/' + pwid);
        return pg ; 
     }   
}