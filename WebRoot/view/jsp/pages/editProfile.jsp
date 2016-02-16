<%@ taglib prefix="s" uri="/struts-tags"%>

<s:if test="hasActionMessages()">
	<div id="actionMessageId" class="overlay">
			<div class="SuccessPop" id="SuccessPopDiv" style="display:block;">
                    <a class="CLoseIcon" href="#" onclick="hideMessage('actionMessageId');">X</a>              
                    <i class="fa fa-check-square-o grn"></i>                      
                <span id="successBoxText">	<s:actionmessage/></span>
            </div>
	</div>
</s:if>

<script type="text/javascript">
function cancelProfile(){
	window.location="editProfile";
	return false;
}

$(document).ready(function(){
	$("#addressEditorId").Editor();
	$(".Editor-editor").attr("data-text","Address");
	$(".Editor-editor").html($("#addressId").val());
});

/* 
function editProfile(){
	$("#editProfileDivId").show();
	$("#profileDivId").hide();
	$("#titleId").val($("#userTitleId").val());
	return false;
} */

function updateProfile(){
	var fname =	$("#fnameId").val();
	var lname =	$("#lnameId").val();
	$("#addressId").val($(".Editor-editor").html());
	var address =$("#addressId").val();
	var contactNo =	$("#contactNoId").val();
	if(fname==""){
		showSuccessMessage("Please Enter First Name");
		return false;
	}if(lname==""){
		showSuccessMessage("Please Enter Last Name");
		return false;
	}if(address=="" || address=="<br>"){
		showSuccessMessage("Please Enter Address");
		return false;
	}if(contactNo==""){
		showSuccessMessage("Please Enter Contact Number");
		return false;
		}if(contactNo.length!=10 || !testNumber(contactNo)){
		showSuccessMessage("Contact number must be 10 digits number");
		return false;
		}
	startwindowDisable();
	$("#profileFormId").submit();
}
</script>

<div class="mainpanel"> 
    
    <!-- Edit Profile -->
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li>  
            <li><a href="#"><i class="fa fa-cog mr5"></i>Setting</a></li>          
            <li class="active"><i class="fa fa-edit mr5"></i>Edit Profile</li>
          </ol>     
                 
            <div class="panel">
                <div class="panel-heading">
                  <h4 class="panel-title">Edit Profile</h4>             
                </div>
                <div class="panel-body">
                	<form class="form-horizontal" id="profileFormId" action="updateProfile" method="post">
                		 <input type="text" id="userTitleId"  value="<s:property value="userVo.title"/>" style="display:none;">
                      <div class="form-group">
	                            <label class="col-sm-3 control-label">Title</label>
	                             <div class="col-sm-6">
	                             <s:select id="titleId" cssClass="form-control" name="title" list="#{'Mr.':'Mr.','Mrs.':'Mrs.','Ms.':'Ms.','Dr.':'Dr.'}" value="userVo.title">
		                          <!--    <option value="Mr.">Mr.</option>
		                             <option value="Mrs.">Mrs.</option>
		                             <option value="Ms.">Ms.</option>
		                             <option value="Dr.">Dr.</option> -->
	                            </s:select>
	                            </div>
	                  </div>
                      <div class="form-group">
                        <label for="oldpass" class="col-sm-3 control-label">First Name :</label>
                        <div class="col-sm-6">
                          <input type="text" class="form-control" id="fnameId" name="fname" value="<s:property value="userVo.fname"/>">
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="newpass" class="col-sm-3 control-label">Last Name : </label>
                        <div class="col-sm-6">
                          <input type="text" class="form-control" id="lnameId" name="lname" value="<s:property value="userVo.lname"/>" >
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="newpass" class="col-sm-3 control-label">Address :</label>
                        <div class="col-sm-6">
                          <input type="text" class="form-control" id="addressId" style="display:none;" name="address" value="<s:property value="userVo.address"/>">
                           <textarea  id="addressEditorId"></textarea>
                        </div>
                      </div>
                      <div class="form-group">
                        <label for="newpass" class="col-sm-3 control-label">Contact No :</label>
                        <div class="col-sm-6">
                          <input type="text" class="form-control" id="contactNoId" name="contactNo"  value="<s:property value="userVo.contactNo"/>">
                        </div>
                      </div>
                      
                      <div class="form-group">
                        <div class="col-sm-offset-3 col-sm-6">
                          	<button class="bttn" onclick="return updateProfile();">UPDATE</button>
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