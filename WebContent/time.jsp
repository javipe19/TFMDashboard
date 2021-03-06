<%@ page import= "java.util.ArrayList"%>
<%@ page import="com.google.gson.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Pages & Time</title>
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
    <li> <a href="index.jsp"><i class="icon icon-home"></i> <span>Home</span></a> </li>
    <li> <a href="Controller?page=data"><i class="icon icon-th"></i> <span>General Data</span></a> </li>
    <li> <a href="Controller?page=act"><i class="icon icon-signal"></i> <span>Activities & Frequency</span></a> </li>
    <li class="active"><a href="Controller?page=time"><i class="icon icon-time"></i> <span>Pages & Time</span></a></li>
  </ul>
</div>
<!--sidebar-menu-->
<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">Pages & Time</a> </div>
    <h1>Pages & Time</h1>
    <h1>User: <%=shownUser%></h1>
  </div>
  <div class="container-fluid">
    <hr>      
      <div class="span10">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-bar-chart"></i> </span>
            <h5>Times spent in pages</h5>
          </div>
          	<% String json =(String) request.getAttribute("times");%>
			<p id="json" hidden><%=json %></p>
			<svg width="1000" height="1000" font-family="sans-serif" font-size="10" text-anchor="middle"></svg>
    	</div>
 	 </div>
 	 	<div class="span4">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-time"></i> </span>
           <% if(shownUser.equals("javipe19@gmail.com")){ %>
            <h5>Maximum Time Spent in Pages by all users</h5>
            <%
            }
            else{
            %>
            <h5>Maximum Time Spent in Pages by <%=shownUser %></h5>
            <% } %>
          </div>
			<div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>Page</th>
				  <th>Time</th>
                </tr>
              </thead>
              <tbody>
              <%
             
            	  String times =(String) request.getAttribute("times");
              	  
            	  if(times!=null){
                  	  JsonElement el = new JsonParser().parse(times);
                  	  JsonArray array = el.getAsJsonArray();
            		  for(int i=0;i<array.size();i++){
            			  JsonObject pagetime = array.get(i).getAsJsonObject();
            			  String p = pagetime.get("page").toString().replace("\"", "");
            			  int s = Integer.parseInt(pagetime.get("duration").toString());
            			  Date date = new Date((long)(s*1000)); 
            			  String formattedDate = new SimpleDateFormat("HH:mm:ss").format(date);
                		  out.println("<tr>");
                		  out.println("<td>"+p+"</td>");
                		  out.println("<td>"+formattedDate+"</td>");
                		  out.println("</tr>");  
            		  }
            	 
              }
              %>
              </tbody>
            </table>
        </div> 
      </div>
    </div>
    <% if(!shownUser.equals("javipe19@gmail.com")){
         String recent =(String) request.getAttribute("recentTimes");
     %>
	<div class="span4">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-time"></i> </span>

          <h5>Last Times Spent in Pages by <%=shownUser%></h5>
          </div>
			<div class="widget-content nopadding">
            <table class="table table-bordered table-striped">
              <thead>
                <tr>
                  <th>Page</th>
				  <th>Time</th>
                </tr>
              </thead>
              <tbody>
              <% if(recent!=null){
                  	  JsonElement el = new JsonParser().parse(recent);
                  	  JsonArray array = el.getAsJsonArray();
            		  for(int i=0;i<array.size();i++){
            			  JsonObject pagetime = array.get(i).getAsJsonObject();
            			  String p = pagetime.get("page").toString().replace("\"", "");
            			  int s = Integer.parseInt(pagetime.get("duration").toString());
            			  Date date = new Date((long)(s*1000)); 
            			  String formattedDate = new SimpleDateFormat("HH:mm:ss").format(date);
                		  out.println("<tr>");
                		  out.println("<td>"+p+"</td>");
                		  out.println("<td>"+formattedDate+"</td>");
                		  out.println("</tr>");  
            		  }
            	 
	              }           	  
          		%>
              </tbody>
            </table>
        </div> 
      </div>
    </div>
    <% } %>
	</div>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script>
var data = JSON.parse(document.getElementById("json").innerHTML);

var diameter = 950, //max size of the bubbles
 color = d3.scale.category20b(); //color category

var bubble = d3.layout.pack()
.sort(null)
.size([diameter, diameter])
.padding(1.5);

var svg = d3.select("svg")
.append("svg")
.attr("width", diameter)
.attr("height", diameter)
.attr("class", "bubble");



//convert numerical values from strings to numbers
data = data.map(function(d){ d.value = +d["duration"]; return d; });

//bubbles needs very specific format, convert data to this.
var nodes = bubble.nodes({children:data}).filter(function(d) { return !d.children; });

//setup the chart
var bubbles = svg.append("g")
    .attr("transform", "translate(0,0)")
    .selectAll(".bubble")
    .data(nodes)
    .enter();

//create the bubbles
bubbles.append("circle")
    .attr("r", function(d){ return d.r; })
    .attr("cx", function(d){ return d.x; })
    .attr("cy", function(d){ return d.y; })
    .style("fill", function(d) { return color(d.value); });

//format the text for each bubble
bubbles.append("text")
    .attr("x", function(d){ return d.x; })
    .attr("y", function(d){ return d.y + 5; })
    .attr("text-anchor", "middle")
    .text(function(d){ return d["page"]; })
    .style({
        "fill":"black", 
        "font-family":"Helvetica Neue, Helvetica, Arial, san-serif",
        "font-size": "12px"
    });
    
    
	var margin = {top: 20, right: 20, bottom: 20, left: 20},
	width = 960 - margin.left - margin.right,
	height = 500 - margin.top - margin.bottom;
	
</script>


<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2017&copy; Javier Pe�a Uribelarrea <a href="http://www.uc3m.es/">UC3M</a> </div>
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
