<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Columbia Buy n Sell</title>
</head>
<body>
		<jsp:include page="header.jsp" />
		<c:set var="pid" value="${requestScope.pid}"></c:set>
		<c:set var="name" value="${requestScope.name}"></c:set>
		<c:set var="des" value="${requestScope.des}"></c:set>
		<c:set var="image1" value="${requestScope.image1}"></c:set>
		<c:set var="prices" value="${requestScope.prices}"></c:set>
		<c:set var="pnames" value="${requestScope.pnames}"></c:set>
		<c:set var="category" value="${requestScope.category}"></c:set>
		<c:set var="address" value="${requestScope.address}"></c:set>
		<c:set var="emailid" value="${requestScope.emailid}"></c:set>
		<c:set var="phone" value="${requestScope.phone}"></c:set>
		<c:set var="fname" value="${requestScope.fname}"></c:set>
		<c:set var="lname" value="${requestScope.lname}"></c:set>
		<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.jsp">Home</a></li>
			<li class="active">Your Account</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title"><c:out value="${name}"></c:out></h1>
				</header>
				<h3 class="thin text-center">Address: <c:out value="${address}"></c:out></h3>
				<h3 class="thin text-center">Contact Number: <c:out value="${phone}"></c:out></h3>
				
				<!-- <h3 class="thin text-center"></h3>
				 --><hr>
				<div class="w3-responsive">
				<table class="w3-table w3-bordered w3-striped" >
					<c:forEach items="${des}" varStatus="i">
					<c:set var="urltext" value="/ProductServlet?pid=${pid[i.index]}"></c:set>
						<tr> 
						<td style="float:left; width:35%; font-family:Open sans, Helvetica, Arial; font-size: 15px;">
						<a href="${urltext}">
						<img src="<c:out value="${image1[i.index]}"></c:out>" alt="" style="width:100%">
						</a>
						<br>
						</td>
						<td style="float:right; width:55%; font-family:Open sans, Helvetica, Arial; font-size: 15px;">
						<br>
						<a href="${urltext}" style="color:black; text-decoration:none;">
						Product name:<c:out value="${pnames[i.index]}"></c:out><br>
						</a>
						Product description:<c:out value="${des[i.index]}"></c:out><br>
						Price:<c:out value="${prices[i.index]}"></c:out><br>
						Category:<c:out value="${category[i.index]}"></c:out><br>
						</td>
						<td>
						<c:set var="urltext2" value="/AccountServlet?fname=${fname}&lname=${lname}&statid=${pid[i.index]}"></c:set>
						<%-- <form action="${urltext2}">
						<input type="submit" id="status" value="Set as Sold" >
						</form>
						 --%>
						 <input type="button" id="status" value="Set as Sold" onClick="location.href='${urltext2}'" >
						 <%-- <a href="${urltext2}">Set as Sold</a> --%>
						 </td>
		
						</tr>
					</c:forEach>
	
				</table>
		</div>				
		</article>
		<!-- /Article -->
		</div>
	</div>	<!-- /container -->
		<div class="container text-center" id="container">
		
		
	</div>
	
	<jsp:include page="footer.jsp" />
		
		

</body>
</html>