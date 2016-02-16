  <%@ taglib prefix="s" uri="/struts-tags"%>
  
  <style>
  #addAssignmentbox .selectTypeHideId{
	display:none;  
  }
  </style>
  
<script type="text/javascript">
 
var courseId ='${courseVo.courseId}';
var moduleId ='${courseVo.moduleId}';
var type = '${courseVo.type}';
var formTypeId =0;
$(document).ready(function() {
	$("#fileTypeEditorId").Editor();
	$(".subFormEditor").Editor();
});
   
	function applyEditor(assId){
		$("#QuestionEditorId"+assId).Editor();
		$("#QuestionEditorId"+assId+" .Editor-editor").attr("data-text","Question");
	}

var tempId=3;
var addId=2;
function appendChoiceDiv(id,courseType){

	var editDiv=$("#questionFormId"+id);
	editDiv.find("#questionId"+addId).val();
	if(editDiv.find("#questionId"+addId).val()!=""){
	//var aaa= $("#questionId"+tempId-1).val();

		var boxhtml="<div class='form-group' style='clear:both' id='appendData"+tempId+"'>"+
					"<label class='label_set col-sm-2' for='text'>Option:</label>"+
					"<div class='col-sm-7'>"+
					  "<input type='text' id='questionId"+tempId+"' name='choice' class='form-control mgl80' placeholder='Enter option' required>"+
					"</div>"+
					 "<div class='checkbox col-sm-2'>";
					 if(courseType==1){
						boxhtml=boxhtml+ "<label class='mlm80'><input type='checkbox' name='check' value='"+tempId+"'>Is Answer</label>";
					  }
					 boxhtml=boxhtml+ "<button type='button' class='bttn mgl20' onclick='removeChoiceDiv("+tempId+");'><i class='fa fa-minus'></i></button>"+
					"</div>"+
					"<div class='col-sm-1'>"+
					  "</div>"+
					"</div>";
					
					tempId++;
					addId++;
				$("#choiceOptionId-"+id).append(boxhtml).html();
			}else{
				showSuccessMessage("please fill Option");
			}
}

	function removeChoiceDiv(id){
	
	$("#appendData"+id).remove();
	tempId--;
	
	return false;
	}

function addQuestion(assId){

	$(".questionForm").hide();
	$("#addQuestionBox"+assId).show();
	var sddDiv=$("#addQuestionBox"+assId);
	sddDiv.find("#questionMainId").val(0);
	
	sddDiv.find("#updateBtnId").hide();
	sddDiv.find("#saveBtnId").show();
	$("#addQuestionBox"+assId+" input[type=text]").val("");
	$("#addQuestionBox"+assId+" input[type=checkbox]").prop('checked', false);
	$("#questionDetailEditorId .Editor-editor").html("");
	
}

