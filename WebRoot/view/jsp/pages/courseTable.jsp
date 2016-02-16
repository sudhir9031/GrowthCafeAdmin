 <%@ taglib prefix="s" uri="/struts-tags"%>
  <script>
  function saveModule(courseId){
 		/* var resourceTitle = $("#resourseModal #resourceTitleId").val();
 		var resourceDesc = $("#resourseModal #resourceDescId").val($("#resourceFormId .Editor-editor").html());
 		var resDuration = $("#resourseModal #resDurationId").val();
 		var resourceUrl = $("#resourseModal #resourceUrlId").val();
 		var resMetadata = $("#resourseModal #resMetadataId").val();
 		var resAuthor = $("#resourseModal #resAuthorId").val(); */
 		var moduleName = $("#addModulebox"+courseId+" #moduleNameId").val();
 		var description = $("#addModulebox"+courseId+" #moduleFormId"+courseId+" .Editor-editor").html();
 		$("#moduleDescriptionId"+courseId).val(description);
 		if(moduleName==""){
 			showSuccessMessage("Please Enter Module Name");
			return false;
 		}if(description==""){
 			showSuccessMessage("Please Enter Description");
			return false;
 		}
 		/* if(resourceTitle==""){
 			$("#resourseModal").modal("show");
 			showSuccessMessage("Please Enter Resource Title");
			return false;
 		}if(resDuration==""){
 			$("#resourseModal").modal("show");
 			showSuccessMessage("Please Enter Duration");
			return false;
 		}else if(isNaN(resDuration) || resDuration<=0 ){
 				$("#resourseModal").modal("show");
				showSuccessMessage("Duration must be number");
				return false;
			}
			if(resAuthor==""){
 			$("#resourseModal").modal("show");
 			showSuccessMessage("Please Enter Resource Author");
			return false;
 		}if(resMetadata==""){
 			$("#resourseModal").modal("show");
 			showSuccessMessage("Please Enter Resource Metadata");
			return false;
 		}
 		if(resourceDesc==""){
 			$("#resourseModal").modal("show");
 			showSuccessMessage("Please Enter Resource Description");
			return false;
 		}
 		if(resourceUrl==""){
 			$("#resourseModal").modal("show");
 			showSuccessMessage("Please Enter Resource Url");
			return false;
 		} */
 	
 		/* var data=$("#resourceFormId").serialize(); */
 		startwindowDisable();
 		var data="&courseId="+courseId+"&moduleName="+moduleName+"&description="+description;
 		$.post("saveModule",data,function(data,status){
       	 window.location="courseManagement";
        endwindowDisable();
        });
          $("#addModulebox"+courseId).hide();
     	$("#resourceTitleId").val("");
 		$("#resourceDescId").val("");
 		$("#resourceUrlId").val("");
 		$("#moduleNameId").val("");
 		$("#descriptionId").val("");
 		$("#resDurationId").val("");
 		$("#metadataId").val("");
 	return false;
 	}
 
 function hideResourceForm(moduleId){
 	$("#resouceFormDivId"+moduleId).hide();
 	return false;
 }
 
 
        function addModule(courseId) {
        	$(".toHideModuleDiv").hide();
        	$("#addcoursebx").hide();
			$("#addModulebox"+courseId).show();
			/* $("#moduleDescriptionId"+courseId).Editor(); */
			showExitor(courseId);
			//$("#addModulebox"+courseId+" #resourceAddButtonId").show();
			$("#addModulebox"+courseId+" #saveModuleButtonId").show();
			$("#addModulebox"+courseId+" #updateModuleButtonId").hide();
			$("#addModulebox"+courseId+" #moduleNameId").val("");
	 		$("#moduleDetailDescriptionId .Editor-editor").html("");
	 		$("#updateId").val(0);
           return false;
        }
        
        
   function cancelModule(courseId){
		$("#resourceTitleId").val("");
 		$("#resourceDescId").val("");
 		$("#resourceUrlId").val("");
 		$("#moduleNameId").val("");
 		$("#descriptionId").val("");
 		$("#resDurationId").val("");
 		$("#metadataId").val("");
		$("#addModulebox"+courseId).hide();
		return false;
	}
	
function editModule(id,courseId){ 
		var module = $(".moduleClass--"+id).val();
		var desc = $(".descriptionDetClass--"+id).val();

 			$(".toHideModuleDiv").hide();
        	$("#addcoursebx").hide();
			$("#addModulebox"+courseId).show();
			showExitor(courseId);
			$("#moduleDetailDescriptionId .Editor-editor").html(desc);
		
			var editBlock = $("#addModulebox"+courseId);
				editBlock.find("#updateId").val(id);
				editBlock.find("#moduleNameId").val(module);
			/* $("#addModulebox"+courseId+" #saveModuleButtonId").show();
			$("#addModulebox"+courseId+" #updateModuleButtonId").hide(); */
			
			$("#moduleFormId"+courseId+" #updateModuleButtonId").show();
		$("#moduleFormId"+courseId+" #saveModuleButtonId").hide();
			
			$("#updateModuleButtonId").show();
			$("#saveModuleButtonId").hide();
			//$("#moduleNameId").val(module);
	 		//$("#updateId").val(id);
	return false;
}


	var statuss=0;
		function showExitor(courseId){
			if(statuss!=courseId){
			$("#moduleDescriptionId"+courseId).Editor();
			$(".Editor-editor").attr("data-text","Description");
				statuss=courseId;
			}
			return false;		
		}

	function updateModule(courseId){
 		var moduleName = $("#addModulebox"+courseId+" #moduleNameId").val();
 		/* var description = $("#addModulebox"+courseId+" #descriptionId").val(); */
 	var updateId = $("#addModulebox"+courseId+" #updateId").val();
 		
 		var description =$("#moduleDetailDescriptionId .Editor-editor").html();
 		if(moduleName==""){
 			showSuccessMessage("Please Enter Module Name");
			return false;
 		}if(description==""){
 			showSuccessMessage("Please Enter Description");
			return false;
 		}
 		/*var data = $("#moduleFormId"+courseId).serialize();
 		 data=data+"&moduleName="+moduleName+"&description="+description; */
 		var data ="moduleName="+moduleName+"&description="+description+"&moduleId="+updateId;
 		startwindowDisable();
 		$.post("updatModule",data,function(data,status){
       		window.location="courseManagement";
        endwindowDisable();
        });
          $("#addModulebox"+courseId).hide();
 		$("#addModulebox"+courseId+" #moduleNameId").val("");
 		$("#addModulebox"+courseId+" #descriptionId").val("");
 	return false;
}

