@isTest
global class MockHttpResponseGenerator implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{   "destination_addresses" : [ "106 Pendery Ave, Cincinnati, OH 45215, USA" ],   "origin_addresses" : [ "106 Pendery Ave, Cincinnati, OH 45215, USA" ],   "rows" : [      {         "elements" : [            {               "distance" : {                  "text" : "1 ft",                  "value" : 0               },               "duration" : {                  "text" : "1 min",                  "value" : 0               },               "status" : "OK"            }         ]      }   ],   "status" : "OK"}');
        res.setStatusCode(200);
        system.assert(res.getStatusCode()==200,'status code');
        return res;
    }
}