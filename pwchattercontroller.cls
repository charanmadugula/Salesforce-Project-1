//========================================================================
//  Object: pwchattercontroller
//  Company: Omnicare
//  Author: Sai Charan
// Comment: Extension for PWChatter,,IVchatter,perdiemchatter VF Page
//========================================================================
//          Date            Purpose
// Changes: 8/5/2016     Initial Version
//========================================================================

public with sharing class pwchattercontroller { 
public id pwid{get;set;}
public id Ivid{get;set;}
public id perdimid{get;set;}
public string strURLPW{get;set;}
public string strURLIV{get;set;}
public string strURLperdim{get;set;}


//        INTERNAL IV PRICING & PER DIEM CHATTER CONSTRUCTOR

public pwchattercontroller()
{
     if(apexpages.currentpage().getparameters().get('iwsId') !=null && apexpages.currentpage().getparameters().get('iwsId') !='')
     {  
        Ivid = apexpages.currentpage().getparameters().get('iwsId');
     }
     if(apexpages.currentpage().getparameters().get('perdimid') !=null && apexpages.currentpage().getparameters().get('perdimid') !='')
     {  
        perdimid = apexpages.currentpage().getparameters().get('perdimid');
     }

}
//       PRICING WORKSHEET CHATTER CONSTRUCTOR

public pwchattercontroller (ApexPages.StandardController controller) {
     
     pwid = controller.getId();
     strURLPW = url.getsalesforcebaseurl().toexternalform()+'/apex/pricing_worksheet_chatter?id='+pwid;
       
     if(apexpages.currentpage().getparameters().get('iwsId') !=null && apexpages.currentpage().getparameters().get('iwsId') !='')
     {  
        Ivid = apexpages.currentpage().getparameters().get('iwsId');
        strURLIV = url.getsalesforcebaseurl().toexternalform() +'/apex/IVchatter?iwsId='+Ivid;
     }
     //system.debug(Logginglevel.info,'>>>apexpages.currentpage().getparameters()'+apexpages.currentpage().getparameters().get('perdimid'));
     if(apexpages.currentpage().getparameters().get('perdimid') !=null && apexpages.currentpage().getparameters().get('perdimid') !='')
     {  
         //system.debug(Logginglevel.info,'>>>apexpages.currentpage().getparameters()');
        perdimid = apexpages.currentpage().getparameters().get('perdimid');
        strURLperdim = url.getsalesforcebaseurl().toexternalform() + '/apex/perdiemchatter?perdimid='+perdimid;
     }
     
    }  
    public pagereference Back(){
        return new pagereference(URL.getSalesforceBaseUrl().toExternalForm() + '/apex/pwView?id='+pwid);
    }
    
    public void initIvChatter()
    {
        
    }
        
    
}