/************************************************************************

    Name: AccountTriggerHandler.cls
    Purpose: Handler to update renewal date based on frequency 
    History:  
**********************************************************************
    Version        Created by         Date             Description
       1          TCS Offshore      10/1/2015          Created

*************************************************************************/
public with sharing class AccountTriggerHandler
{

    public final String useCreatedDate = System.Label.Created_Date;
    public String dateAPIName='';
    
    public AccountTriggerHandler(){
   
        if(useCreatedDate=='Yes'){
            dateAPIName= 'CreatedDate';
        }
        else{
            dateAPIName= 'Custom_Created_Date__c';
        }
        
    }
    
    public void onUpdate(List<Account> listOfAccounts)
    {
       
        system.debug('useCreatedDate::'+useCreatedDate );
        system.debug('dateAPIName::'+dateAPIName);
        for(Account newAccount : listOfAccounts)
        {
            if(newAccount.retention_lastSurveyDate__c != null){
                if(newAccount.retention_frequencySurvey__c == 'Quarterly'){ 
                    newAccount.retention_nextSurveyDue__c = newAccount.retention_lastSurveyDate__c.addMonths(3); 
                }
                else if(newAccount.retention_frequencySurvey__c == 'Semi-Annually'){ 
                    newAccount.retention_nextSurveyDue__c = newAccount.retention_lastSurveyDate__c.addMonths(6); 
                }
                else if(newAccount.retention_frequencySurvey__c == 'Annually'){ 
                    newAccount.retention_nextSurveyDue__c = newAccount.retention_lastSurveyDate__c.addYears(1); 
                }
                else{ 
                    newAccount.retention_nextSurveyDue__c = null; 
                }
            }
            /*  if(newAccount.retention_lastExecReview__c != null)
            {
                if(newAccount.retention_frequencyER__c == 'Quarterly')
                { 
                    newAccount.retention_nextExecReviewDue__c =  newAccount.retention_lastExecReview__c.addMonths(3); 
                }
                else if(newAccount.retention_frequencyER__c == 'Semi-Annually')
                { 
                    newAccount.retention_nextExecReviewDue__c =  newAccount.retention_lastExecReview__c.addMonths(6); 
                }
                else if(newAccount.retention_frequencyER__c == 'Annually')
                { 
                    newAccount.retention_nextExecReviewDue__c =  newAccount.retention_lastExecReview__c.addYears(1); 
                }
                else
                { 
                    newAccount.retention_nextExecReviewDue__c =  null; 
                }
            }
            */
        }    
    }
    
    /************************************************************************
    
    Method Name: toUpdateWeekTotal
    Purpose: To update week total 
    
    ************************************************************************/
    public void toUpdateWeekTotal(List<Account> listOfNewAccounts,Boolean isUpdateAccounts)
    {
      
        
        Integer trendWeek =Integer.valueOf(Label.Trend_Number_of_Weeks);
        Date lastsixWeeks = System.today().toStartOfWeek().addDays(-((trendWeek)*7));
        Date lastDay = System.today().toStartOfWeek().addDays(7);
        system.debug('==lastsixWeeks ::'+lastsixWeeks );
        Map<Id,Decimal> mapOfAccountAndSevereCount = new Map<Id,Decimal>();
        Map<Id,Decimal> mapOfAccountAndModerateCount = new Map<Id,Decimal>();
        Map<Id,Decimal> mapOfAccountAndCriticalCount = new Map<Id,Decimal>();
        Map<Id,Decimal> mapOfAccountAndSevereCurrentCount = new Map<Id,Decimal>();
        Map<Id,Decimal> mapOfAccountAndModerateCurrentCount = new Map<Id,Decimal>();
        Map<Id,Decimal> mapOfAccountAndCriticalCurrentCount = new Map<Id,Decimal>();
        Integer iteration = 0;        
        Decimal severeCount,severeCurrentCount,moderateCount,moderateCurrentCount,criticalCount,criticalCurrentCount; 
        //severeCount = severeCurrentCount = moderateCount = moderateCurrentCount = criticalCount = criticalCurrentCount=0;
        system.debug('listOfNewAccounts++'+listOfNewAccounts);
        //List<Case> listOfCase = new List<Case>();
        List<Account> aList = new List<Account>();
        if(useCreatedDate=='Yes'){
            //listOfCase= [Select Id,AccountId,Issue_Rating__c,createddate,Custom_Created_Date__c From Case Where AccountId in:listOfNewAccounts and CreatedDate >=: lastsixWeeks and CreatedDate <=:lastDay];
            aList = [Select OCR_Pharmacy_Name__c,All_Related_Cust_Status_Severe__c,All_Related_Cust_Status_Moderate__c,All_Related_Cust_Status_Critical__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Severe__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Critical__c,RecordTypeId,RecordType.Name,ParentId,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c, CreatedDate,(Select Id,AccountId,Issue_Rating__c,createddate,Custom_Created_Date__c From Cases where CreatedDate >=: lastsixWeeks and CreatedDate <=:lastDay) From Account Where Id in:listOfNewAccounts];
        }
        else{
            //listOfCase= [Select Id,AccountId,Issue_Rating__c,Custom_Created_Date__c,createddate From Case Where AccountId in:listOfNewAccounts and Custom_Created_Date__c >=:lastsixWeeks and Custom_Created_Date__c <=:lastDay];
            aList = [Select OCR_Pharmacy_Name__c,All_Related_Cust_Status_Severe__c,All_Related_Cust_Status_Moderate__c,All_Related_Cust_Status_Critical__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Severe__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Critical__c,RecordTypeId,RecordType.Name,ParentId,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c, CreatedDate,(Select Id,AccountId,Issue_Rating__c,createddate,Custom_Created_Date__c From Cases where Custom_Created_Date__c >=:lastsixWeeks and Custom_Created_Date__c <=:lastDay) From Account Where Id in:listOfNewAccounts];
        }
        
        system.debug('aList=='+aList);
        //system.debug('listOfCase::'+listOfCase);
        for(Account a : aList){
            severeCount = severeCurrentCount = moderateCount = moderateCurrentCount = criticalCount = criticalCurrentCount=0;
            for(Case newCase: a.Cases){
                //if(a.Id == newCase.AccountId){
                    Iteration = iteration+1;
                    System.debug('Iteration '+'case id = '+newCase.Id+'-'+iteration);

                    if(newCase.Issue_Rating__c =='Severe' ){
                        System.debug('Comin inside severe ');
                        if(mapOfAccountAndSevereCount.containsKey(newCase.AccountId)){
                            severeCount = mapOfAccountAndSevereCount.get(newCase.AccountId);
                            System.debug('coming inside severe count loop'+severeCount);
                        }
                        if((DateTime)newCase.get(dateAPIName) >= lastsixWeeks && (DateTime)newCase.get(dateAPIName) < System.today().toStartOfWeek()){
                            severeCount= severeCount+1;
                            System.debug('coming inside severe count increment loop '+severeCount);
                        }
                        system.debug('(DateTime)newCase.get(dateAPIName)::'+(DateTime)newCase.get(dateAPIName));
                        if((DateTime)newCase.get(dateAPIName) >= System.Today().toStartOfWeek() && (DateTime)newCase.get(dateAPIName) <= System.Today().toStartofWeek().addDays(7) ){
                            System.debug('coming inside current count severe loop');
                            if(mapOfAccountAndSevereCurrentCount.containsKey(newCase.AccountId))
                            {
                                severeCurrentCount= mapOfAccountAndSevereCurrentCount.get(newCase.AccountId);
                                System.debug('coming inside severe current count getting '+severeCurrentCount);                        
                            }
                            severeCurrentCount= severeCurrentCount+1;
                            System.debug('severe current count increment '+severeCurrentCount);                    
                        }
                    }
                    
                    if(newCase.Issue_Rating__c == 'Moderate'){
                        if(mapOfAccountAndModerateCount.containsKey(newCase.AccountId)){
                            moderateCount= mapOfAccountAndModerateCount.get(newCase.AccountId);
                        }
                        if((DateTime)newCase.get(dateAPIName) >= lastsixWeeks && (DateTime)newCase.get(dateAPIName) < System.today().toStartOfWeek()){
                            moderateCount= moderateCount+1;
                        }
                        system.debug('moderateCount=='+moderateCount);
                        System.debug('Iteration Number '+iteration+' case id - '+newCase.Id);
                        System.debug('First boolean '+ (DateTime)newCase.get(dateAPIName) +'>='+System.Today().toStartOfWeek()+'==>'+String.valueOf( (DateTime)newCase.get(dateAPIName) >=System.Today().toStartOfWeek()));
                        System.debug('Second boolean '+ (DateTime)newCase.get(dateAPIName) +'<='+System.Today().toStartOfWeek().addDays(7)+'==>'+String.valueOf( (DateTime)newCase.get(dateAPIName) <=System.Today().toStartOfWeek().addDays(7)));                
                        System.debug('Third boolean '+mapOfAccountAndModerateCurrentCount.containsKey(newCase.AccountId));
                        
                        if((DateTime)newCase.get(dateAPIName) >= System.Today().toStartOfWeek() && (DateTime)newCase.get(dateAPIName) <= System.Today().toStartofWeek().addDays(7) ){
                            if(mapOfAccountAndModerateCurrentCount.containsKey(newCase.AccountId)){
                                moderateCurrentCount= mapOfAccountAndModerateCurrentCount.get(newCase.AccountId);

                            } 
                            moderateCurrentCount= moderateCurrentCount+1;
                        }
                    }
                    if(newCase.Issue_Rating__c =='Critical'){
                        if(mapOfAccountAndCriticalCount.containsKey(newCase.AccountId)){
                            criticalCount= mapOfAccountAndCriticalCount.get(newCase.AccountId);
                        }
                        if((DateTime)newCase.get(dateAPIName) >= lastsixWeeks && (DateTime)newCase.get(dateAPIName) < System.today().toStartOfWeek()){
                            criticalCount= criticalCount+1;
                        }
                        if((DateTime)newCase.get(dateAPIName) >= System.Today().toStartOfWeek() && (DateTime)newCase.get(dateAPIName) <= System.Today().toStartOfWeek().addDays(7)){
                            if(mapOfAccountAndCriticalCurrentCount.containsKey(newCase.AccountId)){
                                criticalCurrentCount= mapOfAccountAndCriticalCurrentCount.get(newCase.AccountId);
                            }
                            criticalCurrentCount= criticalCurrentCount+1;
                        }
                    }
                    
                    if(newCase.Issue_Rating__c == 'Severe'){
                        mapOfAccountAndSevereCount.put(newCase.AccountId,severeCount);
                        mapOfAccountAndSevereCurrentCount.put(newCase.AccountId,severeCurrentCount);                
                    }
                    if(newCase.Issue_Rating__c == 'Moderate'){
                        mapOfAccountAndModerateCount.put(newCase.AccountId,moderateCount);
                        mapOfAccountAndModerateCurrentCount.put(newCase.AccountId,moderateCurrentCount);
                        system.debug('mapOfAccountAndModerateCount=='+mapOfAccountAndModerateCount);
                        system.debug('mapOfAccountAndModerateCurrentCount=='+mapOfAccountAndModerateCurrentCount);
                    }
                    if(newCase.Issue_Rating__c == 'Critical'){
                        mapOfAccountAndCriticalCount.put(newCase.AccountId,criticalCount);
                        mapOfAccountAndCriticalCurrentCount.put(newCase.AccountId,criticalCurrentCount);
                    }                        
                //}
            }
        }
        System.debug('List contains '+listOfNewAccounts+'Map contains '+mapOfAccountAndSevereCount);
        List<Account> listOfAccountsToUpdate = new List<Account>();
        for(Account newAccount: listOfNewAccounts){
            newAccount.Current_Week_Severe__C = NULL;
            newAccount.Case_Trend_Severe__c = NULL;
            newAccount.Current_Week_Moderate__c = NULL;
            newAccount.Case_Trend_Moderate__c = NULL;
            newAccount.Current_Week_Critical__c = NULL;
            newAccount.Case_Trend_Critical__c = NULL;
            newAccount.Status_Severe_Deviation__c = NULL;
            newAccount.Status_Moderate_Deviation__c = NULL;
            newAccount.Status_Critical_Deviation__c = NULL;
        }
        
        for(Account newAccount: listOfNewAccounts){
            system.debug('Account CreatedDate::'+newAccount.CreatedDate);
            system.debug('lastsixWeeks::'+lastsixWeeks);
            System.debug('After Nulling '+newAccount.Current_Week_Severe__c);
            Double deviation=0;
            Double deviationPercentage = 0;
            if(mapOfAccountAndSevereCurrentCount.containsKey(newAccount.Id) && Schema.SObjectType.Account.fields.Current_Week_Severe__c.isUpdateable()){
                newAccount.Current_Week_Severe__c = mapOfAccountAndSevereCurrentCount.get(newAccount.Id);
            }
            if(newAccount.CreatedDate < lastsixWeeks || test.isrunningtest()){
                if(mapOfAccountAndSevereCount.containsKey(newAccount.Id) && Schema.SObjectType.Account.fields.Case_Trend_Severe__c.isUpdateable()){
                    newAccount.Case_Trend_Severe__c = mapOfAccountAndSevereCount.get(newAccount.Id)/trendWeek;
                }
                if(newAccount.Case_Trend_Severe__c !=NULL && newAccount.Case_Trend_Severe__c <= decimal.valueOf(Label.Low_Volume_Threshold)){
                    deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Severe);
                }
                else{
                    deviationPercentage = Double.valueOf(Label.Negative_Deviation_Severe);
                }
                system.debug('deviationPercentage=='+deviationPercentage);
                
                if(Schema.SObjectType.Account.fields.Deviation_Severe__c.isUpdateable() && Schema.SObjectType.Account.fields.Status_Severe_Deviation__c.isUpdateable()) {
                  newAccount.Deviation_Severe__c = toCalculateDeviation(newAccount.Current_Week_Severe__c,newAccount.Case_Trend_Severe__c);
                  newAccount.Status_Severe_Deviation__c = toUpdateStatus(newAccount.Current_Week_Severe__c,newAccount.Case_Trend_Severe__c,deviationPercentage);
                }
            }

            if(mapOfAccountAndModerateCurrentCount.containsKey(newAccount.Id) && Schema.SObjectType.Account.fields.Current_Week_Moderate__c.isUpdateable()){
                newAccount.Current_Week_Moderate__c = mapOfAccountAndModerateCurrentCount.get(newAccount.Id);
            }
            if(newAccount.CreatedDate < lastsixWeeks || test.isrunningtest()){
                if(mapOfAccountAndModerateCount.containsKey(newAccount.Id) && Schema.SObjectType.Account.fields.Case_Trend_Moderate__c.isUpdateable() ){
                    newAccount.Case_Trend_Moderate__c = mapOfAccountAndModerateCount.get(newAccount.Id)/trendWeek;
                }
                if(newAccount.Case_Trend_Moderate__c !=NULL && newAccount.Case_Trend_Moderate__c <= decimal.valueOf(Label.Low_Volume_Threshold)){
                    deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Moderate);
                }
                else{
                    deviationPercentage = Double.valueOf(Label.Negative_Deviation_Moderate);
                }
                
                if(Schema.SObjectType.Account.fields.Deviation_Moderate__c.isUpdateable() && Schema.SObjectType.Account.fields.Status_Moderate_Deviation__c.isUpdateable()) {
                  newAccount.Deviation_Moderate__c = toCalculateDeviation(newAccount.Current_Week_Moderate__c,newAccount.Case_Trend_Moderate__c);
                  newAccount.Status_Moderate_Deviation__c = toUpdateStatus(newAccount.Current_Week_Moderate__c,newAccount.Case_Trend_Moderate__c,deviationPercentage); 
                }         
            }

            if(mapOfAccountAndCriticalCurrentCount.containsKey(newAccount.Id) && Schema.SObjectType.Account.fields.Current_Week_Critical__c.isUpdateable()){
                newAccount.Current_Week_Critical__c = mapOfAccountAndCriticalCurrentCount.get(newAccount.Id);
            }
            if(newAccount.CreatedDate < lastsixWeeks || test.isrunningtest()){
                if(mapOfAccountAndCriticalCount.containsKey(newAccount.Id) && Schema.SObjectType.Account.fields.Case_Trend_Critical__c.isUpdateable()){
                    newAccount.Case_Trend_Critical__c = mapOfAccountAndCriticalCount.get(newAccount.Id)/trendWeek;
                }
                if(newAccount.Case_Trend_Critical__c !=NULL && newAccount.Case_Trend_Critical__c <= decimal.valueOf(Label.Low_Volume_Threshold)){
                    deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Critical);
                }
                else{
                    deviationPercentage = Double.valueOf(Label.Negative_Deviation_Critical);
                }
                if(Schema.SObjectType.Account.fields.Deviation_Critical__c.isUpdateable() &&  Schema.SObjectType.Account.fields.Status_Critical_Deviation__c.isUpdateable()) {
                  newAccount.Deviation_Critical__c = toCalculateDeviation(newAccount.Current_Week_Critical__c,newAccount.Case_Trend_Critical__c);
                  newAccount.Status_Critical_Deviation__c = toUpdateStatus(newAccount.Current_Week_Critical__c,newAccount.Case_Trend_Critical__c,deviationPercentage);
                }
            }

            listOfAccountsToUpdate.add(newAccount);
        }
        
        if(isUpdateAccounts && (listOfAccountsToUpdate!=null && !listOfAccountsToUpdate.isEmpty() && listOfAccountsToUpdate.size()>0)){
            System.debug('Before updating list'+listOfAccountsToUpdate);
            try{
              if (Schema.sObjectType.Account.isUpdateable()) {
                update listOfAccountsToUpdate;
                
               }
             }
            catch(DMLException e){
                for(Account accRec : listOfAccountsToUpdate){
                    System.debug('Error in Updating Account:'+ accRec + ':' + e.getMessage());
                }
            }
        }
      }
    
    
    /************************************************************************
    
    Method Name: toUpdateParentCaseTrends
    Purpose: To update parent case trends 
    
    ************************************************************************/
    /*public void toUpdateParentCaseTrends(List<Account> listOfAccounts)
    {
        Map<Id,List<Account>> mapOfIdAndChildAccounts = new Map<Id,List<Account>>();
        Map<Id,Account> mapOfIdAndAccount = new Map<Id,Account>();
        List<Id> listOfAccountIds = new List<Id>();
        List<Id> listOfParentAccountIds = new List<Id>();
        for(Account newAccount:listOfAccounts)
        {
            listOfAccountIds.add(newAccount.Id);
            if(newAccount.ParentId != NULL){
                listOfParentAccountIds.add(newAccount.ParentId);
            }
        }
        
        for(Account newAccount:[Select Id,ParentId,parent.Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c From Account Where parentId in:listOfParentAccountIds or parentId in:listOfAccountIds])
        {
            List<Account> listOfAccountsIterate = new List<Account>();
            if(mapOfIdAndChildAccounts.containsKey(newAccount.ParentId)){
                listOfAccountsIterate = mapOfIdAndChildAccounts.get(newAccount.ParentId);
            }                       
            listOfAccountsIterate.add(newAccount);
            mapOfIdAndChildAccounts.put(newAccount.ParentId,listOfAccountsIterate);
        }
        
        for(Account newAccount:[Select Id,ParentId,Current_Week_Severe__c,Case_Trend_Severe__c,Current_Week_Moderate__c,Case_Trend_Moderate__c,Current_Week_Critical__c,Case_Trend_Critical__c,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c From Account Where Id in:listOfParentAccountIds])
        {
            mapOfIdAndAccount.put(newAccount.Id,newAccount);
        }
        
        List<Account> listOfAccountToUpdate = new List<Account>();
        Map<Id,String> mapOfIdAndValue = new Map<Id,String>();
        for(Id newAccountId:mapOfIdAndChildAccounts.keySet()){
        
            Decimal severeCount,severeCurrentCount,moderateCount,moderateCurrentCount,criticalCount,criticalCurrentCount;
            severeCount=severeCurrentCount=moderateCount=moderateCurrentCount=criticalCount=criticalCurrentCount=0;
            for(Account newAccount:mapOfIdAndChildAccounts.get(newAccountId)){
                if(newAccount.Case_Trend_Severe__c !=NULL){
                    severeCount = severeCount+newAccount.Case_Trend_Severe__c;
                }
                if(newAccount.Current_Week_Severe__c !=NULL){
                    severeCurrentCount = severeCurrentCount+newAccount.Current_Week_Severe__c;
                }
                if(newAccount.Case_Trend_Moderate__c != NULL){
                    moderateCount = moderateCount+newAccount.Case_Trend_Moderate__c;
                }
                if(newAccount.Current_Week_Moderate__c != NULL){
                    moderateCurrentCount = moderateCurrentCount+newAccount.Current_Week_Moderate__c;
                }
                if(newAccount.Case_Trend_Critical__c !=NULL){
                    criticalCount = criticalCount+newAccount.Case_Trend_Critical__c;
                    System.debug('For Parent case calculation '+criticalCount);
                }
                if(newAccount.Current_Week_Critical__c != NULL){
                    criticalCurrentCount = criticalCurrentCount+newAccount.Current_Week_Critical__c;                
                }
            }
            mapOfIdAndValue.put(newAccountId,''+criticalCurrentCount+','+moderateCurrentCount+','+severeCurrentCount+','+criticalCount+','+moderateCount+','+severeCount);
        }
        
        System.debug('map contains '+mapOfIdAndValue);
        for(Account newAccount:[Select Id,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_curr_Week_severe__c,
                                    Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c From Account Where Id In:mapOfIdAndValue.keySet()])
        {
            String countValues = mapOfIdAndValue.get(newAccount.Id);
            List<String> counts = countValues.split(',');
            newAccount.Cust_Facilities_Curr_Week_Critical__c = Decimal.valueOf(counts[0]);
            newAccount.Cust_Facilities_Curr_Week_Moderate__c = Decimal.valueOf(counts[1]);
            newAccount.Cust_Facilities_Curr_Week_Severe__c = Decimal.valueOf(counts[2]);
            newAccount.Cust_Facilities_Trend_Critical__c = Decimal.valueOf(counts[3]);
            newAccount.Cust_Facilities_Trend_Moderate__c = Decimal.valueOf(counts[4]);
            newAccount.Cust_Facilities_Trend_Severe__c = Decimal.valueOf(counts[5]);
            listOfAccountToUpdate.add(newAccount);
            System.debug('Coming inside for loop')           ;
        }
        
        if(listOfAccountToUpdate!=null && !listOfAccountToUpdate.isEmpty() && listOfAccountToUpdate.size()>0){
            try{
                update listOfAccountToUpdate;
            }
            catch(DMLException e){
                for(Account accRec : listOfAccountToUpdate){
                        System.debug('Error in Updating Account:'+ accRec + ':' + e.getMessage());
                }
            }
            System.debug('After update statement');
        }
    }*/

    public Decimal toCalculateDeviation(Decimal currentWeek,Decimal caseTrend){
        Decimal deviation;
        if(currentWeek !=NULL && caseTrend !=NULL ){
            if(caseTrend!=0){
                deviation = (((caseTrend-currentWeek)/caseTrend)*100);
                system.debug('deviation=='+deviation);
            }
        }
        return deviation;        
    }
    
    public String toUpdateStatus(Decimal currentWeek,Decimal caseTrend,Decimal deviationPercentage)
    {
        String returnString='';
        Decimal deviation;
        if(currentWeek !=NULL && caseTrend !=NULL )
        {
            if(currentWeek<caseTrend){
                returnString='Favorable';
            }
            if(currentWeek>=caseTrend && caseTrend!=0){
                deviation = Math.abs(((((caseTrend-currentWeek)/caseTrend)*100)));
                if(deviation >=deviationPercentage){
                    returnString ='Unfavorable';
                }
                else if(deviation<deviationPercentage && deviation>=0){
                    returnString = 'Same';
                }
            }
            if(currentWeek>caseTrend && caseTrend==0){
                returnString='Unfavorable';
            }
            if(currentWeek==caseTrend){
                returnString='Same';
            }
        }
        return returnString;        
    }
    
    /*public void toUpdatePharmacyTotal(List<Account> listOfNewAccounts)
    {
        List<Id> listOfPharmacyIds = new List<Id>();
        Map<Id,Double> mapOfPharmacyIdsAndCriticalTotal = new Map<Id,Double>();
        Map<Id,Double> mapOfPharmacyIdsAndModerateTotal = new Map<Id,Double>();
        Map<Id,Double> mapOfPharmacyIdsAndSevereTotal = new Map<Id,Double>();
        Map<Id,Double> mapOfPharmacyIdsAndCurrentCriticalTotal = new Map<Id,Double>();
        Map<Id,Double> mapOfPharmacyIdsAndCurrentModerateTotal = new Map<Id,Double>();
        Map<Id,Double> mapOfPharmacyIdsAndCurrentSevereTotal = new Map<Id,Double>();                        
        for(Account newAccount: listOfNewAccounts)
        {
            Double criticalCount,criticalCurrentCount,moderateCount,moderateCurrentcount,severeCount,severeCurrentCount;
            criticalCount = criticalCurrentCount = moderateCount = moderateCurrentCount = severeCount = severeCurrentCount = 0;
            if(mapOfPharmacyIdsAndCriticalTotal.containsKey(newAccount.OCR_Pharmacy_Name__c)){
                criticalCount = mapOfPharmacyIdsAndCriticalTotal.get(newAccount.OCR_Pharmacy_Name__c);
            }
            if(newAccount.Case_Trend_Critical__c !=NULL){
                criticalCount = criticalCount+newAccount.Case_Trend_Critical__c;
            }
            mapOfPharmacyIdsAndCriticalTotal.put(newAccount.OCR_Pharmacy_Name__c,criticalCount);
            

            if(mapOfPharmacyIdsAndModerateTotal.containsKey(newAccount.OCR_Pharmacy_Name__c)){
                moderateCount= mapOfPharmacyIdsAndModerateTotal.get(newAccount.OCR_Pharmacy_Name__c);
            }
            if(newAccount.Case_Trend_Moderate__c !=NULL){
                moderateCount = moderateCount+newAccount.Case_Trend_Moderate__c;
            }
            mapOfPharmacyIdsAndModerateTotal.put(newAccount.OCR_Pharmacy_Name__c,moderateCount); 
            
            if(mapOfPharmacyIdsAndSevereTotal.containsKey(newAccount.OCR_Pharmacy_Name__c)){
                severeCount= mapOfPharmacyIdsAndSevereTotal.get(newAccount.OCR_Pharmacy_Name__c);
            }
            if(newAccount.Case_Trend_Severe__c !=NULL){
                severeCount = severeCount+newAccount.Case_Trend_Severe__c;
            }
            mapOfPharmacyIdsAndSevereTotal.put(newAccount.OCR_Pharmacy_Name__c,severeCount);             

            if(mapOfPharmacyIdsAndCurrentCriticalTotal.containsKey(newAccount.OCR_Pharmacy_Name__c)){
                criticalCurrentCount = mapOfPharmacyIdsAndCurrentCriticalTotal.get(newAccount.OCR_Pharmacy_Name__c);
            }
            if(newAccount.Current_Week_Critical__c !=NULL){
                criticalCurrentCount = criticalCurrentCount+newAccount.Current_Week_Critical__c;
            }
            mapOfPharmacyIdsAndCriticalTotal.put(newAccount.OCR_Pharmacy_Name__c,criticalCurrentCount);
            

            if(mapOfPharmacyIdsAndCurrentModerateTotal.containsKey(newAccount.OCR_Pharmacy_Name__c)){
                moderateCurrentCount= mapOfPharmacyIdsAndCurrentModerateTotal.get(newAccount.OCR_Pharmacy_Name__c);
            }
            if(newAccount.Current_Week_Moderate__c !=NULL){
                moderateCurrentCount = moderateCurrentCount+newAccount.Current_Week_Moderate__c;
            }
            mapOfPharmacyIdsAndCurrentModerateTotal.put(newAccount.OCR_Pharmacy_Name__c,moderateCurrentCount); 
            
            if(mapOfPharmacyIdsAndCurrentSevereTotal.containsKey(newAccount.OCR_Pharmacy_Name__c)){
                severeCurrentCount= mapOfPharmacyIdsAndCurrentSevereTotal.get(newAccount.OCR_Pharmacy_Name__c);
            }
            if(newAccount.Current_Week_Severe__c !=NULL){
                severeCurrentCount = severeCurrentCount+newAccount.Current_Week_Severe__c;
            }
            mapOfPharmacyIdsAndCurrentSevereTotal.put(newAccount.OCR_Pharmacy_Name__c,severeCurrentCount);                                    
            
            listOfPharmacyIds.add(newAccount.OCR_Pharmacy_Name__c);
        }
        
        List<OCR_Pharmacy__c> listOfPharmacyToUpdate = new List<OCR_Pharmacy__c>();
        Integer trendWeek =Integer.valueOf(Label.Trend_Number_of_Weeks);
        for(OCR_Pharmacy__c newPharmacy: [Select Id,Cust_Facilities_Curr_Week_Critical__c,Cust_Facilities_Curr_Week_Moderate__c,Cust_Facilities_Curr_Week_Severe__c,Cust_Facilities_Trend_Critical__c,Cust_Facilities_Trend_Moderate__c,Cust_Facilities_Trend_Severe__c From OCR_Pharmacy__c Where Id In:listOfPharmacyIds])
        {
            if(mapOfPharmacyIdsAndCriticalTotal.containsKey(newPharmacy.Id)){
                newPharmacy.Cust_Facilities_Trend_Critical__c = mapOfPharmacyIdsAndCriticalTotal.get(newPharmacy.Id)/trendWeek;
            }
            if(mapOfPharmacyIdsAndModerateTotal.containsKey(newPharmacy.Id)){
                newPharmacy.Cust_Facilities_Trend_Moderate__c = mapOfPharmacyIdsAndModerateTotal.get(newPharmacy.Id)/trendWeek;            
            }
            if(mapOfPharmacyIdsAndSevereTotal.containsKey(newPharmacy.Id)){
                newPharmacy.Cust_Facilities_Trend_Severe__c = mapOfPharmacyIdsAndSevereTotal.get(newPharmacy.Id)/trendWeek;            
            }
            if(mapOfPharmacyIdsAndCurrentCriticalTotal.containsKey(newPharmacy.Id)){
                newPharmacy.Cust_Facilities_Curr_Week_Critical__c = mapOfPharmacyIdsAndCurrentCriticalTotal.get(newPharmacy.Id);            
            }
            if(mapOfPharmacyIdsAndCurrentModerateTotal.containsKey(newPharmacy.Id)){
                newPharmacy.Cust_Facilities_Curr_Week_Moderate__c = mapOfPharmacyIdsAndCurrentModerateTotal.get(newPharmacy.Id);                        
            }
            if(mapOfPharmacyIdsAndCurrentSevereTotal.containsKey(newPharmacy.Id)){
                newPharmacy.Cust_Facilities_Curr_Week_Severe__c = mapOfPharmacyIdsAndCurrentSevereTotal.get(newPharmacy.Id);                        
            }

            Double deviationPercentage;
            if(newPharmacy.Cust_Facilities_Trend_Critical__c !=NULL && newPharmacy.Cust_Facilities_Trend_Critical__c <= decimal.valueOf(Label.Low_Volume_Threshold)){
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Critical);
            }
            else{
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Critical);
            }
            newPharmacy.All_Related_Cust_Status_Critical__c = toUpdateStatus(newPharmacy.Cust_Facilities_Curr_Week_Critical__c,newPharmacy.Cust_Facilities_Trend_Critical__c,deviationPercentage);                        
            if(newPharmacy.Cust_Facilities_Trend_Moderate__c !=NULL && newPharmacy.Cust_Facilities_Trend_Moderate__c <= decimal.valueOf(Label.Low_Volume_Threshold)){
            
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Moderate);
            }
            else{
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Moderate);
            }
            newPharmacy.All_Related_Cust_Status_Moderate__c = toUpdateStatus(newPharmacy.Cust_Facilities_Curr_Week_Moderate__c,newPharmacy.Cust_Facilities_Trend_Moderate__c,deviationPercentage);                        
            if(newPharmacy.Cust_Facilities_Trend_Severe__c !=NULL && newPharmacy.Cust_Facilities_Trend_Severe__c <= decimal.valueOf(Label.Low_Volume_Threshold)){
                deviationPercentage = Double.valueOf(Label.Low_Vol_Negative_Deviation_Severe);
            }
            else{
                deviationPercentage = Double.valueOf(Label.Negative_Deviation_Severe);
            }
            newPharmacy.All_Related_Cust_Status_Severe__c = toUpdateStatus(newPharmacy.Cust_Facilities_Curr_Week_Severe__c,newPharmacy.Cust_Facilities_Trend_Severe__c,deviationPercentage);                                                
            listOfPharmacyToUpdate.add(newPharmacy);
        }
        
        if(listOfPharmacyToUpdate!=null && !listOfPharmacyToUpdate.isEmpty() && listOfPharmacyToUpdate.size()>0){
            try{
                update listOfPharmacyToUpdate;
            }
            catch(DMLException e){
                for(OCR_Pharmacy__c ocrPhar : listOfPharmacyToUpdate){
                    System.debug('Error in Updating OCR Pharmacy:'+ ocrPhar + ':' + e.getMessage());
                }
            }
        }
    }*/
    
    
    
    
    public void calculateDistance(List<Account> TriggerNew,Map<Id,Account> TriggerOldMap,boolean isInsert,boolean isUpdate){
        Set<Id> accIdSet = new Set<Id>();
        
    
    
        for(Account acc : TriggerNew){
            if(isInsert){
                if(acc.OCR_Pharmacy_Name__c !=null && (acc.BillingStreet!=null || acc.BillingPostalCode!=null || acc.BillingCity!=null || acc.BillingState!=null || acc.BillingCountry!=null)){
                    accIdSet.add(acc.Id);
                }
            }
            if(isUpdate){
                if( DataUtil_Check.var_AddressCheck &&
                    ((acc.billingstreet != TriggerOldMap.get(acc.id).billingstreet || 
                        acc.billingcity != TriggerOldMap.get(acc.id).billingcity ||
                        acc.billingstate != TriggerOldMap.get(acc.id).billingstate || 
                        acc.billingpostalcode != TriggerOldMap.get(acc.id).billingpostalcode ||
                        acc.billingcountry != TriggerOldMap.get(acc.id).billingcountry))){
                            System.debug(LoggingLevel.info,'$$$$$$$$'+ acc.Id);
                             accIdSet.add(acc.Id);
                           
                }else if(DataUtil_Check.var_AddressCheck == false && ((acc.Distance_to_Service_Facility__c == null  ) || 
                    (acc.OCR_Pharmacy_Name__c != TriggerOldMap.get(acc.Id).OCR_Pharmacy_Name__c))){
                    	 accIdSet.add(acc.Id);
                    }
            }
        }
     System.debug(LoggingLevel.info,'accIdSet'+ accIdSet);
        if(accIdSet!=null && !accIdSet.isEmpty() && accIdSet.size()>0){
           // calculateDistanceFuture(accIdSet);
            if(DataUtil_Check.var_StopSecondBatch == true){
                calculateDistanceBatchMethod(accIdSet);
            }
        }
    }
    
    public void calculateDistanceBatchMethod(Set<Id> accIdSet){
        system.debug('...calculateDistanceBatchMethod -> accIdSet: ' + accIdSet);
        CalculateDistanceBatch  b = new CalculateDistanceBatch (accIdSet);
        database.executebatch(b,1);
    }
    
    
    /*@future(callout=true)
    public static void calculateDistanceFuture(Set<Id> accIdSet){
        Map<Id,String> accIdOcrAddressMap= new Map<Id,String>();
        Map<Id,String> accIdAccAddressMap= new Map<Id,String>();
        List<Account> accountList = new List<Account>();
        List<Account> accountUpdateList = new List<Account>();
        
        if(accIdSet!=null && !accIdSet.isEmpty() && accIdSet.size()>0){
        String addressOCR='';
        String addressACC='';
        for(Account accRec : [Select Id,BillingStreet,BillingPostalCode,BillingCity,BillingState,BillingCountry,
            OCR_Pharmacy_Name__r.Address__c,OCR_Pharmacy_Name__r.City__c,OCR_Pharmacy_Name__r.State_Province__c,OCR_Pharmacy_Name__r.Zip_Postal_Code__c,
            OCR_Pharmacy_Name__r.Country__c from Account where Id IN: accIdSet]){
                addressOCR='';
                addressACC='';
                if((accRec.OCR_Pharmacy_Name__r.Address__c!=null || accRec.OCR_Pharmacy_Name__r.City__c!=null || accRec.OCR_Pharmacy_Name__r.State_Province__c!=null ||
                                accRec.OCR_Pharmacy_Name__r.Zip_Postal_Code__c!=null || accRec.OCR_Pharmacy_Name__r.Country__c!=null) && 
                                (accRec.BillingStreet!=null || accRec.BillingPostalCode!=null ||  accRec.BillingCity!=null || accRec.BillingState!=null || accRec.BillingCountry!=null)){
                    addressOCR= accRec.OCR_Pharmacy_Name__r.Address__c +
                                accRec.OCR_Pharmacy_Name__r.City__c +
                                accRec.OCR_Pharmacy_Name__r.State_Province__c +
                                accRec.OCR_Pharmacy_Name__r.Zip_Postal_Code__c +
                                accRec.OCR_Pharmacy_Name__r.Country__c;
                    addressACC= accRec.BillingStreet +
                                accRec.BillingPostalCode+ 
                                accRec.BillingCity+
                                accRec.BillingState+
                                accRec.BillingCountry;
                }
                
                if(addressOCR!='' && addressACC!=''){
                    accIdOcrAddressMap.put(accRec.Id,addressOCR);
                    accIdAccAddressMap.put(accRec.Id,addressACC);
                    accountList.add(accRec);
                }               
            }
        }
    
        if((accIdOcrAddressMap!=null && !accIdOcrAddressMap.isEmpty() && accIdOcrAddressMap.size()>0) && 
            (accIdAccAddressMap!=null && !accIdOcrAddressMap.isEmpty() && accIdOcrAddressMap.size()>0)){
            for(Account accountRec : accountList){
                accountRec.Distance_to_Service_Facility__c = getGoogleMaps.getDistance(accIdOcrAddressMap.get(accountRec.Id),accIdAccAddressMap.get(accountRec.Id));
                accountUpdateList.add(accountRec);
            }
        }
        
        if(accountUpdateList!=null && !accountUpdateList.isEmpty() && accountUpdateList.size()>0){
            update accountUpdateList;
        }
        
    }*/
    
}