var tempText = 0;
	function makeDesc(id){
		if(tempText!=id){
		$("#resourceFormId"+id+" #resourceDescId1").Editor();
		$(".Editor-editor").attr("data-text","Description");
		
		tempText=id;
		}
	
	}

function editResource(id,moduleId){
	makeDesc(moduleId);
	var title=$("#resourceTitle--"+id).val();
	var url=$("#resourceUrl--"+id).val();
	var duration=$("#resDuration--"+id).val();
	var author=$("#resAuthor--"+id).val();
	var desc=$("#resourceDesc--"+id).val();
	var matadata=$("#resMetadata--"+id).val();
	var type=$("#type--"+id).val();
	$("#resouceFormDivId"+moduleId).show();
	$("#resourceFormId"+moduleId+" #resourceTitleId").val(title);
	$("#resourceFormId"+moduleId+" #resAuthorId").val(author);
	$("#resourceFormId"+moduleId+" #resDurationId").val(duration);
	$("#resourceFormId"+moduleId+" .Editor-editor").html(desc);
	$("#resourceFormId"+moduleId+" #resMetadataId").tokenfield('setTokens', matadata);
	$("#resourceFormId"+moduleId+" #resUpdateId").val(id);
	$("#resourceFormId"+moduleId+" #restypeId").val(type);
	if($("#type--"+id).val() == "1"){
		$("#resourceFormId"+moduleId+" #resourceUrlId").css('display','block');
		$("#resourceFormId"+moduleId+" #resourceUrlId").val(url);
	}else if($("#type--"+id).val() == "2"){
		$("#resourceFormId"+moduleId+" #pptUrlId").css('display','block');
		$("#resourceFormId"+moduleId+" #pdfUrlId .input-group").css('display','none');
		/* $("#resourceFormId"+moduleId+" #pptUrlId").val(url); */
		$("#resourceFormId"+moduleId+" #pptUrlId").val(url);
	}else if($("#type--"+id).val() == "4"){
		$("#resourceFormId"+moduleId+" #pptUrlId").css('display','none');
		$("#resourceFormId"+moduleId+" #pdfUrlId").css('display','block');
		$("#resourceFormId"+moduleId+" #pdfUrlId").val(url);
	}
	
	return false;
}



