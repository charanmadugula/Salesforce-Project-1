public with sharing class GoogleApiUtils {

    public static List<Google_API_Keys__c> googleApiKeys = Google_API_Keys__c.getAll().values();
    
    
    // Constructor
    public GoogleApiUtils(){
    
    }
    
    // get active API key from list of available keys in custom setting
    public static String getActiveApiKey() {
        String apiKey = '';     
        
        if(googleApiKeys == null) {
            return apiKey;
        }
        
        for(Google_API_Keys__c googleApiKey : googleApiKeys) {
            if(googleApiKey.Is_Exhausted__c == true) {
                continue;
            }
            
            apiKey = googleApiKey.API_Key__c;
            break;
        }
        
        return apiKey;
    }
    
    
    // if a key is exhausted then mark it as exhausted
    public static void markKeyAsExhausted(String activeApiKey) {
        if(String.isBlank(activeApiKey)) {
            return;
        }
        
        for(Google_API_Keys__c googleApiKey : googleApiKeys) {
            if(googleApiKey.API_Key__c != activeApiKey) {
                continue;
            }
            
            googleApiKey.Is_Exhausted__c = true;
            googleApiKey.Exhaust_timestamp__c = System.now();
            break;
        }
        
        update googleApiKeys;
    }
    
    
    // Parse the JSON response
    public static Decimal parseJSONResponse(String respJSON) {
        Decimal distanceinMiles = 0.0;
        String distance = '';
        
        if(String.isBlank(respJSON)) {
            return distanceinMiles;
        }
        
        JSON2Apex result = JSON2Apex.parse(respJSON);
        system.debug('result:'+result);
        for(JSON2Apex.rows res: result.rows)
        {
           for(JSON2Apex.Elements dist : res.elements){
               system.debug('dist.status::'+dist.status);
               if(dist.status=='OK'){
               if(dist.Distance!=null && dist.Distance.text!='null' && dist.Distance.text!=null){
               distance=dist.Distance.text;
               if(distance.contains('mi')){
                   distance= distance.replace('mi','');
                   distance= distance.replace(',','');
                   distance= distance.trim();
                   distanceinMiles= Decimal.valueOf(distance);
                   break;
               }
               else if(distance.contains('ft'))
                   distance= distance.replace('ft','');
                   distance= distance.replace(',','');
                   distance= distance.trim();
                   distanceinMiles= Decimal.valueOf(distance);
                   distanceinMiles= (distanceinMiles * 0.000189394);
                   break;
               }
              
              } else if (dist.status == 'OVER_QUERY_LIMIT') {
                   distanceinMiles = -1;
              } else {
              	   distanceinMiles = 0;
              }
           }
                                              
        }
        
        return distanceinMiles;
    }
    
    
    
}