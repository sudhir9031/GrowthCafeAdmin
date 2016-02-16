  <%@ taglib prefix="s" uri="/struts-tags"%>
  
  
  <script type="text/javascript">
		$(document).ready(function() {
			$(".date-picker").datepicker();
			$(".date-picker").on("change", function () {
				var id = $(this).attr("id");
				var val = $("label[for='" + id + "']").text();
				$("#msg").text(val + " changed");
			});
		});
</script>


<script type="text/javascript">

	function removeDiv(divId){
		$("#moreId"+divId).remove();
		return false;
	}


		var dateCounter=3;
		var dateCounter2 =dateCounter+1;
		function moreSessions(courseId){
			var date1 = $("#date-picker-"+courseId+""+(dateCounter-2)).val();
			var date2 = $("#date-picker-"+courseId+""+(dateCounter2-2)).val();
			if(date1!="" && date2!=""){
			 var moreSessionDiv = "<div id='moreId"+dateCounter+"'><div class='form-group col-sm-5'>"+
                                 "<div class='input-group'>"+
                                    "<input name='startedOn' id='date-picker-"+courseId+""+dateCounter+"' type='text' class='date-picker form-control' placeholder='01/18/2016'/>"+
                                    "<label for='date-picker-"+courseId+""+dateCounter+"' class='input-group-addon btn'><span class='glyphicon glyphicon-calendar'></span>"+
                                    "</label>"+
                                "</div>"+
                            "</div>"+
                           
                              "<div class='form-group col-sm-5'>"+
                                 "<div class='input-group'>"+
                                    "<input name='endOn' id='date-picker-"+courseId+""+dateCounter2+"' type='text' class='date-picker form-control' placeholder='01/24/2016'/>"+
                                    "<label for='date-picker-"+courseId+""+dateCounter2+"' class='input-group-addon btn'><span class='glyphicon glyphicon-calendar'></span>"+
                    
                                    "</label>"+
                                "</div>"+
                            "</div> "+
                             "<div class='form-group col-sm-1'>"+
                                 "<button type='button' class='bttn mgt5' onclick='removeDiv("+dateCounter+")'><i class='fa fa-minus'></i></button>"+
                             "</div></div>";
                     $("#moreSessionId"+courseId).append(moreSessionDiv);
                     dateCounter= dateCounter+2;
                     dateCounter2=dateCounter+1;
	            $(".date-picker").datepicker();
				$(".date-picker").on("change", function () {
					var id = $(this).attr("id");
					var val = $("label[for='" + id + "']").text();
					$("#msg").text(val + " changed");
				});
			}else{
				showSuccessMessage("Please first select presession");
			}
		
		}
		
		function saveGroup(courseId){
			var date1 = $("#date-picker-"+courseId+""+1).val();
			var date2 = $("#date-picker-"+courseId+""+2).val();

			if(Date.parse(date1) > Date.parse(date2)){
				showSuccessMessage("End Session date must be Greater than Start Session Date.");
				return false;
			}else{
				$("#sessionFormId"+courseId).submit();
			}
			return false;
		}
		
		function cancelGroup(courseId){
			$("#date-picker-"+courseId+""+1).val("");
			$("#date-picker-"+courseId+""+2).val("");
			$("#sessionDivId"+courseId).hide();
			return false;
		}
		
		function addSession(courseId){
			$(".divHide").hide();
			$(".collapsed").click();
			$("#sessionDivId"+courseId).show();
			$("#plusButtonId"+courseId).show();
			$("#sessionDivId"+courseId+" #groupId").val(0);
			$("#date-picker-"+courseId+"1").val("");
			$("#date-picker-"+courseId+"2").val("");
			return false;
		}
		
		function addContainer(courseId){
			$("#sessionFormId"+courseId).submit();
		}
		
		function editSession(courseId,groupId){
			$("#sessionDivId"+courseId).show();
			$("#plusButtonId"+courseId).hide();
			$("#sessionDivId"+courseId+" #groupId").val($("#editDivId"+groupId+" #groupId").val());
			$("#date-picker-"+courseId+"1").val($("#editDivId"+groupId+" #startDate").val());
			$("#date-picker-"+courseId+"2").val($("#editDivId"+groupId+" #endDate").val());
		}
    </script>
    
  
  	<%--<div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
                <li><a href="index.html"><i class="fa fa-home mr5"></i> Home</a></li> 
                <li><a href="#"><i class="fa fa-book mr5"></i> Course Sessions</a></li>            
            </ol> 
           <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
      		 <div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if>
          
                 
           <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	
                <div class="col-sm-12 col-md-12">
              	  <button class="bttn pull-right  btn-pos" onclick="return courseSession();"   data-id="addcoursebx">ADD COURSE SESSION <i class="fa fa-plus-circle"></i></button>
                  <!--<button class="bttn pull-right btn-pos" onclick="return Show_MapDiv();"   data-id="addmapbx">MAP COURSE <i class="fa fa-plus-circle"></i></button>-->
                 </div>
              </div>
              
            </div>
            
            <div class="panel-body">
             <div id="addcoursebx" class="mgt48" style="display:none;">
        	<div class="row">
                <form id="saveGroupFormId" action="saveGroup" method="post">
                	<s:hidden name="courseName" id="courseNameId"></s:hidden>
                	<div class="form-group col-sm-4">
                       <select class="form-control" name="courseType" id="courseTypeId" onChange="return selectCourseType(this.value);">
                              <option value="0">Select Type</option>
                              <option value="1">Self Paced</option>
                              <option value="2">Instructor Led</option>
                            </select>
                     </div>
                     <div  id="sectionId">
                	<div class="form-group col-sm-4">
                       		<select class="form-control" id="instructorCourseId" style="display:none;" name="">
                              <option value="0">Select Course</option>
                              <s:iterator value="coursesList">
                              	<option value="<s:property value="courseId"/>"><s:property value="courseName" /> </option>
                              </s:iterator>
                            </select>
                            <select class="form-control" id="selfCourseId" style="display:none;" name="">
                              <option value="0">Select Course</option>
                              <s:iterator value="selfCoursesList">
                              	<option value="<s:property value="courseId"/>"><s:property value="courseName" /> </option>
                              </s:iterator>
                            </select>
                     </div>
                	
                    <div class="form-group col-sm-12" id="sessionDescriptionDivId">
                    	 <textarea  class="form-control" id="sessionDescriptionId" name="description"></textarea>
                  	</div>
                     <div class="form-group col-sm-12">
                     	
                     	<div class="row" id="sessionDateDivId" style="display:none;">
                            <div class="form-group col-sm-5">
                            <label>Start Session</label>
                                <div class="input-group">
                                    <input id="date-picker-1" name="startedOn" type="text" class="date-picker form-control" placeholder="01/14/2016" />
                                    <label for="date-picker-1" class="input-group-addon btn"><span class="glyphicon glyphicon-calendar"></span>
                                    </label>
                                </div>
                            </div>
                             
                             <div class="form-group col-sm-5">
                             	<label>End Session</label>
                                <div class="input-group">
                                    <input id="date-picker-2" name="endOn" type="text" class="date-picker form-control" placeholder="01/20/2016" />
                                    <label for="date-picker-2" class="input-group-addon btn"><span class="glyphicon glyphicon-calendar"></span></label>
                                </div>
                            </div>
                            <div class="form-group col-sm-1">
                                 <button type="button" class="bttn close-btn" onclick="moreSessions();"><i class="fa fa-plus"></i></button>
                             </div>
                             
                        </div>
                     </div>
                     <div id="moreSessionId">
                     
                     </div>
                  	
                    <div class="form-group col-sm-12">
                        <button type="button" class="bttn" onclick="return saveGroup();">SAVE</button>
                        <button type="submit" class="bttn"  onclick="return Hide_Div();">CANCEL</button>
                    </div>
                    </div>
                    </form>
                  		</div>	
             </div> 
            
            </div>--%>
          
          
          <%-- <div class="panel-group" id="accordion">
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
                              <th width="60%" bgcolor="#e1e1e1">Course Session</th> 
                              <th width="10%" bgcolor="#e1e1e1" >Type</th>                     
                              <th width="25%" bgcolor="#e1e1e1" >Action</th>
                            </tr>
                          </thead>
                         </table>
                        </div>
                      <div class="table-responsive">
                       <s:if test="groupsList !=null && groupsList.size()>0">
                          <s:iterator value="groupsList" status="status">
                        <table class="table table-bordered nomargin">    
                          <tbody>
	                            <tr>
	                              <td width="5%" bgcolor="#e1e1e1" >
	                               <s:property value="#status.count" />
	                              </td>
	                              <td width="60%"bgcolor="#e1e1e1"><s:property value="groupName" /></td>
	                              <td width="10%" bgcolor="#e1e1e1" >
	                              <s:if test="courseType==1">
	                              		Self Paced
	                              </s:if>
	                              <s:else>
	                              		Instructor Led
	                              </s:else>
	                              </td>                      
	                              <td width="25%" bgcolor="#e1e1e1" > 
	                               <s:if test="courseType!=1">
	                              		<button class="bttn" type="submit">ADD SESSION</button> 
	                              </s:if>
	                              <button class="bttn mmgr80" type="submit">DEACTIVATE</button> 
	                             <s:if test="courseType==0">
	                              	<a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion<s:property value="#status.count" />" href="#collapse<s:property value="#status.count" />" aria-expanded="false" aria-controls="collapseFive" class="collapsed"><i class="fa fa-caret-down grn" style="font-size:24px"></i></a>
	                              </s:if>
	                              </td>
	                            </tr>
                           </tbody>
                        </table>
                        <div id="collapse<s:property value="#status.count" />" class="panel-collapse collapse" aria-expanded="false" style="height: 0px;">
                   
                    	<div class="course-list" id="second-acordion">                   				
                           <div class="panel-group" id="accordion<s:property value="#status.count"/>" role="tablist" aria-multiselectable="true">
                              <div class="panel">
                                <div role="tab" id="headingFive">
                                  
                                  
            						                    
                        <div class="table-responsive">
                            <table class="table table-bordered nomargin">
                              <thead>
                                <tr>
                                  <th  bgcolor="#e1e1e1" width="5%">
                                   S.No
                                  </th>
                                  <th width="35%" bgcolor="#e1e1e1">Session Start Date</th>
                                  <th width="35%" bgcolor="#e1e1e1">Session End Date</th>
                                  <th width="25%" bgcolor="#e1e1e1" >Action</th>
                                </tr>
                              </thead>
                              <tbody>
                              <s:if test="groupList !=null && groupList.size()>0">
                              	<s:iterator value="groupList" status="sessionStatus">
                              	<s:if test="startDate !=null">
                                <tr>
                                  <td  style="background:#e1e1e1;">
                                   <s:property value="#sessionStatus.count" />
                                  </td>
                                  <td bgcolor="#e1e1e1"><s:property value="startDate" /></td>
                                  <td bgcolor="#e1e1e1"><s:property value="endDate" /></td>  
                                  <td bgcolor="#e1e1e1" ><button class="bttn mg17" type="submit">EDIT</button> <button class="bttn" type="submit">DEACTIVATE</button> </td>
                                </tr>
                                </s:if>
                                </s:iterator>
                                </s:if>
                              </tbody>
                            </table>
                          </div>
                                 
                                </div>
                                 
                              
                              </div>
                              
      
    </div>
                                        
                                        
                             </div>
                               
                  </div>
                      </s:iterator>
                         </s:if>
                     </div>
                    </div>
                  </div>
                  
                </div>
              </div>
          </div> 
          </div> 
          --%>
          