function editQuestion(id,quesId,courseType){
	//$("#addAssignmentbox #selectTypeHideId").hide();
	$("#selectTypeId").addClass("selectTypeHideId");
	var question = $("#question--"+quesId).val();
	var check = $("#checkssize--"+quesId).val();
	
	var teempp=$("#checkssize"+quesId).val();
	var choice = $("#choicesize--"+quesId).val();
	var editBox=$("#addQuestionBox"+id);
	$("#QuestionEditorId"+quesId).Editor();
	 
	var descText=$("#addQuestionBox"+id+" #questionDetailEditorId .Editor-editor").html();
	$("#QuestionEditorId"+id).val(descText);
	editBox.find("#updateBtnId").show();
	editBox.find("#saveBtnId").hide();
	var selectBoxId = editBox.find("#selectTypeId").val();
	editBox.find("#questionMainId").val(quesId);
	if(selectBoxId ==1){
	
	}
	
	if(selectBoxId ==2){
	}
	
	if(selectBoxId ==3){
/* 	$("#addQuestionBox"+id+" #selectTypeId").val(selectBoxId); */
	if(choice>0){
		for(var aa=1;aa<=choice; aa++){
		if(aa<3){
		editBox.find("#questionId"+aa).val($("#"+quesId+"-choiceQuestion--"+aa).val());
		}
		else{
		var boxhtml="<div class='form-group' style='clear:both' id='appendData"+aa+"'>"+
					"<label class='label_set col-sm-2' for='text'>Option:</label>"+
					"<div class='col-sm-7'>"+
					  "<input type='text' id='questionId"+aa+"' name='choice' value='"+$("#"+quesId+"-choiceQuestion--"+aa).val()+"' class='form-control mgl80' placeholder='Enter option' required>"+
					"</div>";
					if(courseType==1){
					boxhtml=boxhtml+ "<div class='checkbox col-sm-2'>"+
					  "<label class='mlm80'><input type='checkbox' id='checkboxId"+aa+"' name='check' value='"+aa+"'>Is Answer</label>"+
					"</div>";}
					boxhtml=boxhtml+"<div class='col-sm-1'>"+
					    "<button type='button' class='bttn mgl20' onclick='removeChoiceDiv("+aa+");'><i class='fa fa-minus'></i></button>"+
					  "</div>"+
					"</div>";
					 
	$("#choiceOptionId-"+id).append(boxhtml).html();
			}
		}
	}
	
 
 
 var ch=teempp.split(", ");
 
	 
		for(var i=0;i<ch.length; i++){
		$("#addQuestionBox"+id+" #checkboxId"+ch[i]).prop('checked', true);
	 
	}
	
	}
	if(selectBoxId ==4){
	var box=$("#truesfalseId--"+quesId).val();
	$("#addQuestionBox"+id+" #selectTypeId").val(selectBoxId);
	$("#addQuestionBox"+id+" #ddrOptionId").val(box);
	}
	$("#questionDetailEditorId .Editor-editor").html(question);
	$(".questionForm").hide();
	$("#addQuestionBox"+id).show();

	return false;
	}

function cancelAddQuestion(){
	$(".questionForm").hide();
	return false;
}


function updateQuestion(id){
	var qusId=$("#questionFormId"+id+" #questionMainId").val();;
	var type=$("#questionFormId"+id+" #selectTypeId").val();
	$("#QuestionEditorId"+id).val($("#questionFormId"+id+" #questionDetailEditorId .Editor-editor").html());
	var descText=$("#QuestionEditorId"+id).val();	
	if(descText==""||descText=="<br>"){ 
			showSuccessMessage("Please Enter Question");
			return false;
		}
	var dataString=$("#questionFormId"+id).serialize();
	var data = dataString+"&assignmentId="+id;  
	 $.post("updateQuestion",data, function(result){
	       	//$("#assignmentTableDivId").html(result);
	       		window.location="assignment?courseId="+courseId+"&moduleId="+moduleId+"&type="+type;
	       	$("#QuestionEditorId"+id).Editor();
	    });
	return false;
}

function saveQuestion(assId){
		$("#QuestionEditorId"+assId).val($("#questionFormId"+assId+" .Editor-editor").html());
		var question = $("#QuestionEditorId"+assId).val();
		if(question==""||question=="<br>"){ 
			showSuccessMessage("Please Enter Question");
			return false;
		}
		var data = $("#questionFormId"+assId).serialize(); 
		data=data+"&assignmentId="+assId;
		  $.post("saveQuestion",data, function(result){
	       	//$("#assignmentTableDivId").html(result);
	       	window.location="assignment?courseId="+courseId+"&moduleId="+moduleId+"&type="+type;
	    });
		 
	return false;
}


