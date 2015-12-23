package helperClasses;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DatabaseQuery {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}
	public static DbCon updateTable(String query)
	{
		String user="";//"root";
		String password="";//"";
		DbCon d=new DbCon();
		Connection con=null;
		ResultSet rs=null;
		try{
		Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql:///cloudproject",user,password);
        Statement stmt = con.createStatement();
        //System.out.println("Created DB Connection....");
			stmt.executeUpdate(query);
			//con.close();
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		d.rst=rs;
		d.cntcn=con;
		return d;
		
	}
	public static DbCon getResultSet(String query)
	{
		DbCon d=new DbCon();
		String user="";//"root";
		String password="";//"";
		Connection con=null;
		ResultSet rs=null;
		try{
			Class.forName("com.mysql.jdbc.Driver");
	         con = DriverManager.getConnection("jdbc:mysql:///cloudproject",user,password);
			Statement stmt = con.createStatement();
	        //System.out.println("Created DB Connection....");
				rs=stmt.executeQuery(query);
				//con.close();
			}catch(Exception e)
			{
				e.printStackTrace();
			}
		d.rst=rs;
		d.cntcn=con;
		return d;
	}

}
