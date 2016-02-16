 <%@ taglib prefix="s" uri="/struts-tags"%>
 <s:if test="hasActionMessages()">
	<div id="actionMessageId" class="overlay">
		<div  class="vinDivClass signpop"><p>
			<s:actionmessage />
		</p>
			<button type='button' class='loginbutton' style='width: 50px; color:#000;' onclick="hideMessage('actionMessageId');">Ok</button>
		</div>
	</div>
</s:if>
 
 
                       <%--  <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" class="text-center">
                               S.No
                              </th>
                              <th width="30%" bgcolor="#e1e1e1" class="text-center">Student name</th>
                              <th width="10%" bgcolor="#e1e1e1" class="text-center">Email</th>
                              <th width="18%" bgcolor="#e1e1e1" class="text-center">Department</th> 
                              <th width="15%" bgcolor="#e1e1e1" class="text-center">Group</th>                     
                              <th width="12%" bgcolor="#e1e1e1" class="text-center">Action</th>
                            </tr>
                          </thead>
                          <tbody>
                          <s:if test="studentsList !=null && studentsList.size()>0">
                  			<s:iterator value="studentsList" status="status">
                            <tr>
                              <td bgcolor="#e1e1e1" class="text-center">
                              <s:property value="%{#status.count}"/>
                              </td>
                              <td bgcolor="#e1e1e1" class="text-center"><s:property value="fname"/> &nbsp;<s:property value="lname"/></td>
                              <td bgcolor="#e1e1e1" class="text-center"><s:property value="email"/></td>
                              <td bgcolor="#e1e1e1" class="text-center"><s:property value="depName"/> </td>
                              <td bgcolor="#e1e1e1" class="text-center"><s:property value="groupName"/></td>
                                              
                              <td bgcolor="#e1e1e1" class="text-center">
                              <button class="bttn" onclick="changeUserLoginStatus(<s:property value="userId"/>,1)">DEACTIVATE</button>
                              </td>
                              <s:if test="status==1">
	                      		<td class="text-center"><button class="bttn" onclick="changeUserLoginStatus(<s:property value="userId"/>,0)">deactivate</button></td>
		                      	</s:if>
		                      	<s:else>
		                      		<td class="text-center"><button class="bttn" onclick="changeUserLoginStatus(<s:property value="userId"/>,1)">Activate</button></td>
		                      	</s:else>
                                                   
                            </tr>
                            </s:iterator>
                            </s:if>
                            
                           </tbody>
                        </table>
                        
                   
                
                
                 <!-- detail table -->
                 <s:iterator value="teacherList" status="status">
                      <div class="modal fade" id="myModal<s:property value="%{#status.count}"/>" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header">
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
							        <h4 class="modal-title" id="myModalLabel">Teacher Detail</h4>
							      </div>
							    
								      <div class="modal-body">
								      <table class="table table-bordered table-danger nomargin">
							                  <thead>
							                    <tr>
							                      <th class="text-center" width="8%">
							                       S. No.
							                      </th>
							                      <th width="25%" class="text-center">Organisation Name</th>
							                      <th width="22%" class="text-center">Department Name</th>                     
							                      <th width="22%" class="text-center">Group Name</th>
							                      <th width="23%" class="text-center">Course Name</th>
							                    </tr>
							                  </thead>
							                  <tbody>
							                  <s:iterator value="detailList" var="var" status="test">
							                  	<tr>
							                  	<td> <s:property value="%{#test.count}"/></td>
							                  	<td><s:property value="orgName"/></td>
							                  	<td><s:property value="depName"/></td>
							                  	<td><s:property value="groupName"/></td>
							                  	<td><s:property value="courseName"/></td>
							                  	</tr>
							                  
							                  </s:iterator>
							                  
							                  </tbody>
							                  </table>
								      </div>
							      
							      
							      <div class="modal-footer">
							        <button  class="btn btn-danger btn-quirk" data-dismiss="modal">Close</button>
							      </div>
							    </div>
							  </div>
							</div>
                		</s:iterator>
                    <!-- detail end -->  
                    
                     --%>
                    
   <div class="panel" id="ddd">
          <div class="panel-group" id="accordion">
              <div id="course-panel">     
                <div class="panel">
                  <div class="panel-heading">
                    <div class="panel-body">
                      <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" >
                               S.No
                              </th>
                              <th width="40%" bgcolor="#e1e1e1">Student name</th>
                              <th width="15%" bgcolor="#e1e1e1" >Email</th>
                              <th width="10%" bgcolor="#e1e1e1" >Department</th> 
                              <th width="10%" bgcolor="#e1e1e1" >Course</th>                    
                              <th width="20%" bgcolor="#e1e1e1" >Action</th>
                            </tr>
                          </thead>
                          <tbody>
                           <s:if test="studentsList !=null && studentsList.size()>0">
                  			<s:iterator value="studentsList" status="status">
                            <tr>
                              <td bgcolor="#e1e1e1" >
                               		<s:property value="%{#status.count}"/>
                              </td>
                              <td bgcolor="#e1e1e1"><s:property value="fname"/> &nbsp;<s:property value="lname"/></td>
                               <td bgcolor="#e1e1e1"><s:property value="email"/></td>
                               <td bgcolor="#e1e1e1" ><button class="bttn" type="button" data-toggle="modal" data-target="#departmentmodal<s:property value="userId"/>"><s:property value="departmentList.size()"/></button></td>
                              <td bgcolor="#e1e1e1" ><button class="bttn" type="button" data-toggle="modal" data-target="#coursemodal<s:property value="userId"/>"><s:property value="containerList.size()"/></button></td>
                              <td class="text-center"><button class="bttn" type="button" onclick="return editStudent(<s:property value="userId"/>);">EDIT</button>
                              <input type="text" value="${fname}" id="fnameId<s:property value="userId"/>" style="display:none;">
                              <input type="text" value="${lname}" <s:property value="userId"/> id="lnameId<s:property value="userId"/>" style="display:none;">
                              <input type="text" value="${email}" id="emailId<s:property value="userId"/>" style="display:none;">
                              <input type="text" value="${password}" id="passwordId<s:property value="userId"/>" style="display:none;">
                              <input type="text" value="${title}" id="titleId<s:property value="userId"/>" style="display:none;">
	                              <s:if test="status==0">
		                      		<button class="bttn" onclick="changeUserLoginStatus(<s:property value="userId"/>,1)">deactivate</button>
			                      	</s:if>
			                      	<s:else>
			                      		<button class="bttn" onclick="changeUserLoginStatus(<s:property value="userId"/>,0)">Activate</button>
			                      	</s:else>                      
                                 </td>                  
                            </tr>
                            </s:iterator>
                            </s:if>
                           </tbody>
                        </table>
                        
                     </div>
                     
                               <!-- Modal for course section -->
                    <s:if test="studentsList !=null && studentsList.size()>0">
                		<s:iterator value="studentsList" status="status">         
                               
                        <div id="coursemodal<s:property value="userId"/>" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                              <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                   <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Student Details</h4>
                              </div>
                              <div class="modal-body modal_scroll">
                                 <div class="row">
                                 		<form action="mapContainerToUser" method="post"> 
                                 			<s:hidden name="userId"/>
                                 			<s:hidden name="departmentId"/>
                                          <div class="form-group col-sm-6">
                                                  <select id="groupSelId" name="groupId" class="form-control selectpicker" data-live-search="true" title="Select Course ...">
                                                    <s:if test="availableContainer !=null && availableContainer.size()>0">
					                              	  <s:iterator value="availableContainer">
					                                  	<option value="<s:property value="key"/>"><s:property value="startDate" />&nbsp;<s:property value="value" /> </option>
					                                  </s:iterator>
					                                  </s:if>
												</select>
                                          </div>
                                          <div class="form-group col-sm-3">
                                           		<button class="bttn mt5" type="submit">Map to new Course</button>
                                           </div>
                                        </form>     
                                    	 <div class="form-group col-sm-3">
                                             <div class="dropdown pull-right">
                                                <button class="bttn dropdown-toggle mt5" type="button" data-toggle="dropdown">Filter Course
                                                <span class="caret"></span></button>
                                                <ul class="dropdown-menu" id="dropbutton">
                                                  <li>All</li>
                                                  <li>In Progress</li>
                                                  <li>Not Started</li>
                                                  <li>Completed</li>
                                                </ul>
                                            </div>
                                        </div>
                                    
                                </div>  
                               
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th  bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="70%" bgcolor="#e1e1e1">Course Name</th>
                                                  <th width="10%" bgcolor="#e1e1e1">Session</th>
                                                  <th width="15%" bgcolor="#e1e1e1">Status</th>
                                                  
                                                </tr>
                                              </thead>
                                              <tbody>
                                              <s:if test="containerList !=null && containerList.size()>0">
                                              <s:iterator value="containerList" status="containerStatus">
                                                <tr>
                                                  <td  bgcolor="#e1e1e1"><s:property value="#containerStatus.count" /> </td>
                                                  <td bgcolor="#e1e1e1"><s:property value="groupName" /></td>
                                                  <td bgcolor="#e1e1e1"><s:property value="startDate" /></td>
                                                  <td bgcolor="#e1e1e1">In Progress</td> 
                                                </tr>
                                                 </s:iterator>
                                                </s:if>
                                                <tr>
                                              </tbody>
                                            </table>
                                          </div>  
                                              
                              </div>
                              <div class="modal-footer">
                              	<!-- <button type="button" class="bttn">PRINT</button> -->
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       
                        <!-----modal ends------->
                         <!-- Modal for Department Section -->
                        <div id="departmentmodal<s:property value="userId"/>" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                              <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                   <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Student Details</h4>
                              </div>
                              <div class="modal-body modal_scroll">
                                 <div class="row">
                                 	<form action="mapStudToNewDep" method="post">
                                 		<s:hidden name="userId"/>
                                    	 <div class="form-group col-sm-3">
                                                   <select id="select1" class="form-control" name="departmentId">
                                                 	    <option value="0">Select Department</option>
                                                        <s:if test="availableDep !=null && availableDep.size()>0">
					                              	  <s:iterator value="availableDep">
					                                  	<option value="<s:property value="key"/>"><s:property value="value" /> </option>
					                                  </s:iterator>
					                                  </s:if>
                                                </select>
                                          </div>
                                           <div class="form-group col-sm-3">
                                           		<button class="bttn mt5" type="submit">Map to new Department</button>
                                           </div>
                                           </form>      
                                    	 <div class="form-group col-sm-6">
                                             <div class="dropdown pull-right">
                                                <button class="bttn dropdown-toggle mt5" type="button" data-toggle="dropdown">filter department
                                                <span class="caret"></span></button>
                                                <ul class="dropdown-menu" id="dropbutton">
                                                  <li>All</li>
                                                  <li>Current Department</li>
                                                  <li>Previous Department</li>
                                                </ul>
                                            </div>
                                        </div>
                                </div>  
                               
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th  bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="55%" bgcolor="#e1e1e1">Department Name</th>
                                                  <th width="10%" bgcolor="#e1e1e1">Join Date</th>
                                                  <th width="10%" bgcolor="#e1e1e1">End Date</th>
                                                  <th width="20%" bgcolor="#e1e1e1">Status</th>
                                                  
                                                </tr>
                                              </thead>
                                              <tbody>
                                              <s:if test="departmentList !=null && departmentList.size()>0">
                                              <s:iterator value="departmentList" status="depStatus">
                                                <tr>
                                                  <td  bgcolor="#e1e1e1"><s:property value="#depStatus.count" /></td>
                                                  <td bgcolor="#e1e1e1"><s:property value="departmentName" /></td>
                                                  <td bgcolor="#e1e1e1"><s:property value="startDate" /></td>
                                                  <s:if test="endDate !=null">
                                                  <td bgcolor="#e1e1e1"><s:property value="endDate" /></td> 
                                                  <td bgcolor="#e1e1e1">Previous Department</td>
                                                  </s:if>
                                                  <s:else>
                                                  	 <td bgcolor="#e1e1e1" class="center">-</td> 
                                                  <td bgcolor="#e1e1e1">Current Department</td>
                                                  </s:else> 
                                                </tr>
                                                </s:iterator>
                                                </s:if>
                                              </tbody>
                                            </table>
                                          </div>  
                                              
                              </div>
                              <div class="modal-footer">
                              	<!-- <button type="button" class="bttn">PRINT</button> -->
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       </s:iterator>
                       </s:if>
                        <!-----modal ends------->
                                                  
                    </div>
                  </div>
                  
                </div>
              </div>
          </div>
    </div>
    <!-- contentpanel -->