<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Sergey Pozhilov (GetTemplate.com)">

<title>Columbia - Buy n Sell</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
<script src="assets/js/jquery.autocomplete.js"></script>
<link rel="shortcut icon" href="assets/images/cbs_logo.png">

<link rel="stylesheet" media="screen"
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/font-awesome.min.css">
<link rel="stylesheet" type="text/css"
	href="assets/css/jquery.autocomplete.css" />

<!-- Custom styles for our template -->
<link rel="stylesheet" href="assets/css/bootstrap-theme.css"
	media="screen">
<link rel="stylesheet" href="assets/css/main.css">

<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!--[if lt IE 9]>
	
	<script src="assets/js/html5shiv.js"></script>
	<script src="assets/js/respond.min.js"></script>
    
	
	<![endif]-->
</head>
<body onload="test()">

	<script>
		var fn;
		var ln;
		var urltext2;
		var fn2;
		var ln2;
		var urltext3;
		window.fbAsyncInit = function() {
			FB.init({
				appId : '',
				cookie : true,
				status : true,
				xfbml : true,
				version : 'v2.5'
			});
		};
		(function(d, s, id) {
			var js, fjs = d.getElementsByTagName(s)[0];
			if (d.getElementById(id))
				return;
			js = d.createElement(s);
			js.id = id;
			js.src = "//connect.facebook.net/en_US/sdk.js";
			fjs.parentNode.insertBefore(js, fjs);
		}(document, 'script', 'facebook-jssdk'));
		function test() {
			//alert("In test");
			fbAsyncInit();
			FB.getLoginStatus(function(response) {
				//alert("in fb");
				if (response.status === 'connected') {
					//  alert("logged in....");
					getCurrentUserInfo(response);
					document.getElementById("signin").style.display = 'none';
					document.getElementById("signout").style.display = 'block';
					document.getElementById("myacc").style.display = 'block';

				} else {
					document.getElementById("signin").style.display = 'block';
					document.getElementById("signout").style.display = 'none';
					document.getElementById("myacc").style.display = 'none';
				}
			});
		}
		function getCurrentUserInfo() {

			FB.api('/me?fields=first_name,last_name,email', function(userInfo) {
				//alert(userInfo.first_name);
				fn = userInfo.first_name;
				ln = userInfo.last_name;
				urltext2 = "/AccountServlet?fname=" + fn
						+ "&lname=" + ln;

				document.getElementById("fname").value = userInfo.first_name;
				document.getElementById("lname").value = userInfo.last_name;
			});
		}
		acc = function() {
			location.href = urltext2;
		}

		function check() {
			//alert('hi');

			fbAsyncInit();

			FB.getLoginStatus(function(response) {

				FB.api('/me?fields=first_name,last_name,email', function(
						userInfo) {
					//alert(userInfo.first_name);
					fn2 = userInfo.first_name;
					ln2 = userInfo.last_name;
					urltext3 = "/CheckUserServlet?fname=" + fn2
							+ "&lname=" + ln2;
					location.href = urltext3;
				});
			});
		}
	</script>
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom">
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="index.jsp"><img
					src="assets/images/cbs_logo.png" alt="Progressus HTML5 template"></a>
			</div>
			<div class="navbar-collapse collapse">
				<ul class="nav navbar-nav pull-right">
					<li class="active"><a href="index.jsp">Home</a></li>
					<li><a href="#" onclick="check()">Post an Ad</a></li>
					
					<li id="myacc" style="display: none"><a
						href="javascript:acc()">My Account</a></li>
					<li id="signin" style="display: none"><a class="btn"
						href="signin.jsp">SIGN IN</a></li>
					<li id="signout" style="display: none"><a class="btn"
						href="signin.jsp">SIGN OUT</a></li>
				</ul>
			</div>
			<!--/.nav-collapse -->
		</div>
	</div>
	<!-- /.navbar -->

	<!-- Header -->
	<header id="head">
	<div class="container">
		<form id="form1" action="/SearchServlet" method="post">
			<div class="row">
				<h1 class="lead">BUY, BORROW, SELL</h1>
				<p class="tagline">Marketplace for the Columbia community</p>
				<p>
					<select class="btn btn-action" name="category"
						style="background-color: #f2f2f2; width: 150px; color: black; padding-left: 10px; padding-right: 10px;">
						<option value="all" selected="selected">All</option>
						<option value="Bedding">Bedding</option>
						<option value="Kitchenware">Kitchen Ware</option>
						<option value="Furniture">Furniture</option>
						<option value="Applicances">Appliances</option>
						<option value="Apparel">Apparels</option>
					</select> <input class="search_cbs ac_input" id="searchbox" name="sb"
						type="text" placeholder="Search..." 
						style="height: 34px; border-bottom-width: 0px; border-top-width: 2px; padding-bottom: 0px; padding-top: 4px; margin-bottom: 10px;">
					<script>
						$("#searchbox").autocomplete("getData.jsp");
					</script>
					<input class="btn btn-action btn-cbs" type="submit" value="Search"
						style="color: black">

				</p>
			</div>
			<div class="row">
				<input type="checkbox" id="loc" name="loc" value="loc"
					onchange="displayAddressBox()"
					style="color: orange; font-size: 50px; width: 20px; height: 20px"><font
					style="color: white; font-size: 20px; width: 20px; height: 20px; font-weight: bold">Filter
					by location</font>
			</div>
			<div class="row" id="address_filter" style="display: none">
				<input id="autocomplete" type="text" name="address"
					placeholder="Enter address:">
				<div id="listing">
					<table id="resultsTable">
						<tbody id="results"></tbody>
					</table>
				</div>
			</div>
		</form>
	</div>
	</header>

