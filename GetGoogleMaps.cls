/************************************************************************
    Name: GetGoogleMaps
    Purpose: Web service to calculate the distance between OCR's address and related account's address. It also calls the JSON class and parses the data.
    History:
**********************************************************************
    Version        Created by         Date             Description
    1
*************************************************************************/
global with sharing class GetGoogleMaps implements queueable, Database.AllowsCallouts {

    public static String distance;
    public static Decimal distanceinMiles=0.00;

    public String address1;
    public String address2;
    public Account account;

    public GetGoogleMaps() {
    }

    public GetGoogleMaps(String address1, String address2, Account account) {
        this.address1 = address1;
        this.address2 = address2;
        this.account = account;
    }

    public void execute(QueueableContext qContext) {
        distanceinMiles = getDistance(address1, address2);
        if((Schema.SObjectType.Account.fields.Distance_to_Service_Facility__c.isUpdateable()) == false) {
            return;
        }
        if(distanceinMiles > 0) {
            account.Distance_to_Service_Facility__c = distanceinMiles;
        } else {
            
        }

        if(Schema.SObjectType.Account.isUpdateable()) {
            update account;
        }

    }

    webservice static Decimal getAccOCRDistance(String accId){
      System.debug('...getGoogleMaps -> getAccOCRDistance -> accId: ' + accId);
        String address1='';
        String address2='';
        if(accId!=''){
            List<Account> accountList = [Select Id,BillingStreet,BillingPostalCode,BillingCity,BillingState,BillingCountry,
            OCR_Pharmacy_Name__r.Address__c,OCR_Pharmacy_Name__r.City__c,OCR_Pharmacy_Name__r.State_Province__c,OCR_Pharmacy_Name__r.Zip_Postal_Code__c,OCR_Pharmacy_Name__r.Country__c from Account where Id =: accId limit 1];
            if(accountList!=null && !accountList.isEmpty() && accountList.size()>0){
                address1= accountList[0].OCR_Pharmacy_Name__r.Address__c +
                            accountList[0].OCR_Pharmacy_Name__r.City__c +
                            accountList[0].OCR_Pharmacy_Name__r.State_Province__c +
                            accountList[0].OCR_Pharmacy_Name__r.Zip_Postal_Code__c +
                            accountList[0].OCR_Pharmacy_Name__r.Country__c;
                address2= accountList[0].BillingStreet +
                            accountList[0].BillingCity+
                            accountList[0].BillingState+
                            accountList[0].BillingPostalCode+
                            accountList[0].BillingCountry;
            }
        }

        if(address1!='' && address2!=''){
            distanceinMiles = getDistance(address1,address2);
        }
        return distanceinMiles;
    }


    public static Decimal getDistance(String address1,String address2) {
        address1=EncodingUtil.urlEncode(address1, 'UTF-8');
        address2=EncodingUtil.urlEncode(address2, 'UTF-8');
        system.debug('... getDistance -> address1 After Encoding::::'+address1);
        system.debug('... getDistance -> address2 After Encoding::::'+address2);

        String apiKey = GoogleApiUtils.getActiveApiKey();
        String jsonResults = getJsonResults(address1, address2, apiKey);

        /*
        JSON2Apex result = JSON2Apex.parse(jsonResults);
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
              }
           }

        }
        system.debug('distance::::'+distance);
        system.debug('distanceinMiles::::'+distanceinMiles);
        */
        distanceinMiles = GoogleApiUtils.parseJSONResponse(jsonResults);

        if(distanceinMiles < 0.0) {
          GoogleApiUtils.markKeyAsExhausted(apiKey);

          // Recalculate with new key
          // return getDistance(address1,address2);
        }

        return distanceinMiles;
    }

    public static String getJsonResults(String address1,String address2, String apiKey) {

        HttpRequest req = new HttpRequest();
        Http http = new Http();

        req.setMethod('GET');

        String url = 'https://maps.googleapis.com/maps/api/distancematrix/json'
            + '?origins=' + address1
            + '&destinations=' + address2
            + '&mode=driving'
            + '&sensor=false'
            + '&language=en'
            + '&units=imperial'
            + '&key=' + apiKey;


        req.setEndPoint(url);
        system.debug('url: ' + url);

        HTTPResponse resp = http.send(req);
        //String jsonResults = 'dump';
        String jsonResults = resp.getBody().replace('\n', '');
        system.debug('jsonResults::'+jsonResults);
        return jsonResults;
    }

}