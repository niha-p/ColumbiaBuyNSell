package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import helperClasses.DatabaseQuery;
import helperClasses.DbCon;

/**
 * Servlet implementation class ProductServlet
 */
@WebServlet("/ProductServlet")
public class ProductServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String user="root";
	static String password="";   
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProductServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		
		
		//******************Change "sb" to name tag of the hyperlink(product name) on productpage.jsp!!
		
		String t=(String) request.getParameter("pid");
		//System.out.println(t);
		int pid=Integer.parseInt(t);
		//String q2="SELECT * FROM product WHERE `description` LIKE %"+t+"%";
		
		//Getting product "t"
		
		//*********************Get product by id Not name!!
        String query="SELECT * FROM product WHERE `product_id`="+pid+"";// OR `description` LIKE %"+t+"%";
		DbCon d= new DbCon();
		d=DatabaseQuery.getResultSet(query);
        ResultSet rs=d.getRst();
        Connection ctn=d.getCntcn();
		String pname="",desc="",img1="",img2="",img3="";
		Double price=0.0,latitude=0.0,longitude=0.0;
		int status=0,user_id=0;
		try {
			while(rs.next()){
				pname=rs.getString("product_name");
				desc=rs.getString("description");
				img1=rs.getString("image1");
				img2=rs.getString("image2");
				img3=rs.getString("image3");
				
				status=rs.getInt("status");
				price=rs.getDouble("price");
				latitude=rs.getDouble("latitude");
				longitude=rs.getDouble("longitude");
				user_id=rs.getInt("user_id");
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			rs.close();
			ctn.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		
		
		String uname="",address="",city="";
		int zip=0;
		long phone=0;
		
		
		System.out.println("user id:"+user_id);
		String query1="SELECT * FROM `user` WHERE `user_id`="+user_id+"";//"SELECT `name` FROM user WHERE `user_id`="+user_id+";// OR `description` LIKE %"+t+"%";
		d=DatabaseQuery.getResultSet(query1);
		ResultSet rs1=d.getRst();
		ctn=d.getCntcn();
		try {
			while(rs1.next())
			{
				uname=rs1.getString("name");
				address=rs1.getString("address");
				city=rs1.getString("city");
				zip=rs1.getInt("zip");
				phone=rs1.getLong("phone_no");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			rs1.close();
			ctn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		request.setAttribute("pname",pname);
		request.setAttribute("desc",desc);
		request.setAttribute("img1",img1);
		request.setAttribute("img2",img2);
		request.setAttribute("img3",img3);
		request.setAttribute("address",address);
		request.setAttribute("status",status);
		request.setAttribute("price",price);
		request.setAttribute("latitude",latitude);
		request.setAttribute("longitude",longitude);
		request.setAttribute("uname",uname);
		request.setAttribute("address",address);
		request.setAttribute("city",city);
		request.setAttribute("zip",zip);
		request.setAttribute("phone",phone);
		
		request.getRequestDispatcher("ProductPage.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