</body>
<script>
	function displayAddressBox() {
		var x = document.getElementById('loc').checked;
		if (x == true) {
			document.getElementById('address_filter').style.display = 'block';
		} else {
			document.getElementById('address_filter').style.display = 'none';
		}
	}
</script>

<script type="text/javascript">
	//This example uses the autocomplete feature of the Google Places API.
	//It allows the user to find all hotels in a given place, within a given
	//country. It then displays markers for all the hotels returned,
	//with on-click details for each hotel.

	var places, infoWindow;
	var autocomplete;
	var countryRestrict = {
		'country' : 'us'
	};
	var hostnameRegexp = new RegExp('^https?://.+?/');

	var countries = {
		'us' : {
			center : {
				lat : 37.1,
				lng : -95.7
			},
			zoom : 3
		}
	};

	function initMap() {

		// Create the autocomplete object and associate it with the UI input control.
		// Restrict the search to the default country, and to place type "cities".
		autocomplete = new google.maps.places.Autocomplete(
		/** @type {!HTMLInputElement} */
		(document.getElementById('autocomplete')), {

			componentRestrictions : countryRestrict
		});
		// places = new google.maps.places.PlacesService(map);

		autocomplete.addListener('place_changed', onPlaceChanged);
	}

	//When the user selects a city, get the place details for the city and
	//zoom the map in on the city.
	function onPlaceChanged() {
		var place = autocomplete.getPlace();
	}

	function addResult(result, i) {
		var results = document.getElementById('results');
		var markerLetter = String.fromCharCode('A'.charCodeAt(0) + i);
		var markerIcon = MARKER_PATH + markerLetter + '.png';

		var tr = document.createElement('tr');
		tr.style.backgroundColor = (i % 2 === 0 ? '#F0F0F0' : '#FFFFFF');
		/*
		 tr.onclick = function() {
		 google.maps.event.trigger(markers[i], 'click');
		 };
		 */

		var iconTd = document.createElement('td');
		var nameTd = document.createElement('td');
		var icon = document.createElement('img');
		icon.src = markerIcon;
		icon.setAttribute('class', 'placeIcon');
		icon.setAttribute('className', 'placeIcon');
		var name = document.createTextNode(result.name);
		iconTd.appendChild(icon);
		nameTd.appendChild(name);
		tr.appendChild(iconTd);
		tr.appendChild(nameTd);
		results.appendChild(tr);
	}

	function clearResults() {
		var results = document.getElementById('results');
		while (results.childNodes[0]) {
			results.removeChild(results.childNodes[0]);
		}
	}
</script>
</script>
<script
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBjRk7V9Qa63ZYdKeqsCjssj4NMtognDqw&signed_in=true&libraries=places&callback=initMap"
	async defer></script>
</html>