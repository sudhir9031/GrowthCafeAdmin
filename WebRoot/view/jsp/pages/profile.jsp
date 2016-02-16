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
<s:if test="hasActionErrors()">
	<div id="actionMessageId" class="overlay">
			<div class="errorPop" id="SuccessPopDiv" style="display:block;">
                    <a class="CLoseIcon" href="#" onclick="hideMessage('actionMessageId');">X</a>              
                    <i class="fa fa-c"></i>                      
                <span id="successBoxText"><s:actionerror /></span>
            </div>
	</div>
</s:if>

<div class="mainpanel"> 
    
      
    <div class="contentpanel" id="profileDivId" >
      		
         <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li>  
            <li><a href="#"><i class="fa fa-cog mr5"></i>Setting</a></li>          
            <li class="active"><i class="fa fa-user mr5"></i>My Profile</li>
          </ol>     
                 
               <div class="panel">
                <div class="panel-heading">
                  <h4 class="panel-title">My Profile</h4>             
                </div>
                <div class="panel-body">
                	<form class="form-horizontal" id="profileFormId" action="updateProfile">
                		
                      <div class="form-group">
	                            <label class="col-sm-3 control-label">Full Name : </label>
	                             <div class="col-sm-9">
	                            <label class="col-sm-12 control-label text-left"> <s:property value="userVo.title"/>&nbsp;<s:property value="userVo.fname"/>&nbsp;<s:property value="userVo.lname"/></label>
	                            </div>
	                  </div>
                      <div class="form-group">
	                            <label class="col-sm-3 control-label">Email : </label>
	                             <div class="col-sm-9">
	                            <label class="col-sm-12 control-label text-left"> <s:property value="userVo.email"/></label>
	                            </div>
	                  </div>
					  <div class="form-group">
	                            <label class="col-sm-3 control-label">Address : </label>
	                             <div class="col-sm-9">
	                            <label class="col-sm-12 control-label text-left"> ${userVo.address}</label>
	                            </div>
	                  </div>
					  <div class="form-group">
	                            <label class="col-sm-3 control-label">Contact number : </label>
	                             <div class="col-sm-9">
	                            <label class="col-sm-12 control-label text-left">  <s:property value="userVo.contactNo"/></label>
	                            </div>
	                  </div>
					  
                    </form>
                </div>
                
              </div>  
              
    </div>
    
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 