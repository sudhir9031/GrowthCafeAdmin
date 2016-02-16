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


	<div id="course-panel">


		<div class="panel">


				<div class="panel-body">

					<div class="table-responsive">
						<table class="table table-bordered nomargin">
							<thead>
								<tr>
									<th width="5%" bgcolor="#e1e1e1">S.No
									</th>
									<th width="35%" bgcolor="#e1e1e1">ORGANIZATION</th>
									<!-- <th width="15%" bgcolor="#e1e1e1">ADDRESS</th> -->
									<th width="30%" bgcolor="#e1e1e1">WEBSITE</th>
									<th width="30%" bgcolor="#e1e1e1">ACTION</th>
								</tr>

							</thead>
						</table>
					</div>
	<div class="panel-group" id="accordion"  role="tablist" aria-multiselectable="true">
					<s:if test="organisationList !=null && organisationList.size()>0">
						<s:iterator value="organisationList" status="status" var="courseVar">
						<div class="panel panel-default">
                     	<div class="panel-heading tbl" role="tab" id="headingOne">
							<div class="table-responsive">
								<table class="table table-bordered nomargin">

									<tbody>
										<tr>
											<td width="5%"><s:property
													value="%{#status.count}" /></td>
											<td width="35%"><s:property value="organisationName" />
											</td>
											<%-- <td width="15%"><s:property value="address" /> 
											</td>--%>
											<td width="30%" ><s:property value="website" />
											</td>
											<td width="30%" bgcolor="#e1e1e1">
											 <button class="bttn" onclick="return addAdmin(<s:property value="organisationId" />);" data-id="addTeacherBox"> ADD ADMIN <i class="fa fa-plus-circle"></i></button>
												<%-- <button class="bttn"
													onclick="editOrg('<s:property value="organisationName"/>','<s:property value="logo"/>','<s:property value="address"/>'
											,'<s:property value="website"/>','<s:property value="description"/>', <s:property value="organisationId"/>);">EDIT</button>
											 --%>	
											 <button class="bttn" onclick="editOrg(<s:property value="organisationId"/>);">EDIT</button>
											
											<input type="hidden" class="organisationNameClass-<s:property value="organisationId" />" name="organisationName" value="<s:property value="organisationName" />"> 
			                          		<input type="hidden" class="logoClass-<s:property value="organisationId"/>" name="logo" value="<s:property value="logoFileName" />"> 
			                          		<input type="hidden" class="addressClass-<s:property value="organisationId"/>" name="address" value="<s:property value="address" />"> 
			                          		<input type="hidden" class="websiteClass-<s:property value="organisationId"/>" name="website" value="<s:property value="website" />"> 
			                          		<input type="hidden" class="descriptionClass-<s:property value="organisationId"/>" name="description" value="<s:property value="description" />"> 
	                          		
												
												<!-- <button class="bttn" type="submit">DEACTIVATE</button> -->
										<s:if test="status==1">
											<button	class="bttn" onclick="changeStatus(<s:property value="organisationId"/>,0,'org')">Activate</button>
										</s:if>
										<s:else>
											<button class="bttn" onclick="changeStatus(<s:property value="organisationId"/>,1,'org')">Deactivate</button>
										</s:else>
											<a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion" href="#collapse<s:property value="%{#status.count}" />" aria-expanded="false" aria-controls="collapse1" class="collapsed">
												<i class="fa fa-caret-down grn" style="font-size:24px"></i>
											</a>
											</td>

										</tr>
									</tbody>
								</table>
							</div>
						</div>
				

							<div id="addAdminBox<s:property value="organisationId" />" style="display:none;" class="tp10">

															<!-- <h4>ADD ADMIN</h4> -->

															<div class="row">
																<form id="addAdminFormId<s:property value="organisationId" />">

																	<input type="text" class="form-control" name="userId"
																		id="updateId" style="display:none;">
																	<div class="form-group col-sm-2">
																		 <select id="titleId" class="form-control" name="title">
																			<option value="Mr.">Mr.</option>
																			<option value="Mrs.">Mrs.</option>
																			<option value="Ms.">Ms.</option>
																			<option value="Dr.">Dr.</option>
																		</select>
																	</div>
																	<div class="form-group col-sm-5">
																		<input type="text" class="form-control" placeholder="First Name" name="Fname" id="FnameId">
																	</div>

																	<div class="form-group col-sm-5">
																		<input type="text" class="form-control" name="Lname" placeholder="Last Name" id="LnameId">
																	</div>
																	<div class="form-group col-sm-2">
																			<input type="text" class="form-control" placeholder="Contact Number" name="contactNo" id="contactNoId">
																	</div>
																	

																	<div class="form-group col-sm-5" id="emailparentId">
																			<input type="text" class="form-control" placeholder="Email"  name="email" id="emailId">
																	</div>
																	
																	<div class="form-group col-sm-5">
																		<div class="form-group">
																				<input type="password" placeholder="password" class="form-control" name="password" id="passwordId">
																		</div>
																	</div>

																	<%-- <div class="form-group col-md-4">
																		<label>Address <span class="strike_color">*</span>
																		</label>
																		<div class="form-group">
																			<input type="text" class="form-control"
																				name="address" id="addressId">
																		</div>
																	</div> --%>


																	<div class="form-group col-md-12" id="saveButtonId"
																		style="display:none;">
																		<button class="bttn"
																			onClick="return saveAdmin(<s:property value="organisationId"/>);">SAVE</button>
																		&nbsp;&nbsp;
																		<button class="bttn"
																			onclick="return cancelAdmin(<s:property value="organisationId"/>);">CANCEL</button>
																	</div>
																	<div class="form-group col-md-12" id="updateButtonId"
																		style="display:none;">
																		<button class="bttn"
																			onClick="return updateAdmin(<s:property value="organisationId" />);">UPDATE</button>
																		&nbsp;&nbsp;
																		<button class="bttn"
																			onclick="return cancelAdmin(<s:property value="organisationId" />);">CANCEL</button>
																	</div>
																</form>
															</div>





														</div>
							<div id="collapse<s:property value="%{#status.count}" />" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
								
											<div class="panel panel-default">
												<div role="tab" id="headingFive">
														<div class="table-responsive" id="adminTableDivId<s:property value="organisationId" />">
															<s:include value="adminTable.jsp"/>
														</div>
												</div>
											</div><br>
							</div>
					</div>
						</s:iterator>
					</s:if>


				</div>
				</div>
			</div>
		</div>
	







