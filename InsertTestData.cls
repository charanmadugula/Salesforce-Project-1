/************************************************************************

    Name: InsertTestData.cls
    Purpose: Utility Class to insert Test data for Test methods.
    History:
**********************************************************************
    Version        Created by         Date             Description
       1

*************************************************************************/

public class InsertTestData
{
   public static List<User> listOfUsers;
    static
    {
        listOfUsers = new List<User>();
        Profile systemAdminProfile = [Select Id from Profile Where Name='System Administrator' Limit 1];
        if(Schema.SObjectType.User.isCreateable()) {
            User firstUser= new User(Username = 'testuser1gujgj@testing.com', ProfileId = systemAdminProfile.Id, LocaleSidKey = 'en_US', LanguageLocaleKey = 'en_US',TimeZoneSidKey= 'America/Chicago', LastName ='Test',Alias='test', Email= 'test3@testing.com', EmailEncodingKey ='ISO-8859-1');
            listOfUsers.add(firstUser);
            User secondUser= new User(Username = 'testuser2fjghm@testing.com', ProfileId= systemAdminProfile.Id, LocaleSidKey   = 'en_US',LanguageLocaleKey = 'en_US',TimeZoneSidKey= 'America/Chicago', LastName ='Test',Alias='test', Email= 'test1@testing.com', EmailEncodingKey ='ISO-8859-1');
            listOfUsers.add(secondUser);
            insert listOfUsers;
        }
    }
    public static void insertUsers()
    {

        User_2__c firstCustomUser= new User_2__c(User__c = listOfUsers[0].id,Beds_YTD__c=0);
        insert firstCustomUser;

        User_2__c secondCustomUser= new User_2__c(User__c = listOfUsers[1].id,Beds_YTD__c=0);
        insert secondCustomUser;

    }
   public static void insertOpportunity()
    {
        if(!(Schema.SObjectType.Opportunity.fields.Name.isCreateable()
            && Schema.SObjectType.Opportunity.fields.StageName.isCreateable()
            && Schema.SObjectType.Opportunity.fields.CloseDate.isCreateable())) {
            return;
        }
        List<Opportunity> listOfOpportunity = new List<Opportunity>();
        Opportunity newOpportunity= new Opportunity (OwnerId = listOfUsers[0].id, Name = 'test', StageName = 'Signed',CloseDate = System.today());
        listOfOpportunity.add(newOpportunity);

        Opportunity secondOpportunity= new Opportunity (OwnerId = listOfUsers[0].id, Name = 'test',StageName='Signed',CloseDate = System.today());
        listOfOpportunity.add(secondOpportunity);

        Opportunity thirdOpportunity= new Opportunity (OwnerId = listOfUsers[0].id, Name = 'test',StageName='Signed',CloseDate = System.today());
        listOfOpportunity.add(thirdOpportunity);

        Opportunity fourthOpportunity= new Opportunity (OwnerId = listOfUsers[1].id, Name = 'test',StageName='Signed',CloseDate = System.today());
        listOfOpportunity.add(fourthOpportunity);

        Opportunity fifthOpportunity= new Opportunity (OwnerId = listOfUsers[1].id, Name = 'test',StageName='Signed',CloseDate = System.today());
        listOfOpportunity.add(fifthOpportunity);

        insert listOfOpportunity;
    }



    public static Account createParentAccount(string Name, string PharmacyName, string BillingCountry,boolean TestClassReference){
        Account prntAccount = new Account();
        prntAccount.Name = Name;
        prntAccount.Pharmacy_Name__c = PharmacyName;
        prntAccount.BillingCountry = BillingCountry;
        prntAccount.Test_Class_Reference__c = TestClassReference;
        return prntAccount ;
    }

    public static Account createAccount(string Name, string PharmacyName,Id parentAccountId, string BillingCountry,boolean TestClassReference){
        Account accObj = new Account();
        accObj.Name = Name;
        accObj.Pharmacy_Name__c = PharmacyName;
        accObj.ParentId = parentAccountId;
        accObj.BillingCountry = BillingCountry;
        accObj.Test_Class_Reference__c= TestClassReference;
        return accObj;
    }

    public static Web_Focus__c createWebFocus(Id AccountId){
        Web_Focus__c newWebFocus = new Web_Focus__c();
        newWebFocus.Account_ID__c = AccountId;
        return newWebFocus ;
    }

    public static Case createCase(String Status,String Origin,String Type,Id AccountId,Id ContactId,DateTime customCreateddate,string rating){

        Case caseObj = new Case();
        caseObj.Status = Status;
        caseObj.Origin = Origin;
        caseObj.Type=Type;
        caseObj.AccountId = AccountId;
        caseObj.ContactId = ContactId;
        caseObj.Custom_Created_Date__c = customCreateddate;
        caseObj.Issue_Rating__c = rating;
        return caseObj;
     }

     public static Contact CreateContact(string lastName,Id accountId,string state){
         Contact con = new Contact();
         con.LastName = lastName;
         con.AccountId = accountId;
         con.MailingState = state;
         return con;

     }
     public static Satisfaction_Surveys__c createSatisfactionSurveys(Id Account){
         Satisfaction_Surveys__c satSurvey= new Satisfaction_Surveys__c();
         satSurvey.Account__c=Account;
        // satSurvey.Date_of_Survey__c=dateOfSurvey;
         return satSurvey;
     }

     public static OCR_Pharmacy__c createOCRPharmacy(string name,string phone,string city,string state,string zipCode,string country){
         OCR_Pharmacy__c oCR = new OCR_Pharmacy__c();
         oCR.Name=name;
         oCR.Phone__c=phone;
         oCR.City__c=city;
         oCR.State_Province__c=state;
         oCR.Zip_Postal_Code__c=zipCode;
         oCR.Country__c=country;
         return oCR;
     }

     Public static Pricing_Worksheet__c createPricingWorkSheet(String name){
         Pricing_Worksheet__c priceWorkSheet= new Pricing_Worksheet__c();
         priceWorkSheet.name=name;
         return priceWorkSheet;
         }

         public Static opportunity createOpportunity(String Name,id AccountId){
         Opportunity opp= new Opportunity();
         opp.Name=Name;
         opp.Accountid=AccountId;
         return opp;
         }

         public static Per_Diem__c createPerDiem(){
         Per_Diem__c perDiem= new Per_Diem__c();
        // perDiem.AccountId=Account;
         return perDiem;
         }


         public static Per_Diem_Exclusion__c createPerDiemExclusion(String Name){
         Per_Diem_Exclusion__c diemExclusion= new Per_Diem_Exclusion__c();
         diemExclusion.Name=Name;
         return diemExclusion;
          }

          public static Financial_Info__c createFinancialInfo(String Name){
          Financial_Info__c financeInfo= new Financial_Info__c();
          financeInfo.Name=Name;
          return financeInfo;
          }

          public static Internal_IV_Worksheet__c createInternalWorkSheet(){
          Internal_IV_Worksheet__c internalWorkSheet= new Internal_IV_Worksheet__c();
          return internalWorkSheet;
          }

          public static Special_Pricing__c createSpecialPricing(String name){
          Special_Pricing__c specialPricing= new Special_Pricing__c();
          specialPricing.name=name;
          return specialPricing;
          }

      }