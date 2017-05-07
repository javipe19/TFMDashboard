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
    <li> <a href="Controller?page=data"><i class="icon icon-th"></i> <span>General Data</span></a> </li>
    <li class="active"> <a href="Controller?page=act"><i class="icon icon-signal"></i> <span>Activities & Frequency</span></a> </li>
    <li><a href="tables.html"><i class="icon icon-time"></i> <span>Pages & Time</span></a></li>
  </ul>
</div>
<!--sidebar-menu-->
<div id="content">
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a> <a href="#" class="current">General Data</a> </div>
    <h1>Activities & Frequency</h1>
  </div>
  <div class="container-fluid">
    <hr>
      <div class="span12">
        <div class="widget-box">
          <div class="widget-title"> <span class="icon"> <i class="icon-th"></i> </span>
            <h5>Most Frequent Activities</h5>
          </div>
          	<% String json =(String) request.getAttribute("act");%>
			<p id="json" hidden><%=json %></p>
			<svg width="960" height="960" font-family="sans-serif" font-size="10" text-anchor="middle"></svg>
    	</div>
 	 </div>
	</div>
<script src="https://d3js.org/d3.v3.min.js"></script>
<script>
var data = JSON.parse(document.getElementById("json").innerHTML);

var diameter = 1000, //max size of the bubbles
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
data = data.map(function(d){ d.value = +d["frequency"]; return d; });

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
    .text(function(d){ return d["name"]; })
    .style({
        "fill":"black", 
        "font-family":"Helvetica Neue, Helvetica, Arial, san-serif",
        "font-size": "12px"
    });


</script>
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
