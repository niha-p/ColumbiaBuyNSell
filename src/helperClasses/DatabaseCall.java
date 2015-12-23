package helperClasses;
 
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.StringTokenizer;
 
public class DatabaseCall {
    private int totalProducts;
    private String data="";
    private String query;
    private List<String> productNames;
    public DatabaseCall() {
    	DbCon d= new DbCon();
    	query="SELECT `product_name` FROM product";
    	d=DatabaseQuery.getResultSet(query);
   	 	ResultSet rs2=d.rst;
   	 	Connection ctn=d.cntcn;
        try {
			while(rs2.next()){
				data+=rs2.getString("product_name")+",";
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        try {
			rs2.close();
			ctn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
    	
        productNames = new ArrayList<String>();
        StringTokenizer st = new StringTokenizer(data, ",");
         
        while(st.hasMoreTokens()) {
        	productNames.add(st.nextToken().trim());
        }
        totalProducts =productNames.size();
    }
     
    public List<String> getData(String guess) {
        String product = null;
        guess = guess.toLowerCase();        
        List<String> matched = new ArrayList<String>();
        for(int i=0; i<totalProducts; i++) {
            product = productNames.get(i).toLowerCase();
            if(product.startsWith(guess)) {
                matched.add(productNames.get(i));
            }
        }
        return matched;
    }
}
