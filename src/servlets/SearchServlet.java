package servlets;

import helperClasses.DatabaseQuery;
import helperClasses.DbCon;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;



import java.net.*;
/**
 * Servlet implementation class SearchServlet
 */
@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static String user="root";
	static String password=""; 
	String[] names;
	double[] prices;
	String[] descriptions;
	String[] image1;
	int[] product_id;
	int[]userid;
	String[] addr;
	double[] distances;
	int number;
	
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		//Search Box Result
		String t=(String) request.getParameter("sb");
		System.out.println(t);
		//Category
		String c=(String) request.getParameter("category");
		System.out.println(c);
		
		//PRICE SORTING!!
		String sortOption=(String) request.getParameter("sortingOption");
		System.out.println(sortOption);
		
		
		//String q2="SELECT * FROM product WHERE `description` LIKE %"+t+"%";
		String query="";
		String query1="";
		if(t!=null)
		{
			if(c.equals("all"))
			{
				query="SELECT COUNT(*) FROM product WHERE (`product_name` LIKE '%"+t+"%' OR `description` LIKE '%"+t+"%') AND status=0";
				query1="SELECT * FROM product WHERE (`product_name` LIKE '%"+t+"%' OR `description` LIKE '%"+t+"%') AND status=0";
			}
			else
			{
				query="SELECT COUNT(*) FROM product WHERE (`product_name` LIKE '%"+t+"%' OR `description` LIKE '%"+t+"%') AND status=0 AND `category` LIKE '%"+c+"%'" ;
				query1="SELECT * FROM product WHERE (`product_name` LIKE '%"+t+"%' OR `description` LIKE '%"+t+"%') AND status=0 AND `category` LIKE '%"+c+"%'" ;
			}
		}
		System.out.println("QUERY="+query);
		//String query="SELECT COUNT(*) FROM product WHERE (`product_name` LIKE '%"+t+"%' OR `description` LIKE '%"+t+"%') AND status=0";
		DbCon d= new DbCon();
		d=DatabaseQuery.getResultSet(query);
		ResultSet rs2=d.getRst();
		Connection ctn=d.getCntcn();
        number=0;
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
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        //query="SELECT * FROM product WHERE (`product_name` LIKE '%"+t+"%' OR `description` LIKE '%"+t+"%') AND status=0";
		d=DatabaseQuery.getResultSet(query1);
        ResultSet rs=d.getRst();
        ctn=d.getCntcn();
		names=new String[number];
		prices=new double[number];
		descriptions=new String[number];
		image1=new String[number];
		product_id=new int[number];
		userid=new int[number];
		addr=new String[number];
		int i=0;
		try {
			while(rs.next()){
				product_id[i]=rs.getInt("product_id");
				names[i]=rs.getString("product_name");
				prices[i]=rs.getDouble("price");
				descriptions[i]=rs.getString("description");
				image1[i]=rs.getString("image1");
				userid[i]=rs.getInt("user_id");
				i++;
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
		
		ResultSet rs3=null;
		try{
			
		for(int j=0; j<number; j++)
		{
		String query3="SELECT * FROM `user` WHERE `user_id`="+userid[j]+"";
		d=DatabaseQuery.getResultSet(query3);
		rs3=d.getRst();
		ctn=d.getCntcn();
		while(rs3.next()){
			addr[j]=rs3.getString("address").replaceAll("\\s+","")+""+rs3.getString("city").replaceAll("\\s+","")+"|"+rs3.getInt("zip");
			
		}
		try {
			rs3.close();
			ctn.close();
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		}
		}catch(SQLException e)
		{
			e.printStackTrace();
		}
		
		
		

		//FINDING DISTANCE!!
		distances=new double[number]; 
		// Reference - https://developers.google.com/maps/documentation/distancematrix/
		try{
		String[] urls=new String[number];
		//Address Filter
		String address=(String) request.getParameter("address");
		address=address.replaceAll("\\s+", "");
		address=address.replaceAll(",","|");
		System.out.println(address);
		
		if(address!=null)
			
		{
		for(int k=0; k<number;k++)
		{
			
		 urls[k]="https://maps.googleapis.com/maps/api/distancematrix/json?origins="+address+"&destinations="+addr[k]+"&key=AIzaSyBjRk7V9Qa63ZYdKeqsCjssj4NMtognDqw";
		  //URL url = new URL("https://maps.googleapis.com/maps/api/distancematrix/json?origins=Vancouver+BC|Seattle&destinations=San+Francisco|Victoria+BC&key=AIzaSyBjRk7V9Qa63ZYdKeqsCjssj4NMtognDqw");
	     URL url=new URL(urls[k]); 
		 HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	      conn.setRequestMethod("GET");
	      String line, outputString = "";
	      BufferedReader reader = new BufferedReader(
	      new InputStreamReader(conn.getInputStream()));
	      while ((line = reader.readLine()) != null) {
	          outputString += line;
	      }
	      System.out.println(outputString);
	      
	      
	      JSONObject jsonRespRouteDistance = new JSONObject(outputString)
	                .getJSONArray("rows")
	                .getJSONObject(0)
	                .getJSONArray ("elements")
	                .getJSONObject(0)
	                .getJSONObject("distance");

			String distance = jsonRespRouteDistance.get("text").toString();
			System.out.println(distance);
			distances[k]=Double.parseDouble(distance.substring(0,distance.indexOf(" ")));

	      
	     
		}
		sorting(1);
		
		}
	     
		
				
		}catch(Exception e){e.printStackTrace();}
		if(sortOption!=null)
		{
		if(sortOption.equals("1"))
		{
			sorting(2);
		}
		else if (sortOption.equals("2"))
		{
			sorting(3);
		}
		}
		
		
		
		/*************/
		
		
		
		
		
		request.setAttribute("search", t);
		request.setAttribute("pid", product_id);
		request.setAttribute("names",names);
		request.setAttribute("prices",prices);
		request.setAttribute("descriptions",descriptions);
		request.setAttribute("image1",image1);
		request.setAttribute("number",number);
		request.setAttribute("sb",t);
		request.setAttribute("category",c);
		
		request.setAttribute("distances",distances);
		
		request.getRequestDispatcher("SearchPage.jsp").forward(request, response);

	}
	
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
	
	protected void sorting(int option)
	{
		//option=1 --> Sort by location distance
		//option=2 --> Sort by Price (Low to High)
		//option=3 --> Sort by Price (High to Low)
		double swapBy[]=new double[number];
		if (option==1)
		{
			swapBy=distances;
		}
		else if (option==2||option==3)
		{
			swapBy=prices;
		}
		for (int c1 = 0; c1 < ( number - 1 ); c1++) {
		      for (int d = 0; d < number - c1 - 1; d++) {
		    	  if(option!=3)
		    	  {
		        if (swapBy[d] > swapBy[d+1]) /* For descending order use < */
		        {
		          double dis=distances[d];
		          distances[d]=distances[d+1];
		          distances[d+1]=dis;
		          
		          int p=product_id[d];
		          product_id[d]=product_id[d+1];
		          product_id[d+1]=p;
		          
		          String nam=names[d];
		          names[d]=names[d+1];
		          names[d+1]=nam;
		          
		          double pric=prices[d];
		          prices[d]=prices[d+1];
		          prices[d+1]=pric;
		          
		          String desc=descriptions[d];
		          descriptions[d]=descriptions[d+1];
		          descriptions[d+1]=desc;
		          
		          String imag=image1[d];
		          image1[d]=image1[d+1];
		          image1[d+1]=imag;
		        	
		        }
		    	}
		    	  else
		    	  {
		    		  if (swapBy[d] < swapBy[d+1]) /* For descending order use < */
				        {
				          double dis=distances[d];
				          distances[d]=distances[d+1];
				          distances[d+1]=dis;
				          
				          int p=product_id[d];
				          product_id[d]=product_id[d+1];
				          product_id[d+1]=p;
				          
				          String nam=names[d];
				          names[d]=names[d+1];
				          names[d+1]=nam;
				          
				          double pric=prices[d];
				          prices[d]=prices[d+1];
				          prices[d+1]=pric;
				          
				          String desc=descriptions[d];
				          descriptions[d]=descriptions[d+1];
				          descriptions[d+1]=desc;
				          
				          String imag=image1[d];
				          image1[d]=image1[d+1];
				          image1[d+1]=imag;
				        	
				        }
		    	  }
		    	  
		      }
		    }
		
	}
}
