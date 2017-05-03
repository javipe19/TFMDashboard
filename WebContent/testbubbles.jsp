<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html lang="en">
<head>
<title>Matrix Admin</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file="/header.jsp"%>
  <div id="content-header">
	<h1>Charts &amp; graphs</h1>
  </div>
  <div class="container-fluid">
	<% String json =(String) request.getAttribute("json");%>
	<p id="json" hidden><%=json %></p>
	<svg width="960" height="960" font-family="sans-serif" font-size="10" text-anchor="middle"></svg>
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
</body>
</html>

