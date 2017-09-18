/************************************************************************
    Name: DataUtil_Check 
    Purpose: For declaring static variables for controlling the execution of code.
    History:  
**********************************************************************    
    Version        Created by         Date             Description       
    1             TCS Offshore      11/19/2015          Created
*************************************************************************/
public with sharing class DataUtil_Check {
    public static Boolean var_StopSecondBatch = True;        // To stop the execution of second batch from first batch.
    public static Boolean var_StopAccountTriggerFromWebFocus = True; // To Stop execution of Account Trigger when Webfocus's records are inserted or updated.
    public  static Boolean  var_StopAccountTriggerfromCase = True; //To stop execution of calculateDistance batch from Account Trigger when Case records are inserted or updated.
    public static Boolean var_AddressCheck = true;
}