/************************************************************************
    Name: JSON2Apex 
    Purpose: Format of the data we got from the GoogleMaps.
    History:  
**********************************************************************    
    Version        Created by         Date             Description       
    1             TCS Offshore      11/14/2015          Created
*************************************************************************/
public class JSON2Apex {

        public List<String> destination_addresses;
        public List<String> origin_addresses;
        public List<Rows> rows;
        public String status;
    
        public class Elements {
            public Distance distance;
            public Distance duration;
            public String status;
        }
    
        public class Distance {
            public String text;
            public Integer value;
        }
    
        public class Rows {
            public List<Elements> elements;
        }
    
        
        public static JSON2Apex parse(String json) {
            return (JSON2Apex) System.JSON.deserialize(json, JSON2Apex.class);
        }
    }