 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script type="text/javascript">
 
 
 function getOrgCourse(){
 	var orgId = $("#selectOrgId").val();
 		$("#addButtonId").hide();
 		$("#addcoursebx").hide();
 		$.ajax({
 		 url:"getOrgCourse",
		  data : {"organisationId":orgId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	//$("#courseTableDivId").html(result);
		  }
		});
		getCourseChoiceforOrg();
 	return false;
 }
 
  function getCourseChoiceforOrg(){
 	   var orgId = $("#selectOrgId").val();
	 	if(orgId !=0){
		 	var url="getCourseChoice?organisationId="+orgId;
			$.get( url, function(data) {
			$("#courseSelectId").html("<option value='0'>All</option>");
				var result = JSON.parse(data);
			 	var optionHtml="";
			  for(var i=0;i<result.length;i++){
			  	optionHtml=optionHtml+"<option value='"+result[i].courseId+"'>"+result[i].courseName+"</option>";
			  }
			   $("#courseSelectId").html(optionHtml);
			   $("#courseMapSaveButtonId").show();
			});
		}else{
				$("#courseMapSaveButtonId").hide();
				$("#courseSelectId").html("<option value='0'>All</option>");
		}
 
 }
 
 function mapOrgCourse(){
 	startwindowDisable();
 	$("#orgCourseMapFormId").submit();
 }
 
