<script type="text/javascript">

function cancelProfile(){
	window.location="changePassword";
	return false;
}


function updatePassword(){
	var confirmpassword = $("#confirmpasswordId").val();
	var newpassword = $("#newpasswordId").val();
	var password = $("#passwordId").val();
	if(password==""){
		showSuccessMessage("Please Enter Old Password");
		return false;
	}if(newpassword==""){
		showSuccessMessage("Please Enter New Password");
		return false;
	}if(newpassword.length<6){
		showSuccessMessage("Please Enter Password Of Minimum 6 Character.");
		return false;
	} if(confirmpassword==""){
		showSuccessMessage("Please Enter Confirmation Password");
		return false;
	}if(newpassword!=confirmpassword){
		showSuccessMessage("Confirmation Password not match");
		return false;
	}
	$("#changePasswordFormId").submit();
	return false;
}

</script>


<div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li>  
            <li><a href="#"><i class="fa fa-cog mr5"></i>Setting</a></li>          
            <li class="active"><i class="fa fa-lock"></i>Change Password</li>
          </ol>     
                 
            <div class="panel">
                <div class="panel-heading">
                  <h4 class="panel-title">Change Password</h4>             
                </div>
                <div class="panel-body">
                	<form class="form-horizontal" id="changePasswordFormId" action="updatePassword" method="post">
                      <div class="form-group">
                        <label for="oldpass" class="col-sm-3 control-label">Old Password :</label>
                        <div class="col-sm-6">
                          <input type="password" class="form-control" id="passwordId" name="password">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="newpass" class="col-sm-3 control-label">New Password : </label>
                        <div class="col-sm-6">
                          <input type="password" class="form-control" id="newpasswordId" name="newPassword">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="newpass" class="col-sm-3 control-label">Confirm Password :</label>
                        <div class="col-sm-6">
                          <input type="password" class="form-control" id="confirmpasswordId" name="confirmpassword">
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                          	<button class="bttn" onclick="return updatePassword();">SAVE</button>
                                 &nbsp;&nbsp; <button class="bttn" onclick="return cancelProfile();">CANCEL</button>
                        </div>
                      </div>
                    </form>
                </div>
                
              </div>  
            
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 