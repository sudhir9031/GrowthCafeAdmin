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
	
<s:if test="hasActionErrors()">
	<div id="actionMessageId" class="overlay">
		<div  class="vinDivClass signpop"><p>
			<s:actionerror />
		</p>
				<s:textfield id="mapUserId"  style="display:none;" name="mapTeacherId"/>
			<button type='button' class='loginbutton' style='width: 50px; color:#000;' onclick="mapTeaherNewOrg();">Yes</button>
			<button type='button' class='loginbutton' style='width: 50px; color:#000;' onclick="hideMessage('actionMessageId');">No</button>
		</div>
		</div>
	</s:if>
  <%-- <table class="table table-bordered table-danger nomargin">
  
  
  
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                       S. No
                      </th>
                      <th width="30%">Teacher Name</th>
                      <th width="15%">Email</th>  
                       <th width="15%">Courses</th>                   
                      <th width="16%" class="text-center">Edit</th>
                      <th width="16%" class="text-center">Deactivate</th>
                    </tr>
                  </thead>
                  <tbody>
                  	<s:if test="teacherList !=null && teacherList.size()>0">
                  	<s:iterator value="teacherList" status="status">
                    <tr>
                      <td class="text-center">
                       <s:property value="%{#status.count}"/>
                      </td>
                      <td><s:property value="fname"/> &nbsp;<s:property value="lname"/>  </td>
                      <td><s:property value="email"/>  </td>
                      <s:if test="count>0">
                      <td><button type="button" class="btn btn-danger btn-lg" data-toggle="modal" data-target="#myModal<s:property value="%{#status.count}" />"><s:property value="count"/> </button> </td>                    
                      </s:if>
                      <s:else>
                      	 <td><button type="button" class="btn btn-danger btn-lg" data-toggle="modal"><s:property value="count"/> </button> </td>
                      </s:else>
                      <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke" onclick="editTeacher('<s:property value="title"/>','<s:property value="fname"/>',
                      '<s:property value="lname"/>','<s:property value="contactNo"/>','<s:property value="address"/>','<s:property value="password"/>',<s:property value="UserId"/>);">edit</button></td>
                      <s:if test="status==1">
                      		<td class="text-center"><button class="btn btn-danger btn-quirk btn-stroke" onclick="changeTeacherStatus(<s:property value="userId"/>,0)">deactivate</button></td>
                      	</s:if>
                      	<s:else>
                      		<td class="text-center"><button class="btn btn-danger btn-quirk" onclick="changeTeacherStatus(<s:property value="userId"/>,1)">Activate</button></td>
                      	</s:else>
                      
                    </tr>
                    
                    </s:iterator>
                    </s:if>
                  </tbody>
                </table> --%>
                <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" class="text-center">
                               S.No
                              </th>
                              <th width="45%" bgcolor="#e1e1e1">Coach name</th>
                              <th width="15%" bgcolor="#e1e1e1" class="text-center">Email</th> 
                              <th width="10%" bgcolor="#e1e1e1" class="text-center">course</th>                     
                              <th width="25%" bgcolor="#e1e1e1" class="text-center">Action</th>
                            </tr>
                          </thead>
                          <tbody>
                          <s:if test="teacherList !=null && teacherList.size()>0">
	                  			<s:iterator value="teacherList" status="status">
		                            <tr>
		                              <td bgcolor="#e1e1e1" class="text-center">
		                                  <s:property value="%{#status.count}"/>
		                              </td>
		                              <td bgcolor="#e1e1e1"><s:property value="fname"/> &nbsp;<s:property value="lname"/></td>
		                               <td bgcolor="#e1e1e1"><s:property value="email"/></td>
		                              <td bgcolor="#e1e1e1" class="text-center">
		                               <s:if test="count>0">
		                               <button class="bttn" type="button" data-toggle="modal" data-target="#coachDetail<s:property value="%{#status.count}" />"><s:property value="count"/></button>
		                               </s:if>
		                               <s:else>
		                                <button class="bttn" type="button" data-toggle="modal" data-target="#coachDetail"><s:property value="detailList.size()"/></button>
		                      			</s:else>
		                              
		                              </td>                      
		                              <td bgcolor="#e1e1e1" class="text-center">
		                                 
		                                <button class="bttn" onclick="editTeacher(<s:property value="UserId"/>);">EDIT</button> 
		                              	
		                              	<input type="hidden" name="title" id="title--<s:property value="UserId"/>" value="<s:property value="title"/>">
		                               	<input type="hidden" name="fname" id="fname--<s:property value="UserId"/>" value="<s:property value="fname"/>">
		                                <input type="hidden" name="lname" id="lname--<s:property value="UserId"/>" value="<s:property value="lname"/>">
		                                <input type="hidden" name="contactNo" id="contactNo--<s:property value="UserId"/>" value="<s:property value="contactNo"/>">
		                                <input type="hidden" name="address" id="address--<s:property value="UserId"/>" value="<s:property value="address"/>">
		                              	<input type="hidden" name="password" id="password--<s:property value="UserId"/>" value="<s:property value="password"/>">
		                              
		                              
		                              
		                               <s:if test="status==1">
		                      		 <button class="bttn" onclick="changeTeacherStatus(<s:property value="userId"/>,0)">DEACTIVATE</button> 
		                      	</s:if>
		                      	<s:else>
		                      		 <button class="bttn" onclick="changeTeacherStatus(<s:property value="userId"/>,1)">ACTIVATE</button> 
		                      	
		                      	</s:else>
		                               </td>                    
		                            </tr>
	                            </s:iterator>
                            </s:if>
                            
                           </tbody>
                        </table>
                
                
                 <!-- detail table -->
                 
                 
                 
                 
                 
                 <s:iterator value="teacherList" status="status">
                 <%-- <div id="departmentmodal<s:property value="%{#status.count}"/>" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog">
                            Modal content
                            <div class="modal-content">
                              <div class="modal-header">
                              <button type="button" class="close" data-dismiss="modal">&times;</button>
                                <h4 class="modal-title">Coach Details</h4>
                              </div>
                              <div class="modal-body">
                                <div class="table-responsive">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th class="text-center" bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="25%" bgcolor="#e1e1e1" class="text-center">Department</th>
                                                  <th width="25%" bgcolor="#e1e1e1" class="text-center">Group</th>
                                                  <th width="45%" bgcolor="#e1e1e1" class="text-center">Course</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                                <s:iterator value="detailList" var="var" status="test">
                                                <tr>
                                                  <td class="text-center" bgcolor="#e1e1e1"> <s:property value="%{#test.count}"/></td>
                                                  <td bgcolor="#e1e1e1" class="text-center"><s:property value="depName"/></td>  
                                                  <td bgcolor="#e1e1e1" class="text-center"><s:property value="groupName"/></td> 
                                                  <td bgcolor="#e1e1e1" class="text-center"><s:property value="courseName"/></td> 
                                                </tr>
                                                </s:iterator>
                                               
                                              </tbody>
                                            </table>
                                          </div>        
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div> --%>
                        
                        
                        
                 		<div id="coachDetail<s:property value="%{#status.count}"/>" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                               <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                  <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Coach Details</h4>
                              </div>
                              <div class="modal-body modal_scroll">
                                 <form>
                               		<div class="row">
                                        <div class="form-group col-sm-4">
                                        	<select class="form-control" onchange="return filterData(this.value,<s:property value="%{#status.count}"/>);">
                                            	<option value="3">All</option>
                                                <option value="0">In Progress</option>
                                                <option value="1">Completed</option>
                                                <option value="2">Not Started</option>
                                            </select>
                                        </div>
                                    </div>
                               </form> 
                               
                                <div class="table-responsive">
                                		<s:if test="detailList !=null && detailList.size()>0">
                                            <table class="table table-bordered nomargin">
                                              <thead>
                                                <tr>
                                                  <th  bgcolor="#e1e1e1" width="5%">
                                                   S.No
                                                  </th>
                                                  <th width="45%" bgcolor="#e1e1e1">Course Session</th>
                                                  <!-- <th width="25%" bgcolor="#e1e1e1" >Department</th> -->
                                                  <th width="25%" bgcolor="#e1e1e1" >Session Date</th>
                                                  <th width="25%" bgcolor="#e1e1e1" >Status</th>
                                                </tr>
                                              </thead>
                                              <tbody>
                                              <s:iterator value="detailList" var="var" status="test">
                                                <tr id="row-<s:property value="status"/>" class="detatilRow">
                                                  <td  bgcolor="#e1e1e1"><s:property value="%{#test.count}"/></td>
                                                  <td bgcolor="#e1e1e1" ><s:property value="groupName"/></td>
                                                  <td bgcolor="#e1e1e1" ><s:property value="joiningDate"/></td>
                                                  <td bgcolor="#e1e1e1" >
                                                  	<s:if test="status==0">
                                                   		In Progress
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
                                            </s:if>
                                          </div>        
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       
                        <!-----modal ends------->
                 
                 
                		</s:iterator>
                    <!-- detail end -->  