<%@ page import= "java.util.ArrayList"
import="com.google.gson.*"
    %>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Matrix Admin</title>
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
<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">General Data</a> </div>
    <h1>Tables</h1>
  </div>
  <div class="container-fluid">
    <hr>
      <div class="span4">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
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
            	  for(int i=0;i<10;i++){
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
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Dates</h5>
          </div>
			<div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>Actor Last Dates</th>
                </tr>
              </thead>
              <tbody>
              <%
              JsonArray dates =(JsonArray) request.getAttribute("dates");
              if(dates!=null){ 
            	  for(int i=0;i<10;i++){
            		  JsonObject element = dates.get(i).getAsJsonObject();
            		  String actor = element.get("actor").toString();
            		  String date = element.get("date").toString();
            		  out.println("<tr>");
            		  out.println("<td>"+actor+"</td>");
            		  out.println("<td>"+date+"</td>");
            		  out.println("</tr>");
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
  <div id="footer" class="span12"> 2013 &copy; Matrix Admin. Brought to you by <a href="http://themedesigner.in">Themedesigner.in</a> </div>
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
