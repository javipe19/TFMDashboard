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
<% String user =(String) request.getSession().getAttribute("userName");
		if(user!=null && user!=""){
	 	RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/index.jsp"); //si el nombre de usuario vinculado en sesion  no es null, se pasa el control la página de login
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
			</div>
			<div class="control-group">
				<div class="controls" align="center">
					<%String error = (String) request.getSession().getAttribute("errorMsg");
					String cont = (String) request.getSession().getAttribute("intento");
	
					if (error!=null && error!="") out.println(error);
					%>
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<div class="main_input_box">
						<span class="add-on bg_lg">
							<i class="icon-user"></i>
						</span>
						<input type="text" name="userName" placeholder="Username" required/>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<div class="main_input_box">
						<span class="add-on bg_ly">
							<i class="icon-lock"><br></i>
						</span>
						<input type="password" name="password" placeholder="Password" required/>
					</div>
				</div>
			</div>
			<div class="form-actions">
				<span class="pull-left"><a href="#"
					class="flip-link btn btn-info" id="to-recover">Sign Up</a></span> <span
					class="pull-right"><input type="submit" name="login" value="Login"
					class="btn btn-success" /></span>
			</div>
		</form>
		<form id="recoverform" class="form-vertical" method="post" action="Login">
			<p class="normal_text">Enter your Username and password</p>

			<div class="controls">
				<div class="main_input_box">
					<span class="add-on bg_lo">
						<i class="icon-user"></i>
					</span>
					<input type="text" name="signUpUser" placeholder="Username" required/>
				</div>
			</div>
			<div class="control-group">
				<div class="controls">
					<div class="main_input_box">
						<span class="add-on bg_ly">
							<i class="icon-lock"><br></i>
						</span>
						<input type="password" name="signUpPassword" placeholder="Password" required/>
					</div>
				</div>
			</div>

			<div class="form-actions">
				<span class="pull-left"><a href="#"
					class="flip-link btn btn-success" id="to-login">&laquo; Back to
						login</a></span> <span class="pull-right"><input type="submit" name="register" value="Send" class="btn btn-success"></span>
			</div>
		</form>
	</div>

	<script src="js/jquery.min.js"></script>
	<script src="js/matrix.login.js"></script>
</body>