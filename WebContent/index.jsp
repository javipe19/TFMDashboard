<!DOCTYPE html>
<html lang="en">
<head>
<title>UC3M Learning Analytics Dashboard</title>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<link rel="stylesheet" href="css/bootstrap.min.css" />
<link rel="stylesheet" href="css/bootstrap-responsive.min.css" />
<link rel="stylesheet" href="css/fullcalendar.css" />
<link rel="stylesheet" href="css/matrix-style.css" />
<link rel="stylesheet" href="css/matrix-media.css" />
<link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
<link rel="stylesheet" href="css/jquery.gritter.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans:400,700,800' rel='stylesheet' type='text/css'>
</head>
<body>
<%@ include file="/header.jsp"%>
<!--sidebar-menu-->
<div id="sidebar"><a href="#" class="visible-phone"><i class="icon icon-home"></i> Dashboard</a>
  <ul>
    <li class="active"><a href="index.jsp"><i class="icon icon-home"></i> <span>Home</span></a> </li>
    <li> <a href="Controller?page=data"><i class="icon icon-th"></i> <span>General Data</span></a> </li>
    <li> <a href="Controller?page=act"><i class="icon icon-signal"></i> <span>Activities & Frequency</span></a> </li>
    <li><a href="Controller?page=time"><i class="icon icon-time"></i> <span>Pages & Time</span></a></li>
  </ul>
</div>
<!--sidebar-menu-->
<!--main-container-part-->
<div id="content">
<!--breadcrumbs-->
  <div id="content-header">
    <div id="breadcrumb"> <a href="index.jsp" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a></div>
  </div>
  <br>
<!--End-breadcrumbs-->
<!--Action boxes-->
  <div class="container-fluid"  align="center">
    <div class="quick-actions_homepage">
      <ul class="quick-actions">
        <li class="bg_lb span2"> <a href="index.jsp"> <i class="icon-home"></i> <span class="label label-important"></span> Home </a> </li>
        <li class="bg_lg span2"> <a href="Controller?page=data"> <i class="icon-th"></i> General Data </a> </li>
        <li class="bg_ly span3"> <a href="Controller?page=act"> <i class="icon-signal"></i><span class="label label-success"></span> Activities & Frequency </a> </li>
        <li class="bg_lo span3"> <a href="Controller?page=time"> <i class="icon-time"></i> Pages & Time </a> </li>
      </ul>
    </div>
    <hr/>
  </div>
<!--End-Action boxes-->

<!--Chart-box-->    
    <div class="row-fluid"  align="center">
      <br><br><br><br>
      <div>
        <img src="img/dashboard_logo.png" alt="Logo" height="50%" width="50%"/>
      	<img src="img/uned.jpg" alt="Logo" height="15%" width="15%"/>
      </div>
    </div>
<!--End-Chart-box--> 

</div>

<!--end-main-container-part-->

<!--Footer-part-->

<div class="row-fluid">
  <div id="footer" class="span12"> 2017&copy; Javier Pe�a Uribelarrea <a href="http://www.uc3m.es/">UC3M</a> </div>
</div>

<!--end-Footer-part-->

<script src="js/excanvas.min.js"></script> 
<script src="js/jquery.min.js"></script> 
<script src="js/jquery.ui.custom.js"></script> 
<script src="js/bootstrap.min.js"></script> 
<script src="js/jquery.flot.min.js"></script> 
<script src="js/jquery.flot.resize.min.js"></script> 
<script src="js/jquery.peity.min.js"></script> 
<script src="js/fullcalendar.min.js"></script> 
<script src="js/matrix.js"></script> 
<script src="js/matrix.dashboard.js"></script> 
<script src="js/jquery.gritter.min.js"></script> 
<script src="js/matrix.chat.js"></script> 
<script src="js/jquery.validate.js"></script> 
<script src="js/matrix.form_validation.js"></script> 
<script src="js/jquery.wizard.js"></script> 
<script src="js/jquery.uniform.js"></script> 
<script src="js/select2.min.js"></script> 
<script src="js/matrix.popover.js"></script> 
<script src="js/jquery.dataTables.min.js"></script> 
<script src="js/matrix.tables.js"></script> 

<script type="text/javascript">
  // This function is called from the pop-up menus to transfer to
  // a different page. Ignore if the value returned is a null string:
  function goPage (newURL) {

      // if url is empty, skip the menu dividers and reset the menu selection to default
      if (newURL != "") {
      
          // if url is "-", it is this page -- reset the menu:
          if (newURL == "-" ) {
              resetMenu();            
          } 
          // else, send page to designated URL            
          else {  
            document.location.href = newURL;
          }
      }
  }

// resets the menu selection upon entry to this page:
function resetMenu() {
   document.gomenu.selector.selectedIndex = 2;
}
</script>
</body>
</html>
