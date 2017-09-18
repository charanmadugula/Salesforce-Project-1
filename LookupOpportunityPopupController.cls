public with sharing class LookupOpportunityPopupController 
{

    public String query {get; set;}
    public List<Opportunity> lstOpportunity{get;set;}
    
    private static final String[] HTML_DECODED  = new String[]{ '&', '<', '>', '"', '\''};
    private static final String[] HTML_ENCODED  = new String[]{ '&amp;', '&lt;', '&gt;', '&quot;', '&#39;' };
    
    public LookupOpportunityPopupController()
    {
      string strAccId = apexpages.currentpage().getparameters().get('accid');
      strAccId = ENCODE(strAccId,HTML_DECODED,HTML_ENCODED);
      
      if(strAccId !=null)
      {
       lstOpportunity = [select Id,Name from Opportunity where AccountId =:strAccId ];
      }else
      {
       lstOpportunity = new List<Opportunity>();
      }
      system.debug('>>>>>>>>lstOpportunity'+lstOpportunity);
    }
    
    private String ENCODE(String input, String[] fromArr, String[] toArr) {
    if (input == null || input.length() == 0)
      return input;

    for (Integer i = 0; i < fromArr.size(); ++i) {
      input = input.replace(fromArr[i], toArr[i]);
    }
    
    return input;
  }
    
}