 <%@ taglib prefix="s" uri="/struts-tags"%>

 
 											<table class="table table-bordered nomargin">
 														<s:if test="adminList !=null && adminList.size()>0">
																<thead>
																	<tr>
																		<th class="ft11" width="5%">S. No</th>
																		<th class="ft11" width="35%">ADMIN NAME</th>
																		<th class="ft11" width="30%">EMAIL</th>
																		<!-- <th width="15%">ORGANIZATION</th> -->
																		<th class="ft11" width="30%" >ACTION</th>
																	</tr>
																</thead>
																<tbody>
																		<s:iterator value="adminList" status="adminStatus">
																			<tr>
																				<td ><s:property value="#adminStatus.count" /></td>
																				<td  ><s:property value="fname" /> &nbsp;<s:property
																						value="lname" />
																				</td>
																				<td><s:property value="email" />
																				</td>
																				<%-- <td><s:property value="orgName" /> 
																				</td>--%>
																				<td ><button class="bttn" onclick="editAdmin('<s:property value="title"/>','<s:property value="fname"/>',
                     															 '<s:property value="lname"/>','<s:property value="contactNo"/>','<s:property value="password"/>',<s:property value="UserId"/>,<s:property value="organisationId" />);">EDIT</button>
																					
																					
															                      	<s:if test="status==0">
															                      		<button class="bttn" onclick="changeAdminStatus(<s:property value="organisationId"/>,<s:property value="userId"/>,1)">ACTIVATE</button>
															                      	</s:if>
															                      	 <s:elseif test="status==1">
																					 	<button class="bttn" onclick="changeAdminStatus(<s:property value="organisationId"/>, <s:property value="userId"/>,0)">DEACTIVATE</button>
															                      	</s:elseif>
																					</td>
																			</tr>
																		</s:iterator>
																</tbody>
																</s:if>
                       										<s:else><tr><td>There is no admin added</td></tr></s:else>
															</table>