function getModule(){
	 	var courseId = $("#courseSelectId").val();
			if(courseId>0){
			 var url="getModule?courseId="+courseId;
			$.get( url, function(data) {
			$("#moduleSelectId").html("<option value='0'>All</option>");
			var result = JSON.parse(data);
			  var optionHtml="<option value='0'>All</option>";
			  for(var i=0;i<result.length;i++){
			  	optionHtml=optionHtml+"<option value='"+result[i].moduleId+"'>"+result[i].moduleName+"</option>";
			  }
			   $("#moduleSelectId").html(optionHtml);
			});
		}else{
			$("#moduleSelectId").html("<option value='0'>All</option>");
		}
 	}

 	function getAssignmentModule(){
 	 	$("#addAssignmentbox").hide();
 		$("#addButtonId").hide();
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var groupId = $("#selectGroupId").val();
 		var courseId = $("#courseSelectId").val();
 		$.ajax({
 		 url:"getAssignmentTable",
		  data : {"organisationId":orgId,"departmentId":depId,"groupId":groupId,"courseId":courseId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	$("#assignmentTableDivId").html(result);
		  }
		});
 		getModule();
 	}
 	
 	function getAssignmentTable(){
 		var orgId = $("#selectOrgId").val();
 		var depId = $("#selectDepId").val();
 		var groupId = $("#selectGroupId").val();
 		var courseId = $("#courseSelectId").val();
 		var moduleId = $("#moduleSelectId").val();
 		if(moduleId==0){
 			$("#addAssignmentbox").hide();
 			$("#addButtonId").hide();
 		}else{
 			$("#addButtonId").show();
 			$("#addAssignmentbox").hide();
 		}
 		$.ajax({
 		 url:"getAssignmentTable",
		  data : {"organisationId":orgId,"departmentId":depId,"groupId":groupId,"courseId":courseId,"moduleId":moduleId},
			beforeSend : function(){
		  },
		  success : function(result){
		  	$("#assignmentTableDivId").html(result);
		  }
		});
 		
 	}
 

     function Show_Div() {
   		$("#selectTypeId").val(0);
		$("#addAssignmentbox").show();
		$("#selectTypeId").show();
		$("#saveButtonId").show();
		$("#updateButtonId").hide();
		$("#selectTypeDivId").show();
		$("#assignmentNameId").val("");
		$("#selectTypeId").removeClass("selectTypeHideId");
		$("#assignDescriptionId .Editor-editor").html("");
		$("#updateId").val(0);
	     return false;
     }
	     
	 function cancelAssignment() {
		$("#addAssignmentbox").hide();
		$("#assignmentNameId").val("");
	 	$("#descriptionId").val("");
	        return false;
	    }     

 	
 	function saveAssignment(){
 		if(formTypeId==0){
 			showSuccessMessage("Please Select Type");
 			return false;
 		}
	 	
	 	var assignmentName = $("#assignmentNameId").val();
	 	var description = $("#fileTypeEditorId").val($("#fileTypeEditorId").parent().find(".Editor-editor").html());
	 	if(assignmentName==""){
	 		showSuccessMessage("Please Enter Assignment");
			return false;
	 	}if(description==""){
	 		showSuccessMessage("Please Enter Description");
			return false;
	 	}
	 	var data= $("#fileTypeFormFormId").serialize();
	 		data=data+"&courseId="+courseId+"&moduleId="+moduleId+"&type="+formTypeId;
	 		startwindowDisable();
		$.post("saveAssignment",data,
	        function(data,status){
	        //$("#assignmentTableDivId").html(data);
	        	window.location="assignment?courseId="+courseId+"&moduleId="+moduleId+"&type="+type;
	        endwindowDisable();
	        });
			$("#addAssignmentbox").hide();
		 	$("#assignmentNameId").val("");
		 	$("#descriptionId").val("");
 		return false;
 	}
 	
 	
 function editAssignment(title,description,id) {
		$("#addAssignmentbox").show();
		$("#updateButtonId").show();
		$("#saveButtonId").hide();
		$("#selectTypeDivId").hide();
		$("#assignmentNameId").val(title);
	 	$("#descriptionId").val(description);
	 	$("#updateId").val(id);
	        return false;
	     }
	     
	     
	function updateAssignment(){
		var assignmentName = $("#assignmentNameId").val();
	 	$("#fileTypeEditorId").val($("#assignDescriptionId .Editor-editor").html());
	 	var description =$("#fileTypeEditorId").val();
	 	if(assignmentName==""){
	 		showSuccessMessage("Please Enter Assignment");
			return false;
	 	}if(description==""||description=="<br>"){
	 		showSuccessMessage("Please Enter Description");
			return false;
	 	}
	 	startwindowDisable();
	 	var data= $("#fileTypeFormFormId").serialize();
	 	
	 	 	data=data+"&courseId="+courseId+"&moduleId="+moduleId;
		$.post("updateAssignment",data,
	        function(data,status){
	        //$("#assignmentTableDivId").html(data);
	        	window.location="assignment?courseId="+courseId+"&moduleId="+moduleId+"&type="+type;
	        	endwindowDisable();
	        });
			$("#addAssignmentbox").hide();
		 	$("#assignmentNameId").val("");
		 	$("#descriptionId").val("");
 		return false;
	}   
	     
	     
	     
	 function editAssignment(id){
		var assignmentName=$("#assignmentName---"+id).val();
		var description=$("#description---"+id).val();
		var type=$("#type---"+id).val();
		
		$("#assignmentNameId").val(assignmentName);
		$("#selectTypeId").val(type);
		$("#selectTypeDivId").hide();
		$("#assignDescriptionId .Editor-editor").html(description);
		$("#updateId").val(id);
		$("#addAssignmentbox").show();
		$("#saveButtonId").hide();
		$("#updateButtonId").show();
	
		return false;
	}
	    
	     
	     
	     
	function assignmentType(id){
		formTypeId=id;
		if(id==0){
			document.getElementById('fileTypeFormDivId').style.display = "none";
			}
			else if(id==1){
			document.getElementById('fileTypeFormDivId').style.display = "block";
			}
			else if(id==2){
			document.getElementById('fileTypeFormDivId').style.display = "block";
			}
			else if(id==3){
			document.getElementById('fileTypeFormDivId').style.display = "block";
			}
			else if(id==4){
			document.getElementById('fileTypeFormDivId').style.display = "block";
			}
	/**	if(id==1){
			$("#fileTypeFormDivId").show();
			$("#fileTypeEditorId").Editor();
			$("#addQuestionDivId").hide();
			$("#trueFalseFormDivId").hide();
			$("#multipleChoiceFormDivId").hide();
		}else if(id==2){
			$("#addQuestionDivId").show();
			$("#addQuestionEditorId").Editor();
			$("#fileTypeFormDivId").hide();
			$("#trueFalseFormDivId").hide();
			$("#multipleChoiceFormDivId").hide();
		}else if(id==3){
			$("#multipleChoiceFormDivId").show();
			$("#multipleChoiceEditorId").Editor();
			$("#addQuestionDivId").hide();
			$("#fileTypeFormDivId").hide();
			$("#trueFalseFormDivId").hide();
		}else if(id==4){
			$("#trueFalseFormDivId").show();
			$("#trueFalseEditorId").Editor();
			$("#addQuestionDivId").hide();
			$("#fileTypeFormDivId").hide();
			$("#multipleChoiceFormDivId").hide();
			
		} **/
	}
