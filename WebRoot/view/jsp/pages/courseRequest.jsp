 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script type="text/javascript">
 
 	function changeStatus(status,courseId,userId){
 		if(courseId==0 ){
 			$("#statusId").val(status);
 			$("#changeCourseReqStatusFormId").submit();
 		}if(userId==0 ){
 			$("#statusId").val(status);
 			$("#changeCourseReqStatusFormId").submit();
 		}else{
 			$("#statusId"+courseId+userId).val(status);
 			$("#changeCourseReqStatusFormId"+courseId+userId).submit();
 		}
 		return false;
 	}
 
 </script>

<div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-users mr5"></i> User Management</a></li>            
            <li class="active"><i class="fa fa-graduation-cap mr5"></i> Student</li>
          </ol>     
                <div class="pull-right org_name">Scolere</div> 
                
                <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
               <form id="changeCourseReqStatusFormId" action="changeCourseReqStatus" method="post">
              	<div class="form-group col-sm-3 mg15a">
                	 <select class="form-control" name="departmentId">
                         <option value="0">Select Department</option>
                         <s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                         <s:iterator value="selectDepartmentsList">
                         <option value="<s:property value="departmentId"/>"><s:property value="departmentName"/></option>
                         </s:iterator>
                         </s:if>
                     </select>
                </div>
                <div class="form-group col-sm-6 mg15a">
                	<select id="lunch" name="courseId" class="form-control selectpicker" data-live-search="true" title="Select Course" onChange="Show_selectdiv(this)">
                        <option value="0">Select Course</option>
                        <option value="1">Learning</option>
                        <option value="2">Management</option>
                        <option value="3">Sales</option>
                        <option value="4">Introduction to sales</option>
                        <option value="5">Leadership Selling Ignite</option>
                    </select>
                </div>
                 <input type="text" id="statusId" name="status" style="display:none;" />
               <s:if test="coursesList !=null && coursesList.size()>0">
               	<s:iterator value="coursesList">
               		<s:if test="studentList !=null && studentList.size()>0">
               		<s:iterator value="studentList">
               			<input type="text" name="users" value="${userId}" style="display:none;" />
               			<input type="text" name="containers" value="${groupId}" style="display:none;" />
               		</s:iterator>
               		</s:if>
               	</s:iterator>
               </s:if>
               
                <div class="form-group col-sm-3">
              	  <button class="bttn pull-right btn-pos"onclick="changeStatus(0,0,0)">DECLINE ALL</button>
                  <button class="bttn pull-right btn-pos"onclick="changeStatus(1,0,0)">ACCEPT ALL</button>
               </div>
               <div class=" form-group col-sm-12" style="display:none" id="filterDate">
                    <div class="row">
                        <div class="col-sm-3">
                            <select class="form-control" name="title" required>
                                 <option value="1">Sesion Date</option>
                                 <option value="2">10 Jan 2016</option>
                                 <option value="3">12 Jan 2016</option>
                             </select>
                        </div>
                        <div class="col-sm-3">
                             <button class="bttn mt5">Filter</button>
                        </div>
                    </div>
                </div>
               
               </form> 
              </div>
              
            </div>
            
            <!--<div class="panel-body pdt0">
            	
            
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
                              <th width="70%" bgcolor="#e1e1e1">Course Name</th> 
                              <th width="25%" bgcolor="#e1e1e1">ACTION</th>
                            </tr>
                            
                          </thead>
                        </table>
                    </div>
                  
                     <div class="panel-group" id="accordion"  role="tablist" aria-multiselectable="true">
                     <s:iterator value="coursesList" status="status" var="courseVar">
                       <div class="panel panel-default">
                     	<div class="panel-heading" role="tab" id="headingOne">
                      <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                         
                          <tbody>
                          
                            <tr>
                              <td width="5%">
                               	<s:property value="#status.count" />
                              </td>
                              <td width="70%" ><s:property value="courseName" /></td>                      
                              <td width="25%"  bgcolor="#e1e1e1" ><button class="bttn" type="button" onclick="changeStatus(1,<s:property value="courseId"/>,0)" >Accept All</button>
                               <button class="bttn" type="submit" onclick="changeStatus(0,<s:property value="courseId"/>,0)" >Decline All</button> 
                               <a role="button" id="show-content" data-toggle="collapse" data-parent="#accordion" href="#collapse<s:property value="courseId" />" aria-expanded="true" aria-controls="collapse<s:property value="courseId" />" class="collapsed"><i class="fa fa-caret-down grn" style="font-size:24px"></i></a></td>
                            </tr>
                            </tbody>
                            </table>
                             <form id="changeCourseReqStatusFormId<s:property value="courseId"/>" action="changeCourseReqStatus" method="post">
                            	 <input type="text" id="statusId<s:property value="userId"/>" name="status" style="display:none;" />
					             <input type="text" name="containers" value="${groupId}" style="display:none;" />
					             <input type="text" name="users" value="${userId}" style="display:none;" />
                            </form>
                            </div>
                            </div>
               
                            <div id="collapse<s:property value="courseId" />" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading<s:property value="courseId" />">
                   				<div class="panel panel-default">
                               
                                   
                                  <div class="panel-body" style="padding:0px">
            				<s:if test="studentList !=null && studentList.size()>0">		                    
                        		<div class="table-responsive">
  				<table class="table table-bordered nomargin">
                  <thead>
                    <tr>
                      <th class="ft11" width="5%">
                       S.No
                      </th>
                      <th class="ft11" width="40%">Student Name</th>
                      <th class="ft11" width="15%" >Department</th>
                      <th class="ft11" width="15%" >Session Date</th>
                      <th class="ft11" width="25%" >ACTION</th>
                     </tr>
                  </thead>
                  <tbody>
                  <s:iterator value="studentList" status="studentStatus">
                  	<tr>
                      <td >
                       <s:property value="#studentStatus.count"/>
                      </td>
                      <td> <s:property value="fname"/>&nbsp;<s:property value="lname"/></td>
                      <td><s:property value="depName"/></td>
                      <td><s:property value="startDate"/></td>
                      <td >
                      	<s:if test="status ==3">
	                       <button class="bttn mgr32 flmg" disabled type="button">DECLINED</button> 
	                     </s:if>
	                     <s:else>
	                     	<button class="bttn flmg mgr32"  onclick="changeStatus(0,<s:property value="#courseVar.courseId"/>,<s:property value="userId"/>)">Decline</button>
	                     </s:else>
	                      <button class="bttn flmg"onclick="changeStatus(1,<s:property value="#courseVar.courseId"/>,<s:property value="userId"/>)">Accept</button>
	                      </td>
                     </tr>
                      <form id="changeCourseReqStatusFormId<s:property value="#courseVar.courseId"/><s:property value="userId"/>"  action="changeCourseReqStatus" method="post">
                            	 <input type="text" id="statusId<s:property value="#courseVar.courseId"/><s:property value="userId"/>" name="status" style="display:none;" />
                            	 <input type="text" name="users" value="${userId}" style="display:none;" />
					             <input type="text" name="containers" value="${groupId}" style="display:none;" />
                            </form>
                    </s:iterator>
                    
                  </tbody>
                </table>
                </div>
                  </s:if>                </div>
                                </div>
                            </div>
                  </div>
                  </s:iterator>
                    </div>
                  </s:if>
                  </div>
                 
                  
                  
                </div>
              </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 