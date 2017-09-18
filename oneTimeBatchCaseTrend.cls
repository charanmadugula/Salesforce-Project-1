/************************************************************************
    Name: oneTimeBatchCaseTrend.cls    
    Purpose: One time batch to update case trend total to the existing records.    
    History:  
    **********************************************************************    
    Version        Created by           Date             Description       
        1          TCS Offshore        27/10/2015          Created       

*************************************************************************/
global with sharing class oneTimeBatchCaseTrend implements Database.Batchable<sObject>, Database.Stateful
{

    //Constructor to intialize the query and count.    
    global oneTimeBatchCaseTrend()    
    {            
       
    }               
    global Database.QueryLocator start(Database.BatchableContext BC)    
    {
        return Database.getQueryLocator('Select AccountId,Id,CreatedDate,Custom_Created_Date__c From Case');    
    }    
    //Delete the records and counts the number of records deleted.    
    global void execute(Database.BatchableContext BC, List<Case> scope)    
    {        
        CaseTriggerHandler newHandler = new CaseTriggerHandler();   
        DataUtil_Check.var_StopSecondBatch = false; 
        newHandler.toUpdateCaseTrend(scope,null);    
    }    
    //Once the batch completed, it sends an email notification to the admin user.    
    global void finish(Database.BatchableContext BC)    
    {
    }
}