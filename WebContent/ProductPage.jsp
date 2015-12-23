<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<script>
window.location.hash = '#container';</script>
	<title>Columbia Buy n Sell</title>
</head>

<body>
	<jsp:include page="header.jsp" />

	<!-- <header id="head" class="secondary"></header> -->

	<!-- container -->

	<div class="container" id="container" style="padding-top:20px">
		
		<ol class="breadcrumb">
			<li><a href="index.html">Home</a></li>
			
		</ol>

		<div class="row">
			<c:set var="img1" value="${requestScope.img1}"></c:set>
			<c:set var="img2" value="${requestScope.img2}"></c:set>
			<c:set var="img3" value="${requestScope.img3}"></c:set>
			<!-- Sidebar -->
			<aside class="col-md-4 sidebar sidebar-left">

				
				<div class="row widget">
					<div class="col-xs-12">
					
						<p><img src="<c:out value="${img1}"/>" alt=""></p>
					</div>
				</div>
				<div class="row widget">
					<div class="col-xs-12">
					
						<p><img src="<c:out value="${img2}"/>" alt=""></p>
					</div>
				</div>
				<div class="row widget">
					<div class="col-xs-12">
					
						<p><img src="<c:out value="${img3}"/>" alt=""></p>
					</div>
				</div>
			</aside>
			<!-- /Sidebar -->


			<c:set var="pname" value="${requestScope.pname}"></c:set>
			<c:set var="desc" value="${requestScope.desc}"></c:set>
			<c:set var="price" value="${requestScope.price}"></c:set>
			<c:set var="status" value="${requestScope.status}"></c:set>
			<c:set var="address" value="${requestScope.address}"></c:set>
			<c:set var="latitude" value="${requestScope.pname}"></c:set>
			<c:set var="longitude" value="${requestScope.pname}"></c:set>
			<c:set var="uname" value="${requestScope.uname}"></c:set>
			<c:set var="address" value="${requestScope.address}"></c:set>
			<c:set var="city" value="${requestScope.city}"></c:set>
			<c:set var="zip" value="${requestScope.zip}"></c:set>
			<c:set var="phone" value="${requestScope.phone}"></c:set>
			
			
			<!-- Article main content -->
			<article class="col-md-8 maincontent">
				<header class="page-header">
					<h1 class="page-title"><c:out value="${pname}"></c:out></h1>
				</header>
				
				<!-- ********************Include reference to seller profile page rather than static text -->


				<p>
					<c:out value="${desc}"></c:out>
				</p>
				<h2>
					$
					<c:out value="${price}"></c:out>
				</h2>
				<blockquote>
					<b>SELLER:</b><br>
					<c:out value="${uname}"></c:out>
					<br> <input type="hidden" id="address"
						value="<c:out value="${address}"></c:out>,<c:out value="${city}"></c:out>,<c:out value="${zip}"></c:out>">
					<c:out value="${address}"></c:out>
					,
					<c:out value="${city}"></c:out>
					,
					<c:out value="${zip}"></c:out>
					<br>PHONE:
					<c:out value="${phone}"></c:out>
					</input>
				</blockquote>
				<!--<input type="textbox" id="address1" value="New York,US" style="display:none"/> -->
				<!-- ****************To add map here using latitude and longitude -->


				<br>
				<div id="map" style="width: 100%; height: 500px; margin-bottom: 5%;"></div>


			</article>
			<!-- /Article -->

		</div>
	</div>
	<!-- /container -->


	<jsp:include page="footer.jsp" />


	<script src="https://maps.googleapis.com/maps/api/js?key=&signed_in=true&callback=initMap"
	        async defer></script>
	<script type="text/javascript">
		function initMap() {
			var map = new google.maps.Map(document.getElementById('map'), {
				zoom : 12,
				center : {
					lat : -34.397,
					lng : 150.644
				}
			});
			var geocoder = new google.maps.Geocoder();

			geocodeAddress(geocoder, map);

		}

		function geocodeAddress(geocoder, resultsMap) {
		  var address = document.getElementById('address').value;
		  geocoder.geocode({'address': address}, function(results, status) {
		    if (status === google.maps.GeocoderStatus.OK) {
		      resultsMap.setCenter(results[0].geometry.location);
		      var marker = new google.maps.Marker({
		        map: resultsMap,
		        position: results[0].geometry.location
		      });
		    } else {
		      alert('Geocode was not successful for the following reason: ' + status);
		    }
		  });
		}
		
	</script>
	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets/js/headroom.min.js"></script>
	<script src="assets/js/jQuery.headroom.min.js"></script>
	<script src="assets/js/template.js"></script>
</body>
</html>