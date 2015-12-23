<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>



<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Item</title>
</head>

<body>
	<script type="text/javascript">
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#blah').attr('src', e.target.result).width(150).height(
							200);
				};
				reader.readAsDataURL(input.files[0]);
				document.getElementById("blah").style.display = 'block';
			}
		}
		function readURL1(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#blah1').attr('src', e.target.result).width(150).height(
							200);
				};
				reader.readAsDataURL(input.files[0]);
				document.getElementById("blah1").style.display = 'block';
			}
		}
		function readURL2(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();
				reader.onload = function(e) {
					$('#blah2').attr('src', e.target.result).width(150).height(
							200);
				};
				reader.readAsDataURL(input.files[0]);
				document.getElementById("blah2").style.display = 'block';
			}
		}
	</script>
	<jsp:include page="header.jsp" />
	<!-- container -->
	<div class="container">

		<ol class="breadcrumb">
			<li><a href="index.jsp">Home</a></li>
			<li class="active">Post an ad</li>
		</ol>

		<div class="row">
			
			<!-- Article main content -->
			<article class="col-xs-12 maincontent">
				<header class="page-header">
					<h1 class="page-title">New item</h1>
				</header>
				
				<div class="col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">
					<div class="panel panel-default">
						<div class="panel-body">
							<h3 class="thin text-center">Post details of new item</h3>
							<hr>

							<form id="form2" action="/AdServlet" method="post" enctype="multipart/form-data">
								<div class="top-margin">
									<label>First Name <span class="text-danger">*</span></label>
									<input id="fname" type="text" class="form-control" name="fname" required readonly>
								</div>
								<div class="top-margin">
									<label>Last Name <span class="text-danger">*</span></label>
									<input id="lname" type="text" class="form-control" name="lname" required readonly>
								</div>
								
								<div class="top-margin">
									<label>Product Name <span class="text-danger">*</span></label>
									<input id="pname" type="text" class="form-control" name="pname" onblur="ajaxFunction();" required >
								</div>
								
								<div class="top-margin">
									<label>Description<span class="text-danger">*</span></label>
									<input id="des" type="text" class="form-control" name="des" required >
								</div>
								<div class="top-margin">
									<label>Price <span class="text-danger">*</span></label>
									<input type="text" class="form-control" name="price"  style="width:30%" required>
									<label>Suggested price:</label><input id="pricesug" type="text"  class="form-control" name="pricesug" style="width:30%" readonly>
								</div>
								<div class="top-margin">
								<label>Category <span class="text-danger">*</span></label>
								<select class="btn btn-action btn-cbs" name="category" style="background-color:#f2f2f2;width: 150px;color:black;padding-left: 10px;padding-right: 10px;" >
  									<option value="Bedding">Bedding</option>
  									<option value="Kitchenware">Kitchen Ware</option>
  									<option value="Furniture">Furniture</option>
  									<option value="Applicances">Appliances</option>
  									<option value="Apparel">Apparels</option>
								</select>
								</div>
								<div class="top-margin">
									<label>Image <span class="text-danger">*</span></label>
									<input type="file" class="form-control" name="img1" onchange="readURL(this);" required>
									<img id="blah" src="#" alt="your image" style="display:none"/>
								</div>
								<div class="top-margin">
									<label>Image 2 </label>
									<input type="file" class="form-control" name="img2" onchange="readURL1(this);" >
									<img id="blah1" src="#" alt="your image" style="display:none"/>
								</div>
								<div class="top-margin">
									<label>Image 3 </label>
									<input type="file" class="form-control" name="img3" onchange="readURL2(this);" >
									<img id="blah2" src="#" alt="your image" style="display:none"/>
								</div>

								<hr>
								<div class="row">
									<div class="col-lg-4 text-right">
										<button class="btn btn-action" type="submit">Publish Ad</button>
									</div>
								</div>
							</form>
						</div>
					</div>

				</div>
				
			</article>
			<!-- /Article -->

		</div>
	</div>
	<!-- /container -->
	<jsp:include page="footer.jsp" />
</body>


<script>

function getXMLObject()  //XML OBJECT
{
   var xmlHttp = false;
   try {
     xmlHttp = new ActiveXObject("Msxml2.XMLHTTP")  // For Old Microsoft Browsers
   }
   catch (e) {
     try {
       xmlHttp = new ActiveXObject("Microsoft.XMLHTTP")  // For Microsoft IE 6.0+
     }
     catch (e2) {
       xmlHttp = false   // No Browser accepts the XMLHTTP Object then false
     }
   }
   if (!xmlHttp && typeof XMLHttpRequest != 'undefined') {
     xmlHttp = new XMLHttpRequest();        //For Mozilla, Opera Browsers
   }
   return xmlHttp;  // Mandatory Statement returning the ajax object created
}

var xmlhttp = new getXMLObject();	//xmlhttp holds the ajax object

function ajaxFunction() {
  if(xmlhttp) {
  	var pname = document.getElementById("pname");
    xmlhttp.open("POST","/DemoFactual",true); //getname will be the servlet name
    xmlhttp.onreadystatechange  = handleServerResponse;
    xmlhttp.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
    xmlhttp.send("pname=" + pname.value); //Posting txtname to Servlet
  }
}

function handleServerResponse() {
   if (xmlhttp.readyState == 4) {
     if(xmlhttp.status == 200) {
    	 document.getElementById("pricesug").value=xmlhttp.responseText;
    	 //alert(xmlhttp.responseText);
       //document.myForm.message.innerHTML=xmlhttp.responseText; //Update the HTML Form element

    	    //var result = document.getElementById("txtname1"); 
    	    //result.innerHTML = xmlhttp.responseText; 
     }
     else {
        //alert("Error during AJAX call. Please try again");
     }
   }
}

</script>


</html>