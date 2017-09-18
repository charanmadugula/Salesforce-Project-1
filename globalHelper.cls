//========================================================================
//  Object: globalHelper
// Company: TCS
//  Author: Barney Young Jr.
// Comment: Global helper class for reused methods
//========================================================================
//          Date            Purpose
// Changes: 12/07/2015      Initial Version
//========================================================================

public class globalHelper {


    //Get User Record by Id
    public static Boolean isUserAdmin(string uId){
        
        //Variables
        Boolean isAdmin = false;

        //Custom Variables
        PW_Variables__c pwv = PW_Variables__c.getOrgDefaults();
            String pwAPS = pwv.Pricing_Worksheet_Admin_Approver_id__c;
        
        list<PermissionSetAssignment> psa = [select PermissionSetId, AssigneeId from PermissionSetAssignment where PermissionSetId =:pwAPS and assigneeId = :uId];

        if(psa.size() > 0){
            isAdmin = true;
        }
        else {
            isAdmin = false;
        }
        return isAdmin;
    }
     
    //IsUserApprover
    public static Boolean isUserApprover(Id uId, String aType){
        
        //Variables
        Boolean iUA = false;
        
        List<Pricing_Worksheet_Approvers__c> pwa = [select Id, approver__c, approver_type__c from Pricing_Worksheet_Approvers__c where approver__c =: uId and Approver_Type__c =: aType];

        if(pwa.size() > 0){
            iUA = true;
        }

        return iUA;
    }



    //Get User Record by Id
    public static User getUserFields(id uId){
        
        //Variables
        User u;
        list<User> uList;
        
        String SobjectApiName = 'User';
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where id = :uId limit 1';
        uList = Database.query(query);
        u = uList[0];
        
        //Return Internal IV record
        return u;
    }   

    //Get Pricing Worksheet Record by Id
    public static Pricing_Worksheet__c getPricingWorksheetFields(id pwId){
        
        //Variables
        Pricing_Worksheet__c pw;
        list<Pricing_Worksheet__c> pwList;
        
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where id = :pwId limit 1';
        pwList = Database.query(query);
        pw = pwList[0];
        
        //Return Per Diem record
        return pw;
    } 

    //Get Account Record by Id
    public static Account getAccountFields(id aId){
        
        //Variables
        Account a;
        list<Account> aList;
        
        String SobjectApiName = 'Account';
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where id = :aId limit 1';
        aList = Database.query(query);
        if(aList.size() > 0)
        a = aList[0];
        else a = new Account();
        //Return Per Diem record
        return a;
    } 
    
    //Get Account Record by Default State
    public static Account getAccountFields(String aState){
        
        //Variables
        Account a;
        list<Account> aList;
        
        String SobjectApiName = 'Account';
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where State__c = :aState limit 1';
        aList = Database.query(query);
        a = aList[0];
        
        //Return Per Diem record
        return a;
    } 
    
            
    //Get Per Diem Record by Id
    public static Per_Diem__c getPerDiemFields(id pdId){
        
        //Variables
        Per_Diem__c pd;
        list<Per_Diem__c> pdList;
        
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where id = :pdId limit 1';
        pdList = Database.query(query);
        pd = pdList[0];
        
        //Return Per Diem record
        return pd;
    }   


    //Get Internal IV Worksheet Record by Id
    public static Internal_IV_Worksheet__c getInternalIVFields(id ivId){
        
        //Variables
        Internal_IV_Worksheet__c iv;
        list<Internal_IV_Worksheet__c> ivList;
        
        String SobjectApiName = 'Internal_IV_Worksheet__c';
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where id = :ivId limit 1';
        ivList = Database.query(query);
        iv = ivList[0];
        
        //Return Internal IV record
        return iv;
    }
    
    //Get Internal IV Worksheet Default Schedule Record
    public static Internal_IV_Worksheet__c getInternalIVDefault(String ivDS){
        
        //Variables
        Internal_IV_Worksheet__c iv;
        list<Internal_IV_Worksheet__c> ivList;
        
        String SobjectApiName = 'Internal_IV_Worksheet__c';
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
        String query = 'select ' + commaSepratedFields + ' from ' + SobjectApiName + ' where Default_Schedule__c = true and Active_Schedule__c  = :ivDS limit 1';
        ivList = Database.query(query);
        iv = ivList[0];
        
        //Return Internal IV record
        return iv;
    } 
    
    //Get Record Type Id
    public static string getRTId(String recordTypeName, String SobjectType) {
        String RecordTypeId;
        RecordType objRecordType = new RecordType();
        
        try {
            objRecordType = [Select r.Id, r.Name, r.SobjectType from RecordType r where r.Name =: recordTypeName AND r.SobjectType =: SobjectType];
            RecordTypeId = objRecordType.Id;
        }
        
        catch (Exception e) {
                system.debug('getRTID Exception: ' + e.getMessage());
        }
        
        return RecordTypeId;
    }      
           
}