<%-- <!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>slms: signin</title>

  <link rel="stylesheet" href="view/helper/css/font-awesome.css">
  <link rel="stylesheet" href="view/helper/css/quirk.css">

  <script src="view/helper/js/modernizr.js"></script>
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="../lib/html5shiv/html5shiv.js"></script>
  <script src="../lib/respond/respond.src.js"></script>
  <![endif]-->
  
  <style>
  
  .vinDivClass {
    background-color: #ba0032;
    border: 3px solid #72142d;
    color: white;
    left: 0;
    margin: 0 auto;
    padding: 25px 15px;
    position: fixed;
    right: 0;
    text-align: center;
    top: 40%;
    width: 300px;
    z-index: 999999;
}

 .vinDivClass ul
 {
 margin:0px; padding:0px;
 }
  .vinDivClass ul li
  {
  list-style-type:none;
  margin-bottom:20px;
  }
  </style>
  
<script type="text/javascript">
  function hideMessage(messageDivId){
  	 document.getElementById(messageDivId).style.display = 'none';
		$(".overlay").removeClass("overlay");
return false;
}
  
  </script>
</head>
<%@ taglib prefix="s" uri="/struts-tags"%>
<body class="signwrapper">


<s:if test="hasActionMessages()">
	<div id="actionMessageId">
		<div  class="vinDivClass"><p>
			<s:actionmessage />
		</p>
			<button type='button' class='loginbutton' style='width: 50px; color:#000;' onclick="hideMessage('actionMessageId');">Ok</button>
		</div>
	</div>
</s:if>


  <div class="sign-overlay"></div>
  
  <div class="signpanel"></div>
  

  <div class="panel signin">
    <div class="panel-heading">
     	 <img src="view/helper/images/logo.png" class="img-responsive"  alt="logo">
      <h4 class="panel-title">Welcome! Please signin.</h4>
    </div>
    <div class="panel-body">      
      <form action="dashboard" method="post">
        <div class="form-group mb10">
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-user"></i></span>
            <input type="email" class="form-control" placeholder="Enter email" name="email">
          </div>
        </div>
        <div class="form-group nomargin">
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
            <input type="password" class="form-control" placeholder="Enter Password" name="password">
          </div>
        </div>
        <div><a href="forgetPassword" class="forgot">Forgot password?</a></div>
        <div class="form-group">
          <button class="btn btn-danger btn-quirk btn-block">Sign In</button>
        </div>
      </form>
      <hr class="invisible">
      
    </div>
  </div><!-- panel -->

</body>

</html> --%>


<!DOCTYPE html>
<html lang="en">
 <%@ taglib prefix="s" uri="/struts-tags"%>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>slms: signin</title>
	<script src="view/helper/js/jquery.min.js"></script>
  <link rel="stylesheet" href="view/helper/css/font-awesome.css">
  <link rel="stylesheet" href="view/helper/css/quirk.css">

 
  <!-- HTML5 shim and Respond.js IE8 support of HTML5 elements and media queries -->
  <!--[if lt IE 9]>
  <script src="../lib/html5shiv/html5shiv.js"></script>
  <script src="../lib/respond/respond.src.js"></script>
  <![endif]-->
</head>

<body class="signwrapper">
<script type="text/javascript">
function hideMessage(messageDivId){
	$("#"+messageDivId).hide();
	$(".overlay").removeClass("overlay");
return false;
}

</script>

<s:if test="hasActionErrors()">
	<div id="actionMessageId" class="overlay">
			<div class="errorPop" id="SuccessPopDiv" style="display:block;">
                    <a class="CLoseIcon" href="#" onclick="hideMessage('actionMessageId');">X</a>              
                    <i class="fa fa-c"></i>                      
                <span id="successBoxText"><s:actionerror /></span>
            </div>
	</div>
</s:if>

  <div class="sign-overlay"></div>
  <div class="signpanel"></div>

  <div class="panel signin">
    <div class="panel-heading">
     	 <img src="view/helper/images/logo.png" class="img-responsive"  alt="logo">
      <h4 class="panel-title">Welcome! Please signin.</h4>
    </div>
    <div class="panel-body">      
      <form action="dashboard" method="post">
        <div class="form-group mb10">
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-user"></i></span>
            <input type="email" name="email"  class="form-control" placeholder="Enter Username">
          </div>
        </div>
        <div class="form-group nomargin">
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-lock"></i></span>
            <input type="password" name="password" class="form-control" placeholder="Enter Password">
          </div>
        </div>
		<br/>
        <div><a href="forgetPassword" class="forgot">FORGOT PASSWORD?</a></div>
		
        <div class="form-group">
          <button class="bttn">SIGN IN</button>
        </div>
      </form>
      <hr class="invisible">
      
    </div>
  </div><!-- panel -->

</body>

</html>


