  <%@ taglib prefix="s" uri="/struts-tags"%>
  
<script type="text/javascript">
	
	function addGrade(){
		$("#addGradeBox").show();
		return false;
	}
	
	function editGrade(id,grade,value){
		$("#addGradeBox").show();
		$("#gradeId").val(id);
		$("#gradeLabalId").val(grade);
		$("#valueId").val(value);
		
		return false;
	}
	
	function cancelGrade(){
		$("#addGradeBox").hide();
		return false;
	}
	
	function saveGrade(){
		var grade = $("#gradeLabalId").val();
		var value = $("#valueId").val();
		if(grade==""){
			showSuccessMessage("Please Enter Grade");
			return false;
		}if(value==0){
			showSuccessMessage("Please Enter value");
			return false;
		}
		$("#gradeFormId").submit();
		$("#addGradeBox").hide();
		return false;
	}
</script>
 <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-indent mr5"></i> Scoring Ruberic</a></li>            
            <li class="active"><i class="fa fa-plus-square-o mr5"></i> Grade</li>
          </ol>     
            <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		 <div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if>  
          
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	
                <div class="col-sm-12">
              	  <button class="bttn pull-right btn-pos" onclick="return addGrade();"   data-id="addTeacherBox">ADD Grade <i class="fa fa-sqaure-o"></i></button>
                </div>
              </div>
              
            </div>
            
            <div class="panel-body pdt0">
            	<div id="addGradeBox" class="mgt48" style="display:none">
        			<div class="row">
                        <form action="saveGrade" method="post" id="gradeFormId">
                        	<input type="text" class="form-control" name="gradeId" style="display:none;" value="0" id="gradeId">
                            <div class="form-group col-sm-4">
                                <input type="text" class="form-control" name="grade" required placeholder="Grade e.g. A+" id="gradeLabalId">
                            </div>
                            <div class="form-group col-sm-4">
                             <select class="form-control selectScroll" id="valueId" name="value" placeholder="Value e.g. 90">
                               		<option value="0">Select Value</option>
                                    <option value="5">5</option>
                                    <option value="10">10</option>
                                    <option value="15">15</option>
                                    <option value="20">20</option>
                                    <option value="25">25</option>
                                    <option value="30">30</option>
                                    <option value="35">35</option>
                                    <option value="40">40</option>
                                    <option value="45">45</option>
                                    <option value="50">50</option>
                                    <option value="55">55</option>
                                    <option value="60">60</option>
                                    <option value="65">65</option>
                                    <option value="70">70</option>
                                    <option value="75">75</option>
                                    <option value="80">80</option>
                                    <option value="85">85</option>
                                    <option value="90">90</option>
                                    <option value="95">95</option>
                                    <option value="100">100</option>
                               </select>
                              <!--  <input type="text" class="form-control" name="value" required placeholder="Value e.g. 90" id="valueId"> -->
                            </div>
                            
                            <div class="form-group col-sm-12">
                                <button class="bttn" onclick="saveGrade();" >Save</button>
                                <button class="bttn" onclick="return cancelGrade();">CANCEL</button>
                            </div>
                        </form>
                   </div>	
               </div>
            
            </div>
          </div> 
          
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
                              <th width="55%" bgcolor="#e1e1e1">Grade</th>
                              <th width="15%" bgcolor="#e1e1e1" >Value</th>                     
                              <th width="25%" bgcolor="#e1e1e1" >Action</th>
                            </tr>
                          </thead>
                          <tbody>
                          	<s:if test="gradeList !=null && gradeList.size()>0">
                          	<s:iterator value="gradeList" status="status">
	                            <tr>
	                              <td bgcolor="#e1e1e1" >
	                               	<s:property value="#status.count" />
	                              </td>
	                              <td bgcolor="#e1e1e1"><s:property value="value" /></td>
	                              <td bgcolor="#e1e1e1"><s:property value="startDate" /></td>
	                              <td bgcolor="#e1e1e1" > <button class="bttn" type="button" onclick="return editGrade(<s:property value="key" />,'<s:property value="value" />','<s:property value="startDate" />')">EDIT</button> <button class="bttn" type="submit">DEACTIVATE</button></td>
	                            </tr>
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
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 