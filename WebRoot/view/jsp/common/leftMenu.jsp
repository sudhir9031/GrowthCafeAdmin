  <%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">

function dashboard(){
	window.location="dashboard";
}

function organization(){
	window.location="organization";
	startwindowDisable();
	return false;
}

function department(){
	window.location="department";
	startwindowDisable();
	return false;
}

function group(){
	window.location="group";
	startwindowDisable();
	return false;
}


function reviewParameter(){
	window.location="reviewParameter";
	startwindowDisable();
	return false;
}


function courseManagement(){
	window.location="courseManagement";
	startwindowDisable();
	return false;
}

function module(){
	window.location="module";
	startwindowDisable();
	return false;
}

function assignment(){
	window.location="assignment";
	startwindowDisable();
	return false;
}



function teacherManagment(){
	window.location="teacherManagment";
	startwindowDisable();
	return false;
}

function students(){
	window.location="students";
	startwindowDisable();
	return false;
}

function admins(){
	window.location="admins";
	startwindowDisable();
	return false;
}

function changePassword(){
	window.location="changePassword";
	startwindowDisable();
	return false;
}

</script>

<div class="leftpanel">
    <div class="leftpanelinner"> 
      
      <!-- ################## LEFT PANEL PROFILE ################## -->
   
      <!-- leftpanel-profile -->
      
      <ul class="nav nav-tabs nav-justified nav-sidebar">
        <li class="tooltips active" data-toggle="tooltip" id="mainMenuId" title="Main Menu"><a data-toggle="tab"  data-target="#mainmenu"><i class="tooltips fa fa-ellipsis-h"></i></a></li>
        
        
        <li class="tooltips" data-toggle="tooltip" title="Settings" id="settingsId"><a data-toggle="tab" data-target="#settings"><i class="fa fa-cog"></i></a></li>
        <li class="tooltips" data-toggle="tooltip" title="Log Out"><a href="logout"><i class="fa fa-sign-out"></i></a></li>
      </ul>
      <div class="tab-content"> 
        
        <!-- ################# MAIN MENU ################### -->
        
        <div class="tab-pane active" id="mainmenu">
          	<ul class="nav nav-pills nav-stacked nav-quirk">
                <li  id="leftDashboardId">
               		 <a href="javaScript:;" onclick="dashboard();">
						<i class="fa fa-home"></i><span>Dashboard</span>
					</a>
                </li>
                <s:if test="#session.loginDetail !=null && #session.loginDetail.userType==1">
	                <li class="nav-parent" id="leftCorserManagementId">
	                	 <a href="javaScript:;" onclick="courseManagement();">
							<i class="fa fa-book"></i><span>Course Management</span>
						</a>
	                </li>
	           </s:if>
                
             
                <s:if test="#session.loginDetail !=null && #session.loginDetail.userType==4">
	                <li class="nav-parent" id="leftOrgManagementId">
	                  <a  href="javaScript:;" onclick="organization();"><i class="fa fa-hospital-o"></i> <span>Organization Management</span></a>
	                </li>
	               </s:if>
                 <s:if test="#session.loginDetail !=null && #session.loginDetail.userType==1">
		                <li id="leftReviewParamId"><a id="scoreId" href="#"><i class="fa fa-indent"></i> <span>Scoring ruberic</span> <i class="fa fa-caret-down mg_l28"></i></a></li>
			               	<div id="dropmenu" class="leftReviewParamId" style="display:none;">
			               	<ul class="nav nav-stacked nav-quirk mg0">
			                	<li id="4"><a href="grade"><i class="fa fa-plus-square-o"></i> grades</a></li>
			                    <li id="3"><a href="javaScript:;" onclick="return reviewParameter();"><i class="fa fa-certificate"></i> parameters</a></li>
			                </ul>
			                </div>
                 		<li id="leftDepartmentId">
		                  <a href="javaScript:;" onclick="department();"><i class="fa fa-building"></i> <span>departments</span></a>
		                </li>
		                <li id="leftGroupId">
		                  <a href="javaScript:;" onclick="group();"><i class="fa fa-users"></i> <span>Course Sessions</span></a>
		                </li>
	                 <li id="leftUserManagementId"><a id="managementId" href="#"><i class="fa fa-hospital-o"></i> <span>user Management</span> <i class="fa fa-caret-down mg_l28"></i></a></li>
		               	<div   id="dropmenu1"  class="leftUserManagementId" style="display:none;">
		               	<ul class="nav nav-stacked nav-quirk ">
		                	<li id="1"><a href="javaScript:;" onclick="return teacherManagment();"><i class="fa fa-user"></i> Coach</a></li>
		                    <li  id="2"><a href="javaScript:;" onclick="return students();"><i class="fa fa-graduation-cap"></i> student</a></li>
		                     <!-- <li  id="3"><a href="javaScript:;"><i class="fa fa-user"></i> Upload User</a></li> -->
		                </ul>
		                </div>
	               
                </s:if>
              </ul>
        </div>
        <!-- tab-pane --> 
        
        
        <!-- #################### SETTINGS ################### -->
        
        <div class="tab-pane" id="settings">
         		<div class="panel">
                  <div class="panel-body">
                    <ul class="folder-list">
                      <li id="myProfileTabId"><a href="profile"><i class="fa fa-user"></i> MY PROFILE</a></li>
                     <li id="editProfileTabId" ><a href="editProfile"><i class="fa fa-edit"></i> EDIT PROFILE</a></li>
                      <li id="changePasswordTabId"><a href="javaScript:;" onclick="return changePassword();"><i class="fa fa-lock"></i> CHANGE PASSWORD</a></li>
                      
                   
                    </ul>
                  </div>
                </div>
        </div>
        
        <!-- tab-pane --> 
        
      </div>
      <!-- tab-content --> 
      
    </div>
    <!-- leftpanelinner --> 
  </div>
  <!-- leftpanel -->
