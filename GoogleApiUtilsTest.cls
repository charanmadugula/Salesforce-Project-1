@isTest
public class GoogleApiUtilsTest {
 
   	static testMethod void GoogleApiUtilsTestMethod(){
		Test.startTest();

        Google_API_Keys__c apiKey = new Google_API_Keys__c(Name='TestAPIKey',API_Key__c = 'AIzaSyD6LpFLm2m8KdVHz8hpxrcfqqXAI8aApPM', Google_id__c = 'st91548@gmail.com', password__c = 'Cincinnati23');
		insert apiKey;
        
        system.assert(apiKey.id <> null);
        
        GoogleApiUtils.getActiveApiKey();
        GoogleApiUtils.markKeyAsExhausted('');
        GoogleApiUtils.markKeyAsExhausted('AIzaSyD6LpFLm2m8KdVHz8hpxrcfqqXAI8aApPM');
        GoogleApiUtils.parseJSONResponse('{"destination_addresses" : [ "San Francisco, CA, USA", "Victoria, BC, Canada" ],"origin_addresses" : [ "Vancouver, BC, Canada", "Seattle, WA, USA" ],"rows" : [{"elements" : [{"distance" : {"text" : "1529 mi","value" : 1528699},"duration" : {"text" : "14 hours 56 mins","value" : 53778},"status" : "OK"}]}],"status" : "OK"}');
        GoogleApiUtils.parseJSONResponse('{"destination_addresses" : [ "San Francisco, CA, USA", "Victoria, BC, Canada" ],"origin_addresses" : [ "Vancouver, BC, Canada", "Seattle, WA, USA" ],"rows" : [{"elements" : [{"distance" : {"text" : "1529 ft","value" : 1528699},"duration" : {"text" : "14 hours 56 mins","value" : 53778},"status" : "OK"}]}],"status" : "OK"}');
        GoogleApiUtils.parseJSONResponse('{"destination_addresses" : [ "San Francisco, CA, USA", "Victoria, BC, Canada" ],"origin_addresses" : [ "Vancouver, BC, Canada", "Seattle, WA, USA" ],"rows" : [{"elements" : [{"distance" : {"text" : "1529","value" : 1528699},"duration" : {"text" : "14 hours 56 mins","value" : 53778},"status" : "OK"}]}],"status" : "OK"}');
		Test.stopTest();
	} 
    
}