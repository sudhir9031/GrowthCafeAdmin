  <%@ taglib prefix="s" uri="/struts-tags"%>
  <script type="text/javascript">
  
  	$(document).ready(function(){
  		$("#descriptionId").Editor();
  		$(".Editor-editor").attr("data-text","Description");
  	});
  
  
  
  	function getDepartmentTable(ogrId){
  		
  		if(ogrId==0){
  			$("#depAddButtonId").hide();
  		}else{
	  		$("#depAddButtonId").show();
	  		}
	  		var url="getdepartmentTable?organisationId="+ogrId;
	  		$.get(url, function( data ) {
		  	$("#departMentTableDivId").html( data );
		});
	
	return false;
  	}
  
  
    function Show_Div() {
    $("#addDepartmentBoxId").show();
			$("#addmapbx").hide();
			$("#unmapbx").hide(); 
    		var orgId = $("#selectOrgId").val();
			$("#saveButtonId").show();
			$("#updateButtonId").hide();
			$("#descriptionDescId .Editor-editor").html("");
			var selectedDep = $("#suggestedDepId option:selected").text().trim();
     		$("input[name~='departmentName']").val(selectedDep);
     		//$("#descriptionId").val("");
     		$("#metadataId").val("");
           return false;
        }
        
     function cancelDep(){
     	$("#addDepartmentBoxId").hide();
     	 $("#newDepTextFieldId").val("");
		$("#metadataId").val("");
		$("#descriptionId").val("");
     }
     
		
	function saveDepartment(){
		var orgId = $("#selectOrgId").val();
		var deparmentTxt= $("#newDepTextFieldId").val();
		/* var metadata= $("#metadataId").val(); */
		var description= $("#descriptionDescId .Editor-editor").html();
		$("#descriptionId").val(description);
		$("#updateId").val(0);
			if(deparmentTxt==""){
			showSuccessMessage("Please Enter Department Name");
			return false;
			}/* if(metadata==""){
				showSuccessMessage("Please Enter Metadata");
				return false;
			} */if(description==""){
				showSuccessMessage("Please Enter Description");
				return false;
			}
		if(deparmentTxt!="" && orgId !=0){
				startwindowDisable();
				var data=$("#departmentFormId").serialize();
				/* var url="saveDepartment?"+data+"&organisationId="+orgId; */
				var url="saveDepartment?"+data;
				$.get(url, function( data ) {
			  	$("#departMentTableDivId").html( data );
			  		endwindowDisable();
				});
				$("#addDepartmentBoxId").hide();
			}else{
				showSuccessMessage("Please add new department");
			}
			
		var deparmentTxt= $("#newDepTextFieldId").val("");
		var metadata= $("#metadataId").val("");
		var description= $("#descriptionId").val("");
			return false;
	}
	
	
	
	function editDepartment(id){
	var dep=$(".departmentNameClasss-"+id).val();
	var desc=$(".descriptionNameClasss-"+id).val();
	
		 $("#newDepTextFieldId").val(dep);
		/* $("#metadataId").val(meta); */
	//	$("#descriptionId").val(desc);
		
		$("#descriptionDescId .Editor-editor").html(desc);
		$("#addDepartmentBoxId").show();
		$("#saveButtonId").hide();
		$("#updateButtonId").show();
		$("#updateId").val(id);
	}
	
	function cancelEditDepartment(editDivId){
		$("#"+editDivId).hide();
	}
	
	
	function updateDepartments(){
		var orgId = $("#selectOrgId").val();
		var deparmentTxt= $("#newDepTextFieldId").val();
		/* var metadata= $("#metadataId").val(); */
		var description= $("#descriptionDescId .Editor-editor").html();
		$("#descriptionId").val(description);
		var departmentId= $("#updateId").val();
			if(deparmentTxt==""){
			showSuccessMessage("Please Enter Department Name");
			return false;
			}/* if(metadata==""){
				showSuccessMessage("Please Enter Metadata");
				return false;
			} */if(description==""){
				showSuccessMessage("Please Enter Description");
				return false;
			}
				var data=$("#departmentFormId").serialize();
		
				
				$.post("updateDepartment",data,function(data,status){
       			$("#departMentTableDivId").html(data);
		        endwindowDisable();
		        });
						
			/* var url="updateDepartment";
				$.post(url,dataStr,
			        function(data,status){
				       	$("#departMentTableDivId").html(data);
				        endwindowDisable();
			        }); */
			       
				$("#addDepartmentBoxId").hide();
		return false;
	}
  </script>
 
 <%-- <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li>  
            <li><a href="#">Organization Management</a></li>          
            <li class="active">Department</li>
          </ol>     
                 
            <div class="panel" id="ddd">
               
                <div class="panel-body">
                  	<div class="row">
                    		<div class="form-group col-md-4">
                           <label>Organization</label>
                            <select id="selectOrgId" name="organisationId" onchange="getDepartmentTable(this.value);" class="form-control" >
	                             <s:if test="#session.organisationList !=null">
		                             <s:if test="#session.loginDetail.userType==4">
		                             	<option value="0">All</option>
		                             	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:if>
		                              	<s:else>
		                              	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:else>
	                              </s:if>
                            </select>
                  </div>
                  			<div class="form-group col-md-4">
                            <label>Department</label>
                        <select id="selectDepId" onchange="getGroups();" class="form-control" style="width: 100%" data-placeholder="Basic Select2 Box">
                        	<option value="0">All</option>
                        </select>
                  </div>
                  			
                    </div>
    
                </div>
              </div>  
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
             	 <div class="row">
             	 	<div class="col-md-4  col-md-offset-8" id="depAddButtonId">
             	 		<button class="btn btn-default btn-quirk btn-stroke pull-right" onclick="return Show_Div();">ADD DEPARTMENT <i class="fa fa-plus-circle"></i></button>
             	 	</div>
             	  </div>
            </div>
            
            <div class="panel-body" >
            
            <div id="addDepartmentBoxId" style="display:none;">
            	<div class="row">
                  			<div id="newDepTextFieldDivId">
                  			<form id="departmentFormId">
                  			
                            <div class="form-group col-md-4">
	                           <label>New Department <span class="strike_color">*</span></label>
	                           	<input  type="text" class="form-control" name="departmentId" id="updateId" style="display: none;">
	                            <div class="form-group">
	                           		<input id="newDepTextFieldId" type="text" class="form-control" name="departmentName">
	                          </div>
                		  </div>
                  
                  			<div class="form-group col-md-4">
                             <label>Tags<span class="strike_color">*</span></label>
                            <div class="form-group">
                           		 <input id="metadataId" type="text" class="form-control" name="metadata">
                          </div>
                  </div>
                           
                          
                          <div class="form-group col-md-12">
			                    	<label>Department Description <span class="strike_color">*</span></label>
			                        <textarea class="form-control" cols="4" name="description" id="descriptionId"></textarea>
			                   </div>
                          </form>
                  </div>
                  			                  			
                            
                            <div class="form-group col-md-12" id="saveButtonId" style="display:none;">
                            	<button class="btn btn-danger btn-quirk" onclick="saveDepartment();">save</button>
                                 &nbsp;&nbsp; <button class="btn btn-danger btn-quirk  btn-stroke" onclick="cancelDep();">CANCEL</button>
                            </div>
                             <div class="form-group col-md-12" id="updateButtonId" style="display:none;">
                            	<button class="btn btn-danger btn-quirk" onclick="updateDepartment();">Update</button>
                                 &nbsp;&nbsp; <button class="btn btn-danger btn-quirk  btn-stroke" onclick="cancelDep();">CANCEL</button>
                            </div>
                            
                  		</div>	
        </div>
            
              <div class="table-responsive">
               			<div id="departMentTableDivId">
               				<s:include value="departmentTable.jsp"></s:include>
               			</div>
              </div> 
            </div>
          </div>   
          
        

		
        
        
        
        
           	
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
   --%>
   
   <div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
            <li><a href="dashboard"><i class="fa fa-home mr5"></i> Home</a></li> 
            <li><a href="#"><i class="fa fa-building mr5"></i> Departments</a></li> 
          </ol>     
            <s:if test="#session.loginDetail !=null && #session.loginDetail.userType!=4">    
      		 	<div class="org_name pull-right">${loginDetail.orgName}</div>    
            </s:if>
         
              
            <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-12 col-md-12">
              	  <button class="bttn pull-right btn-pos" onclick="return Show_Div();"   data-id="addDepartmentBoxId">ADD <i class="fa fa-plus-circle"></i></button>
                	<button class="bttn pull-right btn-pos" type="button" data-toggle="modal" data-target="#resourseModal">MAP COURSE <i class="fa fa-plus-circle"></i></button>
                </div>
              </div>
              
            </div>
            
              <!-- Modal -->
                        <div id="resourseModal" class="modal fade" role="dialog" style="z-index:1245465464">
                          <div class="modal-dialog modal-lg">
                        
                            <!-- Modal content-->
                            <div class="modal-content">
                              <div class="modal-header">
                                <!---<button type="button" class="close" data-dismiss="modal">&times;</button>
                                 <button type="button" class="bttn pull-right">ADD RESOURCES</button>--->
                                <h4 class="modal-title">Map Courses</h4>
                              </div>
                              <div class="modal-body">
                                <div class="row">
                                 <form id="departmentMapFormDivId" action="mapDepCourseContainer" method="post">
                                     <div class="form-group col-sm-4">
                                         <select class="form-control" onChange="Show_leftDiv(this)" name="departmentId" id="selectID">
                                              <option value="0">Select Department</option>
                                              <s:if test="departmentsList !=null && departmentsList.size()>0">
                                             	<s:iterator value="departmentsList">
                                              		<option value="<s:property value="departmentId"/>"><s:property value="departmentName"/></option>
                                              	</s:iterator>
                                              </s:if>
                                            </select>
                                     </div>
                                     <div class="col-sm-12" style="display:none" id="lefttoright">
                                     	 	<s:include value="depContainerMap.jsp"/>
                                        <!-- <button type="button" class="bttn" onClick="return enable_leftDiv();">CANCEL</button> -->

                                    </div>
                                 </form>
                                </div>
                                     
                              </div>
                              <div class="modal-footer">
                              	<button type="button" class="bttn" data-dismiss="modal">CLOSE</button>
                              </div>
                            </div>
                        
                          </div>
                        </div>
                       
                        <!-----modal ends------->
            
            <div class="panel-body">
            	<div id="addDepartmentBoxId" style="display:none;">
        	
        	<!-- <h4>ADD</h4> -->
        	
            	<div class="row">
            	
            	
            	        
               <form id="departmentFormId">
               
               <div class="form-group col-md-4" style="display:none;">
                           <label>Organization</label>
                            <select id="selectOrgId" name="organisationId" onchange="getDepartmentTable(this.value);" class="form-control" >
	                             <s:if test="#session.organisationList !=null">
		                             <s:if test="#session.loginDetail.userType==4">
		                             	<option value="0">All</option>
		                             	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:if>
		                              	<s:else>
		                              	<s:iterator value="#session.organisationList">
		                              		<option value="<s:property value="organisationId"/>"><s:property value="organisationName"/> </option>
		                              	</s:iterator>
		                              	</s:else>
	                              </s:if>
                            </select>
                  </div>
                  <input  type="text" class="form-control" name="departmentId" id="updateId" style="display:none;">
                	<div class="form-group col-sm-12">
                    	<!-- <label>Department*</label> -->
                    	<div class="form-group">
                        	 <input type="text" class="form-control" name="departmentName" id="newDepTextFieldId" placeholder="Department">
                  	    </div>
                    </div>
                    <div class="form-group col-sm-12" id="descriptionDescId">
                       	<!-- <label>Department Description*</label> -->
                        <textarea  name="description" id="descriptionId" class="form-control" rows="5" aria-required="true"></textarea>
                    </div>
                  	<!-- <div class="form-group col-sm-12">
                            <label>Tags*</label>
                        	<div class="form-group">
                           		 <input type="text" id="metadataId"  name="metadata" class="form-control" required>
                          </div>
                    </div> -->
                    <div class="form-group col-sm-12" id="saveButtonId" style="display:none;">
                        <button onclick="return saveDepartment();" class="bttn" >SAVE</button>
                        <button type="button" class="bttn"  onclick="cancelDep();">CANCEL</button>
                    </div>
                    
                     <div class="form-group col-sm-12" id="updateButtonId" style="display:none;">
                        <input type="button" onclick="updateDepartments();" class="bttn" value="UPDATE">
                        <button type="button" class="bttn"  onclick="cancelDep();">CANCEL</button>
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
                      <div id="departMentTableDivId">
               				<s:include value="departmentTable.jsp"></s:include>
               			</div>
                    </div>
                  </div>
                  
                </div>
              </div>
          </div>
    </div>
    <!-- contentpanel --> 
    
  </div>
  
  
  
