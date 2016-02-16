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
 <s:if test="departmentsList !=null && departmentsList.size()>0">
<div class="table-responsive">
	<table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" class="text-center">
                               S.No
                              </th>
                              <th width="60%" bgcolor="#e1e1e1" class="text-center">department</th> 
                              <th width="10%" bgcolor="#e1e1e1" class="text-center">course</th>                     
                              <th width="25%" bgcolor="#e1e1e1" class="text-center">Action</th>
                            </tr>
                          </thead>
                          <tbody>
                  			<s:iterator value="departmentsList" status="status">
                            <tr>
                              <td bgcolor="#e1e1e1" class="text-center">
                                 <s:property value="%{#status.count}"/>
                              </td>
                              <td bgcolor="#e1e1e1" class="text-center"><s:property value="departmentName"/></td>
                              <td bgcolor="#e1e1e1" class="text-center">
                              <s:if test="groupList !=null && groupList.size()>0">
                              <button class="bttn" type="button" data-toggle="modal" data-target="#departmentmodal<s:property value="departmentId"/>">
                              <s:property value="groupList.size()"/></button>
                              </s:if><s:else>
                              		<button class="bttn" type="button" data-toggle="modal" data-target="#departmentmodal">0</button>
                              </s:else>
                              
                              </td>                      
                             
                              <td bgcolor="#e1e1e1" class="text-center"> 
                              <%-- <button class="bttn" onclick="editDepartment('<s:property value="departmentName"/>','<s:property value="description"/>',<s:property value="departmentId"/>);">EDIT</button> 
                               --%>
                               <button class="bttn" onclick="editDepartment(<s:property value="departmentId"/>);">EDIT</button> 
                              
                              <input type="hidden" class="departmentNameClasss-<s:property value="departmentId"/>" name="departmentName" value="<s:property value="departmentName"/>">
                              <input type="hidden" class="descriptionNameClasss-<s:property value="departmentId"/>" name="description" value="<s:property value="description"/>">
                              
                               <s:if test="status==1">
						
								<button class="bttn" onclick="changeStatus(<s:property value="departmentId"/>,0,'dep')">ACTIVATE</button>
								</s:if>
								<s:else>
								<button class="bttn" onclick="changeStatus(<s:property value="departmentId"/>,1,'dep')">DEACTIVATE</button>
								</s:else> 
		                              
                               </td>
                                                   
                            </tr>
                             <!-- <tr>
                              <td bgcolor="#e1e1e1" class="text-center">
                               2
                              </td>
                              <td bgcolor="#e1e1e1">Marketing</td>
                              <td bgcolor="#e1e1e1" class="text-center"><button class="bttn" type="button">0</button></td>                      
                              <td bgcolor="#e1e1e1" class="text-center"> <button class="bttn" type="submit">EDIT</button> <button class="bttn" type="submit">DEACTIVATE</button> </td>
                                                   
                            </tr> -->
                            </s:iterator>
                           </tbody>
                     </table>

</div>
 </s:if>
 <s:else>
	There is no data
 </s:else>



   <!-- Modal -->
   <s:if test="departmentsList !=null && departmentsList.size()>0">
   		<s:iterator value="departmentsList">
                        <div id="departmentmodal<s:property value="departmentId"/>" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                               <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                  <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Courses</h4>
                              </div>
                              <div class="modal-body modal_scroll">
                               
                               		<div class="row">
                                        <!--<div class="form-group col-sm-4">
                                        	<select class="form-control">
                                            	<option value="0">All</option>
                                                <option selected value="1"></option>
                                                <option value="2"></option>
                                            </select>
                                        </div>-->
                                    	<div class="form-group col-sm-12">
                                            <div class="dropdown pull-right">
                                                <button class="bttn dropdown-toggle" type="button" data-toggle="dropdown">Filter Course
                                                <span class="caret"></span></button>
                                                <ul class="dropdown-menu" id="dropbutton">
                                                  <li>All</li>		
                                                  <li>In Progress</li>
                                                  <li>Completed</li>
                                                </ul>
                                            </div>
                                        </div>
                                  </div>
                               
                               <s:if test="groupList !=null && groupList.size()>0">
                               
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="65%" bgcolor="#e1e1e1">Course</th>
                                                  <th width="15%" bgcolor="#e1e1e1">Session Date</th>
                                                  <th width="15%" bgcolor="#e1e1e1">Status</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                              <s:iterator value="groupList" status="courseStatus">
                                                <tr>
                                                  <td  bgcolor="#e1e1e1">
                                                   		<s:property value="#courseStatus.count"/>
                                                  </td>
                                                  <td bgcolor="#e1e1e1"><s:property value="groupName"/></td>
                                                  <td bgcolor="#e1e1e1"><s:property value="startDate"/></td> 
                                                  <td bgcolor="#e1e1e1">
                                                  <s:if test="status==0">
                                                  	In progress
                                                  	</s:if>
                                                  	<s:elseif test="status==1">
                                                  		Completed
                                                  	</s:elseif>
                                                  	<s:elseif test="status==2">
                                                  		Not Started
                                                  	</s:elseif>
                                                  </td> 
                                                </tr>
                                                </s:iterator>
                                             </tbody>
                                            </table>
                                          </div>   
                                         </s:if>
                                         <s:else>
                                         	There is no courses
                                         </s:else>     
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn">Print</button>
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                </s:iterator>
   </s:if>                    
                        <!-----modal ends------->
 