function updateResourceDetail(moduleId){
	var type =$("#resourceFormId"+moduleId+" #restypeId").val();
	var title = $("#resourceFormId"+moduleId+" #resourceTitleId").val();
	var url = $("#resourceFormId"+moduleId+" #resourceUrlId").val();
	var author = $("#resourceFormId"+moduleId+" #resAuthorId").val();
	var duration = $("#resourceFormId"+moduleId+" #resDurationId").val();
	var desc = $("#resourceFormId"+moduleId+" .Editor-editor").html();
	var metadata = $("#resourceFormId"+moduleId+" #resMetadataId").val();
	
	$("#resourceFormId"+moduleId+" #resourceDescId1").val(desc);
	
	if(title==""){
 			showSuccessMessage("Please Enter Title");
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
 		}if(type==1 && resourceUrl==""){
 			showSuccessMessage("Please Enter Link");
			return false;
 		}if(type==2){
	 		if(uploadPPT){
	 			
	 		}else{
	 			showSuccessMessage("Please Upload File");
				return false;
	 		}
 		}
 		$("#resourceFormId"+moduleId).submit();
 		startwindowDisable();
	return false;
}




          function resourse_select(){
          	var selectType=$("#selectResoureseId").val();
          	return false;
          }
          
          function addResource(moduleId) {
			$("#addResourcesDivId"+moduleId).show();
           return false;
        }
        
         function resourceType(id,moduleId) {
			$("#addResourcesDivId"+moduleId).show();
			if(id==0){
				$("#addResourcesDivId"+moduleId+" #fieldDivId").hide();
			}else if(id==1){
				$("#addResourcesDivId"+moduleId+" #fieldDivId").show();
				$("#addResourcesDivId"+moduleId+" #videoDivId").show();
				$("#addResourcesDivId"+moduleId+" #slideDivId").hide();
			}else if(id==2){
				$("#addResourcesDivId"+moduleId+" #fieldDivId").show();
				$("#addResourcesDivId"+moduleId+" #fieldDivId #pptId").show();
				$("#addResourcesDivId"+moduleId+" #fieldDivId #pdfId").hide();
				$("#addResourcesDivId"+moduleId+" #videoDivId").hide();
				$("#addResourcesDivId"+moduleId+" #slideDivId").show();
			}else if(id==3){
				$("#addResourcesDivId"+moduleId+" #fieldDivId").show();
				$("#addResourcesDivId"+moduleId+" #videoDivId").hide();
				$("#addResourcesDivId"+moduleId+" #fieldDivId #pdfId").hide();
				$("#addResourcesDivId"+moduleId+" #fieldDivId #pptId").hide();
			}else if(id==4){
				$("#addResourcesDivId"+moduleId+" #fieldDivId #pdfId").show();
				$("#addResourcesDivId"+moduleId+" #fieldDivId #pptId").hide();
				$("#addResourcesDivId"+moduleId+" #fieldDivId").show();
				$("#addResourcesDivId"+moduleId+" #videoDivId").hide();
				$("#addResourcesDivId"+moduleId+" #slideDivId").show();
			}
           return false;
        }
        
      function saveResource(moduleId){
      	var type = $("#addResourcesDivId"+moduleId+" #resourceTypeId").val();
 		var resourceTitle = $("#addResourcesDivId"+moduleId+" #resourceTitleId").val();
 		$("#addResourcesDivId"+moduleId+" #resDescriptionId").val($("#addResourcesDivId"+moduleId+" .Editor-editor").html());
 		var resourceDesc =$("#addResourcesDivId"+moduleId+" #resDescriptionId").val();
 		var metadata = $("#addResourcesDivId"+moduleId+" #resMetadataId").val();
 		var resAuthor = $("#addResourcesDivId"+moduleId+" #resAuthorId").val();
 		var resourceUrl = $("#addResourcesDivId"+moduleId+" #resourceUrlId").val();
 		var uploadFile = $("#addResourcesDivId"+moduleId+" #uploadFileId").val();
 		if(resourceTitle==""){
 			showSuccessMessage("Please Enter Resource Title");
			return false;
 		}if(resourceDesc==""){
 			showSuccessMessage("Please Enter Resource Description");
			return false;
 		}if(resAuthor==""){
 			showSuccessMessage("Please Enter Author");
			return false;
 		}
 		if(metadata==""){
 			showSuccessMessage("Please Enter Tags");
			return false;
 		}if(type==1 && resourceUrl==""){
 			showSuccessMessage("Please Enter Link");
			return false;
 		}if(type==2){
	 		if(uploadFile){
	 			
	 		}else{
	 			showSuccessMessage("Please Upload File");
				return false;
	 		}
 		}
        endwindowDisable();
       $("#addResourcesDivId"+moduleId+" #addResourcesForm").submit();
 	return false;
 	}
  </script>

 <s:if test="hasActionMessages()">
	<div id="actionMessageId" class="overlay">
			<div class="SuccessPop" id="SuccessPopDiv" style="display:block;">
                    <a class="CLoseIcon" href="#" onclick="hideMessage('actionMessageId');">X</a>              
                    <i class="fa fa-check-square-o grn"></i>                      
                <span id="successBoxText">	<s:actionmessage/></span>
            </div>
	</div>
</s:if>

<!-- Table for Super Admin login start -->

<!-- table with organization name -->
<%-- <s:if test="orgCoursesList !=null">
 <table class="table table-bordered table-danger nomargin">
 			
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                       S. No
                      </th>
                      <th width="30%">Course</th>
                      <th width="30%">Organisation</th>                     
                    </tr>
                  </thead>
                  <tbody>
                  	<s:if test="orgCoursesList !=null && orgCoursesList.size()>0">
                  	<s:iterator value="orgCoursesList" status="status">
                    <tr>
                      <td class="text-center">
                      <s:property value="%{#status.count}" />
                      </td>
                      <td><s:property value="courseName" /> </td> 
                       <td><s:property value="orgName" /> </td>                      
                    </tr>
                    </s:iterator>
                    </s:if>
                  </tbody>
             </table>
               </s:if>  
               
               
               
               
               <!-- table without organization name -->