<script type="text/javascript">
		
		function Show_leftDiv(elem) {
			if(elem.value==0){
			document.getElementById('lefttoright').style.display = "none";
			}
			else{
				$.get("getDepartmentContainer?departmentId="+elem.value, function( data ) {
			  	$("#lefttoright").html(data);
			  	/**
			  	Multi Selection Script start
			  	*/
				window.prettyPrint && prettyPrint();
				
				if ( window.location.hash ) {
					scrollTo(window.location.hash);
				}
				
				$('.nav').on('click', 'a', function(e) {
					scrollTo($(this).attr('href'));
				});
		
				$('#multiselect').multiselect();
		
				$('[name="q"]').on('keyup', function(e) {
					var search = this.value;
					var $options = $(this).next('select').find('option');
		
					$options.each(function(i, option) {
						if (option.text.indexOf(search) > -1) {
							$(option).show();
						} else {
							$(option).hide();
						}
					});
				});
		
				$('#search').multiselect({
					search: {
						left: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
						right: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
					}
				});
		
				$('.multiselect').multiselect();
				$('.js-multiselect').multiselect({
					right: '#js_multiselect_to_1',
					rightAll: '#js_right_All_1',
					rightSelected: '#js_right_Selected_1',
					leftSelected: '#js_left_Selected_1',
					leftAll: '#js_left_All_1'
				});
		
				$('#keepRenderingSort').multiselect({
					keepRenderingSort: true
				});
		
				$('#undo_redo').multiselect();
		
				$('#multi_d').multiselect({
					right: '#multi_d_to, #multi_d_to_2',
					rightSelected: '#multi_d_rightSelected, #multi_d_rightSelected_2',
					leftSelected: '#multi_d_leftSelected, #multi_d_leftSelected_2',
					rightAll: '#multi_d_rightAll, #multi_d_rightAll_2',
					leftAll: '#multi_d_leftAll, #multi_d_leftAll_2',
		
					moveToRight: function(Multiselect, options, event, silent, skipStack) {
						var button = $(event.currentTarget).attr('id');
		
						if (button == 'multi_d_rightSelected') {
							var left_options = Multiselect.left.find('option:selected');
							Multiselect.right.eq(0).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
							}
						} else if (button == 'multi_d_rightAll') {
							var left_options = Multiselect.left.find('option');
							Multiselect.right.eq(0).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
							}
						} else if (button == 'multi_d_rightSelected_2') {
							var left_options = Multiselect.left.find('option:selected');
							Multiselect.right.eq(1).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
							}
						} else if (button == 'multi_d_rightAll_2') {
							var left_options = Multiselect.left.find('option');
							Multiselect.right.eq(1).append(left_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.right.eq(1).eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
							}
						}
					},
		
					moveToLeft: function(Multiselect, options, event, silent, skipStack) {
						var button = $(event.currentTarget).attr('id');
		
						if (button == 'multi_d_leftSelected') {
							var right_options = Multiselect.right.eq(0).find('option:selected');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						} else if (button == 'multi_d_leftAll') {
							var right_options = Multiselect.right.eq(0).find('option');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						} else if (button == 'multi_d_leftSelected_2') {
							var right_options = Multiselect.right.eq(1).find('option:selected');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						} else if (button == 'multi_d_leftAll_2') {
							var right_options = Multiselect.right.eq(1).find('option');
							Multiselect.left.append(right_options);
		
							if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
								Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
							}
						}
					}
				});
					  	/**
			  			*	Multi Selection Script end
			  			*/
			  	
			  		document.getElementById('lefttoright').style.display = "block";
				});
				
			}
		}
		/* function enable_leftDiv() {
			document.getElementById('selectID').disabled = false;
		}
 */
		
    </script>
    