function getCourseTable(){
 		var orgId = $("#selectOrgId").val();
 		$("#addButtonId").hide();
 		$("#addcoursebx").hide();
 		$.ajax({
 		 url:"getCourseTable",
		  data : {"organisationId":orgId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	$("#courseTableDivId").html(result);
		  }
		});
 		getDepartment();
 	} 
 	
 	function getCourseGroup(){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		$("#addButtonId").hide();
 		$("#addcoursebx").hide();
 		$.ajax({
 		 url:"getCourseTable",
		  data : {"organisationId":orgId,"departmentId":depId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	$("#courseTableDivId").html(result);
		  }
		});
 		getGroups();
 	}
 	
 	function courseGroupChange(){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var groupId = $("#selectGroupId").val();
 		$.ajax({
 		 url:"getCourseTable",
		  data : {"organisationId":orgId,"departmentId":depId,"groupId":groupId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	$("#courseTableDivId").html(result);
		  }
		});
		if(groupId>0){
 		getCourseChoice();
 		}else{
 			$("#courseSelectId").html("<option value='0'>All</option>");
 		}
 	}
 
 

 function getCourseChoice(){
 	   var orgId = $("#selectOrgId").val();
	 	var depId = $("#selectDepId").val();
	 	var groupId = $("#selectGroupId").val();
	 	if(depId !=0){
	 	startwindowDisable();
		 	var url="getCourseChoice?departmentId="+depId+"&organisationId="+orgId+"&groupId="+groupId;
			$.get( url, function(data) {
			 $("#courseSelectId").html("<option value='0'>All</option>");
			var result = JSON.parse(data);
			  var optionHtml="<option value='0'>All</option>";
			  for(var i=0;i<result.length;i++){
			  	optionHtml=optionHtml+"<option value='"+result[i].courseId+"'>"+result[i].courseName+"</option>";
			  }
			   $("#courseSelectId").html(optionHtml);
			});
			endwindowDisable();
		}else{
			$("#selectGroupId").html("<option value='0'>All</option>");
			$("#courseSelectId").html("<option value='0'>All</option>");
		}
 
 }
 	
	function showSelectDiv(elem) {
		if(elem.value==0){
			document.getElementById('selfId').style.display = "block";
			}			
			else if(elem.value==1){
			document.getElementById('selfId').style.display = "block";
			}
			else if(elem.value==2){
			document.getElementById('selfId').style.display = "none";
			}
	}
 	
 	 function addCourseForm() {
 	 		$(".toHideModuleDiv").hide();
 	 		$("#courseTypeId").show();
			$("#addcoursebx").show();
			$("#addcourseMapBox").hide();
			$("#updateButtonId").hide();
			$("#saveButtonId").show();
			$("#courseNameId").val("");
			$("#authorId").val("");
			$("#descriptionId").val("");
			$("#updateId").val(0);
			$("#courseDescriptionId .Editor-editor").html("");
           return false;
        }
		
	/* function mapCourseForm(){
			$("#addcourseMapBox").show();
			$("#addcoursebx").hide();
		 return false;
		} */
		
		function saveCourse(){
			var courseType =$("#courseTypeId").val();
			var courseName = $("#courseNameId").val();
			var author = $("#authorId").val();
			var courseIcon = $("#courseIconId").val();
			var mataData = $("#metaDataId").val();
			$("#descriptionId").val($("#courseDescriptionId .Editor-editor").html());
			var description = $("#descriptionId").val();
			var duration = Number($("[name='duration']").val().trim());
			
			if(courseType==2){
				showSuccessMessage("Please Select Course Nature");
				return false;
			}if(courseName==""){
				showSuccessMessage("Please Enter Course Name");
				return false;
			}if(description==""){
				showSuccessMessage("Please Enter Description");
				return false;
			}if(author==""){
					showSuccessMessage("Please Enter Author");
				return false;
			}if(isNaN(duration) || duration<=0){
					showSuccessMessage("Please Enter Duration must be number");
				return false;
			}if(mataData==""){
					showSuccessMessage("Please enter tag");
				return false;
			}if(courseIcon==""){
					showSuccessMessage("Please Select Course Icon");
				return false;
			}
			startwindowDisable();
			$("#courseFormId").submit();
			$("#addcoursebx").hide();
		}
		
		function mapCourse(){
			$("#courseMapFormId").submit();
			startwindowDisable();
		}
		
		function showMapButton(courseId){
			if(courseId>0){
				$("#mapSaveButtonId").show();
			}else{
				$("#mapSaveButtonId").hide();
			}
		
		}
		
		function cancelCourse(){
			$("#courseNameId").val("");
			$("#authorId").val("");
			$("#metadataId").val("");
			$("#descriptionId").val("");
			$("[name='duration']").val("");
			$("#addcoursebx").hide();
			return false;
			
		}
		
	/* function editCourse(course,author,description,id){
			$("#addcoursebx").show();
			$("#addcourseMapBox").hide();
			$("#updateButtonId").show();
			$("#saveButtonId").hide();
			$("#courseNameId").val(course);
			$("#authorId").val(author);
			$("#descriptionId").val(description);
			$("#updateId").val(id);
		return false;
	} */
	
	function editCourse(id){
			var author= $(".autherClass-"+id).val();
			var course= $(".courseNameClass-"+id).val();
			
			//$("#txtEditor").Editor();
			var description= $(".descriptionClass-"+id).val();
			var duration= $(".durationClass-"+id).val();
			var metaData= $(".metaDataClass-"+id).val();
			$("#courseTypeId").hide();
			$("#addcoursebx").show();
			$("#addcourseMapBox").hide();
				$("#addcoursebx #selfId").css('display', 'block');
			$("#updateButtonId").show();
			$("#saveButtonId").hide();
			$("#courseNameId").val(course);
			$("#authorId").val(author);
			$("#durationId").val(duration);
			$("#metaDataId").tokenfield('setTokens', metaData);
			$("#courseDescriptionId .Editor-editor").html(description);
			$("#updateId").val(id);
		return false;
	}
	
	function updateCourse(){
			var courseName = $("#courseNameId").val();
			var author = $("#authorId").val();
			var courseIcon = $("#courseIconId").val();
			var duration = $("#durationId").val();
			var description = $("#courseDescriptionId .Editor-editor").html();
			$("#descriptionId").val(description);
			if(courseName==""){
				showSuccessMessage("Please Enter Course Name");
				return false;
			}if(description==""){
				showSuccessMessage("Please Enter Description");
				return false;
			}if(author==""){
				showSuccessMessage("Please Enter Author");
				return false;
			}if(duration==""){
				showSuccessMessage("Please Enter Duration");
				return false;
			}/* if(courseIcon==""){
					showSuccessMessage("Please Select Course Icon");
				return false;
			} */
			startwindowDisable();
			$("#courseFormId").submit();
			$("#addcoursebx").hide();
		}
		
		
		/* Assignment Methods Start */
		
		function addAssignment(moduleId){
			$("#addassignmentModal"+moduleId+" #addAssignmentbox").show();
			return false;
		}
		
		function saveAssignment(moduleId){
 			var assignmentName = $("#addassignmentModal"+moduleId+" #assignmentFormId #assignmentNameId").val();
		 	var description = $("#addassignmentModal"+moduleId+" #assignmentFormId #descriptionId").val();
	 	if(assignmentName==""){
	 		showSuccessMessage("Please Enter Assignment");
			return false;
	 	}if(description==""){
	 		showSuccessMessage("Please Enter Description");
			return false;
	 	}
	 	var data= $("#addassignmentModal"+moduleId+" #assignmentFormId").serialize();
	 		startwindowDisable();
		$.post("saveAssignment",data,
	        function(data,status){
	        $("#assignmentTableDivId").html(data);
	        window.location="courseManagement";
	        endwindowDisable();
	        });
			$("#addAssignmentbox").hide();
		 	$("#assignmentNameId").val("");
		 	$("#descriptionId").val("");
 		return false;
 	}
 	
 	 	
 function editAssignment(title,description,id,moduleId) {
 
		$("#addassignmentModal"+moduleId+" #addAssignmentbox").show();
		$("#addassignmentModal"+moduleId+" #updateButtonId").show();
		$("#addassignmentModal"+moduleId+" #saveButtonId").hide();
		$("#addassignmentModal"+moduleId+"  #assignmentFormId #assignmentNameId").val(title);
	 	$("#addassignmentModal"+moduleId+"  #assignmentFormId #descriptionId").val(description);
	 	$("#addassignmentModal"+moduleId+"  #assignmentFormId #updateId").val(id);
	        return false;
	     }
	     
	          
	function updateAssignment(moduleId){
		var assignmentName = $("#addassignmentModal"+moduleId+" #assignmentFormId #assignmentNameId").val();
		 	var description = $("#addassignmentModal"+moduleId+" #assignmentFormId #descriptionId").val();
	 	if(assignmentName==""){
	 		showSuccessMessage("Please Enter Assignment");
			return false;
	 	}if(description==""){
	 		showSuccessMessage("Please Enter Description");
			return false;
	 	}
	 	startwindowDisable();
	 	var data= $("#addassignmentModal"+moduleId+" #assignmentFormId").serialize();
		$.post("updateAssignment",data,
	        function(data,status){
	      	 window.location="courseManagement";
	        endwindowDisable();
	        });
			$("#addAssignmentbox").hide();
		 	$("#assignmentNameId").val("");
		 	$("#descriptionId").val("");
 		return false;
	}   
	
	
	function assignmentType(id){
		if(id==1){
			$("#fileTypeFormDivId").show();
			$("#addQuestionDivId").hide();
			$("#trueFalseFormDivId").hide();
			$("#multipleChoiceFormDivId").hide();
		}else if(id==2){
			$("#addQuestionDivId").show();
			$("#fileTypeFormDivId").hide();
			$("#trueFalseFormDivId").hide();
			$("#multipleChoiceFormDivId").hide();
		}else if(id==3){
			$("#multipleChoiceFormDivId").show();
			$("#addQuestionDivId").hide();
			$("#fileTypeFormDivId").hide();
			$("#trueFalseFormDivId").hide();
		}else if(id==4){
			$("#trueFalseFormDivId").show();
			$("#addQuestionDivId").hide();
			$("#fileTypeFormDivId").hide();
			$("#multipleChoiceFormDivId").hide();
			
		}
	}
		/* Assignment Methods End */
 </script>
 
 <%-- 
 <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-book mr5"></i> Course Management</a></li>            
            <li class="active">Course</li>
          </ol>     
                 
            <!-- <div class="panel" id="ddd">
                
                <div class="panel-body">
                  	<div class="row">
                    		
                    </div>
    
                </div>
              </div> -->  
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
            <div class="row">
            	<div class="col-md-4 col-md-offset-8">
            <s:if test="#session.loginDetail !=null && #session.loginDetail.userType==4">	
              		<button style="margin-left: 10px;" class="btn btn-default btn-quirk btn-stroke pull-right scroll-link"  onclick="return addCourseForm();"   data-id="addcoursebx">ADD COURSE <i class="fa fa-plus-circle"></i></button>
             </s:if>
             	<button class="btn btn-default btn-quirk btn-stroke pull-right scroll-link"  onclick="return Show_MapDiv();"   data-id="addcoursebx">MAP COURSE <i class="fa fa-plus-circle"></i></button>
              </div>
              
              </div>
            </div>
            
            <div class="panel-body">
            
            	<div id="addcoursebx" style="display:none;">
        	
            	<div class="row">
            		<form id="courseFormId" action="saveCourse" method="post" enctype="multipart/form-data">
            			 <input type="text" class="form-control" name="courseId" id="updateId" style="display:none;">
                    		<div class="form-group col-md-4">
                            <label>Course Name <span class="strike_color">*</span></label>
                            <div class="form-group">
                           		 <input type="text" class="form-control" name="courseName" id="courseNameId">
                          </div>
                  	</div>
                  			
                  			<div class="form-group col-md-4">
                            <label>Author <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		 <input type="text" class="form-control" name="author" id="authorId">
                          </div>
                  </div>
                 			 <div class="form-group col-md-4">
                            <label>Duration(Day/Days) <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		 <input type="text" class="form-control" name="duration" id="durationId">
                          </div>
                  </div>
                  			<div class="form-group col-md-12">
	                    	<label>Tags <span class="strike_color">*</span></label>
	                        <input type="text" class="form-control" name="metadata" id="metadataId">
	                    </div>
                            <div class="form-group col-md-12">
                            	<label>Description <span class="strike_color">*</span></label>
                                <textarea required placeholder="" class="form-control" rows="5" aria-required="true" name="description" id="descriptionId"></textarea>
                            </div>
                             <div class="form-group col-md-12">
                            	<label>Course Icon <span class="strike_color">*</span></label>
                                <s:file name="courseIcon" id="descriptionId" />
                            </div>
                            <div class="form-group col-md-12" id="saveButtonId">
                            	<button class="btn btn-danger btn-quirk" onClick="return saveCourse();">save</button>
                            	 &nbsp;&nbsp;<button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelCourse();">CANCEL</button>
                            </div>
                            <div class="form-group col-md-12" id="updateButtonId">
                            	<button class="btn btn-danger btn-quirk" onClick="return updateCourse();">update</button>
                            	 &nbsp;&nbsp;<button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelCourse();">CANCEL</button>
                            </div>
                        </form>
                  		</div>	
            
        </div>
        
        <div id="addcourseMapBox" style="display:none;">
        	
            	<div class="row">
            		
            			<s:if test="#session.loginDetail !=null && #session.loginDetail.userType==4">	
            			<form id="orgCourseMapFormId" action="mapOrgCourse" method="post" >
                    		<div class="form-group col-md-4">
                            <label>Organization</label>
                            <select id="selectOrgId" class="form-control"  onchange="getOrgCourseTable();" name="organisationId">
                            
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
                  
                  <div class="form-group col-md-4">
                            <label>Course</label>
                        <select id="courseSelectId" onchange="showMapButton(this.value)" class="form-control" name="courseId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  
                 <div class="form-group col-md-12" id="courseMapSaveButtonId" style="display: none;">
                            	<button class="btn btn-danger btn-quirk" onClick="return mapOrgCourse();">Map</button>
                            </div>
                           </form>
                  </s:if>
                  <s:else>
                  <form id="courseMapFormId" action="mapCourse" method="post" >
			                  <div class="form-group col-md-4">
			                            <label>Organization</label>
			                            <select id="selectOrgId" class="form-control"  onchange="getCourseTable();" name="organisationId">
			                            
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
			                  
                  
                  
                  			<div class="form-group col-md-4">
                            <label>Department</label>
                        <select id="selectDepId" onchange="getCourseGroup();" class="form-control" name="departmentId">
                        	<option value="0">All</option>
                        	<s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                        		<s:iterator value="selectDepartmentsList">
                        			<option value='<s:property value="departmentId" />'><s:property value="departmentName" /></option>
                        		</s:iterator>
                        	</s:if>
                        </select>
                  </div>
                  			<div class="form-group col-md-4">
                            <label>Group</label>
                        <select id="selectGroupId" onchange="courseGroupChange();" class="form-control" name="groupId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  
                  	<div class="form-group col-md-4">
                            <label>Course</label>
                        <select id="courseSelectId" onchange="showMapButton(this.value)" class="form-control" name="courseId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                            <div class="form-group col-md-12" id="mapSaveButtonId" style="display: none;">
                            	<button class="btn btn-danger btn-quirk" onClick="return mapCourse();">Map</button>
                            </div>
                        </form>
                      </s:else>      
                       
                  		</div>	
            
        </div>
            
            
              <div class="table-responsive">
               	<div id="courseTableDivId">
               		<s:include value="courseTable.jsp"></s:include>
               	</div>
              </div><!-- table-responsive -->
              
              <nav class="pull-right">
                  <ul class="pagination">
                    <li>
                      <a href="#" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                      </a>
                    </li>
                    <li><a href="#">1</a></li>
                    <li><a href="#">2</a></li>
                    <li><a href="#">3</a></li>
                    <li><a href="#">4</a></li>
                    <li><a href="#">5</a></li>
                    <li>
                      <a href="#" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                      </a>
                    </li>
                  </ul>
                </nav>
            </div>
          </div>   
          
          	<!-- <div class="panel" >
            	<div class="panel-body">
               
                		
                </div>
            </div>  -->

		
        
        
        
        
           	
    </div>
    <!-- contentpanel --> 
    
  </div>  --%>
  <!-- mainpanel --> 
 

  <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-book mr5"></i> Course Management</a></li>  
            </ol>           
             <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		 <div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if>
              
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-12 col-md-12" >
               
              	  <button class="bttn pull-right btn-pos" onclick="return addCourseForm();"   data-id="addcoursebx">ADD COURSE <i class="fa fa-plus-circle"></i></button>
              		<button class="bttn pull-right btn-pos">PUSH CHANGES</button> 
                  <!-- <button class="bttn pull-right btn-pos" onclick="return mapCourseForm();"   data-id="addmapbx">MAP COURSE <i class="fa fa-plus-circle"></i></button> -->
                </div>
              </div>
              
            </div>
            
            <div class="panel-body">
            	<%-- <div id="addcourseMapBox" style="display:none;">
        	
        	<h4>MAP COURSE</h4>
        	
            	<div class="row">
               	 <form id="orgCourseMapFormId" action="mapOrgCourse" method="post">
                 	 <div class="form-group col-sm-4">
                        <label>Organization</label>
                            <select id="selectOrgId" class="form-control"  onchange="getOrgCourse();" name="organisationId">
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
                       <div class="form-group col-sm-4">
                        <label>Course</label>
                            <select id="courseSelectId"  name="courseId" class="form-control selectpicker" title="Select Course" multiple  data-actions-box="true" data-selected-text-format="count > 3">
                              
                               <option value="1">Sales</option>
                               <option value="2">Learning</option>
                               <option selected value="3">Management</option>
                               <option value="4">Marketing</option>
                               <option  value="5">Multiple</option>
                               <option value="6">Questions</option>
                               <option selected value="7">Answers</option>
                            </select>
                             <select id="courseSelectId" onchange="showMapButton(this.value)" class="form-control" name="courseId">
	                        	<option value="0">All</option>
	                        </select>
                     </div>
                   <div class="form-group col-md-4" id="courseMapSaveButtonId" style="display: none;">
                   		<button type="submit" onClick="return mapOrgCourse();" class="bttn map-btn">SAVE</button>
                   </div>
                  
                  
                </form>	    
                </div>	
             </div>
              --%>
             
             
             
             
             
             <div id="addcourseMapBox" style="display:none;">
        	
            	<div class="row">
            		
            			<s:if test="#session.loginDetail !=null && #session.loginDetail.userType==4">	
            			<form id="orgCourseMapFormId" action="mapOrgCourse" method="post" >
                    		<div class="form-group col-md-4">
                            <label>Organization</label>
                            <select id="selectOrgId" class="form-control"  onchange="getOrgCourse();" name="organisationId">
                            
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
                  
                  <div class="form-group col-md-4">
                            <label>Course</label>
                        <select id="courseSelectId" onchange="showMapButton(this.value)" class="form-control" name="courseId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  
                 <div class="form-group col-md-12" id="courseMapSaveButtonId" style="display: none;">
                            	<button class="bttn" onClick="return mapOrgCourse();">Map</button>
                            </div>
                           </form>
                  </s:if>
                  <s:else>
                  <form id="courseMapFormId" action="mapCourse" method="post" >
			                  <div class="form-group col-md-4" style="display:none;">
			                            <label>Organization</label>
			                            <select id="selectOrgId" class="form-control"  onchange="getCourseTable();" name="organisationId">
			                            
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
			                  
                  
                  
                  			<div class="form-group col-md-4">
                            <label>Department</label>
                        <select id="selectDepId" onchange="getCourseGroup();" class="form-control" name="departmentId">
                        	<option value="0">All</option>
                        	<s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                        		<s:iterator value="selectDepartmentsList">
                        			<option value='<s:property value="departmentId" />'><s:property value="departmentName" /></option>
                        		</s:iterator>
                        	</s:if>
                        </select>
                  </div>
                  			<div class="form-group col-md-4">
                            <label>Group</label>
                        <select id="selectGroupId" onchange="courseGroupChange();" class="form-control" name="groupId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  
                  	<div class="form-group col-md-4">
                            <label>Course</label>
                        <select id="courseSelectId" onchange="showMapButton(this.value)" class="form-control" name="courseId">
                        	<option value="0">All</option>
                        </select>
                  </div>
                            <div class="form-group col-md-12" id="mapSaveButtonId" style="display: none;">
                            	<button class="bttn" onClick="return mapCourse();">Map</button>
                            </div>
                        </form>
                      </s:else>      
                       
                  		</div>	
            
        </div>
             
             
             
             
             
             
             	
        <div id="addcoursebx" style="display:none;">
        
        	
        	<!-- <h4>ADD COURSE</h4> -->
        	
           <div class="row">
              <form id="courseFormId" action="saveCourse" method="post" enctype="multipart/form-data">
                 	<input type="text" class="form-control" name="courseId" id="updateId" style="display:none;">
                 	
                 	<div class="form-group col-sm-4">
                            <select class="form-control" name="courseType" onchange="showSelectDiv(this)" id="courseTypeId">
                            <option value="2">Select Course Type</option>
                              <option value="1">Self Paced Course</option>
                              <option value="0">Instructor Led Course</option>
                            </select>
                     </div>
                 <div id="selfId" class="form-group" style="display:none;">
                	<div class="form-group col-sm-12">
                        	 <input type="text" class="form-control" placeholder="Course Name"  name="courseName" id="courseNameId">
                    </div>
                    <div class="form-group col-sm-12"  id="courseDescriptionId">
                        <textarea  id="descriptionId" placeholder="Description" name="description"></textarea>
                    </div>
                  	<div class="form-group col-sm-4">
                          <input type="text" placeholder="Author" class="form-control" name="author" id="authorId">
                    </div>
                    <div class="form-group col-sm-4">
                          	 	<input type="text" class="form-control" name="duration" id="durationId" placeholder="Course Duration (in Hours)">
                    </div> 
                    <div class="form-group col-sm-4">
                            <input type="text" class="form-control tokenfield" data-tokens="Sales" name="metadata" id="metaDataId">
                     </div>
                     <div id="fileInput" class="form-group col-sm-1">
                            <label for="file"><img id="myImg" src="view/helper/images/title.jpg"></label>
                             <s:file name="courseIcon" id="courseIconId" />
                     </div>
                          
                   <!--   <div id="fileInput" class="form-group col-sm-4">
                            <label for="file"><img id="myImg" src="images/bg.jpg"></label>
                           
                        </div> -->
                       
                        <div class="form-group col-md-12" id="saveButtonId">
                            	<button class="bttn" onClick="return saveCourse();">SAVE</button>
                            	 &nbsp;&nbsp;<button class="bttn" onclick="return cancelCourse();">CANCEL</button>
                            </div>
                            <div class="form-group col-md-12" id="updateButtonId">
                            	<button class="bttn" onClick="return updateCourse();">UPDATE</button>
                            	 &nbsp;&nbsp;<button class="bttn" onclick="return cancelCourse();">CANCEL</button>
                            </div>
                            </div>
                    </form>
                  		</div>	
             </div>
            
            </div>
          </div> 
          
                  <div id="courseTableDivId">
               		<s:include value="courseTable.jsp"></s:include>
               	</div>
                  
                  
                  
                  
                  
                  
                
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  
  
  

