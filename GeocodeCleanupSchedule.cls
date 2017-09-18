global class GeocodeCleanupSchedule implements Schedulable {

    global void execute(SchedulableContext SC) {
   
     geopointe.Geocode_Cleanup_Batchjob job = new geopointe.Geocode_Cleanup_Batchjob();
     
     Database.executeBatch(job, 100); 
     sendmail(); 
     }    
      public void sendmail()
      {
          Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
          string [] toaddress= New string[]{'Sandeep.Tantravahi@omnicare.com'};
          email.setSubject('GeoCode Clean up Batch Job');
          email.setPlainTextBody('Apex GeoCode Clean up');
          email.setToAddresses(toaddress);
          Messaging.sendEmail(New Messaging.SingleEmailMessage[]{email});
                        
    }  
   
   }