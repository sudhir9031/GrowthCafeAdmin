 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script>
 	 function getModuleTable(){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var groupId = $("#selectGroupId").val();
 		var courseId = $("#courseSelectId").val();
 		if(courseId==0){
 			$("#module1").hide();
 			$("#addButtonId").hide();
 		}else{
 			$("#module1").hide();
 			$("#addButtonId").show();
 		}
 		$.ajax({
 		 url:"getModuleTable",
		  data : {"organisationId":orgId,"departmentId":depId,"groupId":groupId,"courseId":courseId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	$("#moduleTableDivId").html(result);
		  }
		});
 		
 	}
 
 
 function getCourses(){
	 	var orgId = $("#selectOrgId").val();
	 	var depId = $("#selectDepId").val();
	 	var groupId = $("#selectGroupId").val();
	 		$("#module1").hide();
 			$("#addButtonId").hide();
		 if(orgId !=0){
			 var url="getCourses?organisationId="+orgId+"&departmentId="+depId+"&groupId="+groupId;
			$.get( url, function(data) {
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
 	
 	function saveModule(){
 		var resourceTitle = $("#resourceTitleId").val();
 		var resourceDesc = $("#resourceDescId").val();
 		var resDuration = $("#resDurationId").val();
 		var resourceUrl = $("#resourceUrlId").val();
 		var moduleName = $("#moduleNameId").val();
 		var description = $("#descriptionId").val();
 		var metadata = $("#metadataId").val();
 		if(moduleName==""){
 			showSuccessMessage("Please Enter Module Name");
			return false;
 		}if(metadata==""){
 			showSuccessMessage("Please Enter Module Matadata");
			return false;
 		}if(description==""){
 			showSuccessMessage("Please Enter Description");
			return false;
 		}
 		if(resourceTitle==""){
 			$("#myModal").modal("show");
 			showSuccessMessage("Please Enter Resource Title");
			return false;
 		}if(resDuration==""){
 			$("#myModal").modal("show");
 			showSuccessMessage("Please Enter Duration");
			return false;
 		}else if(isNaN(resDuration) || resDuration<=0 ){
 				$("#myModal").modal("show");
				showSuccessMessage("Duration must be number");
				return false;
			}
 		if(resourceDesc==""){
 			$("#myModal").modal("show");
 			showSuccessMessage("Please Enter Description");
			return false;
 		}
 		if(resourceUrl==""){
 			$("#myModal").modal("show");
 			showSuccessMessage("Please Enter Url");
			return false;
 		}
 	
 		var courseId = $("#courseSelectId").val();
 		var data = $("#moduleFormId").serialize();
 		startwindowDisable();
 		data=data+"&courseId="+courseId;
 		$.post("saveModule",data,function(data,status){
        $("#moduleTableDivId").html(data);
        endwindowDisable();
        });
          $("#module1").hide();
     	$("#resourceTitleId").val("");
 		$("#resourceDescId").val("");
 		$("#resourceUrlId").val("");
 		$("#moduleNameId").val("");
 		$("#descriptionId").val("");
 		$("#resDurationId").val("");
 		$("#metadataId").val("");
 	return false;
 	}
 
 function hideResourceForm(){
 	$("#myModal").modal("hide");
 	return false;
 }
 
        function Show_Div1() {
			$("#module1").show();
			$("#resourceAddButtonId").show();
			$("#saveModuleButtonId").show();
			$("#updateModuleButtonId").hide();
			$("#moduleNameId").val("");
	 		$("#descriptionId").val("");
	 		$("#metadataId").val("");
	 		$("#updateId").val(0);
           return false;
        }
        
 function saveResource(formId, count){	
 
 	var resourceTitle = $("#tableResourceTitleId"+count).val();
	var resDuration = $("#tableResDurationId"+count).val();
	var resAuthor = $("#tableResAuthorId"+count).val();
	var resMetadata = $("#tableResMetadataId"+count).val();
	var resourceDesc = $("#tableResourceDescId"+count).val();
	var resourceUrl = $("#tableResourceUrlId"+count).val();
 if(resourceTitle==""){
 			showSuccessMessage("Please Enter Resource Title");
			return false;
 		}
 		if(resDuration==""){
 			showSuccessMessage("Please Enter Duration");
			return false;
 		}else if(isNaN(resDuration) || resDuration<=0 ){
				showSuccessMessage("Duration must be number");
				return false;
			}if(resAuthor==""){
 			showSuccessMessage("Please Enter Author");
			return false;
 		}if(resMetadata==""){
 			showSuccessMessage("Please Enter Matadata");
			return false;
 		}if(resourceDesc==""){
 			showSuccessMessage("Please Enter Description");
			return false;
 		}if(resourceUrl==""){
 			showSuccessMessage("Please Enter Url");
			return false;
			}
	var data = $("#"+formId).serialize();
	startwindowDisable();
	$.post("saveResource",data,
        function(data,status){
        $("#moduleTableDivId").html(data);
        endwindowDisable();
        $(".modal-backdrop").removeClass("modal-backdrop fade in");
        });
   $("#tableResourceTitleId"+count).val("");
	$("#tableResDurationId"+count).val("");
	$("#tableResAuthorId"+count).val("");
	$("#tableResMetadataId"+count).val("");
	$("#tableResourceDescId"+count).val("");
	$("#tableResourceUrlId"+count).val("");
	return false;
}

function cancelModule(){
		$("#resourceTitleId").val("");
 		$("#resourceDescId").val("");
 		$("#resourceUrlId").val("");
 		$("#moduleNameId").val("");
 		$("#descriptionId").val("");
 		$("#resDurationId").val("");
 		$("#metadataId").val("");
		$("#module1").hide();
		return false;
	}
	
function editModule(module,desc,metaData,id){
	$("#module1").show();
	$("#resourceAddButtonId").hide();
	$("#saveModuleButtonId").hide();
	$("#updateModuleButtonId").show();
	$("#moduleNameId").val(module);
 	$("#descriptionId").val(desc);
 	$("#metadataId").val(metaData);
 	$("#updateId").val(id);
 	$("#resDurationId").val(0);
	return false;
}

	function updateModule(){
 		var moduleName = $("#moduleNameId").val();
 		var description = $("#descriptionId").val();
 		var metadata = $("#metadataId").val();
 		if(moduleName==""){
 			showSuccessMessage("Please Enter Module Name");
			return false;
 		}if(metadata==""){
 			showSuccessMessage("Please Enter Module Matadata");
			return false;
 		}if(description==""){
 			showSuccessMessage("Please Enter Description");
			return false;
 		}
 		var data = $("#moduleFormId").serialize();
 		startwindowDisable();
 		$.post("updatModule",data,function(data,status){
        $("#moduleTableDivId").html(data);
        endwindowDisable();
        });
          $("#module1").hide();
 		$("#moduleNameId").val("");
 		$("#descriptionId").val("");
 		$("#metadataId").val("");
 	return false;
}


function editResource(title,url,duration,author,desc,matadata,id){
	$("#editResourceFormId #resourceTitleId").val(title);
	$("#editResourceFormId #resourceUrlId").val(url);
	$("#editResourceFormId #resAuthorId").val(author);
	$("#editResourceFormId #resDurationId").val(duration);
	$("#editResourceFormId #resourceDescId").val(desc);
	$("#editResourceFormId #resMetadataId").val(matadata);
	$("#editResourceFormId #resUpdateId").val(id);
	return false;
}


function updateResource(){
	var title = $("#editResourceFormId #resourceTitleId").val();
	var url = $("#editResourceFormId #resourceUrlId").val();
	var author = $("#editResourceFormId #resAuthorId").val();
	var duration = $("#editResourceFormId #resDurationId").val();
	var desc = $("#editResourceFormId #resourceDescId").val();
	var metadata = $("#editResourceFormId #resMetadataId").val();
	if(title==""){
 			showSuccessMessage("Please Enter Title");
			return false;
 		}if(url==""){
 			showSuccessMessage("Please Enter Url");
			return false;
 		}if(author==""){
 			showSuccessMessage("Please Enter Author");
			return false;
 		}if(duration==""){
 			showSuccessMessage("Please Enter Duration");
			return false;
 		}if(desc==""){
 			showSuccessMessage("Please Enter Description");
			return false;
 		}if(metadata==""){
 			showSuccessMessage("Please Enter Tag");
			return false;
 		}
 		$("#editResourceFormId").submit();
 		startwindowDisable();
	return false;
}
 </script>
	
<div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li>
             <li><a href="#"><i class="fa fa-book mr5"></i> Course Management</a></li>            
            <li class="active"> Module</li>
          </ol>     
                 
            <div class="panel" id="ddd">
                
                <div class="panel-body">
                  	<div class="row">
                    		<%-- <div class="form-group col-md-4">
                            <label>Organisation</label>
                            <select id="selectOrgId" class="form-control"  onchange="getDepartment();">
                            		<option value="0">All</option>
	                             <s:if test="#session.organisationList !=null">
	                             	<s:iterator value="#session.organisationList">
	                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
	                              	</s:iterator>
	                              </s:if>
                            </select>
                  </div>
                  			<div class="form-group col-md-4">
                            <label>Department</label>
                        <select id="selectDepId" onchange="getGroups();" class="form-control" >
                        	<option value="0">All</option>
                        </select>
                  </div>
                  			<div class="form-group col-md-4">
                            <label>Group</label>
                        <select id="selectGroupId" class="form-control"  onchange="getCourses();">
                        	<option value="0">All</option>
                        </select>
                  </div> --%>
                  
               			   <div class="form-group col-md-4" style="margin-top:10px;">
                            <label>Course</label>
                        <select id="courseSelectId" class="form-control" onchange="getModuleTable();">
                        	 <s:if test="coursesList !=null">
		                             	<option value="0">All</option>
		                             	<s:iterator value="coursesList">
		                              		<option value="<s:property value="courseId"/>"><s:property value="courseName"/> </option>
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
              <s:if test="#session.loginDetail !=null && #session.loginDetail.userType==1">
              	<div class="col-md-4 col-md-offset-8" id="addButtonId">
              		<button class="btn btn-default btn-quirk btn-stroke pull-right" onclick="return Show_Div1();" >ADD MODULE <i class="fa fa-plus-circle"></i></button>
              	</div>
              	</s:if>
              	<s:else>
              	<div class="col-md-4 col-md-offset-8" id="addButtonId" style="display: none;">
              		<button class="btn btn-default btn-quirk btn-stroke pull-right" onclick="return Show_Div1();" >ADD MODULE <i class="fa fa-plus-circle"></i></button>
              	</div>
              	</s:else>
              </div>
            </div>
            
            <div class="panel-body">
            
              
              	<div id="moduleTableDivId">
					<s:include value="moduleTable.jsp"></s:include>   
				</div>             
             
            </div>
          </div>   
          
          

			


		
        
        
        
        
           	
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  
  
  
  
  <div class="modal fade" id="editModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title" id="myModalLabel">Edit Resorces</h4>
      </div>
      <div class="modal-body">
        				<form id="editResourceFormId" action="updateResource" method="post">
								        			<input name="resourceId" id="resUpdateId" type="text" value="" style="display: none;">
								            		<div class="form-group">
								                    	<label>Resource Title <span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resourceTitle" id="resourceTitleId">
								                    </div>
								                    <div class="form-group col-sm-6 left_padding0">
								                    	<label>Duration(Day/Days) <span class="strike_color">*</span></label>
								                        <input type="text"  class="form-control" name="resDuration" id="resDurationId">
								                    </div>
								                    <div class="form-group col-sm-6 right_padding0">
								                    	<label>Author <span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resAuthor" id="resAuthorId">
								                    </div>
								                    
								                    <div class="form-group">
								                    	<label>Tags<span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resMetadata" id="resMetadataId">
								                    </div>
								                    								                    
								                    <div class="form-group">
								                    	<label>Resources Discription <span class="strike_color">*</span></label>
								                        <textarea class="form-control" cols="4" name="resourceDesc" id="resourceDescId"></textarea>
								                    </div>
								                    
								                    <div class="form-group">
								                    	<label>Add URL <span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resourceUrl" id="resourceUrlId">
								                    </div>
								                    <button class="btn btn-danger btn-quirk" onclick="return updateResource();">Update</button>
								            </form>
      </div>
      
    </div>
  </div>
</div>
