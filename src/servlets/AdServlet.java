package servlets;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.FileItem;

import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.PutObjectResult;

import helperClasses.DatabaseQuery;
import helperClasses.DbCon;

/**
 * Servlet implementation class AdServlet
 */
@WebServlet("/AdServlet")
@MultipartConfig
public class AdServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String pname=request.getParameter("pname");
		String fname=request.getParameter("fname");
		String lname=request.getParameter("lname");
		double price=Double.parseDouble(request.getParameter("price"));
		String category=request.getParameter("category");
		String des=request.getParameter("des");
		
		String query="";
		String query1="";
		System.out.println(fname);
		String name=fname+" "+lname;
		query="SELECT COUNT(*) FROM product"; 
		DbCon d=new DbCon();
		Connection ctn;
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
		} catch (SQLException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
        
        String query3="SELECT * FROM `user` WHERE `name` LIKE '%"+fname+" "+lname+"%'";//"SELECT `name` FROM user WHERE `user_id`="+user_id+";// OR `description` LIKE %"+t+"%";
		d=DatabaseQuery.getResultSet(query3);
        ResultSet rs3=d.getRst();
        ctn=d.getCntcn();
		String user_id="";
		try {
			while(rs3.next())
			{
				user_id=rs3.getString("user_id");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			rs3.close();
			ctn.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
        
        number=number+1;        
		
		AWSCredentials credentials = new BasicAWSCredentials("","");
		AmazonS3 s3Client = new AmazonS3Client(credentials);
		String existingBucketName = "sdnt";
		String keyName = fname+lname+pname+number+"-1.jpg";
		
		String url2="";
		String url3="";
		
		Part filePart = request.getPart("img1"); 
	    String fileName = filePart.getSubmittedFileName();
	    InputStream fileContent = filePart.getInputStream();
	    String amazonFileUploadLocationOriginal=existingBucketName+"/";
	    ObjectMetadata objectMetadata = new ObjectMetadata();
	    PutObjectRequest putObjectRequest = new PutObjectRequest(amazonFileUploadLocationOriginal, keyName, fileContent, objectMetadata);
	    PutObjectResult result = s3Client.putObject(putObjectRequest);
	    s3Client.setObjectAcl(amazonFileUploadLocationOriginal, keyName, CannedAccessControlList.PublicRead);
	    //System.out.println("Etag:" + result.getETag() + "-->" + result);
	    String url1="https://s3.amazonaws.com///"+keyName;
	    
	    Part filePart2 = request.getPart("img2");
	    Part filePart3 = request.getPart("img3");
	    query1="INSERT INTO `cloudproject`.`product` (`product_id`, `user_id`, `product_name`, `description`, `category`, `price`, `status`, `image1`, `image2`, `image3`) VALUES ";
        query1+="('"+Integer.toString(number)+"', '"+user_id+"', '"+pname+"', '"+des+"', '"+category+"', '"+Double.toString(price)+"', '0', '"+url1+"', "; 
	    if(filePart2.getSize()==0){
	    	url2="NULL";
	    	query1+="NULL, ";
	    }
	    else{
	    	String keyName2 = fname+lname+pname+number+"-2.jpg";
			String fileName2 = filePart2.getSubmittedFileName();
		    InputStream fileContent2 = filePart2.getInputStream();
		    String amazonFileUploadLocationOriginal2=existingBucketName+"/";
		    ObjectMetadata objectMetadata2 = new ObjectMetadata();
		    PutObjectRequest putObjectRequest2 = new PutObjectRequest(amazonFileUploadLocationOriginal2, keyName2, fileContent2, objectMetadata2);
		    PutObjectResult result2 = s3Client.putObject(putObjectRequest2);
		    s3Client.setObjectAcl(amazonFileUploadLocationOriginal2, keyName2, CannedAccessControlList.PublicRead);
		    //System.out.println("Etag:" + result.getETag() + "-->" + result);
		    url2="https://s3.amazonaws.com///"+keyName2;
		    query1+="'"+url2+"', ";
	    }
	    String t3=request.getParameter("img3");
	    if(filePart3.getSize()==0){
	    	url3="NULL";
	    	query1+="NULL";
	    }
	    else{
	    	String keyName3 = fname+lname+pname+number+"-3.jpg";
			String fileName3 = filePart3.getSubmittedFileName();
		    InputStream fileContent3 = filePart3.getInputStream();
		    String amazonFileUploadLocationOriginal3=existingBucketName+"/";
		    ObjectMetadata objectMetadata3 = new ObjectMetadata();
		    PutObjectRequest putObjectRequest3 = new PutObjectRequest(amazonFileUploadLocationOriginal3, keyName3, fileContent3, objectMetadata3);
		    PutObjectResult result3 = s3Client.putObject(putObjectRequest3);
		    s3Client.setObjectAcl(amazonFileUploadLocationOriginal3, keyName3, CannedAccessControlList.PublicRead);
		    //System.out.println("Etag:" + result.getETag() + "-->" + result);
		    url3="https://s3.amazonaws.com///"+keyName3;
		    query1+="'"+url3+"'";
	    }
	    
	    
	    query1+=")";
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
