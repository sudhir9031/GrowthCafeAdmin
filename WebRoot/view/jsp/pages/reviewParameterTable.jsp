
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
 
 <div id="addcoursebx" style="display:none;">
        	
        	<h4>ADD NEW</h4>
        	
            	<div class="row">
                			<%-- <div class="form-group col-md-4">
                            <label>Organisation</label>
                        <select id="select1" class="form-control" style="width: 100%" data-placeholder="Basic Select2 Box">
                          <option value="">Select Organisation</option>
                          <option value="">Organisation 1</option>
                              <option value="">Organisation 2</option>
                              <option value="">Organisation 3</option>
                        </select>
                  </div> --%>
				  <div style="clear:both"></div>
				 
				  <div class="form-group col-md-4">
                            <label>Parameter</label>
                        <select id="selParameterId" onchange="return getReviewValue(this.value);" class="form-control" style="width: 100%" data-placeholder="Basic Select2 Box">
                          		<option value='addNew'>Add New</option>
                          	<s:if test="paramList !=null && paramList.size()>0">
                          		<s:iterator value="paramList">
                          		<option value='<s:property value="key" />'><s:property value="value" /> </option>
                          		</s:iterator>
                          	</s:if>
                        </select>
                  </div>
				   
				  <!--  <div class="padding_OR col-md-2">
				   OR
				   </div> -->
				  
                    <div class="form-group col-md-4" id="newParamDivId">
                            <label>New Parameter*</label>
                            <div class="form-group">
                           		 <input type="text" class="form-control" id="newParamTextFieldId">
                          </div>
                  </div>
				  
				  
				 
				  <div class="form-group col-md-4" id="selParamValueDivId" style="display:none;">
				   <div style="clear:both"></div>
                            <label>Grade </label>
                        <select id="selParamValueId" class="form-control" onchange="showHideSaveButton(this.value);" style="width: 100%" data-placeholder="Basic Select2 Box">
                          <option value="addNew">Add new</option>
                        </select>
                  </div>
				   
				   <!-- <div class="padding_OR col-md-2">
				   OR
				   </div> -->
				  
                    		<div class="form-group col-md-4"  id="newParamValueDivId">
                            <label>Grade*</label>
                            <div class="form-group">
                           		 <input type="text" class="form-control" id="newParamValueTextFieldId">
                          </div>
                  </div>
				   <div style="clear:both"></div>
                  			
                           <div class="form-group col-md-6" id="saveButtonId">
                                	 <button class="bttn" onClick="return saveReviewParameter();">SAVE</button>
                                	  &nbsp;&nbsp; <button class="bttn" onclick="return cancelReview();">CANCEL</button>
                                </div> 
                  		</div>	
                    
           
            
            
            
        </div>
 
 
 
 
<table class="table table-bordered nomargin">
                  <thead>
                    <tr>
                      <th class="text-center"  bgcolor="#e1e1e1" width="8%">
                       S. No
                      </th>
                     <!--  <th width="40%"  bgcolor="#e1e1e1">Organization</th>        -->              
					  <th width="41%"  bgcolor="#e1e1e1" class="text-center">Parameter</th>  
					  <th width="31%"  bgcolor="#e1e1e1" class="text-center">Grade</th>  					  
                      <!-- <th width="10%" class="text-center">Edit</th> -->
                      <th width="20%"  bgcolor="#e1e1e1" class="text-center">Action</th>
                    </tr>
                  </thead>
                  <tbody>
                  <s:if test="reviewList !=null && reviewList.size()>0">
                  	<s:iterator value="reviewList" status="status">
                    <tr>
                      <td bgcolor="#e1e1e1" class="text-center">
                       <s:property value="%{#status.count}"/>
                      </td>
                      <%-- <td bgcolor="#e1e1e1" class="text-center"><s:property value="organisationName"/></td>     --%>
					  <td bgcolor="#e1e1e1" class="text-center"><s:property value="param"/></td>    					  
					  <td bgcolor="#e1e1e1" class="text-center"><s:property value="valueLabel"/></td>    					  
                      <!-- <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke ">edit</button></td> -->
						<td bgcolor="#e1e1e1" class="text-center"><button class="bttn" onclick="deleteParameter(<s:property value="paramId"/>,<s:property value="valueId"/>)">DELETE</button>
						</td>
                    </tr>
                    </s:iterator>
                   </s:if>
                    
                  </tbody>
                </table>