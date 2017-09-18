//========================================================================
//  Object: methods_PricingWorksheet
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Pricint_Worksheet__c Methods
//========================================================================
//          Date            Purpose
// Changes: 12/01/2015      Initial Version
//========================================================================

public class methods_PricingWorksheet {

    public static void readyForApproval(List<Pricing_Worksheet__c> pws){

        //Variables
        List<Pricing_Worksheet__c> updatePWs = new List<Pricing_Worksheet__c>();

        //Cycle Through
        for (Pricing_Worksheet__c pw : pws) {
            
            Boolean approveCP;

            //Check for Approvals
            if (pw.Status__c == 'In Progress') {
            
                if (pw.approveCAC__c == false && pw.approveCP__c == false && pw.approvePA__c == false) {
                    approveCP = true;
                }
                else if((pw.approveCAC__c == true && pw.Approver_Capital_Assets_and_Compliance__c !=null) && pw.approveCP__c == false && (pw.approvePA__c == true && pw.Approver_Pricing_Analysis__c != null)) {
                    approveCP = true;
                }
                else if((pw.approveCAC__c == true && pw.Approver_Capital_Assets_and_Compliance__c !=null) && (pw.approveCP__c == true && pw.Approver_Contract_Pricing__c != null) && pw.approvePA__c == false) {
                    approveCP = true;
                }
                else if((pw.approveCAC__c == true && pw.Approver_Capital_Assets_and_Compliance__c !=null) && pw.approveCP__c == false && pw.approvePA__c == false) {
                    approveCP = true;
                }
                else if(pw.approveCAC__c == false && (pw.approveCP__c == true && pw.Approver_Contract_Pricing__c != null) && (pw.approvePA__c == true && pw.Approver_Pricing_Analysis__c != null)) {
                    approveCP = true;
                }
                else if(pw.approveCAC__c == false && (pw.approveCP__c == true && pw.Approver_Contract_Pricing__c != null) && pw.approvePA__c == false) {
                    approveCP = true;
                }
                else if(pw.approveCAC__c == false && pw.approveCP__c == false && (pw.approvePA__c == true && pw.Approver_Pricing_Analysis__c != null)) {
                    approveCP = true;
                }
                else if((pw.approveCAC__c == true && pw.Approver_Capital_Assets_and_Compliance__c !=null) && (pw.approveCP__c == true && pw.Approver_Contract_Pricing__c != null) && (pw.approvePA__c == true && pw.Approver_Pricing_Analysis__c != null)) {
                    approveCP = true;
                }
                else {
                    approveCP = false;
                }
            }

            //Build Record to Update
            Pricing_Worksheet__c p1 = new Pricing_Worksheet__c();
                p1.id = pw.Id;
                p1.approveCP__c = approveCP;
            
            updatePWs.add(p1);
        }

        //DML Operations
        try{
            if (updatePWs.size()>0) {
                update updatePWs;
            }
        }
        catch (DMLexception e) {
            system.debug('Method-->readyForApproval DML Exception: ' + e.getMessage());
        }

    }


    //Set Reject Values
    public static void setRejectValues(List<Pricing_Worksheet__c> pws){

        //Variables
        List<Pricing_Worksheet__c> updatePWs = new List<Pricing_Worksheet__c>();

        //Cycle Through
        for (Pricing_Worksheet__c pw : pws) {
            
            //Build Record to Update
            Pricing_Worksheet__c p1 = new Pricing_Worksheet__c();
                p1.id = pw.Id;
                //Approval Date
                p1.Approval_Date_Ad_Hoc__c = null;
                p1.Approval_Date_CAC__c = null;
                p1.Approval_Date_CP__c = null;
                p1.Approval_Date_Credit__c = null;
                p1.Approval_Date_DOP__c = null;
                p1.Approval_Date_Legal__c = null;
                p1.Approval_Date_PA__c = null;
                p1.Approval_Date_EP__c = null;
                p1.Approval_Date_IV_P__c = null;
                p1.Approval_Date_IV_R__c = null;
                p1.Approval_Date_IV_SD__c = null;
                p1.Approval_Date_VPO__c = null;

                //Approvers
                p1.Approver_Ad_Hoc__c = null;
                p1.Approver_Capital_Assets_and_Compliance__c = null;
                p1.Approver_Contract_Pricing__c = null;
                p1.Approver_Credit__c = null;
                p1.Approver_Director_of_Pricing__c = null;
                p1.Approver_Legal__c = null;
                p1.Approver_Pricing_Analysis__c = null;
                p1.Approver_IV_Pricing__c = null;
                p1.Approver_IV_Rx__c = null;
                p1.Approver_IV_SD__c = null;
                p1.Approver_VPO__c = null;
                p1.Approver_E_Prescribe__c = null;
            updatePWs.add(p1);
        }

        //DML Operations
        try{
            if (updatePWs.size()>0) {
                update updatePWs;
            }
        }
        catch (DMLexception e) {
            system.debug('Method-->setRejectValues DML Exception: ' + e.getMessage());
        }

    }

