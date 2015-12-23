<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
	<meta charset="utf-8">
	<meta name="viewport"    content="width=device-width, initial-scale=1.0">
	<meta name="description" content="">
	<meta name="author"      content="Sergey Pozhilov (GetTemplate.com)">
	
	<title>Columbia Buy N Sell Signup</title>

	<link rel="shortcut icon" href="assets/images/gt_favicon.png">
	
	<link rel="stylesheet" media="screen" href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,700">
	<link rel="stylesheet" href="assets/css/bootstrap.min.css">
	<link rel="stylesheet" href="assets/css/font-awesome.min.css">

	<!-- Custom styles for our template -->
	<link rel="stylesheet" href="assets/css/bootstrap-theme.css" media="screen" >
	<link rel="stylesheet" href="assets/css/main.css">

	<!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!--[if lt IE 9]>
	<script src="assets/js/html5shiv.js"></script>
	<script src="assets/js/respond.min.js"></script>
	<![endif]-->
</head>

<body onload="test()">
<script>
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
			getCurrentUserInfo(response);
			
			//getCurrentUserInfo(response);
			//alert("logged in....");
			document.getElementById("signin").style.display='none';
			document.getElementById("signout").style.display='block';
			document.getElementById("sout").style.display='block';
			document.getElementById("sin").style.display='none';			
			document.getElementById("sbody").style.display='none';
		  } else {
			  //alert("logged out")
		document.getElementById("signin").style.display='block';
		document.getElementById("signout").style.display='none';
		document.getElementById("sout").style.display='none';
		document.getElementById("sin").style.display='block';			
		document.getElementById("sbody").style.display='block';
		  }
	});
	FB.Event.subscribe('auth.login',reloading);
	FB.Event.subscribe('auth.logout',reloading);
}
var reloading=function(response){
	location.reload();
}
function getCurrentUserInfo(){
	FB.api('/me?fields=first_name,last_name,email', function(userInfo) {
        document.getElementById("fname").value=userInfo.first_name;
        document.getElementById("lname").value=userInfo.last_name;
        
      });
}
function check(){
	//alert('hi');

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
					
					<li id="signin" style="display:none"><a class="btn" href="signin.jsp">SIGN IN</a></li>
					<li id="signout" style="display:none"><a class="btn" href="signin.jsp">SIGN OUT</a></li>
				
				</ul>
			</div><!--/.nav-collapse -->
		</div>
	</div> 
	<!-- /.navbar -->

	<header id="head" class="secondary"></header>

	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.jsp">Home</a></li>
			<li class="active">Registration</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">Registration</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<div class="panel panel-default">
						<div class="panel-body">
							<h3 class="thin text-center">Register a new account</h3>
							<div class="fb-login-button" data-max-rows="1" data-size="medium" data-show-faces="false" data-auto-logout-link="true"></div>
							<hr>

							<form id="form2" action="/RegisterServlet" method="post">
								<div class="top-margin">
									<label>First Name <span class="text-danger">*</span></label>
									<input id="fname" type="text" class="form-control" name="fname" required readonly>
								</div>
								<div class="top-margin">
									<label>Last Name <span class="text-danger">*</span></label>
									<input id="lname" type="text" class="form-control" name="lname" required readonly>
								</div>
								<div class="top-margin">
									<label>Email Address <span class="text-danger">*</span></label>
									<input type="text" class="form-control" name="email" required>
								</div>
								<div class="top-margin">
									<label>Address <span class="text-danger">*</span></label>
									<input type="text" class="form-control" name="address" required>
								</div>
								
								<div class="row top-margin">
									<div class="col-sm-6">
										<label>City <span class="text-danger">*</span></label>
										<input type="text" class="form-control" name="city" required>
									</div>
									<div class="col-sm-6">
										<label>Zip Code <span class="text-danger">*</span></label>
										<input type="text" class="form-control" name="zip" required>
									</div>
									<div class="col-sm-6">
										<label>Contact No <span class="text-danger">*</span></label>
										<input type="text" class="form-control" name="num" required>
									</div>
								</div>

								<hr>

								<div class="row">
									<div class="col-lg-8">
										<label class="checkbox">
											<input type="checkbox"> 
											I've read the <a href="page_terms.html">Terms and Conditions</a>
										</label>                        
									</div>
									<div class="col-lg-4 text-right">
										<button class="btn btn-action" type="submit">Register</button>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>	<!-- /container -->
	

	<footer id="footer" class="top-space">

		<div class="footer1">
			<div class="container">
				<div class="row">
					
					<div class="col-md-3 widget">
						<h3 class="widget-title">Contact</h3>
						<div class="widget-body">
							<p>+1-5678901234<br>
								<a href="mailto:#">columbia.buynsell@gmail.com</a><br>
								<br>
								Computer Science Department
							<br>	Columbia University
							</p>	
						</div>
					</div>

					<div class="col-md-3 widget">
						<h3 class="widget-title">Follow me</h3>
						<div class="widget-body">
							<p class="follow-me-icons">
								<a href=""><i class="fa fa-twitter fa-2"></i></a>
								<a href=""><i class="fa fa-dribbble fa-2"></i></a>
								<a href=""><i class="fa fa-github fa-2"></i></a>
								<a href=""><i class="fa fa-facebook fa-2"></i></a>
							</p>	
						</div>
					</div>

					<div class="col-md-6 widget">
						<h3 class="widget-title">Site Description</h3>
						<div class="widget-body">
							<p>This site shall help Columbia community to buy, sell and borrow from their peers</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
			</div>
		</div>

		<div class="footer2">
			<div class="container">
				<div class="row">
					
					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="simplenav">
								<a href="#">Home</a> | 
								<a href="about.html">About</a> |
								<a href="sidebar-right.html">Sidebar</a> |
								<a href="contact.html">Contact</a> |
								<b><a href="signup.html">Sign in</a></b>
							</p>
						</div>
					</div>

					<div class="col-md-6 widget">
						<div class="widget-body">
							<p class="text-right">
								
							</p>
						</div>
					</div>

				</div> <!-- /row of widgets -->
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