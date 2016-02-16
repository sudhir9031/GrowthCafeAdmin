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

 <%-- <table class="table table-bordered table-danger nomargin">
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                       S. No
                      </th>
                      <th width="60%">Assignment</th>                     
                      <th width="16%" class="text-center">Edit</th>
                      <th width="16%" class="text-center">Deactivate</th>
                    </tr>
                  </thead>
                  <tbody>
                  <s:if test="assList !=null && assList.size()>0">
                  	<s:iterator value="assList" status="status">
                  		<tr>
	                      <td class="text-center">
	                       <s:property value="%{#status.count}"/>
	                      </td>
	                      <td><s:property value="assignmentName"/></td>                      
	                      <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke " onclick="editAssignment('<s:property value="assignmentName"/>','<s:property value="description"/>',<s:property value="assignmentId"/>)">edit</button></td>
	                       <s:if test="status==1">
						<td class="text-center"><button
								class="btn btn-danger btn-quirk" onclick="courseActiveDeactive(<s:property value="assignmentId"/>,0,'assignment')">Activate</button>
						</td>
						</s:if>
						<s:else>
							<td class="text-center"><button class="btn btn-danger btn-quirk btn-stroke" onclick="courseActiveDeactive(<s:property value="assignmentId"/>,1,'assignment')">deactivate</button></td>
						</s:else> 
                    </tr>
                  	</s:iterator>
                  </s:if>
                  </tbody>
                </table> --%>
                
                
                <div id="course-panel"> 
              <div class="panel">
                 <div class="panel-body">
                  <s:if test="assList !=null && assList.size()>0">
                    <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" >
                               S.No
                              </th>
                              <th width="50%" bgcolor="#e1e1e1">
                              ASSIGNMENT</th>                     
                              <th width="13%" bgcolor="#e1e1e1" >TYPE</th>
                              <th width="32%" bgcolor="#e1e1e1" >ACTION</th>
                            </tr>
                            
                          </thead>
                        </table>
                    </div>
                   
                     <div class="panel-group" id="accordion"  role="tablist" aria-multiselectable="true">
                          <s:iterator value="assList" status="status" var="assDetail">
                     	<div class="panel panel-default">
                     	<div class="panel-heading" role="tab">
                      <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <tbody>
                            <tr>
                              <td width="5%">
                               <s:property value="#status.count" />
                              </td>
                              <td width="50%" ><s:text name="assignmentName"/></td>
                              <td width="13%"  >
                              <s:if test="type==1">File Upload</s:if> 
                              <s:elseif test="type==2">Question/Answer</s:elseif>
                              <s:elseif test="type==3">Multiple Choice</s:elseif>
                              <s:elseif test="type==4">True/False</s:elseif>
                              </td> 
                              <td width="32%"  bgcolor="#e1e1e1">
                               <s:if test="type!=1"> 
                               			<button class="bttn" onclick="return addQuestion(<s:property value="assignmentId"/>);" data-id="addquestion1">ADD QUESTION <i class="fa fa-plus-circle"></i></button> 
                                   </s:if> 
                                   <s:else>
                                   		<button class="bttn mg17 gbg" disabled type="button">ADD QUESTION <i class="fa fa-plus-circle"></i></button> 
                                   </s:else>               
                              		<button class="bttn" onclick="return editAssignment(<s:property value="assignmentId"/>);" type="submit">EDIT</button> 
                              		<input type="hidden" name="assignmentName" value="<s:property value="assignmentName"/>" id="assignmentName---<s:property value="assignmentId"/>">
                              		<input type="hidden" name="description" value="<s:property value="description"/>" id="description---<s:property value="assignmentId"/>">
                              		<input type="hidden" name="type" value="<s:property value="type"/>" id="type---<s:property value="assignmentId"/>">
                              		<input type="hidden" name="courseId" value="<s:property value="courseId"/>" >
                              		<input type="hidden" name="moduleId" value="<s:property value="moduleId"/>" >
                              		<!-- <button class="bttn" type="submit">DEACTIVATE</button> -->
                              		 <s:if test="status==1">
										<button	class="bttn" onclick="assignmentActiveDeactive(<s:property value="assignmentId"/>,0,'assignment',<s:property value="courseId"/>,<s:property value="moduleId"/>)">Activate</button>
									</s:if>
									<s:else>
										<button class="bttn" onclick="assignmentActiveDeactive(<s:property value="assignmentId"/>,1,'assignment',<s:property value="courseId"/>,<s:property value="moduleId"/>)">deactivate</button>
									</s:else> 
		                              <s:if test="type!=1">
			                              	<a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion" href="#collapse<s:property value="#status.count" />" aria-expanded="true" aria-controls="collapse1" class="collapsed">
			                              		<i class="fa fa-caret-down grn" style="font-size:24px"></i>
			                              	</a>
		                              </s:if>
                                </td>                   
                            </tr>
                            
                            
                            
                            </tbody>
                            </table>
                            </div>
                            </div>
                         <!-- second level tabel start -->
                            <div id="collapse<s:property value="#status.count" />" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<s:property value="#status.count" />">
                   				<div class="panel panel-default">
                               
                                   
                                  <div class="panel-body" style="padding:0px">
            						                    
                        		<div class="table-responsive">
				  			<table class="table table-bordered nomargin">
			                  	<s:if test="questionList !=null && questionList.size()>0">
				                  <thead>
				                    <tr>
				                      <th class="ft11" width="5%">S.No</th>
				                      <th class="ft11" width="63%">QUESTION TITLE</th>
				                      <th class="ft11" width="32%" >ACTION</th>
				                     </tr>
				                  </thead>
				                  <tbody>
				                  	
				                  	<s:iterator value="questionList" status="assStatus">
				                    <tr>
				                      <td >
				                      <s:property value="#assStatus.count" />
				                      </td>
				                      <td> <s:text name="question"/></td>
				                      <td><button onclick="return editQuestion(<s:property value="#assDetail.assignmentId"/>,<s:property value="questionId"/>,<s:property value="#courseTypeCheck"/>);" class="bttn">EDIT</button> 
				                      <input type="hidden" name="question" id="question--<s:property value="questionId"/>" value='<s:text name="question"></s:text>'>
				                      <input type="hidden" name="check" id="check--<s:property value="questionId"/>" value="<s:property value="check"/>" >
				                     <%--  <input type="hidden" name="choice" id="choice--<s:property value="questionId"/>" value="<s:property value="choice"/>"> --%>
				                      
				                      <input type="hidden" name="choice" id="choicesize--<s:property value="questionId"/>" value="<s:property value="choice.length"/>">
				                      
				                      	<input type="hidden" name="check" id="checkssize<s:property value="questionId"/>" value="<s:property value="check"/>">
				                      
				                      <input type="hidden" name="tf" id="truesfalseId--<s:property value="questionId"/>" value="<s:property value="tf"/>">
				                      <input type="hidden" name="courseId" value="<s:property value="courseId"/>">
				                      <input type="hidden" name="moduleId" value="<s:property value="moduleId"/>">
				                       <s:iterator value="check" status="checkStatus">
				                      	<input type="hidden" id="<s:property value="questionId"/>-checkQuestion--<s:property value="#checkStatus.count"/>" value="<s:property/>">
				                      </s:iterator>
				                      
				                      <s:iterator value="choice" status="choiceStatus">
				                      <input type="hidden" id="<s:property value="questionId"/>-choiceQuestion--<s:property value="#choiceStatus.count"/>" value="<s:property/>">
				                      </s:iterator>
				                      
				                      
				                      <!-- <button class="bttn">DEACTIVATE</button> -->
				                       <s:if test="status==1">
											<button	class="bttn" onclick="assignmentActiveDeactive(<s:property value="questionId"/>,0,'question',<s:property value="courseId"/>,<s:property value="moduleId"/>)">Activate</button>
										</s:if>
										<s:else>
											<button class="bttn" onclick="assignmentActiveDeactive(<s:property value="questionId"/>,1,'question',<s:property value="courseId"/>,<s:property value="moduleId"/>)">deactivate</button>
										</s:else> 
				                      </td>
				                     </tr>
				                     </s:iterator>
				                    </s:if>
				                    <s:else><tr><td>There is no question added</td></tr></s:else>
				                  </tbody>
				                </table><br>
                </div>
                         </div>
                       </div>
                          </div>  
                            <!-- end -->
                       <!-- forms -->
                       
                       
                      <s:if test="type!=1">
                       <div id="addQuestionBox<s:property value="assignmentId"/>" class="form-group tp10 questionForm" style="display:none;">
				                <div class="row">
				                		<form id="questionFormId<s:property value="assignmentId"/>">
				                			<s:hidden name="type" id="selectTypeId"></s:hidden>
				                			
				                			<s:hidden name="questionId" id="questionMainId"></s:hidden>
				                			
							                <div class="form-group col-sm-12" id="questionDetailEditorId">
							                   <textarea name="question" id="QuestionEditorId<s:property value="assignmentId"/>"></textarea>
							                </div>
							               
							               <s:if test="type==3">
							                  <div class="form-group">
							                        <label class="label_set col-sm-2" for="text">Option:</label>
							                        <div class="col-sm-7">
							                          <input type="text" id="questionId1" class="form-control mgl80" name="choice" placeholder="Enter option" required>
							                        </div>
							                        <s:if test="#courseTypeCheck ==1">
								                         <div class="checkbox col-sm-2">
								                          <label class="mlm80"><input id="checkboxId1" type="checkbox" name="check" value="1">Is Answer</label>
								                        </div>
							                        </s:if>
							                        <div class="col-sm-1">
							                            <!---<button type="button" class=" bttn close-btn1"><i class="fa fa-plus"></i></button>-->
							                        </div>
							                  </div>
							                   <div class="form-group" style="clear:both" >
							                    <label class="label_set col-sm-2" for="text">Option:</label>
							                    <div class="col-sm-7">
							                      <input type="text" id="questionId2" name="choice" class="form-control mgl80" placeholder="Enter option" required>
							                    </div>
							                     <div class="form-group checkbox col-sm-2">
							                     <s:if test="#courseTypeCheck ==1">
							                      	<label class="mlm80"><input id="checkboxId2" type="checkbox" name="check" value="2">Is Answer</label>
							                      </s:if>
							                      <button type="button" class=" bttn mgl20" onclick="appendChoiceDiv(<s:property value="assignmentId"/>,<s:property value="#courseTypeCheck"/>);"><i class="fa fa-plus"></i></button>
							                    </div>
							                    <div class="col-sm-1"></div>
							                   
							                  </div>
							                  
							                  </s:if>
							                  <div id="choiceOptionId-<s:property value="assignmentId"/>"></div>
							                    <s:if test="type==4">
							                    	<s:if test="#courseTypeCheck ==1">
							                    	<div class="form-group col-sm-2">
								                        <select class="form-control" name="tf" id="ddrOptionId">
								                            <option value="1">True</option>
								                            <option value="0">False</option>
								                        </select>
								                    </div>
								                    </s:if>
							                    </s:if>
							                  <div class="form-group col-sm-12">
							                    <button type="button" class="bttn" id="saveBtnId" onclick="return saveQuestion(<s:property value="assignmentId"/>);">SAVE</button>
							                    <button type="button" class="bttn" id="updateBtnId" onclick="return updateQuestion(<s:property value="assignmentId"/>);">UPDATE</button>
							                    <button type="submit" class="bttn"  onclick="return  cancelAddQuestion();">CANCEL</button>
							                   </div>
							               </form>
				                  </div>
			                </div>
                       </s:if>
                       <!-- forms end -->
                        
      
                            
                  </div>
                  				<script>
                  					$(document).ready(function() {
										applyEditor(<s:property value="assignmentId"/>);
									});
								</script>
                          </s:iterator>
                           
                    </div>
                    </s:if>
                    <s:else>
                    	There is no assignment
                    </s:else>
                  </div>
                </div>
              </div>