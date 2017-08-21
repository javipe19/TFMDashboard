<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>UC3M Learning Analytics Dashboard</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/matrix-login.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800'
	rel='stylesheet' type='text/css'>
<% String shownUser =(String) request.getSession().getAttribute("shownUser");
		if(shownUser!=null && shownUser!=""){
	 	RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/index.jsp"); //si el nombre de usuario vinculado en sesion  no es null, se pasa el control la p�gina de login
   		rs.forward(request, response);
		}
%>
</head>

<body>
	<div id="loginbox">
		<form id="loginform" class="form-vertical" name="frmLogin"
			method="post" action="Login">
			<div class="control-group normal_text">
				<h3>
					<img src="img/login_logo_final.png" alt="Logo" />
				</h3>
					<br>
				<h3>Admin, select the view:</h3>
				<div class="form-actions">
					<br>
					<input type="submit" name="general" value="General"class="btn btn-success" /> 
					<br>
					<br>
					<br>
					<input type="submit" name="user" value="User" class="btn btn-success" />
				</div>
			</div>
		</form>
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/matrix.login.js"></script>
</body>