 <%@ taglib prefix="s" uri="/struts-tags"%>

<script type="text/javascript">

 				$(document).ready(function() {
					$("#descriptionId").Editor();
					$(".Editor-editor").attr("data-text","Description");
				});

	 function addOrganization(){
	 		$("#organisationFormId").attr("action","saveOrganisation");
			$("#addOrganizationbx").show();
			$("#saveButtonId").show();
			$("#updateButtonId").hide();
			$("#organisationNameId").val("");
			//$("#addressId").val("");
			//$("#metadataId").val("");
			$("#websiteId").val("");
			$("#descriptionId").val("");
			$("#logoFileId").val("");
			$("#orgDescriptionId .Editor-editor").html("");
           return false;
        }
        
function saveOrganisation(){
	var organisationName = $("#organisationNameId").val();
	/* var address = $("#addressId").val(); */
	/* var metadata = $("#metadataId").val(); */
	var website = $("#websiteId").val();
	var description = $("#orgDescriptionId .Editor-editor").html();
	$("#descriptionId").val(description);
	var logo = $("#logoFileId").val();
	$("#updateId").val(0);
	if(organisationName==""){
		showSuccessMessage("Please Enter Organisation");
		return false;
	}/* if(address==""){
		showSuccessMessage("Please Enter Address");
		return false;
	} */if(logo==""){
		showSuccessMessage("Please Enter Logo");
		return false;
	}if(website==""){
		showSuccessMessage("Please Enter Website");
		return false;
	}if(description==""){
		showSuccessMessage("Please Enter Description");
		return false;
	}	
	startwindowDisable();
	$("#organisationFormId").submit();
			/* $.post("saveOrganisation",data,
	       		 function(data,status){
	       		 $("#orgTableDivId").html( data );
	       		 endwindowDisable();
			  	$("#addOrgBox").hide();
			  	$("#organisationFormId").reset();
	        });
	 $("#addOrgBox").hide();
	$("#organisationNameId").val("");
	$("#addressId").val("");
	$("#metadataId").val("");
	$("#websiteId").val("");
	$("#descriptionId").val("");
	$("#logoId").val(""); */
		return false;
}


function cancelOrg(){
	$("#addOrganizationbx").hide();
	$("#organisationNameId").val("");
	$("#addressId").val("");
	$("#metadataId").val("");
	$("#websiteId").val("");
	$("#descriptionId").val("");
	$("#logoId").val("");
	return false;
}

function editOrg(id){

var org= $(".organisationNameClass-"+id).val();
var logo= $(".logoClass-"+id).val();
var address= $(".addressClass-"+id).val();
var web = $(".websiteClass-"+id).val();
var desc = $(".descriptionClass-"+id).val();
 

	$("#organisationNameId").val(org);
	$("#addressId").val(address);
	/* $("#metadataId").val(meta); */
	$("#websiteId").val(web);
	//$("#descriptionId").val(desc);
	$("#logoId").val(logo);
	$("#orgDescriptionId .Editor-editor").html(desc);
	$("#organisationFormId").attr("action","updateOrg");
	$("#updateId").val(id);
	$("#addOrganizationbx").show();
	$("#saveButtonId").hide();
	$("#updateButtonId").show();
	
	

	return false;
}