<s:if test="coursesList !=null">
 <table class="table table-bordered table-danger nomargin">
 			
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                       S. No
                      </th>
                      <th width="30%">Course</th>
                      <th width="16%" class="text-center">Edit</th>
                      <th width="16%" class="text-center">Deactivate</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<s:if test="coursesList !=null && coursesList.size()>0">
                  	<s:iterator value="coursesList" status="status">
                    <tr>
                      <td class="text-center">
                      <s:property value="%{#status.count}" />
                      </td>
                      <td><s:property value="courseName" /> </td> 
                      <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke " onclick="editCourse('<s:property value="courseName" />','<s:property value="author" />',<s:property value="duration" />,'<s:property value="metadata" />','<s:property value="description" />',<s:property value="courseId" />)">edit</button></td>
                      <s:if test="status==1">
						<td class="text-center"><button
								class="btn btn-danger btn-quirk" onclick="courseActiveDeactive(<s:property value="courseId"/>,0,'course')">Activate</button>
						</td>
						</s:if>
						<s:else>
							<td class="text-center"><button class="btn btn-danger btn-quirk btn-stroke" onclick="courseActiveDeactive(<s:property value="courseId"/>,1,'course')">deactivate</button></td>
						</s:else>
                    </tr>
                    </s:iterator>
                    </s:if>
                  </tbody>
             </table>
               </s:if>  
            
               <!-- Table for Super Admin login end -->
             
             
             
         <!-- Table for admin login start-->
        <s:if test="adminCoursesList !=null">
        <table class="table table-bordered table-danger nomargin">
            
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                       S. No
                      </th>
                      <th width="32%">Course</th>                     
                      <th width="30%" class="text-center">Department</th>
                      <th width="30%" class="text-center">Group</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<s:if test="adminCoursesList !=null && adminCoursesList.size()>0">
                  	<s:iterator value="adminCoursesList" status="status">
                    <tr>
                      <td class="text-center">
                      <s:property value="%{#status.count}" />
                      </td>
                      <td><s:property value="courseName" /> </td>                      
                      <td><s:property value="departmentName" /></td>
                      <td><s:property value="groupName" /></td>
                    </tr>
                    </s:iterator>
                    </s:if>
                  </tbody>
                </table>
              </s:if>   --%>
              
              
              
              
              
         
         <div id="course-panel">     
           <div class="panel">
               <div class="panel-body">
                 <div class="table-responsive">
                   <table class="table table-bordered nomargin">
                     <thead>
                       <tr>
                         <th width="5%" bgcolor="#e1e1e1" class="text-center">
                          S.No
                         </th>
                         <th width="50%" bgcolor="#e1e1e1" class="text-center">Course</th>
                         <th width="13%" bgcolor="#e1e1e1" class="text-center">Type</th>                     
                         <th width="32%" bgcolor="#e1e1e1" class="text-center">Action</th>
                       </tr>
                     </thead>
                     </table>
                  </div>
                  
              <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                     <s:if test="coursesList !=null && coursesList.size()>0">
                  		<s:iterator value="coursesList" var="courseVar" status="courseStatus">
                  		
						  <div class="panel panel-default" style="border: none;">
						    <div class="panel-heading tbl" role="tab" id="headingOne">
                  		 <div class="table-responsive">
	                  		<table class="table table-bordered nomargin">
	                  		   <tbody>
	                       <tr>
	                         <td  width="5%" bgcolor="#e1e1e1">
	                           <s:property value="%{#courseStatus.count}" />
	                         </td>
	                         <td width="50%" bgcolor="#e1e1e1"> <s:property value="courseName" /> </td>  
	                          <td width="13%" bgcolor="#e1e1e1">
								<s:if test="type==1">Self Paced</s:if>
								<s:if test="type==0">Instructor Led</s:if>
								</td>                    
	                         <td width="32%" bgcolor="#e1e1e1">
	                         	<button class="bttn" onclick="return addModule(<s:property value="courseId"/>);" data-id="addmodulebx">ADD LESSON <i class="fa fa-plus-circle fa_white"></i></button>
	                          <%-- <button class="bttn" onclick="editCourse('<s:property value="courseName" />','<s:property value="author" />','<s:property value="description" />',<s:property value="courseId" />)">EDIT</button> 
	                           --%>
	                            <button class="bttn" onclick="editCourse(<s:property value="courseId" />)">EDIT</button> 
	                         		<input type="hidden" class="autherClass-<s:property value="courseId" />" name="author" value="<s:property value="author" />"> 
	                          		<input type="hidden" class="courseNameClass-<s:property value="courseId" />" name="courseName" value="<s:property value="courseName" />"> 
	                          		<input type="hidden" class="descriptionClass-<s:property value="courseId" />" name="description" value="<s:property value="description" />"> 
	                          		<input type="hidden" class="durationClass-<s:property value="courseId" />" name="duration" value="<s:property value="duration" />">
	                          		<input type="hidden" class="metaDataClass-<s:property value="courseId" />" name="metadata" value="<s:property value="metadata" />">
	                          
	                         <!--  <button class="bttn" type="submit">DEACTIVATE</button> -->
	                         <s:if test="status==1">
								<button	class="bttn" onclick="courseActiveDeactive(<s:property value="courseId"/>,0,'course')">Activate</button>
							</s:if>
							<s:else>
								<button class="bttn" onclick="courseActiveDeactive(<s:property value="courseId"/>,1,'course')">Deactivate</button>
							</s:else>
	                           <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse<s:property value="courseId" />" aria-expanded="true" aria-controls="collapse1" class="collapsed"><i class="fa fa-caret-down grn" style="font-size:24px"></i></a></td>
	                       </tr>
	                       </tbody>
                   		</table>
                   		 </div>
                    </div>
                      
                <div class="toHideModuleDiv mt10" id="addModulebox<s:property value="courseId"/>" style="display:none;">
                                  <!-- <h4>ADD LESSON</h4> -->
                                   <div class="row">
                                   <form id="moduleFormId<s:property value="courseId"/>">
                                   			 <input type="text" class="form-control" id="updateId" name="moduleId" style="display:none">
                                           <div class="form-group col-sm-12">
                                                  <input type="text" placeholder="Lesson Name" class="form-control" id="moduleNameId">
                                           </div>
                                           <div class="form-group col-sm-12" id="moduleDetailDescriptionId">
                                               <!-- <label>Description*</label> -->
                                               <textarea  class="form-control" id="moduleDescriptionId<s:property value="courseId"/>" name="description" rows="5" aria-required="true"></textarea>
                                           </div>
                                           
                                          <%--  <div class="form-group col-sm-12">
                                               <button type="submit" class="bttn" onclick="return saveModule(<s:property value="courseId"/>)">SAVE</button>
                                               <button type="submit" class="bttn"  onclick="return cancelModule(<s:property value="courseId"/>);">CANCEL</button>
                                           </div> --%>
                                           
                                           <div class="form-group col-sm-12" id="saveModuleButtonId">
			                                	 <button class="bttn" onClick="return saveModule(<s:property value="courseId"/>);">SAVE</button>
			                                	  &nbsp;&nbsp;<button class="bttn" onclick="return cancelModule(<s:property value="courseId"/>);">CANCEL</button>
			                                </div> 
			                                <div class="form-group col-sm-12" id="updateModuleButtonId">
			                                	 <button class="bttn" onClick="return updateModule(<s:property value="courseId"/>);">UPDATE</button>
			                                	  &nbsp;&nbsp;<button class="bttn" onclick="return cancelModule(<s:property value="courseId"/>);">CANCEL</button>
			                                </div>
                                         </form>
                                               </div>
 								</div>
              
                  
              
              
              
              <div id="collapse<s:property value="courseId" />" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                    	
                              <div class="panel panel-default">
                                <div role="tab" id="headingFive">
                                  <!---  <div class="panel-heading">
                                      <div class="row">
                                        <div class="col-sm-8"></div>
                                        <div class="col-sm-4">
                                          <button class="bttn pull-right" onclick="return Show_Div1();" data-id="addmodulebx">ADD MODULE <i class="fa fa-plus-circle"></i></button>
                                        </div>
                                      </div>
                                    </div>---->
            						                    
                        <div class="table-responsive" >
                            <table class="table table-bordered nomargin">
                            <s:if test="moduleList !=null && moduleList.size()>0">
                              <thead>
                                <tr>
                                  <th class=" ft11" bgcolor="#e1e1e1" width="5%">S.No</th>
                                  <th width="50%" bgcolor="#e1e1e1" class="ft11">Lesson</th>  
                                  <th width="13%" bgcolor="#e1e1e1" class="ft11">Resource</th>                    
                                  <th width="32%" bgcolor="#e1e1e1" class="ft11">Action</th>
                                </tr>
                              </thead>
                              <tbody>
                              <s:iterator value="moduleList" status="moduleStatus" var="moduleVar">
                                <tr>
                                  <td class="text-center" style="background:#e1e1e1;">
                                   <s:property value="%{#moduleStatus.count}" />
                                  </td>
                                  <td style="font-size: 12px;" bgcolor="#e1e1e1" class="text-center"> <s:property value="moduleName" /></td>  
                                  <td bgcolor="#e1e1e1" class="text-center"><button class="bttn" type="button" data-toggle="modal" data-target="#resourseModal<s:property value="moduleId"/>">view</button>
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                  
                                   <!--Resource Modal Start -->
                        <div id="resourseModal<s:property value="moduleId"/>" class="modal fade" role="dialog" style="z-index:999999">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                                <!-- <button type="button" class="close" data-dismiss="modal">&times;</button>
                                 <button type="button" class="bttn pull-right">ADD RESOURCES</button> -->
                                <h4 class="modal-title">Resources</h4>
                              </div>
                              <div class="modal-body modal_scroll">
                                
                                 <!--==================Add Resources================-->
                                 <div id="resouceFormDivId<s:property value="moduleId"/>" style="display:none">
                                    <form id="resourceFormId<s:property value="moduleId"/>" action="updateResource" method="post">
                                    	<input type="text" class="form-control" name="type" id="restypeId" style="display:none">
                                       <input type="text" class="form-control" name="resourceId" id="resUpdateId" style="display:none">
                                        <div class="form-group">
                                            <input placeholder="Resource Title" type="text" class="form-control" name="resourceTitle" id="resourceTitleId" required="required">
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-sm-6 left_padding0">
                                                <input type="text" placeholder="Duration(Day/Days) " class="form-control" name="resDuration" id="resDurationId">
                                            </div>
                                            <div class="form-group col-sm-6 right_padding0">
                                                <input placeholder="Author" type="text" class="form-control" name="resAuthor" id="resAuthorId">
                                            </div>
                                         </div>
                                        
                                        <div class="form-group">
                                            <input type="text" class="form-control tokenfield" data-tokens="Sales" name="resMetadata" id="resMetadataId">
                                        </div>
                                                                                            
                                        <div class="form-group"  id="resourceDescIdDetailId">
                                            <label>Resources Description <span class="strike_color">*</span></label>
                                            <textarea name="resourceDesc" id="resourceDescId1" placeholder="Description" ></textarea>
                                            
                                        </div>
                                        
                                        <div class="form-group">
                                            <input placeholder="Add URL" type="text" class="form-control" name="resourceUrl" id="resourceUrlId" style="display: none">
                                            <input placeholder="Add PPT" type="file" class="form-control" name="upload" id="pptUrlId" accept="application/vnd.ms-powerpoint" style="display: none">
                                            <input placeholder="Add PDF" type="file" class="form-control" name="upload" id="pdfUrlId" accept="application/pdf" style="display: none">
                                        </div>
                                        <input type="button" class="bttn" onclick="updateResourceDetail(<s:property value="moduleId"/>);" value="UPDATE">
                                        <button type="button" class="bttn" onClick="hideResourceForm(<s:property value="moduleId"/>)">CLOSE RESOURCES</button>
                                </form>
                                </div>
                                
	                                <script type="text/javascript">
	                                	$(document).ready(function(){
	                                		$("#addResourcesDivId<s:property value="moduleId"/> #resDescriptionId").Editor();
											$("#addResourcesDivId<s:property value="moduleId"/> #resDescriptionId.Editor-editor").attr("data-text","Description");
	                                	});
	                                </script>
                                
                                <div id="addResourcesDivId<s:property value="moduleId"/>" style="display:none">
                                    <form id="addResourcesForm" action="saveResource" method="post" enctype='multipart/form-data'>
                                    		<s:hidden name="moduleId"/>
	                                    	<div class="row">
	                                       	 <div class="form-group col-sm-4">
	                                                <select name="type" class="form-control" required onChange="resourceType(this.value,<s:property value="moduleId"/>)" id="resourceTypeId">
	                                                  <option value="0">Select Type</option>
	                                                  <option value="1">Video</option>
	                                                  <option value="2">PPT</option>
	                                                  <option value="3">Content</option>
	                                                  <option value="4">PDF</option>
	                                                </select>
	                                         </div>
	                                         </div>
	                                      <div id="fieldDivId" style="display:none">
	                                        <div class="form-group">
	                                            <input type="text" class="form-control" name="resourceTitle" required placeholder="Resource title" id="resourceTitleId">
	                                        </div>
	                                        <div class="form-group">
	                                            <textarea  id="resDescriptionId" placeholder="Description" name="resourceDesc"></textarea>
	                                        </div>
	                                        <div class="row">
	                                            <div class="form-group col-sm-6">
	                                                <input type="text" class="form-control" name="resAuthor" required placeholder=" Author Name" id="resAuthorId">
	                                            </div>
	                                            <div class="form-group col-sm-6">
	                                                <input type="text" class="form-control tokenfield" data-tokens="Sales" name="resMetadata" required id="resMetadataId">
	                                            </div>
	                                       </div>
	                                        
	                                        <div class="form-group" id="videoDivId">
	                                            <input type="text" class="form-control" id="resourceUrlId" name="resourceUrl"  placeholder="https://player.vimeo.com/video/110361870   OR   https://www.youtube.com/embed/FAsdtwj00Uo">
	                                        </div>
	                                        <div class="form-group" id="pptId" style="display:none;">
	                                            <div class="label_logo">PPT only</div>
	                                            <input type="file" class="form-control browse_btn" name="upload"  accept="application/vnd.ms-powerpoint" id="uploadFileId">
	                                        </div>
	                                         <div class="form-group" id="pdfId" style="display:none;">
	                                            <div class="label_logo">PDF only</div>
	                                            <input type="file" class="form-control browse_btn" name="upload"  accept="application/pdf" id="uploadFileId">
	                                        </div>
	                                         
	                                        <button class="bttn" onclick="return saveResource(<s:property value="moduleId"/>);">SAVE</button>
	                                        <button type="button" class="bttn" onClick="close_resources()">CANCEL</button>
	                              
	                                	</div>
                                </form>
                                </div>
                                 <s:if test="resourceList !=null && resourceList.size()>0">
                                <!--==================Add Resources Ends================-->  
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th class="text-center" bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="45%" bgcolor="#e1e1e1" class="text-center">Resource</th>
                                                  <th width="15%" bgcolor="#e1e1e1" class="text-center">Type</th>                     
                                                  <th width="35%" bgcolor="#e1e1e1" class="text-center">Action</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                             
                                              <s:iterator value="resourceList" status="resStatus">
                                                <tr>
                                                  <td class="text-center" bgcolor="#e1e1e1">
                                                 	 <s:property value="%{#resStatus.count}" />
                                                  </td>
                                                  <td bgcolor="#e1e1e1" class="text-center"> <s:property value="resourceTitle" /></td>  
                                                  <td bgcolor="#e1e1e1" class="text-center"> 
                                                  		<s:if test="type==1">Video</s:if>
                                                  		<s:if test="type==2">PPT</s:if>
                                                  		<s:if test="type==3">Content</s:if>
                                                  		<s:if test="type==4">PDF</s:if>
													</td>                      
                                                  <td bgcolor="#e1e1e1" class="text-center">
                                                  <button class="bttn" type="submit" onclick="return editResource(<s:property value="resourceId"/>,<s:property value="#moduleVar.moduleId"/>);">EDIT</button>
                                                   <!-- <button class="bttn" type="submit">DEACTIVATE</button> -->
                                                    <s:if test="status==1">
														<button	class="bttn" onclick="courseActiveDeactive(<s:property value="resourceId"/>,0,'resource')">Activate</button>
													</s:if>
													<s:else>
														<button class="bttn" onclick="courseActiveDeactive(<s:property value="resourceId"/>,1,'resource')">Deactivate</button>
													</s:else>
								                     <input type="hidden" name="resourceTitle" id="resourceTitle--<s:property value="resourceId"/>" value="<s:property value="resourceTitle"/>"> 
								                     <input type="hidden" name="resourceUrl" id="resourceUrl--<s:property value="resourceId"/>" value="<s:property value="resourceUrl"/>"> 
								                     <input type="hidden" name="resDuration" id="resDuration--<s:property value="resourceId"/>" value="<s:property value="resDuration"/>"> 
								                     <input type="hidden" name="resAuthor" id="resAuthor--<s:property value="resourceId"/>" value="<s:property value="resAuthor"/>"> 
								                     <input type="hidden" name="resourceDesc" id="resourceDesc--<s:property value="resourceId"/>" value="<s:property value="resourceDesc"/>"> 
								                     <input type="hidden" name="resMetadata" id="resMetadata--<s:property value="resourceId"/>" value="<s:property value="resMetadata"/>"> 
								                     <input type="hidden" name="type" id="type--<s:property value="resourceId"/>" value="<s:property value="type"/>">
								                      </td>
                                                </tr>
                                              </s:iterator>
                                            
                                                
                                                
                                              </tbody>
                                            </table>
                                          </div>  
                                        </s:if>
                                        <s:else>
                                        	  <p>There is no Resource.</p>     
                                        </s:else>      
                              </div>
                              <div class="modal-footer">
                              
                              	<button type="button" class="bttn">Print</button>
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              	 <s:if test="resourceList ==null || resourceList.size()==0">
                                	<button type="button" class="bttn"  onclick="addResource(<s:property value="moduleId"/>);" data-id="add-resources">ADD RESOURCE</button>
                                </s:if>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       
                        <!----Resource modal ends------->     
                                  
                                  </td>     
                                  <td bgcolor="#e1e1e1" class="text-center">
                                  <s:if test="status==0">
                                  	<a class="bttn pda mg17" href="assignment?courseId=<s:property value="#courseVar.courseId"/>&moduleId=<s:property value="#moduleVar.moduleId"/>&type=<s:property value="#courseVar.type"/>">ASSIGNMENTS <i class="fa fa-plus-circle"></i></a>
                                  </s:if>
                                  <s:else><a class="bttn pda mg17" href="#">ASSIGNMENTS <i class="fa fa-plus-circle"></i></a></s:else>
                                   <%-- <button class="bttn" onclick="editModule('<s:property value="moduleName"/>','<s:property value="description"/>',<s:property value="moduleId"/>,<s:property value="#courseVar.courseId"/>);" type="submit">EDIT</button> 
                                   --%>
                                   <button class="bttn" onclick="editModule(<s:property value="moduleId"/>,<s:property value="#courseVar.courseId"/>);" type="submit">EDIT</button> 
                                  
                                    <input type="hidden" class="moduleClass--<s:property value="moduleId"/>" value="<s:property value="moduleName"/>">
                                    <input type="hidden" class="descriptionDetClass--<s:property value="moduleId"/>" value="<s:property value="description"/>">
                                   
                                  <!--  <button class="bttn" type="submit">DEACTIVATE</button> --> 
                                   <s:if test="status==1">
										<button	class="bttn" onclick="courseActiveDeactive(<s:property value="moduleId"/>,0,'module')">Activate</button>
									</s:if>
									<s:else>
										<button class="bttn" onclick="courseActiveDeactive(<s:property value="moduleId"/>,1,'module')">Deactivate</button>
									</s:else>
                                   <!---<a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion2" href="#collapseFive" aria-expanded="false" aria-controls="collapseFive" class="collapsed"><i class="fa fa-caret-down" style="font-size:24px"></i></a>--->
                                   
                                    
                                    
                                     <!-- Assignment Modal -->
                                  
                        <div id="addassignmentModal<s:property value="moduleId"/>" class="modal fade" role="dialog" style="z-index:99999">
                          <div class="modal-dialog">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                               
                                <h4 class="modal-title">Assignment</h4>
                              </div>
                              <div class="modal-body">
                                
                                 <!--==================Add Resources================-->
                                 <div id="addAssignmentbox" style="display:none">
                                                <div class="row">
                                                    
                                                    <div class="form-group col-sm-4">
                                                    	<label>Type</label>
                                                            <select class="form-control" onChange="assignmentType(this.value)">
                                                              <option value="1">File Upload</option>
                                                              <option value="2">Question/Answer</option>
                                                              <option value="3">Multiple Choice</option>
                                                              <option value="4">True/False</option>
                                                            </select>
                                                     </div>
                                                     <div id="fileTypeFormDivId" class="form-group">
                                       					<form id="assignmentFormId" >
                                       						<input type="text" name="moduleId" style="display:none;" value="<s:property value="moduleId"/>"/>
                                       						<input type="text" name="courseId" style="display:none;" value="<s:property value="#courseVar.courseId"/>"/>
                                       						<input type="text" class="form-control" name="assignmentId" id="updateId" style="display:none;">
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title*</label>
                                                            <div class="form-group">
                                                                 <input type="text"  name="assignmentName" id="assignmentNameId" class="form-control">
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description*</label>
                                                            <textarea  name="description" id="descriptionId"  class="form-control" rows="5" aria-required="true"></textarea>
                                                        </div>
                                                        
                                                        <!-- <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div> -->
                                                   		</form>
                                                   		<div class="form-group col-md-12" id="saveButtonId">
							                            	<button class="bttn" onClick="return saveAssignment(<s:property value="moduleId"/>);">SAVE</button>
							                            	&nbsp;&nbsp;<button class="bttn" onclick="return cancelAssignment();">CANCEL</button>
							                            </div>
							                             <div class="form-group col-md-12" id="updateButtonId" style="display:none;">
							                            	<button class="bttn" onClick="return updateAssignment(<s:property value="moduleId"/>);">UPDATE</button>
							                            	&nbsp;&nbsp;<button class="bttn" onclick="return cancelAssignment();">CANCEL</button>
							                            </div>
      												</div>
                                                     <div id="addQuestionDivId" class="form-group" style="display:none;">
                                       					<form>
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title*</label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description*</label>
                                                            <textarea   class="form-control" rows="5" aria-required="true"></textarea>
                                                        </div>
                                                        <div class="form-group col-sm-10">
                                                            <label>Add Question*</label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-2">
                                                        	<button type="button" class=" bttn close-btn" id="showDivId"><i class="fa fa-plus"></i></button>
                                                            
                                                        </div>
                                                        <div id="tempId"></div>
                                                        <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                 		  </form>
      												</div>
                                                     <div id="multipleChoiceFormDivId" class="form-group" style="display:none;">
                                       					<form action="">
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title<span class="strike_color">*</span></label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description<span class="strike_color">*</span></label>
                                                           <div id="txtEditor8"></div>
                                                        </div>
                                                        
                                                        <div class="form-group col-sm-10">
                                                            <label>Add Question<span class="strike_color">*</span></label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-2">
                                                        	<button type="button" class=" bttn close-btn"><i class="fa fa-plus"></i></button>
                                                        </div>
                                                       
                                                          <div class="form-group">
                                                          	
                                                                <label class="label_set col-sm-2" for="text">Option 1:</label>
                                                                <div class="col-sm-7">
                                                                  <input type="text" class="form-control mgl80" placeholder="Enter First option" required>
                                                                </div>
                                                                <div class="col-sm-1">
                                                                    <!---<button type="button" class=" bttn close-btn1"><i class="fa fa-plus"></i></button>-->
                                                                </div>
                                                                <div class="checkbox col-sm-2">
                                                                  <label><input type="checkbox" value="">Is Answer</label>
                                                                </div>
                                                                
                                                          </div>
                                                           <div class="form-group" style="clear:both">
                                                            <label class="label_set col-sm-2" for="text">Option 2:</label>
                                                            <div class="col-sm-7">
                                                              <input type="text" class="form-control mgl80" placeholder="Enter First option" required>
                                                            </div>
                                                            <div class="col-sm-1">
                                                        		<button type="button" class=" bttn close-btn1"><i class="fa fa-plus"></i></button>
                                                        	</div>
                                                            <div class="checkbox col-sm-2">
                                                              <label><input type="checkbox" value="">Is Answer</label>
                                                            </div>
                                                          </div>
                                                         
                                                          
                                                       
                                                          <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	   </div>
                                                          </form>
                                                        </div>      
                                                     <div id="trueFalseFormDivId" class="form-group" style="display:none;">
                                       					<form action="">
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title*</label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description*</label>
                                                            <textarea  class="form-control"  aria-required="true"></textarea>
                                                        </div>
                                                        
                                                        <div class="form-group col-sm-10">
                                                            <label>Add Question*</label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-2">
                                                        	<button type="button" class=" bttn close-btn"><i class="fa fa-plus"></i></button>
                                                        </div>
                                                         <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                    	</form>
                                                        </div>                                                    
                                                       <!--  <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn" id="hide-btn" onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div> -->
      												</div>
                                               	
                                             
                                </div>
                                <!--==================Add Resources Ends================-->  
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <!-- <th class="text-center" bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th> -->
                                                  <th width="70%" bgcolor="#e1e1e1" class="text-center">Assignment</th>                     
                                                  <th width="8%" bgcolor="#e1e1e1" class="text-center">Type</th>   
                                                  <th width="22%" bgcolor="#e1e1e1" class="text-center">Action</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                              <s:if test="assignmentList !=null && assignmentList.size()>0">
                                              <s:iterator value="assignmentList" status="assStatus">
                                                <tr>
                                                  <%-- <td class="text-center" bgcolor="#e1e1e1">
                                                   <s:property value="#assStatus.count" />
                                                  </td> --%>
                                                  <td bgcolor="#e1e1e1" class="text-center"><s:property value="assignmentName" /></td>
                                                  <td bgcolor="#e1e1e1" class="text-center">File</td>                      
                                                  <td bgcolor="#e1e1e1" class="text-center">
                                                  
                                                  <button class="bttn" type="button" onclick="editAssignment('<s:property value="assignmentName"/>','<s:property value="description"/>',<s:property value="assignmentId"/>,<s:property value="#moduleVar.moduleId"/>)">EDIT</button> 
                                                 <!--  <button class="bttn" type="submit">DEACTIVATE</button></td> -->
                                                                       
                                                </tr>
                                                </s:iterator>
                                                </s:if>
                                                
                                                
                                              </tbody>
                                            </table>
                                          </div>        
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                                	<button type="button" class="bttn" onclick="return addAssignment(<s:property value="moduleId"/>);" data-id="addassignmentbx" >ADD ASSIGNMENT</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       <!-- Assignment model end -->
                                    </td>
                                    </tr>
                                    
                                </s:iterator>
                                         </tbody>
                               </s:if>
                               <s:else><tr><td>There is no resource added.</td></tr></s:else>
                                  </table><br>
                                </div>
                            </div>
                    </div>
                              
                                        
                                        
                             </div>
                                </div>
                  
                   </s:iterator>
                       </s:if>  
                       <s:else><tr><td>There is no Course added</td></tr></s:else>
                  </div>
                 </div>
              </div>
          </div>
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          <!--Resource Modal Start -->
                        <div id="resourseModal" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                                <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                 <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Resources</h4>
                              </div>
                              <div class="modal-body">
                                
                                 <!--==================Add Resources================-->
                                 <div id="resouceFormDivId">
                                    <form id="resourceFormId">
                                    
                                    	<div class="row">
                                       	 <div class="form-group col-sm-4">
                                                <select class="form-control" name="type" id="selectResoureseId" onChange="resourse_select();">
                                                  <option value="1">Video</option>
                                                  <option value="2">Slide</option>
                                                  <option value="3">Content</option>
                                                </select>
                                         </div>
                                         </div>
                                      
                                    
                                        <div class="form-group">
                                            <input type="text" placeholder="Resource Title" class="form-control" name="resourceTitle" id="resourceTitleId" >
                                        </div>
                                        <div class="row">
                                            <div class="form-group col-sm-6 left_padding0">
                                                <input placeholder="Duration(Day/Days)" type="text" class="form-control" name="resDuration" id="resDurationId">
                                            </div>
                                            <div class="form-group col-sm-6 right_padding0">
                                                <input placeholder="Author" type="text" class="form-control" name="resAuthor" id="resAuthorId">
                                            </div>
                                         </div>
                                        
                                        <div class="form-group">
                                            <input  placeholder="Tags" type="text" class="form-control" name="resMetadata" id="resMetadataId">
                                        </div>
                                                                                            
                                        <div class="form-group">
                                            <textarea class="form-control" cols="4" name="resourceDesc" id="resourceDescId"></textarea>
                                        </div>
                                        
                                        <div class="form-group">
                                            <input placeholder="Add URL" type="text" class="form-control" name="resourceUrl" id="resourceUrlId">
                                        </div>
                                        <button type="button" class="bttn" data-dismiss="modal">SAVE</button>
                                        <!-- <button type="button" class="bttn" onClick="close_resources()">CLOSE RESOURCES</button> -->
                                </form>
                                </div>
                               
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                                <!-- <button type="button" class="bttn" onClick="add_resources()" data-id="add-resources">ADD RESOURCES</button> -->
                              </div>
                            </div>
                        
                          </div>
                        </div>
             
                        <!----Resource modal ends------->   
