<%@ taglib prefix="s" uri="/struts-tags"%>
<script>
function addNewResource(id){
	$("#"+id).show();
}

</script>

<s:if test="hasActionMessages()">
	<div id="actionMessageId" class="overlay">
		<div  class="vinDivClass signpop"><p>
			<s:actionmessage />
		</p>
			<button type='button' class='loginbutton' style='width: 50px; color:#000;' onclick="hideMessage('actionMessageId');">Ok</button>
		</div>
	</div>
</s:if>
<div class="module" id="module1" style="display:none;">
                    	<form id="moduleFormId">
                        	<div class="row">
                        			<input type="text" class="form-control" name="moduleId" id="updateId" style="display:none;">
                            	<div class="form-group col-md-4">
                                	<label>Title <span class="strike_color">*</span></label>
                                    <input type="text" class="form-control" name="moduleName" id="moduleNameId">
                                </div>
                                <div class="form-group col-md-4">
                                	<label>Tags  <span class="strike_color">*</span></label>
                                    <input type="text" class="form-control" name="metadata" id="metadataId">
                                </div>
                                
                                <div class="form-group col-md-12" id="resourceAddButtonId">
                                	<label>Add Resources <span class="strike_color">*</span></label>
                                    <button type="button"   class="btn btn-default btn-sm" data-toggle="modal" data-target="#myModal"><i class="fa fa-plus"></i></button>
                                 </div>                              
                                
                                <div class="form-group col-md-12">
                                 	<label>Module Discription <span class="strike_color">*</span></label>
                                    <textarea class="form-control" cols="8" name="description" id="descriptionId"></textarea>
                                 </div>
                                <div class="form-group col-md-6" id="saveModuleButtonId">
                                	 <button class="btn btn-danger btn-quirk" onClick="return saveModule();">Save</button>
                                	  &nbsp;&nbsp;<button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelModule();">CANCEL</button>
                                </div> 
                                <div class="form-group col-md-6" id="updateModuleButtonId">
                                	 <button class="btn btn-danger btn-quirk" onClick="return updateModule();">Update</button>
                                	  &nbsp;&nbsp;<button class="btn btn-danger btn-quirk  btn-stroke" onclick="return cancelModule();">CANCEL</button>
                                </div> 
                                 
                            </div>
                            
                            <!-- Resource form start -->
							                            
							                            
							  <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        <h4 class="modal-title" id="myModalLabel">Add Resource</h4>
							      </div>
							      <div class="modal-body">
							            		<div class="form-group">
							                    	<label>Resources Title <span class="strike_color">*</span></label>
							                        <input type="text" class="form-control" name="resourceTitle" id="resourceTitleId">
							                    </div>
							                     <div class="form-group col-sm-6 left_padding0">
							                    	<label>Duration(Day/Days) <span class="strike_color">*</span></label>
							                        <input type="text"  class="form-control" name="resDuration" id="resDurationId">
							                    </div>
							                    <div class="form-group col-sm-6 right_padding0">
							                    	<label>Author <span class="strike_color">*</span></label>
							                        <input type="text"  class="form-control" name="resAuthor">
							                    </div>
							                     <div class="form-group">
							                    	<label>Tags<span class="strike_color">*</span></label>
							                        <input type="text"  class="form-control" name="resMetadata">
							                    </div>
							                    <div class="form-group">
							                    	<label>Resources Discription <span class="strike_color">*</span></label>
							                        <textarea class="form-control" cols="4" name="resourceDesc" id="resourceDescId"></textarea>
							                    </div>
							                    
							                    <div class="form-group">
							                    	<label>Add URL <span class="strike_color">*</span></label>
							                        <input type="text" class="form-control" name="resourceUrl" id="resourceUrlId">
							                    </div>
							                    <br/>
							                    <div class="form-group" style="margin-top: 56px;">
							                    <button  onclick="return hideResourceForm();" class="btn btn-danger btn-quirk">Save</button>
							                    </div>
							      </div>
							      
							    </div>
							  </div>
							</div>
                            
                              <!-- Resource form end -->
                            
                           
                        </form>
                        
                  </div>



