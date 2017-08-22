<%@ page import= "java.util.ArrayList"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<title>General Data</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/uniform.css" />
<link rel="stylesheet" href="css/select2.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file="/header.jsp"%>
<!--sidebar-menu-->
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
  <ul>
    <li><a href="index.jsp"><i class="icon icon-home"></i> <span>Home</span></a> </li>
    <li class="active"> <a href="Controller?page=data"><i class="icon icon-th"></i> <span>General Data</span></a> </li>
    <li> <a href="Controller?page=act"><i class="icon icon-signal"></i> <span>Activities & Frequency</span></a> </li>
    <li><a href="Controller?page=time"><i class="icon icon-time"></i> <span>Pages & Time</span></a></li>
  </ul>
</div>
<!--sidebar-menu-->
<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">General Data</a> </div>
    <h1>General Data</h1>
    <h1>User: <%=shownUser%></h1>
  </div>
  <div class="container-fluid">
    <hr>
      <div class="span4">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-book"></i> </span>
            <h5>Recent History</h5>
          </div>
			<div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>History</th>
                </tr>
              </thead>
              <tbody>
              <%
              ArrayList<String> history =(ArrayList<String>) request.getAttribute("history");
              if(history!=null){ 
            	  int loop=0;
            	  if(history.size()<100) loop=history.size();
            	  else loop=15;
            	  for(int i=0;i<loop;i++){
            		  String element = history.get(i);
            		  out.println("<tr>");
            		  out.println("<td>"+element+"</td>");
            		  out.println("</tr>");
            	  }
              	} 
              %>
              </tbody>
            </table>
        </div> 
      </div>
    </div>
    <div class="span4">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-check"></i> </span>
            <h5>Test Responses</h5>
          </div>
			<div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>Actor</th>
				  <th>Response 1</th>
                  <th>Response 2</th>
                </tr>
              </thead>
              <tbody>
              <%
              if(shownUser.equals("javipe19@gmail.com")){
            	  HashMap<String, String> test =(HashMap<String, String>) request.getAttribute("test");
           		  Set<String> keys = test.keySet();
       			  String[] actors = keys.toArray(new String[keys.size()]);
            	  if(test!=null){
            		  for(int i=0;i<actors.length;i++){
            			  String responses = test.get(actors[i]);
            			  String[] parts = responses.split(",");
            			  String part1 = parts[0];
            			  String part2 = parts[1];
                		  out.println("<tr>");
                		  out.println("<td>"+actors[i]+"</td>");
                		  out.println("<td>"+part1+"</td>");
                		  out.println("<td>"+part2+"</td>");
                		  out.println("</tr>");
            			  
            		  }
            	  
            	  }
              }
              else{
            	  ArrayList<String> test =(ArrayList<String>) request.getAttribute("test");
            	  if(test!=null){
            		  for(int i=0;i<test.size();i++){
            			  String responses = test.get(i);
            			  String[] parts = responses.split(",");
            			  String part1 = parts[0];
            			  String part2 = parts[1];
                		  out.println("<tr>");
                		  out.println("<td>"+shownUser+"</td>");
                		  out.println("<td>"+part1+"</td>");
                		  out.println("<td>"+part2+"</td>");
                		  out.println("</tr>");
            			  
            		  }
            	  }
              }
              %>
              </tbody>
            </table>
        </div> 
      </div>
    </div>
    <div class="span4">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-time"></i> </span>
            <h5>Recent Accesses</h5>
          </div>
			<div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>Actor</th>
                  <th>Dates</th>
                </tr>
              </thead>
              <tbody>
              <%
              if(shownUser.equals("javipe19@gmail.com")){
	              JsonArray dates =(JsonArray) request.getAttribute("dates");
	              if(dates!=null){ 
	            	  for(int i=0;i<dates.size();i++){
	            		  JsonObject element = dates.get(i).getAsJsonObject();
	            		  String actor = element.get("actor").toString().replace("\"", "");
	            		  String date = element.get("date").toString().replace("\"", "");
	            		  out.println("<tr>");
	            		  out.println("<td>"+actor+"</td>");
	            		  out.println("<td>"+date+"</td>");
	            		  out.println("</tr>");
	            	  }
	              	}
              }
              else{
                  JsonArray dates =(JsonArray) request.getAttribute("dates");
	              if(dates!=null){ 
	            	  for(int i=0;i<dates.size();i++){
	            		  JsonObject element = dates.get(i).getAsJsonObject();
	            		  String date = element.get("date").toString().replace("\"", "");
	            		  out.println("<tr>");
	            		  out.println("<td>"+shownUser+"</td>");
	            		  out.println("<td>"+date+"</td>");
	            		  out.println("</tr>");
	            	  }
	              	}
              }
              %>
              </tbody>
            </table>
        </div> 
      </div>
    </div>
  </div>
</div>
<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2017&copy; Javier Peña Uribelarrea <a href="http://www.uc3m.es/">UC3M</a> </div>
</div>

<!--end-Footer-part-->
<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/jquery.uniform.js"></script> 
<script src="js/select2.min.js"></script> 
<script src="js/jquery.dataTables.min.js"></script> 
<script src="js/matrix.js"></script> 
<script src="js/matrix.tables.js"></script>
</body>
</html>
