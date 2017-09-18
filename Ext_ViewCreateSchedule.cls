public with sharing class Ext_ViewCreateSchedule
{
    public Pricing_Worksheet__c pricingWorkSheet {get;set;}
    public Internal_IV_Worksheet__c internalIVWorkSheet {get;set;}
    public Account acc{get;set;}
     public Account pwa2 {get;set;}
    public String accId;
    public String internalWorkSheetId;
    public Boolean pdTrueUp {get;set;}
      public List<Per_Diem__c> pdList;
      public String Exclusion {get; set;}
public User pwUser {get;set;}
public Boolean rSNF {get;set;}
public Boolean rNONSNF {get;set;}
 public List<PerDiemExclusionWrapper> lstPerDiemExclusionsWrap {get;set;}
    public Per_Diem__c perDiem {get;set;}
 public string PerDiemId {get;set;}
 
    public Ext_ViewCreateSchedule(ApexPages.StandardController stdController) {
        pricingWorkSheet = (Pricing_Worksheet__c)stdController.getRecord();
        pricingWorkSheet = globalHelper.getPricingWorksheetFields(pricingWorkSheet.id);
        internalWorkSheetId = ApexPages.currentPage().getParameters().get('iwsId');
        if(internalWorkSheetId!= null){
        internalIVWorkSheet = globalHelper.getInternalIVFields(internalWorkSheetId);
        }
        accId = ApexPages.currentPage().getParameters().get('accId');
        acc = globalHelper.getAccountFields(pricingWorkSheet.Account__c);
        pwa2 = [Select id, name ,OCR_Pharmacy_Name__r.name,OCR_Pharmacy_Name__r.Pharmacy_Box_Company__c,OCR_Pharmacy_Name__r.Pharmacy_Dispensing_System__c, ParentID,BillingState,RecordTypeId,SNF_Beds__c,ALF_Beds__c,Other_Beds__c from Account where id = :pricingWorkSheet.Account__c];
        //if(accId!= null){
       // acc = globalHelper.getAccountFields(accId);
        //}
         pwUser = globalHelper.getUserFields(pricingWorkSheet.CreatedById);
        //Per Diem True Up
        if (pricingWorkSheet.Facility_Pricing_Contract_terms_Patient__c == 'Per Diem') {
            pdTrueUp = true;
        }
        else {
            pdTrueUp = false;
        }
       // system.debug(LoggingLevel.info,'>>>>>ApexPages.currentPage().getParameters().get'+ApexPages.currentPage().getParameters().get('perdimid'));
        
        if(ApexPages.currentPage().getParameters().get('perdimid') !='' && ApexPages.currentPage().getParameters().get('perdimid') !=null)
          {
            PerDiemId = ApexPages.currentPage().getParameters().get('perdimid');
             getPerDiemInfo();
          }
       
       //SNF
            if(acc.SNF_Beds__c > 0 ) {
                rSNF = true;
            }
            else {
                rSNF = false;
            }
            //NONSNF
            if((acc.SNF_Beds__c > 0 && acc.SNF_Beds__c!= acc.Total_Beds__c)||(acc.SNF_Beds__c== 0)||(acc.SNF_Beds__c==null)) {
                rNONSNF = true;
            }
            else {
                rNONSNF = false;
            }

    }
    
    public void getPerDiemInfo()
    {
        

        //Populate Per Diem
        String SobjectApiName = 'Per_Diem__c';
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where id = :PerDiemId limit 1';
        pdList = Database.query(query);
        perDiem = pdList[0];
        Exclusion = perDiem.Exclusions__c;
        List<Per_Diem_Exclusion__c> lstPerDiemExc = [Select id,Exclusion__c from Per_Diem_Exclusion__c where Per_Diem__c =:PerDiemId];
        lstPerDiemExclusionsWrap = new List<PerDiemExclusionWrapper>();
        if(lstPerDiemExc.size()==0)
            lstPerDiemExclusionsWrap.add(new PerDiemExclusionWrapper(new Per_Diem_Exclusion__c()));
        else
        {
            for(Per_Diem_Exclusion__c perDiemEx : lstPerDiemExc)
            {
                lstPerDiemExclusionsWrap.add(new PerDiemExclusionWrapper(perDiemEx));
            }
        }
        
    }
    
    public PageReference deliverAsPDF() {
    PageReference pdf =  Page.SummaryPDF;
    pdf.getParameters().put('id',pricingWorkSheet.Id);
    pdf.getParameters().put('perdimid',PerDiemId);
    return pdf;
    }
    
     public class PerDiemExclusionWrapper
    {
        public Boolean addRemoveFlag {get;set;}
        public Per_Diem_Exclusion__c perDiemExclusion {get;set;}
        public PerDiemExclusionWrapper(Per_Diem_Exclusion__c perDiemExc)
        {
            addRemoveFlag = false;
            perDiemExclusion = perDiemExc;
        }
    }
    
     public list<SelectOption> optionsExclusions {
        get {
                //Build Containers
                list<SelectOption> soex = new list<SelectOption>();
                soex.add(new SelectOption('Not Applicable', 'Not Applicable'));
                soex.add(new SelectOption('Standard List', 'Standard List'));
                soex.add(new SelectOption('Custom List', 'Custom List'));

                //Return List
                return soex;                
        }
        set;
    }
    
    
}