<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% String user =(String) request.getSession().getAttribute("userName");
String shownUser =(String) request.getSession().getAttribute("shownUser");
if (user==null){
   RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/login.jsp"); //si el nombre de usuario vinculado en sesion es null, se pasa el control la página de login
    rs.forward(request, response);
}
else if(user.equals("javipe19@gmail.com") && shownUser==null){
	   RequestDispatcher rs = request.getServletContext().getRequestDispatcher("/choose.jsp"); 
	   rs.forward(request, response);
}
%>
<!--Header-part-->
<div id="header">
  <h1><a href="index.jsp">TFM Admin</a>TFM Admin</h1>
</div>
<!--close-Header-part--> 

<!--top-Header-menu-->
<div id="user-nav" class="navbar navbar-inverse">
<form name="logoutForm" id="logoutForm" method="post" action="Login">
  <ul class="nav">
    <li  class="dropdown" id="profile-messages" ><a title="" href="#" data-toggle="dropdown" data-target="#profile-messages" class="dropdown-toggle"><i class="icon icon-user"></i>  <span class="text"><%= user %></span><b class="caret"></b></a>
      <ul class="dropdown-menu">
        <li><a href="#"><i class="icon-user"></i> My Profile</a></li>
        <li class="divider"></li>
        <li><a href="#"><i class="icon-check"></i> My Tasks</a></li>
        <li class="divider"></li>
        <li><a href="Login?logout=true"><i class="icon-key"></i> Log Out</a></li>
      </ul>
    </li>
   	<li class=""><a title="" href="Login?logout=true"><i class="icon icon-share-alt"></i><span class="text">Logout</span></a></li>
  </ul>
</form>
</div>
<!--close-top-Header-menu-->
</body>
</html>