function updateOrg(){
	var organisationName = $("#organisationNameId").val();
	/* var address = $("#addressId").val(); */
	/* var metadata = $("#metadataId").val(); */
	var website = $("#websiteId").val();
	 $("#descriptionId").val($("#orgDescriptionId .Editor-editor").html());
	  var description = $("#descriptionId").val();
	var logo = $("#logoFileId").val();
	if(organisationName==""){
		showSuccessMessage("Please Enter Organisation");
		return false;
	}/* if(address==""){
		showSuccessMessage("Please Enter Address");
		return false;
	} *//* if(logo==""){
		showSuccessMessage("Please Select Logo");
		return false;
	} */if(website==""){
		showSuccessMessage("Please Enter Website");
		return false;
	}if(description=="" || description=="<br>"){
		showSuccessMessage("Please Enter Description");
		return false;
	}	
	startwindowDisable();
	var data=$("#organisationFormId").submit();
			/* $.post("updateOrg",data,
	       		 function(data,status){
	       		 $("#orgTableDivId").html( data );
	       		 endwindowDisable();
			  	$("#addOrgBox").hide();
			  	$("#organisationFormId").reset();
	        });
	$("#addOrganizationbx").hide();
	$("#organisationNameId").val("");
	$("#addressId").val("");
	$("#metadataId").val("");
	$("#websiteId").val("");
	$("#descriptionId").val("");
	$("#logoId").val(""); */
	return false;
}









/* Admin methods */

