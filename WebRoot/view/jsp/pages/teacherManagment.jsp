 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script type="text/javascript">
 
 function validPassword(password){
	 var expr = /^(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9]+)|(?=.*[0-9])(?=.*[a-zA-Z])([a-zA-Z0-9-+_!@#$%^&*.,?]+)$/;
		 return expr.test(password);
}
 
 	function getTeacherTable(){
 		var orgId = $("#selectOrgId").val();
 			$("#addTeacherBox").hide();
			$("#mapteacher").hide();
 		if(orgId>0){
 			$("#mapButtonDivId").show();
 			$("#addButtonDivId").hide();
 		}else{
 			$("#mapButtonDivId").hide();
 			$("#addButtonDivId").show();
 		}
 		startwindowDisable();
 		var url="getTeacherTable?organisationId="+orgId;
 		$.get(url, function( data ) {
		  $("#teacherTableDivId").html( data );
		  endwindowDisable();
		});
 			getDepartment();
 	}
 	
 	
 	function Show_Div(){
 					$("#FnameId").val("");
			 		$("#LnameId").val("");
			 		$("#contactNoId").val("");
			 		$("#addressId").val("");
			 		$("#titleId").val("Mr.");
			 		$("#updateId").val(0);
					$("#addTeacherBox").show();
					$("#mapteacher").hide();
					$("#passwordId").val("");
					$("#emailparentId").show();
					$("#updateButtonId").hide();
					$("#saveButtonId").show();
					$("#addmapbx").hide(); 
	           return false;
	        }
        
        /*  function Show_Div1() {
			$("#mapteacher").show();
			$("#addTeacherBox").hide();
           return false;
        } */
		
		
		function getCourses(){
	 	var orgId = $("#selectOrgId").val();
	 	var depId = $("#selectDepId").val();
	 	var groupId = $("#selectGroupId").val();
		 if(orgId !=0){
		 	startwindowDisable();
			 var url="getCourses?organisationId="+orgId+"&departmentId="+depId+"&groupId="+groupId;
			$.get( url, function(data) {
			 endwindowDisable();
			$("#courseSelectId").html("<option value='0'>All</option>");
			var result = JSON.parse(data);
			  var optionHtml="<option value='0'>All</option>";
			  for(var i=0;i<result.length;i++){
			  	optionHtml=optionHtml+"<option value='"+result[i].courseId+"'>"+result[i].courseName+"</option>";
			  }
			   $("#courseSelectId").html(optionHtml);
			});
		}else{
			$("#selectDepId").html("<option value='0'>All</option>");
			 $("#selectGroupId").html("<option value='0'>All</option>");
		}
 	}
 	
 	
 	function saveTeacher(){
 		var orgId = $("#selectOrgId").val();
 		
 		var Fname = $("#FnameId").val();
 		var Lname = $("#LnameId").val();
 		var email = $("#emailId").val();
 		var contactNo = $("#contactNoId").val();
 		var password = $("#passwordId").val();
 		/* var joiningDate = $("#joiningDateId").val();
 		var dateOfBirth = $("#dateOfBirthId").val(); */
 		var address = $("#addressId").val();
 		
 		 if(Fname==""){
				showSuccessMessage("Please Enter First Name");
				return false;
				} if(Lname==""){
				showSuccessMessage("Please Enter Last Name");
				return false;
				} if(email==""){
				showSuccessMessage("Please Enter Email");
				return false;
				} else if(!ValidateEmail(email)){
					showSuccessMessage("Please Enter Valid Email");
				return false;
				}if(contactNo==""){
				showSuccessMessage("Please Enter Contact Number");
				return false;
				} if(password==""){
				showSuccessMessage("Please Enter Password");
				return false;
				}if(!validPassword(password)||password.length<8){
					showSuccessMessage("Short passwords are easy to guess. Try one with at least 8-16 characters including a alphabet and a number.");
					return false;
				}
				
				 /* if(dateOfBirth==""){
				showSuccessMessage("Please Enter Date Of Birth");
				return false;
				} */ if(address==""){
				showSuccessMessage("Please Enter Address");
				$("#FnameId").val("");
 				$("#LnameId").val("");
 				$("#emailId").val("");
 				$("#contactNoId").val("");
 				$("#passwordId").val("");
				return false;
				}
 		
 		var data = $("#addTeacherFormId").serialize();
 		data=data+"&organisationId="+orgId;
 		$.ajax({
 		 url:"saveTeacher",
 		 type :"POST",
		  data : data,
			beforeSend : function(){
			startwindowDisable();
		  },
		  success : function(result){
		  	$("#addTeacherBox").hide();
		  	$("#pageContentDivId").html(result);
		  	endwindowDisable();
		  }
		});
		$("#FnameId").val("");
 		$("#LnameId").val("");
 		$("#emailId").val("");
 		$("#emailId").val("");
 		 $("#passwordId").val("");
 		  $("#contactNoId").val("");
 		/* var joiningDate = $("#joiningDateId").val("");
 		var dateOfBirth = $("#dateOfBirthId").val(""); */
 		var address = $("#addressId").val("");
		return false;
 	}
 	
 	
 	function mapTeacher(){
 		var orgId = $("#selectOrgId").val();
 		var data =	$("#teacherMapFormId").serialize();
 		data=data+"&organisationId="+orgId;
 		$.ajax({
 		 url:"mapTeacher",
 		 type :"POST",
		  data : data,
			beforeSend : function(){
			startwindowDisable();
		  },
		  success : function(result){
		  	$("#addTeacherBox").hide();
		  	$("#teacherTableDivId").html(result);
		  	endwindowDisable();
		  }
		});
		$("#mapteacher").hide();
 		return false;
 	}
 	
 	
 	function changeTeacherStatus(userId,status){
 		var url="changeTeacherStatus?userId="+userId+"&status="+status;
 		startwindowDisable();
	 		$.get(url, function( data ) {
			  $("#teacherTableDivId").html( data );
			  endwindowDisable();
			});
 		return false;
 	}
 	
 	function editTeacher(id){
 	
	 	var title=$("#title--"+id).val();
	 	var fname=$("#fname--"+id).val();
	 	var lname=$("#lname--"+id).val();
	 	var contactNo=$("#contactNo--"+id).val();
	 	var add=$("#address--"+id).val();
	 	var password=$("#password--"+id).val();

 		$("#FnameId").val(fname);
 		$("#LnameId").val(lname);
 		$("#contactNoId").val(contactNo);
 		$("#addressId").val(add);
 		$("#titleId").val(title);
 		$("#updateId").val(id);
 		$("#passwordId").val(password);
 		$("#emailparentId").hide();
 		$("#addTeacherBox").show();
 		$("#updateButtonId").show();
		$("#saveButtonId").hide();
		
 	}
 		
 	
 	
 	function updateTeacher(){
 		var orgId = $("#selectOrgId").val();
 		var Fname = $("#FnameId").val();
 		var Lname = $("#LnameId").val();
 		var contactNo = $("#contactNoId").val();
 		var address = $("#addressId").val();
 		var password = $("#passwordId").val();
 		
 		 if(Fname==""){
				showSuccessMessage("Please Enter First Name");
				return false;
				} if(Lname==""){
				showSuccessMessage("Please Enter Last Name");
				return false;
				} if(contactNo==""){
				showSuccessMessage("Please Enter Contact Number");
				return false;
				}  if(address==""){
				showSuccessMessage("Please Enter Address");
				return false;
				}if(password==""){
				showSuccessMessage("Please Enter Password");
				return false;
				}if(!validPassword(password)||password.length<8){
					showSuccessMessage("Short passwords are easy to guess. Try one with at least 8-16 characters including a alphabet and a number.");
					return false;
				}
 		
 		var data = $("#addTeacherFormId").serialize();
 		data=data+"&organisationId="+orgId;
 		$.ajax({
 		 url:"updateTeacher",
 		 type :"POST",
		  data : data,
			beforeSend : function(){
			startwindowDisable();
		  },
		  success : function(result){
		  	$("#addTeacherBox").hide();
		  	$("#teacherTableDivId").html(result);
		  	endwindowDisable();
		  }
		});
		$("#FnameId").val("");
 		$("#LnameId").val("");
 		$("#contactNoId").val("");
 		$("#addressId").val("");
 		$("#passwordId").val("");
 		$("#addTeacherBox").hide();
		$("#updateButtonId").hide();
		return false;
 	}
 	
 	
 	function getTeacherChoice(){
 		var orgId = $("#selectOrgId").val();
	 	var depId = $("#selectDepId").val();
	 	var groupId = $("#selectGroupId").val();
	 	var courseId = $("#courseSelectId").val();
	 	
	 	if(courseId !=0){
		 	var url="getTeacherChoice?courseId="+courseId+"&departmentId="+depId+"&organisationId="+orgId+"&groupId="+groupId;
			$.get( url, function(data) {
			  var result = JSON.parse(data);
			  var optionHtml="";
			  for(var i=0;i<result.length;i++){
			  	optionHtml=optionHtml+"<option value='"+result[i].userId+"'>"+result[i].userName+"</option>";
			  }
			   $("#selectTeacherId").html(optionHtml);
			   if(result.length>0){
			   		$("#mapTeacherButtonId").show();
			   }
			});
		}else{
			$("#selectTeacherId").html("<option value='0'></option>");
			$("#mapTeacherButtonId").hide();
		}
 		return false;
 	}
 	
 	
 	function mapTeaherNewOrg(){
 		var id = $("#mapUserId").val();
 		window.location="mapTeaherNewOrg?mapTeacherId="+id;
 		//hideMessage('actionMessageId');
 	}
 	
 	function cancelTeacher(){
 		$("#FnameId").val("");
 		$("#LnameId").val("");
 		$("#contactNoId").val("");
 		$("#addressId").val("");
 		$("#passwordId").val("");
 		$("#addTeacherBox").hide();
		$("#updateButtonId").hide();
 		return false;
 	}
 	
 	function filterData(status,count){
 		if(status==0){
 			$("#coachDetail"+count+" .detatilRow").hide();
 			$("#coachDetail"+count+" #row-"+status).show();
 		}else if(status==1){
 			$("#coachDetail"+count+" .detatilRow").hide();
 			$("#coachDetail"+count+" #row-"+status).show();
 		}else if(status==2){
 			$("#coachDetail"+count+" .detatilRow").hide();
 			$("#coachDetail"+count+" #row-"+status).show();
 		}else{
 			$("#coachDetail"+count+" .detatilRow").show();
 		}
 		return false;
 	}
 </script>
 
 <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-hospital-o"></i> User Management</a></li>            
            <li class="active"><i class="fa fa-user mr5"></i>Coach</li>
          </ol>    
           <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		 <div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if> 
                 <select id="selectOrgId" class="form-control" name="organisationId" style="display:none;">
	                              <s:if test="#session.organisationList !=null">
		                             <s:if test="#session.loginDetail.userType==4">
		                             	<option value="0">All</option>
		                             	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:if>
		                              	<s:else>
		                              	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:else>
	                              </s:if>
                            </select>
           <!---- <div class="panel" id="ddd">
                
                <div class="panel-body">
                  	<div class="row">
                    		<div class="form-group col-sm-4">
                            <label>School</label>
                            <select id="select1" class="form-control" required>
                              <option value="">Select School</option>
                              <option value="">School Option 1</option>
                              <option value="">School Option 2</option>
                              <option value="">School Option 3</option>                              
                            </select>
                  </div>
                  			<div class="form-group col-sm-4">
                            <label>Department</label>
                        <select id="select1" class="form-control" required>
                          <option value="">Select Department</option>
                          		<option value="">Department Option 1</option>
                              <option value="">Department Option 2</option>
                              <option value="">Department Option 3</option>
                        </select>
                  </div>
                  			<div class="form-group col-sm-4">
                            <label>Group</label>
                        <select id="select1" class="form-control" required>
                          <option value="">Select Group</option>
                          <option value="">Group Option 1</option>
                              <option value="">Group Option 2</option>
                              <option value="">Group Option 3</option>
                        </select>
                  </div>
                    </div>
    
                </div>
              </div>  --->
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-12">
              	  <button class="bttn pull-right btn-pos" onclick="return Show_Div();"   data-id="addTeacherBox">ADD Coach <i class="fa fa-plus-circle"></i></button>
                  <!-- <button class="bttn pull-right btn-pos" onclick="return Show_MapDiv();"   data-id="addmapbx">MAP <i class="fa fa-plus-circle"></i></button> -->
                  <button class="bttn pull-right btn-pos" data-toggle="modal" data-target="#resourseModal">ASSIGN COURSE <i class="fa fa-plus-circle"></i></button>
                </div>
              </div>
              
            </div>
            
            <div class="panel-body">
            
        	<!-- Modal -->
                        <div id="resourseModal" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                                <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                 <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Map Courses</h4>
                              </div>
                              <div class="modal-body modal_scroll">
                                <div class="row">
                                 <form id="coachContainerMapFormId" action="mapTeacher" method="post">
                                     <div class="form-group col-sm-4">
                                         <select class="form-control" onChange="Show_leftDiv(this)" id="selectID" name="userId">
                                              <option value="0">Select Coach</option>
                                              <s:if test="teacherList !=null && teacherList.size()>0">
                                              <s:iterator value="teacherList">
                                              		<option value="<s:property value="userId" />"><s:property value="fname" />&nbsp;<s:property value="lname" /> </option>
                                              	</s:iterator>
                                              </s:if>
                                            </select>
                                     </div>
                                     <div class="col-sm-12" style="display:none" id="lefttoright">
                                     
                                     	 <!-- coachContainerDetail jsp appended here by jquery on teacher selection -->
                                     	 
                                     	 <br/>
                                        <button type="button" class="bttn">SAVE</button>
                                        <button type="button" class="bttn" onClick="return enable_leftDiv();">CANCEL</button>

                                    </div>
                                 </form>
                                </div>
                                     
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       
                        <!-----modal ends------->
             
             <%-- <div id="addmapbx" style="display:none;">
        	
        	<h4>MAP COACH</h4>
                  <form id="teacherMapFormId">
                  			<div class="form-group col-sm-4">
                            <label>Department</label>
                        <select id="selectDepId" class="form-control" onchange="getGroups();" name="departmentId">
                      	<option value="0">All</option>
                      	<s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                      	<s:iterator value="selectDepartmentsList">
		                              		<option value="<s:property value="departmentId"/>"><s:property value="departmentName"/> </option>
		                              	</s:iterator>
		                              </s:if>
                      </select>
                  </div>
                  			<div class="form-group col-sm-4">
                            <label>Group</label>
                       <select id="selectGroupId" class="form-control"  onchange="getCourses();" name="groupId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  <div class="form-group col-sm-4">
                            <label>Course</label>
                        <select id="courseSelectId" class="form-control" onchange="return getTeacherChoice();" name="courseId">
                        	<option value="0">All</option>
                        </select>
                  </div>	
                  <div class="form-group col-sm-4">
                        <label>COACH</label>
                        <select id="selectTeacherId" class="form-control" name="userId">
                       
                        </select>
                  </div>
                  
                   
                            <div class="form-group col-sm-12" style="display: none;" id="mapTeacherButtonId">
                            	<button class="bttn" onclick="return mapTeacher();">Map</button>
                            </div>
                       </form>
                    </div>	 --%>
             	
            	<div id="addTeacherBox" style="display:none">
        	
        		
        	
            	<div class="row">
                	<form id="addTeacherFormId">
                	
                		<input type="text" class="form-control" name="userId" id="updateId" style="display:none;">
	                	<div class="form-group col-sm-2">
	                           <!--  <label>Title</label> -->
	                             <select id="titleId" class="form-control" name="title" required>
		                             <option value="Mr.">Mr.</option>
		                             <option value="Mrs.">Mrs.</option>
		                             <option value="Ms.">Ms.</option>
		                             <option value="Dr.">Dr.</option>
	                            </select>
	                  </div>
                    		<div class="form-group col-sm-5">
                            <%-- <label>First Name <span class="strike_color">*</span></label> --%>
                            <!-- <div class="form-group"> -->
                           		 <input type="text" class="form-control" name="Fname" id="FnameId" placeholder="First Name">
                          <!-- </div> -->
                  </div>
                  
                  			<div class="form-group col-sm-5">
                            <%-- <label>Last Name <span class="strike_color">*</span></label> --%>
                            <!-- <div class="form-group"> -->
                           		 <input type="text" class="form-control" name="Lname" id="LnameId" placeholder="Last Name">
                          <!-- </div> -->
                  </div>
                  <div class="form-group col-sm-2">
                           <%--  <label>Contact No. <span class="strike_color">*</span></label> --%>
                           		 <input type="text" class="form-control" name="contactNo" id="contactNoId" placeholder="Contact Number">
                  </div>
                  <div class="form-group col-sm-5" id="emailparentId">
                            <%-- <label>Email <span class="strike_color">*</span></label> --%>
                           <!--  <div class="form-group"> -->
                           		 <input type="email" class="form-control" name="email" id="emailId" placeholder="email">
                          <!-- </div> -->
                  </div>
                  			
                  			<div class="form-group col-sm-5">
                           <%--  <label>Password <span class="strike_color">*</span></label> --%>
                           		<!-- <div class="form-group"> -->
                           		 <input type="password" class="form-control" name="password" id="passwordId" placeholder="Password">
                          <!-- </div> -->
                  </div>
                 			
                  
                  <%-- <div class="form-group col-sm-4">
                            <label>Address <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		 <input type="text" class="form-control" name="address" id="addressId" required>
                          </div>
                  </div> --%>
                 			 <!-- <div class="form-group col-sm-4">
                            <label>Photo</label>
                          <div class="form-group">
                           		 <input type="text" class="form-control" name="profileImgName" id="profileImgNameId">
                          </div>
                  </div> -->
                  
                            
                            <div class="form-group col-sm-12" id="saveButtonId" style="display:none;">
                            	<button class="bttn" onclick="return saveTeacher();">SAVE</button>
                            	&nbsp;&nbsp; <button class="bttn" onclick="return cancelTeacher();">CANCEL</button>
                            </div>
                            <div class="form-group col-sm-12" id="updateButtonId" style="display:none;">
                            	<button class="bttn" onclick="return updateTeacher();">update</button>
                            	&nbsp;&nbsp; <button class="bttn" onclick="return cancelTeacher();">CANCEL</button>
                            </div>
                            </form>
                  		</div>	
                    
           
            
            
            
        </div>
            
            </div>
          </div> 
          
          <div class="panel-group" id="accordion">
              <div id="course-panel">     
                <div class="panel">
                  <div class="panel-heading">
                    <div class="panel-body">
                     <div class="table-responsive">
			               	<div id="teacherTableDivId">
			               		<s:include value="teacherTable.jsp"></s:include>
			               	</div>
			              </div><!-- table-responsive -->
                    
                      <!-- <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" class="text-center">
                               S.No
                              </th>
                              <th width="45%" bgcolor="#e1e1e1">Teacher name</th>
                              <th width="15%" bgcolor="#e1e1e1" class="text-center">Email</th> 
                              <th width="10%" bgcolor="#e1e1e1" class="text-center">course</th>                     
                              <th width="25%" bgcolor="#e1e1e1" class="text-center">Action</th>
                            </tr>
                          </thead>
                          <tbody>
                            <tr>
                              <td bgcolor="#e1e1e1" class="text-center">
                               1
                              </td>
                              <td bgcolor="#e1e1e1">LINDA</td>
                               <td bgcolor="#e1e1e1">linda@growthcafe.com</td>
                              <td bgcolor="#e1e1e1" class="text-center"><button class="bttn" type="button" data-toggle="modal" data-target="#departmentmodal">1</button></td>                      
                              <td bgcolor="#e1e1e1" class="text-center"> <button class="bttn" type="submit">EDIT</button> <button class="bttn" type="submit">DEACTIVATE</button></td>
                                                   
                            </tr>
                            
                           </tbody>
                        </table>
                        
                     </div> -->
                     
                               <!-- Modal -->
                        <!-- <div id="departmentmodal" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog">
                        
                            Modal content
                            <div class="modal-content">
                              <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                                   -<button type="button" class="bttn pull-right">ADD RESOURCES</button>-
                                <h4 class="modal-title">Teacher Details</h4>
                              </div>
                              <div class="modal-body">
                                
                               
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th class="text-center" bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="50%" bgcolor="#e1e1e1">Department</th>
                                                  <th width="15%" bgcolor="#e1e1e1" class="text-center">Group</th>
                                                  <th width="25%" bgcolor="#e1e1e1" class="text-center">Course</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                <tr>
                                                  <td class="text-center" bgcolor="#e1e1e1">1</td>
                                                  <td bgcolor="#e1e1e1">Sales</td>  
                                                  <td bgcolor="#e1e1e1" class="text-center">Beginner</td> 
                                                  <td bgcolor="#e1e1e1" class="text-center">Learning Sales</td> 
                                                </tr>
                                               
                                              </tbody>
                                            </table>
                                          </div>        
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div> -->
                       
                        <!-----modal ends------->
                        
                                                  
                    </div>
                  </div>
                  
                </div>
              </div>
          </div>
    </div>
    <!-- contentpanel --> 
    
  </div>
  
  
  
<script type="text/javascript">
function Show_leftDiv(elem) {
			if(elem.value==0){
			document.getElementById('lefttoright').style.display = "none";
			}
			else{
				$.get("getCoachContainerDetail?userId="+elem.value, function( data ) {
			  	$("#lefttoright").html(data);
			  	/**
			  	Multi Selection Script start
			  	*/
				window.prettyPrint && prettyPrint();
				
				if ( window.location.hash ) {
					scrollTo(window.location.hash);
				}
				
				$('.nav').on('click', 'a', function(e) {
					scrollTo($(this).attr('href'));
				});
		
				$('#multiselect').multiselect();
		
				$('[name="q"]').on('keyup', function(e) {
					var search = this.value;
					var $options = $(this).next('select').find('option');
		
					$options.each(function(i, option) {
						if (option.text.indexOf(search) > -1) {
							$(option).show();
						} else {
							$(option).hide();
						}
					});
				});
		
				$('#search').multiselect({
					search: {
						left: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
						right: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
					}
				});
		
				$('.multiselect').multiselect();
				$('.js-multiselect').multiselect({
					right: '#js_multiselect_to_1',
					rightAll: '#js_right_All_1',
					rightSelected: '#js_right_Selected_1',
					leftSelected: '#js_left_Selected_1',
					leftAll: '#js_left_All_1'
				});
		
				$('#keepRenderingSort').multiselect({
					keepRenderingSort: true
				});
		
				$('#undo_redo').multiselect();
		
				$('#multi_d').multiselect({
					right: '#multi_d_to, #multi_d_to_2',
					rightSelected: '#multi_d_rightSelected, #multi_d_rightSelected_2',
					leftSelected: '#multi_d_leftSelected, #multi_d_leftSelected_2',
					rightAll: '#multi_d_rightAll, #multi_d_rightAll_2',
					leftAll: '#multi_d_leftAll, #multi_d_leftAll_2',
		
					moveToRight: function(Multiselect, options, event, silent, skipStack) {
						var button = $(event.currentTarget).attr('id');
		
						if (button == 'multi_d_rightSelected') {
							var left_options = Multiselect.left.find('option:selected');
							Multiselect.right.eq(0).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
							}
						} else if (button == 'multi_d_rightAll') {
							var left_options = Multiselect.left.find('option');
							Multiselect.right.eq(0).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
							}
						} else if (button == 'multi_d_rightSelected_2') {
							var left_options = Multiselect.left.find('option:selected');
							Multiselect.right.eq(1).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
							}
						} else if (button == 'multi_d_rightAll_2') {
							var left_options = Multiselect.left.find('option');
							Multiselect.right.eq(1).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(1).eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
							}
						}
					},
		
					moveToLeft: function(Multiselect, options, event, silent, skipStack) {
						var button = $(event.currentTarget).attr('id');
		
						if (button == 'multi_d_leftSelected') {
							var right_options = Multiselect.right.eq(0).find('option:selected');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						} else if (button == 'multi_d_leftAll') {
							var right_options = Multiselect.right.eq(0).find('option');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						} else if (button == 'multi_d_leftSelected_2') {
							var right_options = Multiselect.right.eq(1).find('option:selected');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						} else if (button == 'multi_d_leftAll_2') {
							var right_options = Multiselect.right.eq(1).find('option');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						}
					}
				});
					  	/**
			  			*	Multi Selection Script end
			  			*/
			  	
			  		document.getElementById('lefttoright').style.display = "block";
				});
				
			}
			
		}
		
    </script>
    
    <script type="text/javascript">
	$(document).ready(function() {
		// make code pretty
		window.prettyPrint && prettyPrint();
		
		if ( window.location.hash ) {
			scrollTo(window.location.hash);
		}
		
		$('.nav').on('click', 'a', function(e) {
			scrollTo($(this).attr('href'));
		});

		$('#multiselect').multiselect();

		$('[name="q"]').on('keyup', function(e) {
			var search = this.value;
			var $options = $(this).next('select').find('option');

			$options.each(function(i, option) {
				if (option.text.indexOf(search) > -1) {
					$(option).show();
				} else {
					$(option).hide();
				}
			});
		});

		$('#search').multiselect({
			search: {
				left: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
				right: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
			}
		});

		$('.multiselect').multiselect();
		$('.js-multiselect').multiselect({
			right: '#js_multiselect_to_1',
			rightAll: '#js_right_All_1',
			rightSelected: '#js_right_Selected_1',
			leftSelected: '#js_left_Selected_1',
			leftAll: '#js_left_All_1'
		});

		$('#keepRenderingSort').multiselect({
			keepRenderingSort: true
		});

		$('#undo_redo').multiselect();

		$('#multi_d').multiselect({
			right: '#multi_d_to, #multi_d_to_2',
			rightSelected: '#multi_d_rightSelected, #multi_d_rightSelected_2',
			leftSelected: '#multi_d_leftSelected, #multi_d_leftSelected_2',
			rightAll: '#multi_d_rightAll, #multi_d_rightAll_2',
			leftAll: '#multi_d_leftAll, #multi_d_leftAll_2',

			moveToRight: function(Multiselect, options, event, silent, skipStack) {
				var button = $(event.currentTarget).attr('id');

				if (button == 'multi_d_rightSelected') {
					var left_options = Multiselect.left.find('option:selected');
					Multiselect.right.eq(0).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
					}
				} else if (button == 'multi_d_rightAll') {
					var left_options = Multiselect.left.find('option');
					Multiselect.right.eq(0).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
					}
				} else if (button == 'multi_d_rightSelected_2') {
					var left_options = Multiselect.left.find('option:selected');
					Multiselect.right.eq(1).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
					}
				} else if (button == 'multi_d_rightAll_2') {
					var left_options = Multiselect.left.find('option');
					Multiselect.right.eq(1).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(1).eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
					}
				}
			},

			moveToLeft: function(Multiselect, options, event, silent, skipStack) {
				var button = $(event.currentTarget).attr('id');

				if (button == 'multi_d_leftSelected') {
					var right_options = Multiselect.right.eq(0).find('option:selected');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				} else if (button == 'multi_d_leftAll') {
					var right_options = Multiselect.right.eq(0).find('option');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				} else if (button == 'multi_d_leftSelected_2') {
					var right_options = Multiselect.right.eq(1).find('option:selected');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				} else if (button == 'multi_d_leftAll_2') {
					var right_options = Multiselect.right.eq(1).find('option');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				}
			}
		});
	});
	
	function scrollTo( id ) {
		if ( $(id).length ) {
			$('html,body').animate({scrollTop: $(id).offset().top - 40},'slow');
		}
	}
	</script>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  <script>
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
			$("#addTeacherBox").show();
			$("#addmapbx").hide(); 
           return false;
        } */
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
    

  
 <%-- <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-book mr5"></i> User Management</a></li>            
            <li class="active">Teacher</li>
          </ol>     
                 
            <div class="panel" id="ddd">
                
                <div class="panel-body">
                  	<div class="row">
                    		<div class="form-group col-sm-4">
                            <label>Organization</label>
                             <select id="selectOrgId" class="form-control"  onchange="getTeacherTable();" name="organisationId">
	                              <s:if test="#session.organisationList !=null">
		                             <s:if test="#session.loginDetail.userType==4">
		                             	<option value="0">All</option>
		                             	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:if>
		                              	<s:else>
		                              	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:else>
	                              </s:if>
                            </select>
                  </div>
                  			
                  			
                    </div>
    
                </div>
              </div>  
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-8"></div>
                <div class="col-sm-2" id="addButtonDivId" style="float: right !important;">
                	<button class="btn btn-default btn-quirk btn-stroke pull-right scroll-link"  onclick="return Show_Div();"   data-id="addcoursebx">ADD TEACHER <i class="fa fa-plus-circle"></i></button>
                    
                </div>
                <div class="col-sm-2" id="mapButtonDivId" >
                	<button class="btn btn-default btn-quirk btn-stroke pull-right scroll-link"  onclick="return Show_Div1();"   data-id="mapteacher">MAP TEACHER <i class="fa fa-plus-circle"></i></button>
                </div>
              </div>
              
            </div>
            
            <div class="panel-body">
            		<div id="addTeacherBox" style="display:none;">
        	
        		<h4>ADD TEACHER</h4>
        	
            	<div class="row">
                	<form id="addTeacherFormId">
                	
                		<input type="text" class="form-control" name="userId" id="updateId" style="display:none;">
	                	<div class="form-group col-sm-4">
	                            <label>Title</label>
	                             <select id="titleId" class="form-control" name="title">
		                             <option value="Mr.">Mr.</option>
		                             <option value="Mrs.">Mrs.</option>
		                             <option value="Ms.">Ms.</option>
		                             <option value="Dr.">Dr.</option>
	                            </select>
	                  </div>
                    		<div class="form-group col-sm-4">
                            <label>First Name <span class="strike_color">*</span></label>
                            <div class="form-group">
                           		 <input type="text" class="form-control" name="Fname" id="FnameId">
                          </div>
                  </div>
                  
                  			<div class="form-group col-sm-4">
                            <label>Last Name <span class="strike_color">*</span></label>
                            <div class="form-group">
                           		 <input type="text" class="form-control" name="Lname" id="LnameId">
                          </div>
                  </div>
                  
                  <div class="form-group col-sm-4" id="emailparentId">
                            <label>Email <span class="strike_color">*</span></label>
                            <div class="form-group">
                           		 <input type="text" class="form-control" name="email" id="emailId">
                          </div>
                  </div>
                  			<div class="form-group col-sm-4">
                            <label>Contact No. <span class="strike_color">*</span></label>
                       		<div class="form-group">
                           		 <input type="text" class="form-control" name="contactNo" id="contactNoId">
                          </div>
                  </div>
                  			
                  			<div class="form-group col-sm-4">
                            <label>Password <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		<div class="form-group">
                           		 <input type="text" class="form-control" name="password" id="passwordId">
                          </div>
                          </div>
                  </div>
                 			 <div class="form-group col-sm-4">
                            <label>Date Of Birth <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		 <input type="text" class="form-control" name="dateOfBirth" id="dateOfBirthId">
                          </div>
                  </div>
                  
                  <div class="form-group col-sm-4">
                            <label>Address <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		 <input type="text" class="form-control" name="address" id="addressId">
                          </div>
                  </div>
                 			 <!-- <div class="form-group col-sm-4">
                            <label>Photo</label>
                          <div class="form-group">
                           		 <input type="text" class="form-control" name="profileImgName" id="profileImgNameId">
                          </div>
                  </div> -->
                  
                  
                  			
                            
                            <div class="form-group col-sm-12"  id="saveButtonId" style="display:none;">
                            	<button class="btn btn-danger btn-quirk" onClick="return saveTeacher();">save</button>
                            	&nbsp;&nbsp; <button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelTeacher();">CANCEL</button>
                            </div>
                            <div class="form-group col-sm-12" id="updateButtonId" style="display:none;">
                            	<button class="btn btn-danger btn-quirk" onClick="return updateTeacher();">update</button>
                            	&nbsp;&nbsp; <button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelTeacher();">CANCEL</button>
                            </div>
                            </form>
                  		</div>	
                    
           
            
            
            
        </div>
        <div id="mapteacher" style="display:none;">
        	
        	<h4>MAP TEACHER</h4>
                  <form id="teacherMapFormId">
                  			<div class="form-group col-sm-4">
                            <label>Department</label>
                        <select id="selectDepId" class="form-control" onchange="getGroups();" name="departmentId">
                      	<option value="0">All</option>
                      	<s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                      	<s:iterator value="selectDepartmentsList">
		                              		<option value="<s:property value="departmentId"/>"><s:property value="departmentName"/> </option>
		                              	</s:iterator>
		                              </s:if>
                      </select>
                  </div>
                  			<div class="form-group col-sm-4">
                            <label>Group</label>
                       <select id="selectGroupId" class="form-control"  onchange="getCourses();" name="groupId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  <div class="form-group col-sm-4">
                            <label>Course</label>
                        <select id="courseSelectId" class="form-control" onchange="return getTeacherChoice();" name="courseId">
                        	<option value="0">All</option>
                        </select>
                  </div>	
                  <div class="form-group col-sm-4">
                        <label>Teacher</label>
                        <select id="selectTeacherId" class="form-control" name="email">
                       
                        </select>
                  </div>
                  
                   
                            <div class="form-group col-sm-12" style="display: none;" id="mapTeacherButtonId">
                            	<button class="btn btn-danger btn-quirk" onclick="return mapTeacher();">Map</button>
                            </div>
                       </form>
                    </div>	
                    
           
            
            
            
        </div>
            
              <div class="table-responsive">
               	<div id="teacherTableDivId">
               		<s:include value="teacherTable.jsp"></s:include>
               	</div>
              </div><!-- table-responsive -->
            </div>
          </div>   
          
          	

	
        
        
        
        
           	
    </div>
    <!-- contentpanel --> 
    
  </div> --%>
  <!-- mainpanel --> 
  