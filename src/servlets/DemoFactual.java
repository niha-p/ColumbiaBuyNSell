package servlets;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.factual.driver.Factual;
import com.factual.driver.Query;
import com.factual.driver.ReadResponse;

/**
 * Servlet implementation class DemoFactual
 */
@WebServlet("/DemoFactual")
public class DemoFactual extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DemoFactual() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		
		String name = null;
		PrintWriter out = response.getWriter();
		if(request.getParameter("pname") != null) {
			name = request.getParameter("pname");
		}
                else {
                       name = "";
                }
		String ans=getSuggestedPrice(name)+"";
  	        out.println(ans);
	}
	
	public double getSuggestedPrice(String pname){
		Factual factual = new Factual("",
				"");
		Query query = new Query().search(pname).field("avg_price").notBlank();//.limit(20);
		ReadResponse resp = factual.fetch("products-cpg", query);
		float sum = 0;
		int count = 0;
		String st = resp.getData().toString();
		System.out.println(st);
		for (int i = -1; (i = st.indexOf("avg_price", i + 1)) != -1;) {
			// System.out.println(i);
			int k = st.indexOf(',', i);
			sum = sum + Float.parseFloat(st.substring(i + 10, k));
			count++;

		}
		double price=(sum/count)*0.6;
		double finalprice= Math.round(price * 100.0) / 100.0;
		System.out.println(finalprice);
		return finalprice;
		
	}

}
