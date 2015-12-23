<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta name="description" content="">
<meta name="author" content="Sergey Pozhilov (GetTemplate.com)">
<title>Columbia Buy N Sell Sign in</title>

<link rel="shortcut icon" href="assets/images/gt_favicon.png">

<link rel="stylesheet" media="screen"
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
<link rel="stylesheet" href="assets/css/bootstrap.min.css">
<link rel="stylesheet" href="assets/css/font-awesome.min.css">

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
window.fbAsyncInit = function() {
    FB.init({
      appId      : '',
      cookie	 : true,
      status	 : true,
      xfbml      : true,
      version    : 'v2.5'
    });
  };
(function(d, s, id) {
  var js, fjs = d.getElementsByTagName(s)[0];
  if (d.getElementById(id)) return;
  js = d.createElement(s); js.id = id;
  js.src = "//connect.facebook.net/en_US/sdk.js";
  fjs.parentNode.insertBefore(js, fjs);
}(document, 'script', 'facebook-jssdk'));
function test(){
	//alert("In test");
	fbAsyncInit();
	FB.getLoginStatus(function(response) {
		//alert("in fb");
		  if (response.status === 'connected') {
			  //alert("logged in....");
			  seturl(response);
			document.getElementById("signin").style.display='none';
			document.getElementById("signout").style.display='block';
			document.getElementById("sout").style.display='block';
			document.getElementById("sin").style.display='none';			
			document.getElementById("sbody").style.display='none';
			document.getElementById("myacc").style.display='block';
			

		  } else {
			  //alert("logged out")
		document.getElementById("signin").style.display='block';
		document.getElementById("signout").style.display='none';
		document.getElementById("sout").style.display='none';
		document.getElementById("sin").style.display='block';			
		document.getElementById("sbody").style.display='block';
		document.getElementById("myacc").style.display='none';
		}
	});
	FB.Event.subscribe('auth.login',reloading);
	FB.Event.subscribe('auth.logout',reloading);
}
var reloading=function(response){
	location.reload();
	
}
function seturl(){

	FB.api('/me?fields=first_name,last_name,email', function(userInfo) {
		
		fn=userInfo.first_name;
        ln=userInfo.last_name;
		urltext2="/AccountServlet?fname="+fn+"&lname="+ln;
	});
}
acc=function(){
	location.href=urltext2;
}

function check(){

	fbAsyncInit();
	
	FB.getLoginStatus(function(response) {
		
		FB.api('/me?fields=first_name,last_name,email', function(userInfo) {
			//alert(userInfo.first_name);
			fn2=userInfo.first_name;
	        ln2=userInfo.last_name;
			urltext3="/CheckUserServlet?fname="+fn2+"&lname="+ln2;
			location.href=urltext3;
	});
	});
}
</script>
	
	<!-- Fixed navbar -->
	<div class="navbar navbar-inverse navbar-fixed-top headroom" >
		<div class="container">
			<div class="navbar-header">
				<!-- Button for smallest screens -->
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse"><span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
				<a class="navbar-brand" href="index.jsp"><img src="assets/images/cbs_logo.png" alt="Progressus HTML5 template"></a>
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

	<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.jsp">Home</a></li>
			<li class="active">User access</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title" id="sin" style="display:none">Sign in</h1>
					<h1 class="page-title" id="sout" style="display:none">Sign out</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<div class="panel panel-default">
						<div class="panel-body" id="sbody" style="display:none">
							<h3 class="thin text-center">Sign in to your account</h3>
							<p class="text-center text-muted">If you are a new user, <a href="signup.jsp">Register</a></p>
							<hr>
						</div>
						<div class="fb-login-button" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="true"></div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>
	<!-- /container -->
	<br>
	<br>
	<br>
	<br>
	<br>
	<br>
<br>
	<footer id="footer" class="top-space">

	<div class="footer1">
		<div class="container">
			<div class="row">

				<div class="col-md-3 widget">
					<h3 class="widget-title">Contact</h3>
					<div class="widget-body">
						<p>
							+1-5678901234<br> <a href="mailto:#">columbia.buynsell@gmail.com</a><br>
							<br> Computer Science Department
							<br>	Columbia University
						</p>
					</div>
				</div>

				<div class="col-md-3 widget">
					<h3 class="widget-title">Follow me</h3>
					<div class="widget-body">
						<p class="follow-me-icons">
							<a href=""><i class="fa fa-twitter fa-2"></i></a> <a href=""><i
								class="fa fa-dribbble fa-2"></i></a> <a href=""><i
								class="fa fa-github fa-2"></i></a> <a href=""><i
								class="fa fa-facebook fa-2"></i></a>
						</p>
					</div>
				</div>

				<div class="col-md-6 widget">
					<h3 class="widget-title">Site Description</h3>
					<div class="widget-body">
						<p>This site shall help Columbia community to buy, sell and
							borrow from their peers</p>
					</div>
				</div>

			</div>
			<!-- /row of widgets -->
			<br>
		</div>
	</div>

	<div class="footer2">
		<div class="container">
			<div class="row">

				<div class="col-md-6 widget">
					<div class="widget-body">
						<p class="simplenav">
							<a href="#">Home</a> | <a href="about.html">About</a> | <a
								href="sidebar-right.html">Sidebar</a> | <a href="contact.html">Contact</a>
							| <b><a href="signup.html">Sign in</a></b>
						</p>
					</div>
				</div>



			</div>
			<!-- /row of widgets -->
		</div>
	</div>

	</footer>	



	<!-- JavaScript libs are placed at the end of the document so the pages load faster -->
	<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="http://netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	<script src="assets/js/headroom.min.js"></script>
	<script src="assets/js/jQuery.headroom.min.js"></script>
	<script src="assets/js/template.js"></script>
</body>
</html>