function addAdmin(id){
				$("#addAdminBox"+id+" #FnameId").val("");
		 		$("#addAdminBox"+id+" #LnameId").val("");
		 		$("#addAdminBox"+id+" #contactNoId").val("");
		 		$("#addAdminBox"+id+" #addressId").val("");
		 		$("#addAdminBox"+id+" #titleId").val("Mr.");
		 		$("#addAdminBox"+id+" #updateId").val(0);
				$("#addAdminBox"+id).show();
				$("#addAdminBox"+id+" #mapteacher").hide();
				$("#addAdminBox"+id+" #passwordId").val("");
				$("#addAdminBox"+id+" #emailparentId").show();
				$("#addAdminBox"+id+" #updateButtonId").hide();
				$("#addAdminBox"+id+" #saveButtonId").show();
	           return false;
	        }



 	function cancelAdmin(id){
		$("#addAdminBox"+id+" #FnameId").val("");
 		$("#addAdminBox"+id+" #LnameId").val("");
 		$("#addAdminBox"+id+" #contactNoId").val("");
 		$("#addAdminBox"+id+" #addressId").val("");
 		$("#addAdminBox"+id+" #titleId").val("Mr.");
 		$("#addAdminBox"+id+" #updateId").val(0);
		$("#addAdminBox"+id).hide();
		return false;
 	}
 	
 	function editAdmin(title,fname,lname,contactNo,password,id,orgId){
			 		$("#addAdminBox"+orgId+" #FnameId").val(fname);
			 		$("#addAdminBox"+orgId+" #LnameId").val(lname);
			 		$("#addAdminBox"+orgId+" #contactNoId").val(contactNo);
			 		//$("#addAdminBox"+orgId+" #addressId").val(add);
			 		$("#addAdminBox"+orgId+" #titleId").val(title);
			 		$("#addAdminBox"+orgId+" #updateId").val(id);
			 		$("#addAdminBox"+orgId+" #passwordId").val(password);
			 		$("#addAdminBox"+orgId+" #emailparentId").hide();
			 		$("#addAdminBox"+orgId).show();
			 		$("#addAdminBox"+orgId+" #updateButtonId").show();
					$("#addAdminBox"+orgId+" #saveButtonId").hide();
					$("#addAdminBox"+orgId+" #mapAdminDivId").hide();
			 	}
			 	
			 	
			 	
			 	
 	function updateAdmin(orgid){
 		var Fname = $("#addAdminBox"+orgid+" #FnameId").val();
 		var Lname = $("#addAdminBox"+orgid+" #LnameId").val();
 		var contactNo = $("#addAdminBox"+orgid+" #contactNoId").val();
 		/* var address = $("#addAdminBox"+orgid+" #addressId").val(); */
 		var password = $("#addAdminBox"+orgid+" #passwordId").val();
 		
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
				}  /* if(address==""){
				showSuccessMessage("Please Enter Address");
				return false;
				} */if(password==""){
				showSuccessMessage("Please Enter Password");
				return false;
				}if(password.length<6){
				showSuccessMessage("Please Enter Password Of Minimum 6 Character.");
				return false;
				} 
 		
 		var data = $("#addAdminFormId"+orgid).serialize();
 		data=data+"&organisationId="+orgid;
 		$.ajax({
 		 url:"updateAdmin",
 		 type :"POST",
		  data : data,
			beforeSend : function(){
			startwindowDisable();
		  },
		  success : function(result){
		  	$("#addAdminBox"+orgid).hide();
		  	/* $("#adminTableDivId"+orgid).html(result); */
		  	window.location="organization";
		  	endwindowDisable();
		  }
		});
		$("#addAdminBox"+orgid+" #FnameId").val("");
 		$("#addAdminBox"+orgid+" #LnameId").val("");
 		$("#addAdminBox"+orgid+" #contactNoId").val("");
 		 $("#addAdminBox"+orgid+" #contactNoId").val("");
 		$("#addAdminBox"+orgid+" #addressId").val("");
 		$("#addAdminBox"+orgid).hide();
 		$("#addAdminBox"+orgid+" #passwordId").val("");
		return false;
 	}
 	
 	
 	  
 	
 	function saveAdmin(orgId){
 		var Fname = $("#addAdminBox"+orgId+" #FnameId").val();
 		var Lname = $("#addAdminBox"+orgId+" #LnameId").val();
 		var email = $("#addAdminBox"+orgId+" #emailId").val();
 		var contactNo = $("#addAdminBox"+orgId+" #contactNoId").val();
 		var password = $("#addAdminBox"+orgId+" #passwordId").val();
 		/* var address = $("#addAdminBox"+orgId+" #addressId").val(); */
 		
 		 if(Fname==""){
				showSuccessMessage("Please Enter First Name");
				return false;
				} if(Lname==""){
				showSuccessMessage("Please Enter Last Name");
				return false;
				}if(contactNo==""){
				showSuccessMessage("Please Enter Contact Number");
				return false;
				}if(contactNo.length!=10 || !testNumber(contactNo)){
					showSuccessMessage("Please Enter 10 digit contact number");
				return false;
				} if(email==""){
				showSuccessMessage("Please Enter Email");
				return false;
				} else if(!ValidateEmail(email)){
					showSuccessMessage("Please Enter Valid Email");
				return false;
				} if(password==""){
				showSuccessMessage("Please Enter Password");
				return false;
				}if(password.length<6){
				showSuccessMessage("Please Enter Password Of Minimum 6 Character.");
				return false;
				} /* if(address==""){
				showSuccessMessage("Please Enter Address");
				return false;
				} */
 		var data = $("#addAdminFormId"+orgId).serialize();
 		data=data+"&organisationId="+orgId;
 		$.ajax({
 		 url:"saveAdmin",
 		 type :"POST",
		  data : data,
			beforeSend : function(){
			//startwindowDisable();
		  },
		  success : function(result){
		  	$("#addTeacherBox").hide();
		  	/* $("#pageContentDivId").html(result); */
		  		window.location="organization";
		  	//endwindowDisable();
		  }
		});
		$("#addAdminBox"+orgId+" #FnameId").val("");
 		$("#addAdminBox"+orgId+" #LnameId").val("");
 		$("#addAdminBox"+orgId+" #emailId").val("");
 		$("#addAdminBox"+orgId+" #emailId").val("");
 		 $("#addAdminBox"+orgId+" #passwordId").val("");
 		  $("#addAdminBox"+orgId+" #contactNoId").val("");
 		$("#addAdminBox"+orgId+" #addressId").val("");
 		$("#addAdminBox"+orgId).hide();
		return false;
 	}
 	
 	
 	function getAdminsToMap(){
 		var orgId = $("#selectOrgId").val();
 		if(orgId>0){
 			$("#mapAdminDivId").show();
 			$("#addButtonDivId").hide();
 			$("#addTeacherBox").hide();
 			$.get( "getAdminTable?organisationId="+orgId, function( data ) {
	 		 $("#adminTableDivId").html( data );
			});
 		}else{
 			$("#mapAdminDivId").hide();
 			$("#addButtonDivId").show();
 		}
 	}
 	
 	function changeAdminStatus(orgId,userId,status){
 		var url="changeAdminStatus?userId="+userId+"&status="+status+"&organisationId="+orgId;
 		startwindowDisable();
	 		$.get(url, function( data ) {
			  $("#adminTableDivId"+orgId).html( data );
			  endwindowDisable();
			   $("#selectOrgId").val(0);
			   $("#addButtonDivId").show();
			});
 		return false;
 	}
