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
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		String address=request.getParameter("address");
		String email=request.getParameter("email");
		String city=request.getParameter("city");
		String zip=request.getParameter("zip");
		String num=request.getParameter("num");
		String query="";
		String query1="";
		System.out.println(fname);
		String name=fname+" "+lname;
		query="SELECT COUNT(*) FROM user"; 
		DbCon d= new DbCon();
		d=DatabaseQuery.getResultSet(query);
		ResultSet rs2=d.getRst();
		Connection ctn=d.getCntcn();
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
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		query1="INSERT INTO `cloudproject`.`user` (`user_id`, `login_id`, `name`, `address`, `city`, `zip`, `phone_no`) VALUES ";
        query1+="('"+Integer.toString(number+1)+"', '"+email+"', '"+name+"', '"+address+"', '"+city+"', '"+zip+"', '"+num+"')";
        query1+=";";
        System.out.println(query1);
        d=DatabaseQuery.updateTable(query1);
        ctn=d.getCntcn();
        try {
			ctn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        request.getRequestDispatcher("index.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
