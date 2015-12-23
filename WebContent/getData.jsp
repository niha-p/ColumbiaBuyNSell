<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="helperClasses.DatabaseCall"%>
<%
    DatabaseCall db = new DatabaseCall();
 
    String query = request.getParameter("q");
     
    List<String> productNames = db.getData(query);
 
    Iterator<String> iterator = productNames.iterator();
    while(iterator.hasNext()) {
        String product = (String)iterator.next();
        out.println(product);
    }
%>