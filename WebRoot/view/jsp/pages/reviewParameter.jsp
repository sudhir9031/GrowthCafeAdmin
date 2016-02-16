 <%@ taglib prefix="s" uri="/struts-tags"%>

<%-- <script type="text/javascript">

	function getReviewParameter(){
		var orgId = $("#selectOrgId").val();
		if(orgId>0){
			$("#addButtonId").show();
			var url ="getParamValue?organisationId="+orgId;
			$.get( url, function( data ) {
					/* var result = JSON.parse(data);
					var selOption = "<option value='addNew'>Add New</option>";
					for(var i=0; i<result.length;i++){
						selOption=selOption+"<option value='"+result[i].key+"'>"+result[i].value+"</option>";
					}
					$("#selParameterId").html(selOption); */
					$("#reviewParameterTableDivId").html(data);
				});
		}else{
			$("#addButtonId").hide();
		}
		return false;
	}
	
	function getReviewValue(id){
			var orgId = $("#selectOrgId").val();
			if(id=='addNew'){
				$("#newParamDivId").show();
				$("#newParamValueDivId").show();
				$("#selParamValueId").val('addNew');
				$("#selParamValueDivId").hide();
				$("#saveButtonId").show();
			}else{
				$("#newParamDivId").hide();
				$("#selParamValueDivId").show();
				var url ="getReviewValue?paramId="+id;
			$.get( url, function( data ) {
					var result = JSON.parse(data);
					var selOption = "<option value='addNew'>Add New</option>";
					for(var i=0; i<result.length;i++){
						selOption=selOption+"<option value='"+result[i].key+"'>"+result[i].value+"</option>";
					}
					$("#selParamValueId").html(selOption);
				});
				$("#newParamTextFieldId").val("");
			}
			
		return false;
	}
	
	function showHideSaveButton(id){
		if(id=='addNew'){
			$("#saveButtonId").show();
			$("#newParamValueDivId").show();
		}else{
			$("#saveButtonId").hide();
			$("#newParamValueDivId").hide();
		}
		
		return false;
	}

function saveReviewParameter(){
	var value = $("#newParamValueTextFieldId").val();
	var param= $("#newParamTextFieldId").val();
	var orgId = $("#selectOrgId").val();
	var paramId= $("#selParameterId").val();
	if(paramId=='addNew'){
		if(param==''){
			showSuccessMessage("Please Enter Parameter");
			return false;
		}
	}
	if(value==''){
		showSuccessMessage("Please Enter Value");
			return false;
	}
	startwindowDisable();
	if(param!='' && value!=''){
			var val1 =	encodeURIComponent(value);
			var url ="saveReviewParameter?organisationId="+orgId+"&param="+param+"&value="+val1;
			$.get( url, function(data) {
					$("#reviewParameterTableDivId").html(data);
					$("#newParamValueTextFieldId").val("");
					 $("#newParamTextFieldId").val("");
					$("#addcoursebx").hide();
					$("#selParameterId").val('addNew');
					$("#selParamValueId").val('addNew');
				});
		}else{
			var val1 =	encodeURIComponent(value);
			var data ="paramId="+paramId+"&value="+val1+"&organisationId="+orgId;
			/* $.get(url, function(data) { */
			$.post("saveReviewParameter",data,
			 function(data,status){
						$("#reviewParameterTableDivId").html(data);
						$("#newParamValueTextFieldId").val("");
					 	$("#newParamTextFieldId").val("");
						$("#addcoursebx").hide();
						$("#selParameterId").val('addNew');
						$("#selParamValueId").val('addNew');
				});
	}
	endwindowDisable();
	return false;
}

function deleteParameter(paramId, valueId){
	var orgId = $("#selectOrgId").val();
	var url ="deleteParameter?paramId="+paramId+"&valueId="+valueId+"&organisationId="+orgId;
	startwindowDisable();
	 $.get(url, function(data) {
		$("#reviewParameterTableDivId").html(data);
		endwindowDisable();
		});
	return false;
}