<script type="text/javascript">


$("#showDivId").click(function(){
	
	var html="<div class='form-group test col-sm-10'>"+
     "<label>Add Another Question*</label>"+
     "<input type='text' class='form-control' required>"+
     "</div>"+
     "<div class='form-group test col-sm-2'>"+
     "<button type='button' class='bttn close-btn' id='removeDivId'><i class='fa fa-minus'></i></button>"+
     "</div>";
	 $("#tempId").before(html);

$("#removeDivId").click(function(){
	 $(".test").remove();
});
});


		/* function Show_div(elem) {
			document.getElementById('hide-btn').style.visibility = "hidden";
			if(elem.value==1){
			document.getElementById('addfile').style.display = "block";
			document.getElementById('addquestion').style.display = "none";
			document.getElementById('multiplechoice').style.display = "none";
			document.getElementById('true-false').style.display = "none";
			}
			else if(elem.value==2){
			document.getElementById('addquestion').style.display = "block";
			document.getElementById('multiplechoice').style.display = "none";
			document.getElementById('true-false').style.display = "none";
			document.getElementById('addfile').style.display = "none";
			}
			else if(elem.value==3){
			document.getElementById('multiplechoice').style.display = "block";
			document.getElementById('true-false').style.display = "none";
			document.getElementById('addfile').style.display = "none";
			document.getElementById('addquestion').style.display = "none";
			}
			else if(elem.value==4){
			document.getElementById('true-false').style.display = "block";
			document.getElementById('addfile').style.display = "none";
			document.getElementById('addquestion').style.display = "none";
			document.getElementById('multiplechoice').style.display = "none";
			}
		} */
		
		
		 /* function Hide_Div() {
			$("#addcoursebx").hide();
           return false;
        }
		
		 function Hide_Div1() {
			$("#addmodulebx").hide();
           return false;
        }
		
		function Hide_filediv() {
			
			$("#addassignmentbx").hide();			
           return false;
        }
		function close_resources() {
			
			$("#add-resources").hide();			
           return false;
        } */
        
        $(document).ready(function() {
					$("#descriptionId").Editor();
					$("#resourceDescId").Editor();
					$(".Editor-editor").attr("data-text","Description");
					$(".tokenfield").tokenfield();
  				
				});
    </script>
    
    
   