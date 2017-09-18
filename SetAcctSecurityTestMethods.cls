@isTest
private class SetAcctSecurityTestMethods {

	static testMethod void SetAcctSecurityTestMethods() {
		Account testAccount = new Account(name = 'KDJ Test Account');
        
        insert testAccount; 
        
        List<Account> lstACC = [select id from Account Limit 100];
        system.assert(lstACC.size() > 0,'ACC size');		
	}

}