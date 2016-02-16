<%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">

function hideMessage(messageDivId){
	$("#"+messageDivId).hide();
	$(".overlay").removeClass("overlay");
return false;
}

function testNumber(number) {
      var expr = /^[0-9]*$/;
        return expr.test(number);
    };


 function isURL(str) {
     var urlRegex = '^(?!mailto:)(?:(?:http|https|ftp)://)(?:\\S+(?::\\S*)?@)?(?:(?:(?:[1-9]\\d?|1\\d\\d|2[01]\\d|22[0-3])(?:\\.(?:1?\\d{1,2}|2[0-4]\\d|25[0-5])){2}(?:\\.(?:[0-9]\\d?|1\\d\\d|2[0-4]\\d|25[0-4]))|(?:(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)(?:\\.(?:[a-z\\u00a1-\\uffff0-9]+-?)*[a-z\\u00a1-\\uffff0-9]+)*(?:\\.(?:[a-z\\u00a1-\\uffff]{2,})))|localhost)(?::\\d{2,5})?(?:(/|\\?|#)[^\\s]*)?$';
     var url = new RegExp(urlRegex, 'i');
     return str.length < 2083 && url.test(str);
}


function getDepartment(){
	 var orgId = $("#selectOrgId").val();
	 if(orgId !=0){
		 var url="getDepartment?organisationId="+orgId;
		$.get( url, function(data) {
		var result = JSON.parse(data);
		  var optionHtml="<option value='0'>All</option>";
		  for(var i=0;i<result.length;i++){
		  	optionHtml=optionHtml+"<option value='"+result[i].departmentId+"'>"+result[i].departmentName+"</option>";
		  }
		   $("#selectDepId").html(optionHtml);
		});
		$("#selectGroupId").html("<option value='0'>All</option>");
		$("#courseSelectId").html("<option value='0'>All</option>");
		$("#moduleSelectId").html("<option value='0'>All</option>");
	}else{
		$("#selectDepId").html("<option value='0'>All</option>");
		 $("#selectGroupId").html("<option value='0'>All</option>");
		 $("#courseSelectId").html("<option value='0'>All</option>");
		  $("#moduleSelectId").html("<option value='0'>All</option>");
	}
}

 function getGroups(){
	 var orgId = $("#selectOrgId").val();
	 	var depId = $("#selectDepId").val();
	 	if(depId !=0){
		 	var url="getGroups?departmentId="+depId+"&organisationId="+orgId;
			$.get( url, function(data) {
			var result = JSON.parse(data);
			  var optionHtml="<option value='0'>All</option>";
			  for(var i=0;i<result.length;i++){
			  	optionHtml=optionHtml+"<option value='"+result[i].groupId+"'>"+result[i].groupName+"</option>";
			  }
			   $("#selectGroupId").html(optionHtml);
			   $("#courseSelectId").html("<option value='0'>All</option>");
			   $("#moduleSelectId").html("<option value='0'>All</option>");
			});
		}else{
			$("#selectGroupId").html("<option value='0'>All</option>");
			$("#courseSelectId").html("<option value='0'>All</option>");
			$("#moduleSelectId").html("<option value='0'>All</option>");
		}
 	}


function changeStatus(id,flag,contentType){
		var courseId = $("#courseSelectId").val();
		var moduleId = $("#moduleSelectId").val();
		var couMod="";
		if(courseId>0){
			couMod=couMod+"&courseId="+courseId;
		}if(moduleId>0){
			couMod=couMod+"&moduleId="+moduleId;
		}
		var url="activeDeactive?id="+id+"&flag="+flag+"&contentType="+contentType+couMod;
		$.get( url, function(data) {
		if(contentType=='org'){
			$("#orgTableDivId").html(data);
		}else if(contentType=='dep'){
			$("#departMentTableDivId").html(data);
		}else if(contentType=='group'){
			$("#groupTableDivId").html(data);
		}
	});
}