<div class="table-responsive">
<table class="table table-bordered table-danger nomargin">
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                         S No.
                      </th>
                      <th width="45%">Module</th>          
                      <th width="15%" class="text-center">Resource</th>          
                      <th width="16%" class="text-center">Edit</th>
                      <th width="16%" class="text-center">Deactivate</th>
                    </tr>
                  </thead>
                  <tbody>
                  <s:if test="moduleList !=null && moduleList.size()>0">
                  <s:iterator value="moduleList" status="status">
                    <tr>
                      <td class="text-center"> <s:property value="%{#status.count}" /> </td>
                      <td><s:property value="moduleName"/> </td>   
                      <td><button type="button" class="btn btn-danger btn-lg" data-toggle="modal" data-target="#myModal<s:property value="%{#status.count}" />"><s:property value="count" /> </button>
                      		<div class="modal fade" id="myModal<s:property value="%{#status.count}" />" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        <h4 class="modal-title" id="myModalLabel">Resources</h4>
							      </div>
							      <div class="modal-body">
							        <!-- resource table start -->
							        
							        		<table class="table table-bordered table-danger nomargin">
							                  <thead>
							                    <tr>
							                      <th class="text-center" width="8%">
							                       S. No
							                      </th>
							                      <th width="50%">Resource</th> 
							                      <th width="10%">Duration</th>                    
							                      <th width="16%" class="text-center">Edit</th>
							                      <th width="16%" class="text-center">Deactivate</th>
							                    </tr>
							                  </thead>
							                  <tbody>
							                  <s:if test="resourceList !=null && resourceList.size()>0">
							                  <s:iterator value="resourceList" status="resStatus">
							                  		<tr>
								                      <td class="text-center">
								                       <s:property value="%{#resStatus.count}"/>
								                      </td>
								                      <td><s:property value="resourceTitle"/></td>  
								                       <td><s:property value="resDuration"/></td>                      
								                      <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke" data-toggle="modal" data-target="#editModal" onclick="return editResource(
								                      '<s:property value="resourceTitle"/>','<s:property value="resourceUrl"/>',<s:property value="resDuration"/>,'<s:property value="resAuthor"/>','<s:property value="resourceDesc"/>',
								                      '<s:property value="resMetadata"/>',<s:property value="resourceId"/>
								                      );">edit</button></td>
								                      <s:if test="status==1">
														<td class="text-center"><button
																class="btn btn-danger btn-quirk" onclick="courseActiveDeactive(<s:property value="resourceId"/>,0,'resource')">Activate</button>
														</td>
														</s:if>
														<s:else>
															<td class="text-center"><button class="btn btn-danger btn-quirk btn-stroke" onclick="courseActiveDeactive(<s:property value="resourceId"/>,1,'resource')">deactivate</button></td>
														</s:else> 
								                      
							                    </tr>
							                  	</s:iterator>
							                  </s:if>
							                  </tbody>
							                </table>
							        
							        <!-- resource table end -->
							      </div>
								      <div class="modal-body" style="display: none;" id="resourceFormDivId<s:property value="%{#status.count}"/>">
								      		
								        	<form id="resourceFormId<s:property value="%{#status.count}"/>">
								        			<input name="moduleId" type="text" value="<s:property value="moduleId"/>" style="display: none;">
								            		<div class="form-group">
								                    	<label>Resource Title <span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resourceTitle" id="tableResourceTitleId<s:property value="%{#status.count}"/>">
								                    </div>
								                    <div class="form-group col-sm-6 left_padding0">
								                    	<label>Duration(Day/Days) <span class="strike_color">*</span></label>
								                        <input type="text"  class="form-control" name="resDuration" id="tableResDurationId<s:property value="%{#status.count}"/>">
								                    </div>
								                    <div class="form-group col-sm-6 right_padding0">
								                    	<label>Author <span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resAuthor" id="tableResAuthorId<s:property value="%{#status.count}"/>">
								                    </div>
								                    
								                    <div class="form-group">
								                    	<label>Tags<span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resMetadata" id="tableResMetadataId<s:property value="%{#status.count}"/>">
								                    </div>
								                    								                    
								                    <div class="form-group">
								                    	<label>Resources Discription <span class="strike_color">*</span></label>
								                        <textarea class="form-control" cols="4" name="resourceDesc" id="tableResourceDescId<s:property value="%{#status.count}"/>"></textarea>
								                    </div>
								                    
								                    <div class="form-group">
								                    	<label>Add URL <span class="strike_color">*</span></label>
								                        <input type="text" class="form-control" name="resourceUrl" id="tableResourceUrlId<s:property value="%{#status.count}"/>">
								                    </div>
								                    <button  onclick="return saveResource('resourceFormId<s:property value="%{#status.count}"/>',<s:property value="%{#status.count}"/>);" class="btn btn-danger btn-quirk">Save</button>
								            </form>
								      </div>
							      
							      
							      <div class="modal-footer">
							        <button  class="btn btn-danger btn-quirk" data-dismiss="modal">Close</button>
							        <button  class="btn btn-danger btn-quirk" onclick="return addNewResource('resourceFormDivId<s:property value="%{#status.count}"/>');">Add</button>
							      </div>
							    </div>
							  </div>
							</div>
                      
                      
                      </td>  
                                      
                      <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke " onclick="editModule('<s:property value="moduleName"/>','<s:property value="description"/>','<s:property value="metadata"/>',<s:property value="moduleId"/>);">edit</button></td>
                       <s:if test="status==1">
						<td class="text-center"><button
								class="btn btn-danger btn-quirk" onclick="courseActiveDeactive(<s:property value="moduleId"/>,0,'module')">Activate</button>
						</td>
						</s:if>
						<s:else>
							<td class="text-center"><button class="btn btn-danger btn-quirk btn-stroke" onclick="courseActiveDeactive(<s:property value="moduleId"/>,1,'module')">deactivate</button></td>
						</s:else>                 
                    </tr>
                    </s:iterator>
                   </s:if>
                   
                    
                  </tbody>
                </table>
                </div><!-- table-responsive -->