function cancelReview(){
	$("#addcoursebx").hide();
	$("#selParameterId").val('addNew');
	getReviewValue('addNew');
	return false;
}

</script>


<div class="mainpanel"> 
     
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-tasks"></i> Scoring Rubric</a></li>            
             <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		 <li style="float: right;" ><a href="javaScript:;">Richmond Homes</a></li>
            </s:if>
          </ol>     
                 
            <div class="panel" id="ddd">
                
                <div class="panel-body" style="display:none;">
                  	<div class="row">
                    		<div class="form-group col-md-4">
                            <label>Organization</label>
                            <select id="selectOrgId" class="form-control"  onchange="return getReviewParameter();">
	                             <s:if test="#session.organisationList !=null">
	                             	<s:iterator value="#session.organisationList">
	                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
	                              	</s:iterator>
	                              </s:if>
                            </select>
                  </div>
                    </div>
    
                </div>
              </div>  
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-8"></div>
                <div class="col-sm-4" id="addButtonId">
                	<button class="bttn pull-right"  onclick="return Show_Div();"   data-id="addcoursebx">ADD PARAMETERS <i class="fa fa-plus-circle"></i></button>
                </div>
              </div>
              
            </div>
            
            <div class="panel-body">
            		
            
              <div class="table-responsive">
                <div id="reviewParameterTableDivId">
                	<s:include value="reviewParameterTable.jsp"></s:include>
                </div>
              </div><!-- table-responsive -->
          
            </div>
          </div>   
    
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  --%>
  
  <script type="text/javascript">

        function Show_Div() {
			$("#addcoursebx").show();
			$("#paramId").val(0);
			$("#valueId").val("");
           return false;
        }
        
        function editParam(id,value){
        	$("#addcoursebx").show();
			$("#paramId").val(id);
			$("#valueId").val(value);
        	 return false;
        }
        function cancelParam(){
        	$("#addcoursebx").hide();
        	 return false;
        }
        
		
		function hideForm(){
			$("#hbox").hide();
			return false;
		}
    </script> 
    
    
    
    
    <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-indent mr5"></i> Scoring Ruberic</a></li>            
            <li class="active"><i class="fa fa-certificate mr5"></i> Parameter</li>
          </ol>     
             <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
           		 <div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if> 
          
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	
                <div class="col-sm-12">
              	  <button class="bttn pull-right btn-pos"  onclick="return Show_Div();"    data-id="addTeacherBox">ADD Parameter <i class="fa fa-sqaure-o"></i></button>
                </div>
              </div>
            </div>
            
            <div class="panel-body pdt0">
            	<div id="addcoursebx" class="mgt48" style="display:none">
        			<div class="row">
                        <form action="saveParam" method="post">
                            <div class="form-group col-sm-4">
                            	 <input type="text" class="form-control" name="paramId" style="display:none;" id="paramId" value="0">
                                <input type="text" class="form-control" name="param" required placeholder="Parameter Name" id="valueId">
                            </div>
                             <div class="form-group col-sm-12">
                                <button class="bttn">Save</button>
                                <button class="bttn" onclick="return cancelParam();">CANCEL</button>
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
                              <th width="70%" bgcolor="#e1e1e1">Parameter</th>                     
                              <th width="25%" bgcolor="#e1e1e1" >Action</th>
                            </tr>
                          </thead>
                          <tbody>
                          <s:if test="paramList !=null && paramList.size()>0">
                          <s:iterator value="paramList" status="status">
	                            <tr>
	                              <td bgcolor="#e1e1e1" >
	                               <s:property value="#status.count" />
	                              </td>
	                              <td bgcolor="#e1e1e1"><s:property value="value" /> </td>
	                              <td bgcolor="#e1e1e1" > <button class="bttn" type="submit" onclick="editParam(<s:property value="key" />,'<s:property value="value" />');">EDIT</button> <button class="bttn" type="submit">DEACTIVATE</button></td>
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