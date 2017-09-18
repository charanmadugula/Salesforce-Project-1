public class UpdateContactHandler {
    
    Public static Account_trigger_settings__c triggerSetting = Account_trigger_settings__c.getInstance();
      
    
    // constructorr 
    public UpdateContactHandler() {}
    
    // method to change contact owner
    public void changeContactOwner(Map<Id, Account> oldAccountMap, Map<Id, Account> newAccountMap) {
        
        if ( triggerSetting.IS_Disabled__c ==true || null == oldAccountMap || null == newAccountMap) {
            return;
        }
        
        
        Set<Id> accountsToConsider = new Set<Id>();
        //Map<Id, Id> accountOwnerMap = new Map<Id, Id>();
        for(Account account : newAccountMap.values()) {
            if((oldAccountMap.get(account.Id).OwnerId != account.OwnerId) && (account.RecordTypeId == triggerSetting.RecordTypeID__c)) {
                accountsToConsider.add(account.Id);
                //accountOwnerMap.put(account.Id, account.OwnerId);
            }
        }
        
        Map<String, List<Contact>> accountContactsMap = new Map<String, List<Contact>>();
        for(Account account : [
            SELECT Id
                 , Name
                 , OwnerId
                 , (SELECT Id, Name, OwnerId FROM Contacts)
              FROM Account
             WHERE Id IN :accountsToConsider
        ]) {
            accountContactsMap.put(account.Id, account.Contacts);
        }
        
        //system.assert(false, 'accountContactsMap : ' + accountContactsMap);
        
        List<Contact> contactsToUpdate = new List<Contact>();
        for(String accountId : accountContactsMap.keySet()) {
            for(Contact contact : accountContactsMap.get(accountId)) {
            	
            	if (Schema.sObjectType.Contact.fields.OwnerId.isUpdateable()) {
            		
                contact.OwnerId = newAccountMap.get(accountId).OwnerId;
                
            	}
                // Any other field change in same fashion
                // contact.LastName =  newAccountMap.get(accountId).Name;
                
                
                contactsToUpdate.add(contact);
                
                
            }
        }
        
        //System.assert(false, 'contact: '  + contactsToUpdate);
        //try {
        if (Schema.sObjectType.Contact.isUpdateable()) { 
            update contactsToUpdate;
        }
        //} catch (DMLException excep) {
            //System.debug('Exception : ' + excep);
        //}
    }
    
    
    }