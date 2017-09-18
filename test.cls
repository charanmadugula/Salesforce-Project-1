public class test {
    List<test1> products;

    public List<test1> getProducts() {

        if(products == null) {

            products = new List<test1>();

            for(account item : [ SELECT  Name, TypeCust__c, Phone FROM account where  parent.Id =: ApexPages.currentPage().getParameters().get('id')]) 
                    {

                products.add(new test1(item));

            }

        }

        return products;

    }

     

    // Inner class to hold online store details for item

    public class test1 {
private account merchandise;

        public test1(account item) {

            this.merchandise = item;

        }
        // Properties for use in the Visualforce view

        public String name {

            get { return merchandise.Name; }

        }

        public String type {

            get { return merchandise.TypeCust__c; }

        }

        public String phone {

            get { return merchandise.Phone; }

        }
        
   
       // public Integer qtyToBuy { get; set; }

    }

}