</script>

<%-- <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-book mr5"></i> Course Management</a></li>            
            <li class="active">Assignment</li>
          </ol>     
                 
            <div class="panel" id="ddd">
                
                <div class="panel-body">
                  	<div class="row">
                  
               			   <div class="form-group col-md-4" style="margin-top:10px;">
                            <label>Course</label>
                        <select id="courseSelectId" class="form-control" onchange="return getAssignmentModule();">
                        	 <s:if test="coursesList !=null">
		                             	<option value="0">All</option>
		                             	<s:iterator value="coursesList">
		                              		<option value="<s:property value="courseId"/>"><s:property value="courseName"/> </option>
		                              	</s:iterator>
	                              </s:if>
                        </select>
                  </div>
                 			<div class="form-group col-md-4" style="margin-top:10px;">
                            <label>Module</label>
                        <select id="moduleSelectId" class="form-control"  onchange="getAssignmentTable();">
                          <option value="0">All</option>
                        </select>
                  </div>
                    </div>
    
                </div>
              </div>  
              
            <div class="panel">
            <div class="panel-heading">
              <div class="row">
              		<div class="col-md-4 col-md-offset-8" id="addButtonId">
              			<button class="bttn pull-right" onclick="return Show_Div();">ADD Assignment <i class="fa fa-plus-circle"></i></button>
              		</div>
              </div>
            </div>
            
            <div class="panel-body">
            
            
            <div id="addassignmentbx">
                                    <form>
                                                <div class="row">
                                                    
                                                    <div class="form-group col-sm-4">
                                                    	<label>Type</label>
                                                            <select class="form-control"  onChange="assignmentType(this.value)">
                                                              <option value="0">Select Type</option>
                                                              <option value="1">File Upload</option>
                                                              <option value="2">Question/Answer</option>
                                                              <option value="3">Multiple Choice</option>
                                                              <option value="4">True/False</option>
                                                            </select>
                                                     </div>
                                                     <div id="fileTypeFormDivId" class="form-group" style="display:none;">
                                       
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title<span class="strike_color">*</span></label>
                                                            <div class="form-group">
                                                                 <input type="text" class="form-control" required>
                                                            </div>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description<span class="strike_color">*</span></label>
                                                             <div id="txtEditor6"></div>
                                                        </div>
                                                        
                                                        <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                   
      												</div>
                                                     <div id="addQuestionDivId" class="form-group" style="display:none;">
                                       
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title<span class="strike_color">*</span></label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description<span class="strike_color">*</span></label>
                                                            <div id="txtEditor7"></div>
                                                        </div>
                                                        <div class="form-group col-sm-10">
                                                            <label>Add Question<span class="strike_color">*</span></label>
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
                                                   
      												</div>
                                                     <div id="multipleChoiceFormDivId" class="form-group" style="display:none;">
                                       
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
                                                          
                                                        </div>      
                                                     <div id="trueFalseFormDivId" class="form-group" style="display:none;">
                                       
                                                        <div class="form-group col-sm-12">
                                                            <label>Assignment Title<span class="strike_color">*</span></label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <label>Description<span class="strike_color">*</span></label>
                                                             <div id="txtEditor9"></div>
                                                        </div>
                                                        
                                                        <div class="form-group col-sm-8">
                                                            <label>Add Question<span class="strike_color">*</span></label>
                                                            <input type="text" class="form-control" required>
                                                        </div>
                                                        <div class="form-group col-sm-2">
                                                        	<button type="button" class=" bttn close-btn"><i class="fa fa-plus"></i></button>
                                                        </div>
                                                         <div class="form-group col-sm-2" style="position:relative; top:24px">
                                                        	<select>
                                                            	<option>True</option>
                                                                <option>False</option>
                                                                
                                                                
                                                            </select>
                                                         
                                                        </div>
                                                         <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                        </div>                                                    
                                                        <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn" id="hide-btn" onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                   
      												</div>
                                               	
                                              </form>
                                </div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            	<div id="addAssignmentbox" style="display:none;">
        	
        	
            	<div class="row">
                   <form id="assignmentFormId">
                   		<input type="text" class="form-control" name="assignmentId" id="updateId" style="display:none;">
                 		<div class="form-group col-md-4">
                            <label>Assignment <span class="strike_color">*</span></label>
                        	<div class="form-group">
                           		 <input type="text" class="form-control" name="assignmentName" id="assignmentNameId">
                          </div>
                 		 </div>
                  
                  
                  			
                            <div class="form-group col-md-12">
                            	<label>Description <span class="strike_color">*</span></label>
                                <textarea name="description"  placeholder="" class="form-control" rows="5" aria-required="true" id="descriptionId"></textarea>
                            </div><br/>
                            
                        </form>
                            <div class="form-group col-md-12" id="saveButtonId">
                            	<button class="btn btn-danger btn-quirk" onClick="return saveAssignment();">save</button>
                            	&nbsp;&nbsp;<button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelAssignment();">CANCEL</button>
                            </div>
                             <div class="form-group col-md-12" id="updateButtonId">
                            	<button class="btn btn-danger btn-quirk" onClick="return updateAssignment();">update</button>
                            	&nbsp;&nbsp;<button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelAssignment();">CANCEL</button>
                            </div>
                  		</div>	
                    
           
        </div>
            
              <div class="table-responsive">
               	<div id="assignmentTableDivId">
               		<s:include value="assignmentTable.jsp"></s:include>
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
          
        
	
        
        
        
        
           	
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
 --%>
 
 
 <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-book mr5"></i> Course Management</a></li>            
            <!-- <li class="active">Course</li> -->
          </ol>     
             <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		 <div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if> 
         
              
            <div class="panel" id="">
            <div class="panel-heading">
            	<a class="bttn pda" href="courseManagement;">GO BACK TO COURSE</a>
            
             <div class="row">
              	<div class="col-sm-9">
                	<%-- <p class="mgt25"><strong>Course Name:</strong> <span>${courseVo.courseName}</span></p> --%>
                	<p><strong>Course Name : </strong> <span><s:property value="courseName"/></span></p>
                
                	<%-- <p class="mgt25"><strong>Lesson Name:</strong> <span>${courseVo.moduleName}</span></p> --%>
                	<p><strong>Lesson Name : </strong> <span><s:property value="moduleName"/></span></p>
                </div>
                <div class="col-sm-3">
              	  <button class="bttn pull-right btn-pos"  onclick="return Show_Div();"   data-id="addassignmentbx">ADD ASSIGNMENT <i class="fa fa-plus-circle"></i></button>
                  
                </div>
              </div>
            </div>
            
            			<div class="panel-body">
                                 <div id="addAssignmentbox" class="" style="display:none">
                                                <div class="row">
                                               <form id="fileTypeFormFormId">
                                                    <s:set var = "courseTypeCheck" value = "%{courseVo.type}" />
                                                    <div class="form-group col-sm-4" id="selectTypeDivId">
                                                    	<select class="form-control" id="selectTypeId" onChange="assignmentType(this.value)" >
                                                              <option value="0">Select Type</option>
                                                              <s:if test="courseVo.type !=1">
	                                                              <option value="1">File Upload</option>
	                                                              <option value="2">Question/Answer</option>
                                                              </s:if>
                                                              <option value="3">Multiple Choice</option>
                                                              <option value="4">True/False</option>
                                                            </select>
                                                     </div>
                                                     <div id="fileTypeFormDivId" class="form-group" style="display: none;">
                                       					
                                       					<input type="text" class="form-control" name="assignmentId" id="updateId" style="display:none;">
	                                                        <div class="form-group col-sm-12">
	                                                            <input type="text" id="assignmentNameId" name="assignmentName" class="form-control" required placeholder="Assignment Title">
	                                                        </div>
	                                                        <div class="form-group col-sm-12" id="assignDescriptionId">
	                                                        	<textarea rows="" cols="" name="description" id="fileTypeEditorId"></textarea>
	                                                        </div>
	                                                        
	                                                        <div class="form-group col-sm-12" id="saveButtonId" style="display:none;">
	                                                            <button type="button" onclick="return saveAssignment();" class="bttn">SAVE</button>
	                                                            <button type="submit" class="bttn"  onclick="return cancelAssignment();">CANCEL</button>
	                                                    	</div>
	                                                    	
	                                                    	<div class="form-group col-sm-12" id="updateButtonId" style="display:none;">
							                            	<button class="bttn" onclick="return updateAssignment();">UPDATE</button>
							                            	&nbsp;&nbsp;<button class="bttn" onclick="return cancelAssignment();">CANCEL</button>
							                            </div>
      												</div>
      											</form>
                                                     <%-- <div id="addQuestionDivId" class="form-group" style="display:none;">
                                       
                                                        <div class="form-group col-sm-12">
                                                            <input type="text" class="form-control" required placeholder="Enter Assignment Title">
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                        <textarea rows="" cols="" name="" id="addQuestionEditorId"></textarea>
                                                        </div>
                                                        <div class="form-group col-sm-10">
                                                            <div id="txtEditor10"></div>
                                                        </div>
                                                        <div class="form-group col-sm-2">
                                                        	<button type="button" class=" bttn" id="showDivId"><i class="fa fa-plus"></i></button>
                                                            
                                                        </div>
                                                        <div id="tempId"></div>
                                                        <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                   
      												</div>
                                                     <div id="multipleChoiceFormDivId" class="form-group" style="display:none;">
                                       
                                                        <div class="form-group col-sm-12">
                                                           <input type="text" class="form-control" required placeholder="Enter Assignment Title">
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <textarea rows="" cols="" name="" id="multipleChoiceEditorId"></textarea>
                                                        </div>
                                                        
                                                        <div class="form-group col-sm-10">
                                                            <div id="txtEditor11"></div>
                                                        </div>
                                                        <div class="form-group col-sm-2">
                                                        	<button type="button" class=" bttn"><i class="fa fa-plus"></i></button>
                                                        </div>
                                                       
                                                          <div class="form-group">
                                                          	
                                                                <label class="label_set col-sm-2" for="text">Option:</label>
                                                                <div class="col-sm-7">
                                                                  <input type="text" class="form-control mgl80" placeholder="Enter option" required>
                                                                </div>
                                                                 <div class="checkbox col-sm-2">
                                                                  <label class="mlm80"><input type="checkbox" value="">Is Answer</label>
                                                                </div>
                                                                <div class="col-sm-1">
                                                                    <!---<button type="button" class=" bttn close-btn1"><i class="fa fa-plus"></i></button>-->
                                                                </div>
                                                               
                                                                
                                                          </div>
                                                           <div class="form-group" style="clear:both">
                                                            <label class="label_set col-sm-2" for="text">Option:</label>
                                                            <div class="col-sm-7">
                                                              <input type="text" class="form-control mgl80" placeholder="Enter option" required>
                                                            </div>
                                                             <div class="checkbox col-sm-2">
                                                              <label class="mlm80"><input type="checkbox" value="">Is Answer</label>
                                                            </div>
                                                            <div class="col-sm-1">
                                                        		<button type="button" class=" bttn close-btn1"><i class="fa fa-plus"></i></button>
                                                        	</div>
                                                           
                                                          </div>
                                                         
                                                          
                                                       
                                                          <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	   </div>
                                                          
                                                        </div>      
                                                     <div id="trueFalseFormDivId" class="form-group" style="display:none;">
                                       
                                                        <div class="form-group col-sm-12">
                                                            <input type="text" class="form-control" required placeholder="Enter Assignment Title">
                                                        </div>
                                                        <div class="form-group col-sm-12">
                                                            <textarea rows="" cols="" name="" id="trueFalseEditorId"></textarea>
                                                        </div>
                                                        
                                                        <div class="form-group col-sm-9">
                                                           <div id="txtEditor12"></div>
                                                        </div>
                                                         <div class="form-group col-sm-2">
                                                        	<select class="form-control">
                                                            	<option>True</option>
                                                                <option>False</option>
                                                                
                                                                
                                                            </select>
                                                         
                                                        </div>
                                                        <div class="form-group col-sm-1">
                                                        	<button type="button" class=" bttn"><i class="fa fa-plus"></i></button>
                                                        </div>
                                                        
                                                         <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn">SAVE</button>
                                                            <button type="submit" class="bttn"  onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div>
                                                        </div>   --%>                                                  
                                                       <!--  <div class="form-group col-sm-12">
                                                            <button type="submit" class="bttn" id="hide-btn" onclick="return Hide_filediv();">CANCEL</button>
                                                    	</div> -->
                                                   
      												</div>
                                               	
                                </div>
                            
            
            </div>
          </div> 
          <div id="assignmentTableDivId">
          		<s:include value="assignmentTable.jsp"></s:include>
          </div>
         
              
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  