 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script type="text/javascript">
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
	           return false;
	        }
        
 	
 	function saveAdmin(){
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
				}if(contactNo.length!=10 || !testNumber(contactNo)){
					showSuccessMessage("Please Enter 10 digit contact number");
				return false;
				} if(password==""){
				showSuccessMessage("Please Enter Password");
				return false;
				}if(password.length<6){
				showSuccessMessage("Please Enter Password Of Minimum 6 Character.");
				return false;
				} if(address==""){
				showSuccessMessage("Please Enter Address");
				return false;
				}
 		
 		var data = $("#addAdminFormId").serialize();
 		data=data+"&organisationId="+orgId;
 		$.ajax({
 		 url:"saveAdmin",
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
 		$("#addressId").val("");
 		$("#addTeacherBox").hide();
		return false;
 	}
 	
 	
 	function mapAdmin(){
 		var orgId = $("#selectOrgId").val();
 		$("#mapOrgId").val(orgId);
 		/* $("#adminMapFormId").submit(); */
 		var data = $("#adminMapFormId").serialize();
 		var url="mapAdmin";
 		startwindowDisable();
 		$.post(url, data, function( data ) {
 		$("#adminTableDivId").html(data);
			  $("#selectOrgId").val(0);
			  $("#addButtonDivId").show();
			 endwindowDisable();
 		});
 		$("#mapAdminDivId").hide();
 		return false;
 	}
 	
 	
 	/* 
 		function mapAdmin(){
 		var orgId = $("#selectOrgId").val();
 		$("#mapOrgId").val(orgId);
 		//$("#adminMapFormId").submit();
 		var url="mapAdmin.action";
 		var data = $("#adminMapFormId").serialize();
 		$.post(url, data, function( data ) {
 		//startwindowDisable();
			  $("#adminTableDivId").html(data);
			  $("#selectOrgId").val(0);
			 
 		});
 		//$("#mapAdminDivId").hide();
 		
 		return false;
 	} */
 	
 	
 	function changeAdminStatus(userId,orgId,status){
 		var url="changeAdminStatus?userId="+userId+"&status="+status+"&organisationId="+orgId;
 		startwindowDisable();
	 		$.get(url, function( data ) {
			  $("#adminTableDivId").html( data );
			  endwindowDisable();
			   $("#selectOrgId").val(0);
			   $("#addButtonDivId").show();
			});
 		return false;
 	}
 	
 	function editAdmin(title,fname,lname,contactNo,add,password,id){
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
					$("#mapAdminDivId").hide();
			 	}
 		
 	
 	
 	function updateAdmin(){
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
				}if(contactNo.length!=10 || !testNumber(contactNo)){
					showSuccessMessage("Please Enter 10 digit contact number");
				return false;
				}  if(address==""){
				showSuccessMessage("Please Enter Address");
				return false;
				}if(password==""){
				showSuccessMessage("Please Enter Password");
				return false;
				}if(password.length<6){
				showSuccessMessage("Please Enter Password Of Minimum 6 Character.");
				return false;
				} 
 		
 		var data = $("#addAdminFormId").serialize();
 		data=data+"&organisationId="+orgId;
 		$.ajax({
 		 url:"updateAdmin",
 		 type :"POST",
		  data : data,
			beforeSend : function(){
			startwindowDisable();
		  },
		  success : function(result){
		  	$("#addTeacherBox").hide();
		  	$("#adminTableDivId").html(result);
		  	endwindowDisable();
		  }
		});
		$("#FnameId").val("");
 		$("#LnameId").val("");
 		$("#contactNoId").val("");
 		 $("#contactNoId").val("");
 		$("#addressId").val("");
 		$("#addTeacherBox").hide();
 		$("#passwordId").val("");
		return false;
 	}
 	
 	
 	function cancelAdmin(){
		$("#FnameId").val("");
	 	$("#LnameId").val("");
	 	$("#contactNoId").val("");
	 	$("#addressId").val("");
	 	$("#titleId").val("Mr.");
	 	$("#updateId").val(0);
	 	$("#passwordId").val("");
		$("#addTeacherBox").hide();
		$("#updateButtonId").hide();
		$("#saveButtonId").hide();
 	}
 </script>
 
 <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-book mr5"></i> User Management</a></li>            
            <li class="active">Organisation Admin</li>
          </ol>     
                 
            <div class="panel" id="ddd">
                
                <div class="panel-body">
                  	<div class="row">
                    		<div class="form-group col-md-4">
                            <label>Organization</label>
                             <select id="selectOrgId" class="form-control"  onchange="getAdminsToMap();" name="organisationId">
	                             <option value="0">All</option>
	                             <s:if test="#session.organisationList !=null">
	                             	<s:iterator value="#session.organisationList">
	                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/></option>
	                              	</s:iterator>
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
                	<button class="btn btn-default btn-quirk btn-stroke pull-right scroll-link"  onclick="return Show_Div();"   data-id="addcoursebx">ADD ADMIN <i class="fa fa-plus-circle"></i></button>
                    
                </div>
              
              </div>
              
            </div>
            
            
            
              
               	<div id="adminTableDivId">
               		<s:include value="adminTable.jsp"></s:include>
              </div>
          </div>   
          
          	

	
        
        
        
        
           	
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  