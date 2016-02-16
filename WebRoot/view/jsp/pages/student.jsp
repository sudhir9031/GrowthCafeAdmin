 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script type="text/javascript">
 	function getStudentDepartment(){
 		var orgId = $("#selectOrgId").val();
 		var url="getStudentTable?organisationId="+orgId;
 		$.get(url, function( data ) {
		  $("#studentTableDivId").html( data );
		});
 			getDepartment();
 	}
 	
 	
	function getStudentGroup(){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var url="getStudentTable?organisationId="+orgId+"&departmentId="+depId;
 		$.get(url, function( data ) {
		  $("#studentTableDivId").html( data );
		});
 		getGroups();
 	}
 	
 	function getStudentTable(groupId){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var url="getStudentTable?organisationId="+orgId+"&departmentId="+depId+"&groupId="+groupId;
 		$.get(url, function( data ) {
		  $("#studentTableDivId").html(data);
		});
 			
 	}
 	
 	function changeUserLoginStatus(userId,status){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var groupId = $("#selectGroupId").val();
 		var url="changeUserLoginStatus?userId="+userId+"&status="+status+"&organisationId="+orgId+"&departmentId="+depId+"&groupId="+groupId;
 		startwindowDisable();
 		$.get(url, function( data ) {
		  $("#studentTableDivId").html( data );
		  endwindowDisable();
		});
 	}
 	
 	function editStudent(userId){
 		$("#editStudentBox").show();
 		var title = $("#titleId"+userId).val();
 		var fname = $("#fnameId"+userId).val();
 		var lname = $("#lnameId"+userId).val();
 		var email = $("#emailId"+userId).val();
 		var password = $("#passwordId"+userId).val();
 		$("#editStudentBox #userId").val(userId);
 		$("#editStudentBox #FnameId").val(fname);
 		$("#editStudentBox #LnameId").val(lname);
 		$("#editStudentBox #passwordId").val(password);
 		$("#editStudentBox #emailId").val(email);
 		$("#editStudentBox #titleId").val(title);
 		
 		return false;
 	}
 </script>
 
 
  <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-users mr5"></i> User Management</a></li>            
            <li class="active"><i class="fa fa-graduation-cap mr5"></i> Student</li>
          </ol>     
             <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		<div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if>  
                
                <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-4 col-md-5"></div>
                <div class="col-sm-8 col-md-12">
              	  <button class="bttn pull-right btn-pos" onclick="return Show_Div();"   data-id="addTeacherBox">ADD STUDENT <i class="fa fa-plus-circle"></i></button>
                  <div class="dropdown pull-right btn-pos">
                    <button class="bttn dropdown-toggle" type="button" data-toggle="dropdown">PENDING REQUEST
                    <span class="caret"></span></button>
                    <ul class="dropdown-menu" id="dropbutton">
                      <li><a href="newRegistration">Registration</a></li>
                      <li><a href="sessionRequest">Course Session</a></li>
                    </ul>
                </div>
                </div>
              </div>
              
            </div>
            
            <div class="panel-body">
            	<div id="addTeacherBox" style="display:none">
        		  <div class="row">
                	<form id="addStudentFormId" action="saveStudent" method="post">
	                	<div class="form-group col-sm-4">
	                           <select id="titleId" class="form-control" name="title" required>
		                             <option value="Mr.">Mr.</option>
		                             <option value="Mrs.">Mrs.</option>
		                             <option value="Ms.">Ms.</option>
		                             <option value="Dr.">Dr.</option>
	                            </select>
	                  </div>
                        <div class="form-group col-sm-4">
                        	<input type="text" class="form-control" name="fname" id="FnameId" required placeholder="First Name">
                        </div>
                 		<div class="form-group col-sm-4">
                           <input type="text" class="form-control" name="lname" id="LnameId" required placeholder="Last Name">
                        </div>
                        <div class="form-group col-sm-4">
                             <select id="select1" class="form-control" required name="departmentId">
                              	  <option value="0">Select Department</option>
                              	  <s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                              	  <s:iterator value="selectDepartmentsList">
                                  	<option value="<s:property value="departmentId"/>"><s:property value="departmentName" /> </option>
                                  </s:iterator>
                                  </s:if>
                            </select>
                      </div>
                   		<div class="form-group col-sm-4" id="emailparentId">
                           <input type="email" class="form-control" name="email" id="emailId" required placeholder="Email Id">
                         </div>
                         <div class="form-group col-sm-4" id="emailparentId">
                           <input type="password" class="form-control" name="password" required placeholder="Password">
                         </div>
                 		
                            
                            <div class="form-group col-sm-12">
                            	<button class="bttn" onclick="return saveTeacher();">SAVE</button>
                            	<button class="bttn" onclick="return cancelTeacher();">CANCEL</button>
                            </div>
                            </form>
                  		</div>	
        </div>
        
        
        <div id="editStudentBox" style="display:none">
        		  <div class="row">
                	<form id="addStudentFormId" action="saveStudent" method="post">
                		<input type="text" name="userId" style="display:none;" id="userId">
	                	<div class="form-group col-sm-4">
	                           <select id="titleId" class="form-control" name="title" required>
		                             <option value="Mr.">Mr.</option>
		                             <option value="Mrs.">Mrs.</option>
		                             <option value="Ms.">Ms.</option>
		                             <option value="Dr.">Dr.</option>
	                            </select>
	                  </div>
                        <div class="form-group col-sm-4">
                        	<input type="text" class="form-control" name="fname" id="FnameId" required placeholder="First Name">
                        </div>
                 		<div class="form-group col-sm-4">
                           <input type="text" class="form-control" name="lname" id="LnameId" required placeholder="Last Name">
                        </div>
                   		<div class="form-group col-sm-4" id="emailparentId">
                           <input type="email" class="form-control" name="email" id="emailId" required placeholder="Email Id">
                         </div>
                         <div class="form-group col-sm-4" id="emailparentId">
                           <input type="text" class="form-control" name="password" required placeholder="Password" id="passwordId">
                         </div>
                 		
                            
                            <div class="form-group col-sm-12">
                            	<button class="bttn">UPDATE</button>
                            	<button class="bttn" onclick="return cancelTeacher();">CANCEL</button>
                            </div>
                            </form>
                  		</div>	
        </div>
            
            </div>
          </div> 
		<div id="studentTableDivId">
           <s:include value="studentTable.jsp"></s:include>
        </div>
    
  </div>
  <!-- mainpanel --> 
  
  
  <script type="text/javascript">

         function Show_Div() {
			$("#addTeacherBox").show();
			$("#addmapbx").hide(); 
           return false;
        }
		 function Show_MapDiv() {
			$("#addmapbx").show();
			$("#addTeacherBox").hide();
           return false;
        }
		
		function cancelTeacher() {
			 $("#addTeacherBox").hide();
           return false;
        }
		
		 
		
		
    </script>
  