    //Populate Enoxaparin
    public static void populateEnoxaparin(id spId){

        //Containers
        list<Special_Pricing_Detail__c> eList = new list<Special_Pricing_Detail__c>();
        list<Special_Pricing__c> spList = new list<Special_Pricing__c>();
        list<Special_Pricing_Detail__c> spdInsert = new list<Special_Pricing_Detail__c>();
        List<Special_Pricing__c> spUpdate = new list<Special_Pricing__c>();

        //Get Enoxaparin Values
        eList = [select Price_Per_Unit_GM_ML_and_Each__c, Name, NDC__c, Dispensing_Fee__c from Special_Pricing_Detail__c where DEFAULT_VALUE__C = true];

        //Populate Special Pricing
        for(Special_Pricing_Detail__c enox : eList){
            
            //Build Special Pricing Detail Record
            Special_Pricing_Detail__c addspd = new Special_Pricing_Detail__c();
                addspd.Special_Pricing_ID__c = spId;
                //addspd.Name = enox.Name;
                addspd.Price_Per_Unit_GM_ML_and_Each__c = enox.Price_Per_Unit_GM_ML_and_Each__c;
                addspd.NDC__c = enox.NDC__c;
                addspd.Dispensing_Fee__c = enox.Dispensing_Fee__c;
                addspd.Enoxaparin__c = true;
            
            //Populate Container
            spdInsert.add(addspd);
        }

        spList = [select Id, Enoxaparin__c from Special_Pricing__c where id =: spId];
        
        for (Special_Pricing__c sp5 : spList) {
            
            //Build Special Pricing
            Special_Pricing__c spn = new Special_Pricing__c();
                spn.Enoxaparin__c = true;
                spn.id = sp5.Id;
            
            //Populate Container
            spUpdate.add(spn);

        } 


        //DML Operations
        try{
            insert spdInsert;
            update spUpdate;
        }
        catch (DMLexception e) {
            system.debug('Method-->populateEnoxaparin DML Exception: ' + e.getMessage());
        }
        
        
    }
    
    //Update credit analysis lookup in the pricing worksheet
     public static void updateCreditAnalysisInPricingWorkSheet(List<Pricing_Worksheet__c> lstPricingWorkSheet){
        Set<Id> setAccountIds = new Set<Id>();
        for(Pricing_Worksheet__c pricingWroksheet : lstPricingWorkSheet ){
            //Logic for insert
            if(pricingWroksheet.Account__c != null)
                    setAccountIds.add(pricingWroksheet.Account__c);
            //Logic for update
        }
        if(!setAccountIds.IsEmpty()){
            Map<Id,Account> mapAccountWithCredit = new Map<Id,Account>([select id,(SELECT Id FROM Credit_Approvals__r ORDER BY CreatedDate DESC limit 1) from Account where Id IN : setAccountIds]);
            for(Pricing_Worksheet__c pricingWroksheet : lstPricingWorkSheet ){
                if(mapAccountWithCredit.containsKey(pricingWroksheet.Account__c)){
                    if(mapAccountWithCredit.get(pricingWroksheet.Account__c).Credit_Approvals__r.size()>0)
                        pricingWroksheet.Credit_Analysis__c = mapAccountWithCredit.get(pricingWroksheet.Account__c).Credit_Approvals__r[0].id;
                }
            }
        }
     
    }
}