function courseActiveDeactive(id,flag,contentType){
		var orgId = $("#selectOrgId").val();
		var depId = $("#selectDepId").val();
		var orgdep="";
		if(orgId>0){
			orgdep=orgdep+"&organisationId="+orgId;
		}if(depId>0){
			orgdep=orgdep+"&departmentId="+depId;
		}
		var url="courseActiveDeactive?id="+id+"&flag="+flag+"&contentType="+contentType+orgdep;
		startwindowDisable();
		$.get( url, function(data) {
		if(contentType=='course'){
			$("#courseTableDivId").html(data);
		}else if(contentType=='module'){
			/* $("#moduleTableDivId").html(data); */
			window.location="courseManagement";
		}else if(contentType=='assignment'){
			$("#assignmentTableDivId").html(data);
		}else if(contentType=='resource'){
			window.location="courseManagement";
		}
			$("#selectOrgId").val("<option value='0'>All</option>");
			$("#selectDepId").val("<option value='0'>All</option>");
			$("#courseMapSaveButtonId").hide();
			endwindowDisable();
	});
	
}

function assignmentActiveDeactive(id,flag,contentType,courseId,moduleId){
	var url="courseActiveDeactive?id="+id+"&flag="+flag+"&contentType="+contentType+"&courseId="+courseId+"&moduleId="+moduleId;
	startwindowDisable();
	$.get( url, function(data) {
	if(contentType=='assignment'){
		$("#assignmentTableDivId").html(data);
	}if(contentType=='question'){
		window.location="assignment";
	}
		endwindowDisable();
});

}

function showSuccessMessage(message){
	$("#successMessageId div span").html("<p>"+message+"</p>");
	$("#successMessageId").show();
}

function toggle_visibility(id) {
		$("#successMessageId").hide();
      
    }
    
    
    function ValidateEmail(email) {
      var expr = /^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$/;
        return expr.test(email);
    };
    
</script>



 <style>
	.home_bg{
	background-image: url(teacher/view/helper/images/bg_3.png);
    height: 100%;
    width: 100%;
	    background-size: 100% 100%;
    background-repeat: no-repeat;
   background-attachment:fixed;
   /* -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;*/
}

.home_bg1{
	background-color: #f7f7f7;
    height: 100%;
    width: 100%;
	    background-size: 100% 100%;
    background-repeat: no-repeat;
   background-attachment:fixed;
   /* -webkit-background-size: cover;
    -moz-background-size: cover;
    -o-background-size: cover;
    background-size: cover;*/
}
.vinDivClass {
    padding: 15px;
    right:0;
    left:0;
   	top:10%;
    width: 260px;
    z-index: 999999;
    margin:0px auto;
    text-align:center;
    border: 3px solid #8dc36d;
     position: fixed;
     background-color: #8dc31d;
     color: white;
     margin-top:69px;
    }
    
   .vinDivClass ul{
	    list-style: outside none none;
	    margin:0px; padding:0px;
    }
    
    
    .loadingCenter {
  		margin: 229px 0 0 674px;
   		position: fixed;
    	z-index: 999;
		}
		
.overlay {
 position: fixed;
 left: 0;
 right: 0;
 top: 0;
 bottom: 0;
 background: rgba(102,102,102,0.5);
 Cross-browser opacity below
 -moz-opacity:.80;
 filter:alpha(opacity=80);
 opacity:.80;
 z-index: 9999999;
}
</style>

<header id="inner-head">
  <nav class="navbar navbar-default">
    <div class="container">
      <div class="navbar-header">
        <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar"> <span class="sr-only">Toggle navigation</span> <span class="icon-bar"></span> <span class="icon-bar"></span> <span class="icon-bar"></span> </button>
        <a class="navbar-brand" href="dashboard" style="margin-top: 5px;"><img src="view/helper/images/logo.png" alt="" ></a> </div>
      <div id="navbar" class="navbar-collapse collapse">
        <ul class="nav navbar-nav navbar-right">
          <li class="dropdown"> <a  href="profile"><span class="user">
          <!-- <img src="view/helper/images/user.png" class="img-circle" alt=""> -->
          </span> ${loginDetail.fname}&nbsp;${loginDetail.lname} <%-- <span class="caret"></span> --%></a>
            <ul class="dropdown-menu">
             <!--  <li><a href="#"><i class="fa fa-user"></i> View Profile</a></li> -->
              <li><a  href="logout"><i class="fa fa-sign-out"></i> Log Out</a></li>
            </ul>
          </li>
          
        </ul>
      </div>
      <!--/.nav-collapse --> 
    </div>
  </nav>
</header>


<div id="successMessageId" class="overlay"  style=" display:none; ">
		<div class="errorPop" id="SuccessPopDiv">
                    <a class="CLoseIcon" href="#" onclick="toggle_visibility('successMessageId');">X</a>              
                <span id="successBoxText"></span>
            </div>
</div>