public with sharing class CreatePerDiemInfo
{
    String accountId;
    String pricingWorkSheetId;
    public Account acc {get;set;}
    public id PerDiemId {get;set;}
    public List<Per_Diem__c> pdList;
    public Pricing_Worksheet__c  pricingWorkSheet {get;set;}
    public List<PerDiemExclusionWrapper> lstPerDiemExclusionsWrap {get;set;}
    public Per_Diem__c perDiem {get;set;}
    public String Exclusion {get; set;}
    public Boolean isAdmin {get;set;}   
    public Boolean save {get;set;}
    public User pwUser {get;set;}
     public id curUser {get;set;}
     public string strpwid;
    public List<Pricing_Worksheet__c> lstpw {get;set;}

    // public CreatePerDiemInfo()
    public CreatePerDiemInfo(ApexPages.StandardController stdController) 
    {
        
        PerDiemId = ApexPages.currentPage().getParameters().get('id');
     
        strpwid =   ApexPages.currentPage().getParameters().get('pwid');
         
         //isadmin
      //set initial values
      isadmin = False;
      curUser = Userinfo.getUserId();

      pwUser = globalHelper.getUserFields(CurUser);

      isAdmin = globalHelper.isUserAdmin(pwUser.Id);
      //save
      //set initial values
      save=False;
      
      List<Pricing_Worksheet__c> lstpw = [select id , Status__c from Pricing_Worksheet__c where id = :strpwid] ;
       if(lstpw.size() >0 && ((lstpw[0].status__c == 'New'&&!isadmin) || (lstpw[0].status__c == 'In Progress' && isadmin) || lstpw[0].status__c == 'Rejected' )){
            save = true;
            }   
        
        
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

    //Incident Dropdown
    public list<SelectOption> optionsExclusions 
    {
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
    


    public PageReference addPerDiemExclusion()
    {
        lstPerDiemExclusionsWrap.add(new PerDiemExclusionWrapper(new Per_Diem_Exclusion__c()));
        return null;
    }
    
    public PageReference removePerDiemExclusion()
    {
        List<PerDiemExclusionWrapper> lstPerDiemExclusionsWrap1 = new List<PerDiemExclusionWrapper>();
        List<Per_Diem_Exclusion__c> lstPerDiemExclusion = new List<Per_Diem_Exclusion__c>();
        for(PerDiemExclusionWrapper perDiemExclusionWrap:lstPerDiemExclusionsWrap)
        {
            if(!perDiemExclusionWrap.addRemoveFlag)
            {
                lstPerDiemExclusionsWrap1.add(perDiemExclusionWrap);
            }
            else
            {
                if(perDiemExclusionWrap.perDiemExclusion.id!=null)
                    lstPerDiemExclusion.add(perDiemExclusionWrap.perDiemExclusion);
            }
        }
        lstPerDiemExclusionsWrap = lstPerDiemExclusionsWrap1;
        if(lstPerDiemExclusion.size()>0)
            delete lstPerDiemExclusion;
        return null;
    }

    //Cancel
    public PageReference cancel() 
    {

        pagereference pr = new pagereference('/' + perDiem.Pricing_Worksheet__c);
            pr.setredirect(true);
        return pr;  
    }


    public PageReference savePerDiem()
    {
      
         //List<Pricing_Worksheet__c> lstpw = [select id , Status__c from Pricing_Worksheet__c where id = :strpwid] ;
         // system.debug(LoggingLevel.Info,'>>>>>>objPw'+lstpw);
         /* if(lstpw.size() > 0 && (lstpw[0].Status__c == 'In Progress' || lstpw[0].Status__c == 'Approved') )
           {
             ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Per Diem Worksheet once submitted cannot be edited unless approved'));
             return null;
           }
           else
          { */     
            try{
                perDiem.Exclusions__c = Exclusion;
                update perDiem;
                //if(perDiem.id!=null)
                //{ 
                    //perDiem.Exclusions__c = Exclusion;
                    
                List<Per_Diem_Exclusion__c> lstPerDiemExclusion = new List<Per_Diem_Exclusion__c>();
                for(PerDiemExclusionWrapper perDiemExclusionWrap:lstPerDiemExclusionsWrap)
                {
                    if(perDiemExclusionWrap.perDiemExclusion.id==null)
                        perDiemExclusionWrap.perDiemExclusion.Per_Diem__c = perDiem.id;
                    lstPerDiemExclusion.add(perDiemExclusionWrap.perDiemExclusion);
                }
                if(lstPerDiemExclusion.size()>0)
                    upsert lstPerDiemExclusion;
                  //  PageReference pg = new PageReference('/apex/');
               // }
               system.debug(LoggingLevel.info,'>>>>>>>>>perDiem.Pricing_Worksheet__c'+perDiem.Pricing_Worksheet__c);
                pagereference pr = new pagereference('/' + strpwid);
                    pr.setredirect(true);
                return pr;  
            }
            catch(Exception ex)
            {
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error,ex.getMessage()));
                return null;
            }
         
      
       
    }
     
         
    }