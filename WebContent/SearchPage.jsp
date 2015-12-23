<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script>
window.location.hash = '#container';</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Columbia Buy n Sell</title>
</head>
<body>
	<jsp:include page="header.jsp" />
	<c:set var="search_text" value="${requestScope.search}"></c:set>
	<c:set var="sb" value="${requestScope.sb}"></c:set>
	<c:set var="category" value="${requestScope.category}"></c:set>
	<c:set var="pid" value="${requestScope.pid}"></c:set>
	<c:set var="names" value="${requestScope.names}"></c:set>
	<c:set var="descriptions" value="${requestScope.descriptions}"></c:set>
	<c:set var="image1" value="${requestScope.image1}"></c:set>
	<c:set var="prices" value="${requestScope.prices}"></c:set>
	<c:set var="distances" value="${requestScope.distances}"></c:set>

	<form name="qMain" action="/SearchServlet" method="post">
		<div class="container text-center" id="container">
			<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.jsp">Home</a></li>
			<li class="active">Search Results</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">Results</h1>
					</header>
					<h3 class="thin text-center">
					<c:if test="${empty search_text}">
						Showing ${requestScope.number} results
					</c:if>
					<c:if test="${not empty search_text}">
						Showing ${requestScope.number} results for "${search_text}"
					</c:if>
					</h3>
					<select id="sortingOption" name="sortingOption"
						onchange="changeFunc(this.form);">
						<option value="0">SORTING OPTIONS</option>
						<option value="1">PRICE (Low to High)</option>
						<option value="2">PRICE (High to Low)</option>
					</select> <!-- <h3 class="thin text-center"></h3>
				 -->
					<hr>

					<div class="w3-responsive">
						<table class="w3-table w3-bordered w3-striped"
							style="margin-bottom: 5px">
							<tr>
								<td
									style="font-family: Open sans, Helvetica, Arial; font-size: 15px;">
								</td>
							</tr>
							<input type="text" id="sb" name="sb" style="display: none;">
							<input type="text" id="category" name="category"
								style="display: none;">
							<c:forEach items="${names}" varStatus="i">
								<c:set var="urltext"
									value="/ProductServlet?pid=${pid[i.index]}"></c:set>
								<tr>

									<td valign="middle"
										style="width: 25%; font-family: Open sans, Helvetica, Arial; font-size: 15px;">
										<div>
											<a href="${urltext}"> <img
												src="<c:out value="${image1[i.index]}"></c:out>" alt=""
												style="width: 100%;">
											</a>
										</div> <br>

									</td>
									<td valign="top"
										style="width: 70%; font-family: Open sans, Helvetica, Arial; font-size: 15px;">
										<br> <b><a href="${urltext}"
											style="color: black; text-decoration: none;"> <c:out
													value="${names[i.index]}"></c:out><br>
										</a></b> <c:out value="${descriptions[i.index]}"></c:out><br>
										Price:<c:out value="${prices[i.index]}"></c:out><br>
									</td>


									<td valign="top" height="200px"
										style="width: 5%; font-family: Open sans, Helvetica, Arial; font-size: 15px;">
										<br> <c:if test="${distances[i.index]!=0}">
											<c:out value="${distances[i.index]}"></c:out>km
		</c:if>

									</td>
								</tr>

							</c:forEach>

						</table>

					</div>
					</article>
					<!-- /Article -->
				</div>
			</div>
			<!-- /container -->
		</div>
	</form>

	<script type="text/javascript">
		function changeFunc(fm) {

			var input = document.getElementById('sb');
			var input2 = document.getElementById('category');

			input.value = "${sb}";
			input2.value = "${category}";

			var selectBox = document.getElementById("sortingOption");
			var selectedValue = selectBox.options[selectBox.selectedIndex].value;

			fm.submit();
		}
	</script>
	<jsp:include page="footer.jsp" />

</body>
</html>