package servlets;

import helperClasses.DatabaseQuery;
import helperClasses.DbCon;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AccountServlet
 */
@WebServlet("/AccountServlet")
public class AccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AccountServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String statid=request.getParameter("statid");
		System.out.println(statid);
		DbCon d=new DbCon();
		Connection ctn;
		if(statid!=null)
		{
			
			String query="UPDATE product SET `status`=1 WHERE `product_id`="+statid+";";
			System.out.println(query);
			d=DatabaseQuery.updateTable(query);
			ctn=d.getCntcn();
			try {
				ctn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		String name=fname+" "+lname;
		String query3="SELECT * FROM `user` WHERE `name` LIKE '%"+name+"%'";//"SELECT `name` FROM user WHERE `user_id`="+user_id+";// OR `description` LIKE %"+t+"%";
		d=DatabaseQuery.getResultSet(query3);
		ResultSet rs3=d.getRst();
		ctn=d.getCntcn();
		String user_id="";
		String address="";
		String emailid="";
		long phone=0;
		try {
			while(rs3.next())
			{
				user_id=rs3.getString("user_id");
				emailid=rs3.getString("login_id");
				address=rs3.getString("address")+", "+rs3.getString("city")+", "+rs3.getString("zip");
				phone=Long.parseLong(rs3.getString("phone_no"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			rs3.close();
			ctn.close();
		} catch (SQLException e3) {
			// TODO Auto-generated catch block
			e3.printStackTrace();
		}
		if(user_id.equals("")){
			request.getRequestDispatcher("signup.jsp").forward(request, response);;
		}else{
		String query="SELECT COUNT(*) FROM product WHERE `user_id`="+user_id+" AND `status`=0";
		d=DatabaseQuery.getResultSet(query);
		ResultSet rs2=d.getRst();
		ctn=d.getCntcn();
        int number=0;
        try {
			if(rs2.next()){
				number=rs2.getInt(1);
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        try {
			rs2.close();
			ctn.close();
		} catch (SQLException e2) {
			// TODO Auto-generated catch block
			e2.printStackTrace();
		}
        
        
        String pnames[]=new String[number];
        String des[]=new String[number];
        String category[]=new String[number];
        double prices[]=new double[number];
        String image1[]=new String[number];
        int pid[]=new int[number];
        
        String query2="SELECT * FROM product WHERE `user_id`="+user_id+" AND `status`=0";
        d=DatabaseQuery.getResultSet(query2);
        ResultSet rs=d.getRst();
        ctn=d.getCntcn();
        int count=0;
        try {
			while(rs.next()){
				pnames[count]=rs.getString("product_name");
				des[count]=rs.getString("description");
				category[count]=rs.getString("category");
				prices[count]=rs.getDouble("price");
				image1[count]=rs.getString("image1");
				pid[count]=rs.getInt("product_id");
				count++;
			}
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        try {
			rs.close();
			ctn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        request.setAttribute("pnames", pnames);
        request.setAttribute("des", des);
        request.setAttribute("category", category);
        request.setAttribute("prices", prices);
        request.setAttribute("image1", image1);
        request.setAttribute("pid", pid);
        request.setAttribute("name", name);
        request.setAttribute("fname", fname);
        request.setAttribute("lname", lname);
        request.setAttribute("emailid", emailid);
        request.setAttribute("phone", phone);
        request.setAttribute("address", address);
        request.getRequestDispatcher("myaccount.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
