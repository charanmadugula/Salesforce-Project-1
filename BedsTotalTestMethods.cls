public class BedsTotalTestMethods {

  static testMethod void BedsTotalTestMethods() {
    
    User newUser = new User(Username = 'testuser1234@testing.com', ProfileId= '00e80000000kHqM', LocaleSidKey   = 'en_US',LanguageLocaleKey = 'en_US',TimeZoneSidKey= 'America/Chicago', LastName ='Test',Alias='test', Email= '1234test1@testing.com', EmailEncodingKey ='ISO-8859-1');
    insert newUser;
    
    User newUser3 = new User(Username = 'testuser12324@testing.com', ProfileId= '00e80000000kHqM', LocaleSidKey   = 'en_US',LanguageLocaleKey = 'en_US',TimeZoneSidKey= 'America/Chicago', LastName ='Test',Alias='test', Email= '1234test2@testing.com', EmailEncodingKey ='ISO-8859-1');
    insert newUser3;
    
  
    User_2__c newUser2 = new User_2__c(User__c = newUser.id,Beds_YTD__c=0);
    insert newUser2;
    
    User_2__c newUser5 = new User_2__c(User__c = newUser3.id,Beds_YTD__c=0);
    insert newUser5;
    
    
    
    Opportunity opp = new Opportunity (OwnerId = newUser.id, Name = 'test', StageName = 'Signed',CloseDate = System.today(),Beds_Serviced__c='SNF,ALF,IL',Presented_Value_Prop__c= 'Retail Acquisition',Probability=30.00);
    //insert opp;
  
    Opportunity opp2 = new Opportunity (OwnerId = newUser.id, Name = 'test',StageName='Signed',CloseDate = System.today(),Beds_Serviced__c='SNF,ALF,IL',Presented_Value_Prop__c= 'Retail Acquisition',Probability=30.00);
    //insert opp2;
    
    Opportunity opp4 = new Opportunity (OwnerId = newUser.id, Name = 'test',StageName='Signed',CloseDate = System.today(),Beds_Serviced__c='SNF,ALF,IL',Presented_Value_Prop__c= 'Retail Acquisition',Probability=30.00);
    //insert opp4;
    
    Opportunity opp5 = new Opportunity (OwnerId = newUser3.id, Name = 'test',StageName='Signed',CloseDate = System.today(),Beds_Serviced__c='SNF,ALF,IL',Presented_Value_Prop__c= 'Retail Acquisition',Probability=30.00);
    //insert opp5;
    
    Opportunity opp3 = new Opportunity (OwnerId = newUser3.id, Name = 'test',StageName='Signed',CloseDate = System.today(),Beds_Serviced__c='SNF,ALF,IL',Presented_Value_Prop__c= 'Retail Acquisition',Probability=30.00);
    //insert opp3;
    
    
    List<Opportunity> Opportunity4Update = new List<Opportunity>();
    Opportunity4Update.add(opp);
    Opportunity4Update.add(opp2);
    Opportunity4Update.add(opp3);
    Opportunity4Update.add(opp4);
    Opportunity4Update.add(opp5);
    
    insert Opportunity4Update;
    
    
    opp2.StageName = 'Closed Won';
    update opp2;
    
    List<Opportunity> lstOpp = [select Id,stageName from opportunity where Id = :opp2.Id];
    if(lstOpp.size()>0)
    system.assert(lstOpp[0].stageName == 'Closed Won','Opportunity Closed');
    

  }
}