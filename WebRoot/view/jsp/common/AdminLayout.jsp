<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
<meta name="description" content="">
<meta name="author" content="">
<title>Growth Cafe Admin</title>
<!-- <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.3/jquery.min.js"></script> -->
<script src="view/helper/js/jquery.min.js"></script>
<link href="view/helper/css/bootstrap.css" rel="stylesheet">
<link href="view/helper/css/bootstrap-select.css" rel="stylesheet">
<link href="view/helper/css/toggles-full.css" rel="stylesheet">
<link href="view/helper/css/quirk.css" rel="stylesheet">
<link href="view/helper/css/editor.css" rel="stylesheet">
<link href="view/helper/css/bootstrap-tokenfield.css" rel="stylesheet">
<link rel="shortcut icon" href="favicon.ico" type="image/x-icon">
<!-- <link href="view/helper/css/bootstrap-select.css" rel="stylesheet"> -->
<link href="view/helper/css/font-awesome.css" rel="stylesheet">
<link href="view/helper/css/jquery-ui.css" rel="stylesheet">
<style type="text/css">
body,td,th {
	font-family: "Avenir Medium";
}
</style>

<script>
 $(document).ready(function(){
	$(".nav-parent").removeClass("active");
	$("#"+'${selectedTab}').addClass("active");
	$("."+'${selectedTab}').show();
	$("#"+'${subMenu}').addClass("active");
});

$(document).ready(function(e) {
        $("#managementId").click(function(){
		$("#dropmenu").slideUp(1000);
		$("#dropmenu1").slideDown(1000);
		});
	$("#scoreId").click(function(){
		$("#dropmenu1").slideUp(1000);
		$("#dropmenu").slideDown(1000);
		});
      });
 
 /* function innerTab(tab){
 	$("#"+tab+" div").show();
 }
 */
function startwindowDisable(){
	$(".backdro-container").show();
	return false;
}

function endwindowDisable(){
	$(".backdro-container").hide();
	return false;
}
</script>

<style>

.homebg{
	background-color: #f7f7f7;
    height: 100%;
    width: 100%;
	background-size: 100% 100%;
    background-repeat: no-repeat;
   background-attachment:fixed;
  
  
}

 .backdro-container {
   position: fixed;
   display: none;
   height:150%;
   width: 100%;
   z-index: 999999;
    margin-top: -90px;
}
#backdro {
   z-index:5;
   background: #ccc;
   opacity:0.5;
   height:100%;
   width: 100%;
}

.backdro-container #loading-img {
    position: absolute;
    z-index:10;
    top:30%;
    left:48%;
}
</style>

</head>

<body>

<div class="backdro-container">
    <div id="backdro">&nbsp;</div>
   <img id="loading-img" src='view/helper/images/ajax-loader-large.gif' height="100px;"/>
</div>

<tiles:insertAttribute name="header"/>
<section>
<tiles:insertAttribute name="leftMenu"/>
<div id="pageContentDivId" >
	<tiles:insertAttribute name="pageContent"/>
</div>
</section>
<script src="view/helper/js/upload-image.js"></script>
<!-- <script src="view/helper/js/jquery.js"></script> -->
<script src="view/helper/js/bootstrap.js"></script>
<script src="view/helper/js/dashboard.js"></script>

<!-- <script src="view/helper/js/jquery.validate.js"></script> -->
<script src="view/helper/js/bootstrap-select.min.js"></script>
<script src="view/helper/js/editor.js"></script>
<script src="view/helper/js/jquery-ui.js"></script>
<script src="view/helper/js/multiselect.min.js"></script>
<script src="view/helper/js/prettify.min.js"></script>
<script src="view/helper/js/bootstrap-tokenfield.js"></script>
<script src="view/helper/js/upload-image1.js"></script>
<!-- 
<script type="text/javascript">
$(function() {

  // Textarea Auto Resize
  autosize($('#autosize'));

  // Select2 Box
 

  // Input Masks
  $("#date").mask("99/99/9999");
  $("#phone").mask("(999) 999-9999");
  $("#ssn").mask("999-99-9999");

  // Date Picker
  $('#datepicker').datepicker();
  $('#datepicker-inline').datepicker();
  $('#datepicker-multiple').datepicker({ numberOfMonths: 2 });

// Date Picker
  $('#datepicker2').datepicker();
  $('#datepicker-inline').datepicker();
  $('#datepicker-multiple').datepicker({ numberOfMonths: 2 });
  
  // Time Picker
  $('#tpBasic').timepicker();
  $('#tp2').timepicker({'scrollDefault': 'now'});
  $('#tp3').timepicker();

  $('#setTimeButton').on('click', function (){
    $('#tp3').timepicker('setTime', new Date());
  });

  // Colorpicker
  $('#colorpicker1').colorpicker();
  $('#colorpicker2').colorpicker({
    customClass: 'colorpicker-lg',
    sliders: {
      saturation: {
        maxLeft: 200,
        maxTop: 200
      },
      hue: { maxTop: 200 },
      alpha: { maxTop: 200 }
    }
  });

});
</script>

<script type="text/javascript">


$("#showDivId").click(function(){
	
	var html="<div class='form-group test col-sm-11'>"+
     "<label>Add Another Question*</label>"+
     "<input type='text' class='form-control' required>"+
     "</div>"+
     "<div class='form-group test col-sm-1'>"+
     "<button type='button' class='bttn close-btn' id='removeDivId'><i class='fa fa-minus'></i></button>"+
     "</div>";
	 $("#tempId").before(html);

$("#removeDivId").click(function(){
	
	 $(".test").remove();
});
});
       /*  function Show_Div() {
			$("#addcoursebx").show();
           return false;
        }
		 function Show_Div1() {
			$("#addmodulebx").show();
           return false;
        } */
		 function Show_Div2() {
			$("#addassignmentbx").show();
           return false;
        }
		function Show_div(elem) {
			document.getElementById('hide-btn').style.visibility = "hidden";
			if(elem.value==1){
			document.getElementById('addfile').style.display = "block";
			document.getElementById('addquestion').style.display = "none";
			document.getElementById('multiplechoice').style.display = "none";
			document.getElementById('true-false').style.display = "none";
			}
			else if(elem.value==2){
			document.getElementById('addquestion').style.display = "block";
			document.getElementById('multiplechoice').style.display = "none";
			document.getElementById('true-false').style.display = "none";
			document.getElementById('addfile').style.display = "none";
			}
			else if(elem.value==3){
			document.getElementById('multiplechoice').style.display = "block";
			document.getElementById('true-false').style.display = "none";
			document.getElementById('addfile').style.display = "none";
			document.getElementById('addquestion').style.display = "none";
			}
			else if(elem.value==4){
			document.getElementById('true-false').style.display = "block";
			document.getElementById('addfile').style.display = "none";
			document.getElementById('addquestion').style.display = "none";
			document.getElementById('multiplechoice').style.display = "none";
			}
		}
		
		
		 function Hide_Div() {
			$("#addcoursebx").hide();
           return false;
        }
		 function Hide_Div1() {
			$("#addmodulebx").hide();
           return false;
        }
		
		function Hide_filediv() {
			
			$("#addassignmentbx").hide();			
           return false;
        }
		
    </script> -->
</body>
</html>