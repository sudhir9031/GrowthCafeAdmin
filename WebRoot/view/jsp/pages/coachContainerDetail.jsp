<%@ taglib prefix="s" uri="/struts-tags"%>

								<div class="row">
                                       <div class="col-xs-5">
                                       <p> Available Courses (Mouse Over to Know the Session Date) </p>
                                           <select name="" id="search" class="form-control ofy ht350" multiple="multiple">
                                	<s:if test="suggestedContainer !=null && suggestedContainer.size()>0">
                                 	<s:iterator value="suggestedContainer">
                                  		<option value='<s:property value="groupId"/>' title="" ><s:property value="startDate"/>&nbsp;<s:property value="groupName"/></option>
                                  	</s:iterator>
                                  </s:if>
                                  </select>
                             </div>
                             
                             <div class="col-xs-2">
                              <p class="text-center"> Action </p>
                                 <button type="button" id="search_rightAll" class="btn btn-block" title="Move all to right"><i class="glyphicon glyphicon-forward"></i></button>
                                 <button type="button" id="search_rightSelected" class="btn btn-block" title="Move selected to right"><i class="glyphicon glyphicon-chevron-right"></i></button>
                                 <button type="button" id="search_leftSelected" class="btn btn-block" title="Move selected to left"><i class="glyphicon glyphicon-chevron-left"></i></button>
                                 <button type="button" id="search_leftAll" class="btn btn-block" title="Move all to left"><i class="glyphicon glyphicon-backward"></i></button>
                             </div>
                             
                             <div class="col-xs-5">
                              <p> Mapped Courses (Mouse Over to Know the Session Date)</p>
                                 <select name="containers" id="search_to" class="form-control ofy ht350" multiple="multiple">
                                 <s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                                 	<s:iterator value="selectDepartmentsList">
                                  		<option value='<s:property value="groupId"/>' title="" ><s:property value="endDate"/>&nbsp;<s:property value="groupName"/></option>
                                  	</s:iterator>
                                  </s:if>
                                 </select>
                                
                             </div>
                             
                         </div>
                          <button type="submit" class="bttn">SAVE</button>
                         
