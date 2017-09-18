public with sharing class executeBatchController 
{
    public Boolean renderTrue{get;set;}
    public String batchMessage{get;set;}
    public executeBatchController()
    {
        renderTrue = false;
    }
    public PageReference executeNow() 
    {
        renderTrue = false;
        batchMessage ='';
        ApexClass newClass = [Select Id from ApexClass Where Name='oneTimeBatchCaseTrend'];
        List<String> listOfStatus = new List<String>();
        listOfStatus.add('Processing');
        listOfStatus.add('Queued');
        listOfStatus.add('Preparing');
        List<AsyncApexJob> listOfJobs = [Select Id From AsyncApexJob Where ApexclassId=:newClass.Id and Status in:listOfStatus];
        if(listOfJobs.isEmpty())
        {
            oneTimeBatchCaseTrend  newHandler = new oneTimeBatchCaseTrend ();
            Database.executeBatch(newHandler);
            batchMessage = 'Batch executed Successfully';
            renderTrue = true;
        }
        else
        {
            batchMessage = 'Batch is already in progress. Please try again after some times';
            renderTrue = true;
        }
        return null;
    }





}