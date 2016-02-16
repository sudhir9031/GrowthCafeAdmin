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

                        <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" class="text-center">
                               S.No
                              </th>
                              <th width="35%" bgcolor="#e1e1e1">Group</th> 
                              <th width="35%" bgcolor="#e1e1e1" class="text-center">Department</th>                     
                              <th width="25%" bgcolor="#e1e1e1" class="text-center">Action</th>
                            </tr>
                          </thead>
                          <tbody>
                           <s:if test="groupsList !=null && groupsList.size()>0">
                  			<s:iterator value="groupsList" status="status">
                            <tr>
                              <td bgcolor="#e1e1e1" class="text-center">
                                 <s:property value="%{#status.count}"/>
                              </td>
                              <td bgcolor="#e1e1e1"><s:property value="groupName"/></td>
                              <td bgcolor="#e1e1e1" class="text-center"><s:property value="departmentName"/></td>                      
                              
                              <td bgcolor="#e1e1e1" class="text-center"> 
                              <button class="bttn" onclick="editGroup(<s:property value="groupId"/>,<s:property value="departmentId"/>);">EDIT</button> 
                              <input type="hidden" value="<s:property value="groupName"/>" id="groupName-<s:property value="groupId"/>" name="<s:property value="groupName"/>">
                                <input type="hidden" value="<s:property value="description"/>" id="descriptionDet-<s:property value="groupId"/>" name="<s:property value="description"/>">
                              
                              <s:if test="status==1">
                              <button class="bttn" onclick="changeStatus(<s:property value="groupId"/>,0,'group')">ACTIVATE</button> 
                              </s:if>
                              <s:else>
                              <button class="bttn" onclick="changeStatus(<s:property value="groupId"/>,1,'group')">DEACTIVATE</button> 
                              </s:else>
                              
                             <!--  <a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion2" href="#collapse2" aria-expanded="false" aria-controls="collapseFive" class="collapsed"><i class="fa fa-caret-down" style="font-size:24px"></i></a> --></td>
                                                   
                            </tr>
                            </s:iterator>
                            </s:if>
                            
                           </tbody>
                        </table>
                        
 
 <%-- <table class="table table-bordered table-danger nomargin">
                  <thead>
                    <tr>
                      <th class="text-center" width="8%">
                          Sr. No.
                      </th>
                       <th width="22%" class="text-left"> Organization</th>  
                        <th width="20%" class="text-left"> Department</th> 
                         <th width="20%" class="text-left"> Group</th>                    
                      <th width="15%" class="text-center">Edit</th>
                     <!--  <th width="15%" class="text-center">Deactivate</th> -->
                    </tr>
                  </thead>
                  <tbody>
                  <s:if test="groupsList !=null && groupsList.size()>0">
                  <s:iterator value="groupsList" status="status">
                    <tr>
                      <td class="text-center">
                       <s:property value="%{#status.count}"/>
                      </td>
                      <td class="text-left"><s:property value="organisationName"/> </td>
                      <td class="text-left"><s:property value="departmentName"/></td>
                      <td class="text-left"><s:property value="groupName"/></td>
                      <td class="text-center"><button class="btn btn-default btn-quirk btn-stroke " onclick="editGroup('<s:property value="groupName"/>','<s:property value="description"/>','<s:property value="metadata"/>',<s:property value="groupId"/>);">edit</button></td>
                      <s:if test="status==1">
						<td class="text-center"><button
								class="btn btn-danger btn-quirk" onclick="changeStatus(<s:property value="groupId"/>,0,'group')">Activate</button>
						</td>
						</s:if>
						<s:else>
							<td class="text-center"><button class="btn btn-danger btn-quirk btn-stroke" onclick="changeStatus(<s:property value="groupId"/>,1,'group')">deactivate</button></td>
						</s:else>                     
                    </tr>
                    </s:iterator>
                    </s:if>
                  </tbody>
                </table> --%>