global with sharing class massDeleteBatchClass implements Database.Batchable<sObject>, Database.Stateful{
   
    public String Query;
    global integer Summary;


    global massDeleteBatchClass(String q){
    
        Query=q;
        Summary = 0;
        
   }

   global Database.QueryLocator start(Database.BatchableContext BC){
      return Database.getQueryLocator(query);
   }

   global void execute(Database.BatchableContext BC, List<sObject> scope){
       Summary += scope.size();
       
       delete scope;

   }

   global void finish(Database.BatchableContext BC){

        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();

            User u = [Select email from User where Id = :UserInfo.getUserId()];
            
            String[] toAddresses = new String[] {u.email};   
            mail.setToAddresses(toAddresses);
            mail.setReplyTo('noreply@salesforce.com');      
            mail.setSenderDisplayName('Batch Delete');
            mail.setSubject('Batch delete complete');
            mail.setPlainTextBody('Batch delete complete. ' + string.valueOf(Summary) +' records deleted.');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
   }

}