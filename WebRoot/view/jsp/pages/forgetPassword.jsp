<!DOCTYPE html>
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
</head>
<script src="view/helper/js/jquery.js"></script> 
<script type="text/javascript">
function hideMessage(messageDivId){
	$("#"+messageDivId).hide();
	$(".overlay").removeClass("overlay");
return false;
}

</script>

<body class="signwrapper">
<%@ taglib prefix="s" uri="/struts-tags"%>


  <div class="sign-overlay"></div>
  <div class="signpanel"></div>

  <div class="panel signin">
    <div class="panel-heading">
     	<a href="login"> <img src="view/helper/images/logo.png" class="img-responsive"  alt="logo"></a>
      <h4 class="panel-title">Please enter your email</h4>
    </div>
    <div class="panel-body">      
      <form action="sendforgetPassword" method="post">
        <div class="form-group mb10">
          <div class="input-group">
            <span class="input-group-addon"><i class="fa fa-user"></i></span>
            <input type="text" class="form-control" placeholder="Enter email" name="email">
          </div>
        </div>
        <div class="form-group">
          <button type="submit" class="bttn">Send</button>
        </div>
      </form>
      
      <s:if test="hasActionMessages()">
			<div id="successMessageId" class="overlay">
				<div  class="signpop">
				<div id="saveDivId">
					<b><s:actionmessage />
					</b>
					<button  onclick="hideMessage('saveDivId');" style="color:#000;">ok</button>
				</div>
				</div>
			</div>
		</s:if>
      
      <hr class="invisible">
      
    </div>
  </div><!-- panel -->

</body>

</html>
