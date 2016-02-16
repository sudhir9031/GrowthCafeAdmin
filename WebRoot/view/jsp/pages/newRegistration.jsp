 <%@ taglib prefix="s" uri="/struts-tags"%>
 
 <script type="text/javascript">
 
 	function changeStatus(status,userId){
 		if(userId==0){
 			$("#statusId").val(status);
 			$("#changeNewUserStatusFormId").submit();
 		}else{
 			$("#statusId"+userId).val(status);
 			$("#changeNewUserStatusFormId"+userId).submit();
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
               <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		<div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if> 
                
                <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
               <form id="changeNewUserStatusFormId" action="changeNewUserStatus" method="post">
              	<div class="form-group col-sm-4 mg15a">
                	 <select class="form-control" name="departmentId">
                         <option value="0">Select Department</option>
                         <s:if test="selectDepartmentsList !=null && selectDepartmentsList.size()>0">
                         <s:iterator value="selectDepartmentsList">
                         	 <option value="<s:property value="departmentId"/>"><s:property value="departmentName"/> </option>
                          </s:iterator>
                         </s:if>
                     </select>
                </div>
               <div class="form-group col-sm-8">
              	  <button class="bttn pull-right btn-pos" onclick="changeStatus(0,0)">DECLINE ALL</button>
                  <button class="bttn pull-right btn-pos" onclick="changeStatus(1,0)">ACCEPT ALL</button>
               </div>
               <input type="text" id="statusId" name="status" style="display:none;" />
               <s:if test="studentsList !=null && studentsList.size()>0">
               	<s:iterator value="studentsList">
               		<input type="text" name="containers" value="${userId}" style="display:none;" />
               	</s:iterator>
               </s:if>
               </form> 
              </div>
              
            </div>
            
            <div class="panel-body">
            	
            
            </div>
          </div> 

           <div class="panel" id="ddd">
          <div class="panel-group" id="accordion">
              <div id="course-panel">     
                <div class="panel">
                  <div class="panel-heading">
                    <div class="panel-body">
                    <s:if test="studentsList !=null && studentsList.size()>0">
                      <div class="table-responsive">
                        <table class="table table-bordered nomargin">
                          <thead>
                            <tr>
                              <th width="5%" bgcolor="#e1e1e1" >
                               S.No
                              </th>
                              <th width="45%" bgcolor="#e1e1e1">Student name</th>
                              <th width="15%" bgcolor="#e1e1e1" >Department</th>
                              <th width="15%" bgcolor="#e1e1e1" >Email</th>                     
                              <th width="20%" bgcolor="#e1e1e1" >Action</th>
                            </tr>
                          </thead>
                          <tbody>
                          	<s:iterator value="studentsList" status="status">
                            <tr>
                              <td bgcolor="#e1e1e1" >
                               	<s:property value="#status.count"/>
                              </td>
                              <td bgcolor="#e1e1e1"><s:property value="fname"/>&nbsp;<s:property value="lname"/> </td>
                               <td bgcolor="#e1e1e1"><s:property value="depName"/></td>
                               <td bgcolor="#e1e1e1" ><s:property value="email"/></td>
                              <td bgcolor="#e1e1e1" > <button class="bttn" type="button" onclick="changeStatus(1,<s:property value="userId"/>)">ACCEPT</button>
                              <s:if test="status==3">
                               		DECLINED
                               </s:if>
                               <s:else>
                               		<button class="bttn" type="button" onclick="changeStatus(0,<s:property value="userId"/>)">DECLINE</button>
                               </s:else>
                               </td>
                                                   
                            </tr>
                            <form id="changeNewUserStatusFormId<s:property value="userId"/>" action="changeNewUserStatus" method="post">
                            	 <input type="text" id="statusId<s:property value="userId"/>" name="status" style="display:none;" />
					             <input type="text" name="containers" value="${userId}" style="display:none;" />
                            </form>
                            </s:iterator>
                           </tbody>
                        </table>
                        
                     </div>
                     </s:if>
                     <s:else>
                     	No Data
                     </s:else>
                        
                                                  
                    </div>
                  </div>
                  
                </div>
              </div>
          </div>
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 