<div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
                <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
                <li><a href="#"><i class="fa fa-book mr5"></i> Course Sessions</a></li>            
            </ol> 
           <div class="pull-right org_name">Scolere</div>    
                 
           <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-9 col-md-9">
                	<p><strong>Courses</strong></p>
              	</div>
                <div class="col-sm-3 col-md-3">
                	<a href="mapStudnet" type="button" class="bttn pull-right pda">map student to SESSION</a>
                </div>
              </div>
              
            </div>
            
           <!-- <div class="panel-body">
            	            
            </div>-->
          </div> 
         
          
         <div id="course-panel">     
                <div class="panel"> 
          
          <div class="panel-body">
          		<s:if test="coursesList !=null && coursesList.size()>0">
                      <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" >
                               S.No
                              </th>
                              <th width="58%" bgcolor="#e1e1e1">Course</th> 
                              <th width="12%" bgcolor="#e1e1e1" >Type</th>                     
                              <th width="25%" bgcolor="#e1e1e1" >Action</th>
                            </tr>
                          </thead>
                        </table>
                       </div>
                     <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
                     <s:iterator value="coursesList" var="courseVar" status="courseStatus">
                    <div class="panel">
                  <div class="panel-heading" role="tab" id="heading<s:property value="courseId"/>">
                    <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <tbody>
                            <tr>
                              <td width="5%" bgcolor="#e1e1e1" >
                               <s:property value="#courseStatus.count" />
                              </td>
                              <td width="58%" bgcolor="#e1e1e1"><s:property value="courseName" /></td>
                              <td width="12%" bgcolor="#e1e1e1" >
									  <s:if test="courseType==1">
	                              		Self Paced
	                              </s:if>
	                              <s:else>
	                              		Instructor Led
	                              </s:else>
								</td>                      
                              <td width="25%" bgcolor="#e1e1e1" >
                              	 <s:if test="courseType!=1">
                               		<button class="bttn" type="submit" onClick="return addSession(<s:property value="courseId"/>);">ADD SESSION</button>
                               		<button class="bttn" type="submit">DEACTIVATE</button>
                                	<a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion" href="#collapse<s:property value="courseId"/>" aria-expanded="false" aria-controls="collapseOne" class="collapsed"><i class="fa fa-caret-down grn" style="font-size:24px"></i></a>
                               </s:if>
                               <s:else>
                               		<button class="bttn pull-right deactivate" type="submit">DEACTIVATE</button>
                               		<s:if test="groupList !=null && groupList.size()==0">
                               			<button class="bttn pull-right" type="submit" onClick="return addContainer(<s:property value="courseId"/>);">ADD SESSION</button>
                               			<form id="sessionFormId<s:property value="courseId" />" method="post"  action="saveGroup">
					                     	<s:hidden name="courseId"/>
					                     	<s:hidden name="courseName"/>
					                     	<s:hidden name="courseType"/>
					                     	</form>
                               		</s:if>
                               		
                               </s:else>
                               </td>
                            </tr>
                            
                           </tbody>
                        </table>
                       </div>
                      </div>
                     <div class="mt10 divHide" style="display:none"; id="sessionDivId<s:property value="courseId"/>">
                     	<form id="sessionFormId<s:property value="courseId" />" method="post"  action="saveGroup">
                     	<s:hidden name="courseId"/>
                     	<s:hidden name="courseName"/>
                     	<s:hidden name="courseType"/>
                     	<input type="text" name="groupId" style="display:none;" id="groupId"> 
                     	<div class="row">
                            <div class="form-group col-sm-5">
                            <label>Start Session</label>
                                <!--<input type="date" required class="form-control" placeholder="Start Session Date">--->
                                <div class="input-group">
                                    <input name="startedOn" id="date-picker-<s:property value="courseId" />1" type="text" class="date-picker form-control" placeholder="01/14/2016" />
                                    <label for="date-picker-<s:property value="courseId" />1" class="input-group-addon btn"><span class="glyphicon glyphicon-calendar"></span>
                    
                                    </label>
                                </div>
                            </div>
                             
                             <div class="form-group col-sm-5">
                             	<label>End Session</label>
                                <div class="input-group">
                                    <input name="endOn" id="date-picker-<s:property value="courseId"/>2" type="text" class="date-picker form-control" placeholder="01/20/2016" />
                                    <label for="date-picker-<s:property value="courseId"/>2" class="input-group-addon btn"><span class="glyphicon glyphicon-calendar"></span>
                                    </label>
                                </div>
                            </div>
                            <div class="form-group col-sm-1">
                                 <button type="button" id="plusButtonId<s:property value="courseId"/>" class="bttn close-btn" onclick="moreSessions(<s:property value="courseId"/>);"><i class="fa fa-plus"></i></button>
                             </div>
                             <div id="moreSessionId<s:property value="courseId"/>"></div>
                              <%-- <div class="form-group col-sm-5">
                                 <div class="input-group">
                                    <input id="date-picker-7" type="text" class="date-picker form-control" placeholder="01/18/2016"/>
                                    <label for="date-picker-7" class="input-group-addon btn"><span class="glyphicon glyphicon-calendar"></span>
                    
                                    </label>
                                </div>
                            </div>
                            
                              <div class="form-group col-sm-5">
                                 <div class="input-group">
                                    <input id="date-picker-8" type="text" class="date-picker form-control" placeholder="01/24/2016"/>
                                    <label for="date-picker-8" class="input-group-addon btn"><span class="glyphicon glyphicon-calendar"></span>
                    
                                    </label>
                                </div>
                            </div> 
                             <div class="form-group col-sm-1">
                                 <button type="button" class="bttn mgt5"><i class="fa fa-minus"></i></button>
                             </div>--%>
                             <div class="form-group col-sm-12">
                                <button type="submit" class="bttn" onclick="return saveGroup(<s:property value="courseId"/>);">SAVE</button>
                                <button class="bttn"  onclick="return cancelGroup(<s:property value="courseId"/>);">CANCEL</button>
                            </div>
                        </div>
                        </form>
                     </div>
                        <div id="collapse<s:property value="courseId"/>" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<s:property value="courseId"/>">
                   
                    	<div class="course-list">                   				
                           <div class="panel-group">
                              <div class="panel">
                               <s:if test="groupList !=null && groupList.size()>0">
                                 <div class="table-responsive">
                                
                            <table class="table table-bordered nomargin">
                              <thead>
                                <tr>
                                  <th class="ft11"  bgcolor="#e1e1e1" width="5%">
                                   S.No
                                  </th>
                                  <th class="ft11" width="35%" bgcolor="#e1e1e1">Session Start Date</th>
                                  <th class="ft11" width="35%" bgcolor="#e1e1e1">Session End Date</th>
                                  <th class="ft11" width="25%" bgcolor="#e1e1e1" >Action</th>
                                </tr>
                              </thead>
                              <tbody>
                              <s:iterator value="groupList" status="groupStatus">
                                <tr>
                                  <td  style="background:#e1e1e1;">
                                   	<s:property value="#groupStatus.count" />
                                  </td>
                                  <td bgcolor="#e1e1e1"><s:property value="startDate" /></td>
                                  <td bgcolor="#e1e1e1"><s:property value="endDate" /></td> 
                                  <td bgcolor="#e1e1e1" ><button class="bttn flmg mgr32" type="submit">DEACTIVATE</button> 
                                  <button class="bttn flmg" type="button" onclick="return editSession(<s:property value="#courseVar.courseId" />,<s:property value="groupId" />);">EDIT</button> </td>
                                </tr>
                                 <div id="editDivId<s:property value="groupId"/>">
                                   <s:hidden name="groupId"/> 
                                  <s:hidden name="startDate"/>
                                  <s:hidden name="endDate"/>
                                 </div>
                                </s:iterator>
                                                
                                              </tbody>
                                            </table>
                                          </div>
                                          </s:if>
                                          <s:else>There is no session added</s:else>
                              </div>
                              
      
    </div>
                                        
                                        
                             </div>
                               
                  </div>
                  </div>
                  </s:iterator>
                </div>
               </s:if>
              </div>
          </div>          
          
    </div>
     </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  
  
  <script type="text/javascript">
  
  	$(document).ready(function() {
			$("#sessionDescriptionId").Editor();
		});
  
  </script>
  