<script type="text/javascript">
	$(document).ready(function() {
		// make code pretty
		window.prettyPrint && prettyPrint();
		
		if ( window.location.hash ) {
			scrollTo(window.location.hash);
		}
		
		$('.nav').on('click', 'a', function(e) {
			scrollTo($(this).attr('href'));
		});

		$('#multiselect').multiselect();

		$('[name="q"]').on('keyup', function(e) {
			var search = this.value;
			var $options = $(this).next('select').find('option');

			$options.each(function(i, option) {
				if (option.text.indexOf(search) > -1) {
					$(option).show();
				} else {
					$(option).hide();
				}
			});
		});

		$('#search').multiselect({
			search: {
				left: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
				right: '<input type="text" name="q" class="form-control" placeholder="Search..." />',
			}
		});

		$('.multiselect').multiselect();
		$('.js-multiselect').multiselect({
			right: '#js_multiselect_to_1',
			rightAll: '#js_right_All_1',
			rightSelected: '#js_right_Selected_1',
			leftSelected: '#js_left_Selected_1',
			leftAll: '#js_left_All_1'
		});

		$('#keepRenderingSort').multiselect({
			keepRenderingSort: true
		});

		$('#undo_redo').multiselect();

		$('#multi_d').multiselect({
			right: '#multi_d_to, #multi_d_to_2',
			rightSelected: '#multi_d_rightSelected, #multi_d_rightSelected_2',
			leftSelected: '#multi_d_leftSelected, #multi_d_leftSelected_2',
			rightAll: '#multi_d_rightAll, #multi_d_rightAll_2',
			leftAll: '#multi_d_leftAll, #multi_d_leftAll_2',

			moveToRight: function(Multiselect, options, event, silent, skipStack) {
				var button = $(event.currentTarget).attr('id');

				if (button == 'multi_d_rightSelected') {
					var left_options = Multiselect.left.find('option:selected');
					Multiselect.right.eq(0).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
					}
				} else if (button == 'multi_d_rightAll') {
					var left_options = Multiselect.left.find('option');
					Multiselect.right.eq(0).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(0).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(0));
					}
				} else if (button == 'multi_d_rightSelected_2') {
					var left_options = Multiselect.left.find('option:selected');
					Multiselect.right.eq(1).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
					}
				} else if (button == 'multi_d_rightAll_2') {
					var left_options = Multiselect.left.find('option');
					Multiselect.right.eq(1).append(left_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.right.eq(1).eq(1).find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.right.eq(1));
					}
				}
			},

			moveToLeft: function(Multiselect, options, event, silent, skipStack) {
				var button = $(event.currentTarget).attr('id');

				if (button == 'multi_d_leftSelected') {
					var right_options = Multiselect.right.eq(0).find('option:selected');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				} else if (button == 'multi_d_leftAll') {
					var right_options = Multiselect.right.eq(0).find('option');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				} else if (button == 'multi_d_leftSelected_2') {
					var right_options = Multiselect.right.eq(1).find('option:selected');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				} else if (button == 'multi_d_leftAll_2') {
					var right_options = Multiselect.right.eq(1).find('option');
					Multiselect.left.append(right_options);

					if ( typeof Multiselect.callbacks.sort == 'function' && !silent ) {
						Multiselect.left.find('option').sort(Multiselect.callbacks.sort).appendTo(Multiselect.left);
					}
				}
			}
		});
	});
	
	function scrollTo( id ) {
		if ( $(id).length ) {
			$('html,body').animate({scrollTop: $(id).offset().top - 40},'slow');
		}
	}
	</script>