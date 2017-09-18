//========================================================================
//  Object: ext_CreatePricing
// Company: Omnicare
//  Author: Barney Young Jr.
// Comment: Extension for CreatePricing VF Page
//========================================================================
//          Date            Purpose
// Changes: 12/07/2015      Initial Version
//========================================================================

public with sharing class ext_CreatePricing {
	
	//Variables
	public Account pwAccount {get;set;}
	public Pricing_Worksheet__c pricingWorkSheet{get;set;}
	public list<Pricing_Worksheet__c> pwList;
	public Pricing_Worksheet__c pricingWorkSheetExec{get;set;}
	public list<Pricing_Worksheet__c> pwListExec;	
	public boolean ExecExists {get;set;}
	public id pwid {get;set;}
	public boolean executed {get;set;}
	public boolean edit {get;set;}
	public boolean state {get;set;}
	public boolean CurPW {get;set;}
}