</script>

  
  <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-hospital-o mr5"></i> Organization Management</a></li>            
            <li class="active">Organization</li>
          </ol>     
           <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-7 col-md-8"></div>
                <div class="col-sm-5 col-md-4">
              	  <button class="bttn pull-right btn-pos"  onclick="return addOrganization();"   data-id="addorganizationbx">ADD ORGANIZATION <i class="fa fa-plus-circle"></i></button>	
                </div>
              </div>
              
            </div>
            
            <div class="panel-body">
            	<div id="addOrganizationbx" style="display:none;">
        			<!-- <h4>ADD ORGANIZATION</h4> -->
            		<div class="row">
            	<form action="saveOrganisation" id="organisationFormId" method="post" enctype='multipart/form-data'>
                    		<div class="form-group col-md-4">
                    		<input type="text" style="display: none;" name="organisationId" id="updateId">
                            <%-- <label>Organization Name <span class="strike_color">*</span></label> --%>
                           		 <input type="text" class="form-control" name="organisationName" placeholder="Organization Name" id="organisationNameId">
                  			</div>
                  			<!-- <div class="form-group col-md-4">
                            <label>Organization logo</label>
                           		 <input type="text" placeholder="Organization logo" class="form-control" name="logo" id="logoId">
                  			</div> -->
                  			<div class="form-group col-sm-3 filetypepos">
		                         <div class="label_logo"> logo</div>
		                         <input id="logoFileId" name="logo" type="file" class="form-control browse_btn" required accept="image/*" >
		                    </div>
                  			 <div class="form-group col-sm-1">
                         		<img id="orgLogo" src="view/helper/images/school.png">
                   			 </div>
                            <%-- <div class="form-group col-md-4">
                            	<label>Address <span class="strike_color">*</span></label>
                                <div class="form-group">
                           		 <input type="text" class="form-control" name="address" id="addressId">
                          </div>                          
                            </div> --%>
                                                  
                           <%--  <div class="form-group col-md-4">
                            	<label>Tags<span class="strike_color">*</span></label>
                                <div class="form-group">
                           		 <input type="text" class="form-control" name="metadata" id="metadataId">
                          </div>                          
                            </div> --%>
                            
                            <div class="form-group col-md-4">
                            	<%-- <label>Website <span class="strike_color">*</span></label> --%>
                           		 <input type="text" class="form-control" placeholder="Website" name="website" id="websiteId">
                            </div>
                            
                            
                              <div class="form-group col-md-12"  id="orgDescriptionId">
			                    	<%-- <label>Organization Description <span class="strike_color">*</span></label> --%>
			                        <textarea class="form-control" cols="4" name="description" id="descriptionId"></textarea>
			                   </div>  
                            <div class="form-group col-md-12" id="saveButtonId" style="display:none;">
                            	<button class="bttn" onclick="return saveOrganisation();">SAVE</button>
                                 &nbsp;&nbsp; <button class="bttn" onclick="return cancelOrg();">CANCEL</button>
                            </div>
                            <div class="form-group col-md-12" id="updateButtonId" style="display:none;">
                            	<button class="bttn" onclick="return updateOrg();">UPDATE</button>
                                 &nbsp;&nbsp; <button class="bttn" onclick="return cancelOrg();">CANCEL</button>
                            </div>
                        </form> 
                            
                  		</div>	
                </div>
             
            	
            
            </div>
          </div>   
          <div id="orgTableDivId">
               		<s:include value="organisationTable.jsp"></s:include>
               	</div>
          
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
 