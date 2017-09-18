public class ext_PWEdit { 

public Pricing_Worksheet__c pricingWorkSheet {get;set;}

    public Pagereference submitForApproval(){
  if(pricingWorkSheet!=null)
        pricingWorkSheet.status__c = 'In Process';
        if(pricingWorkSheet!=null)
        Update pricingWorkSheet;
        system.debug('pricingWorkSheet'+pricingWorkSheet);
        PageReference pg;
        pg  = new PageReference('/' + pricingWorkSheet.Id);

        return pg ; 
    }

        public Pagereference save(){

        if(pricingWorkSheet!=null)
        Update pricingWorkSheet;
        system.debug('pricingWorkSheet'+pricingWorkSheet);
        PageReference pg;
        pg  = new PageReference('/' + pricingWorkSheet.Id);

        return pg ; 
    }
}