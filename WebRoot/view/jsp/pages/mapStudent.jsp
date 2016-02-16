<div class="mainpanel"> 
    
      
    <div class="contentpanel">
      		
            <ol class="breadcrumb breadcrumb-quirk">
                <li><a href="index.html"><i class="fa fa-home mr5"></i> Home</a></li> 
                <li><a href="#"><i class="fa fa-book mr5"></i> Course Sessions</a></li>            
            </ol> 
           <div class="pull-right org_name">Scolere</div>    
                 
           <div class="panel" id="ccc">
            <div class="panel-heading">
              <div class="row">
              	<div class="col-sm-12 col-md-12">
                	<button type="button" class="bttn" onclick="window.history.back('course_container.html')">Go back to Course session</button>
                </div>
              </div>
              
            </div>
            
           <!-- <div class="panel-body">
            	            
            </div>-->
          </div> 
          
          <div class="panel">
          	<div class="panel-body">
          		<div class="row">
                	<div class="form-group col-sm-9">
                    	<select class="form-control selectpicker" data-live-search="true" title="Select Course" id="courseSelect">
                            <option value="0">Select Course</option>
                            <option value="1">Learning</option>
                            <option value="2">Management</option>
                            <option value="3">Sales</option>
                            <option value="4">Introduction to sales</option>
                            <option value="5">Leadership Selling Ignite</option>
                        </select>
                    </div>
                    <div class="form-group col-sm-3">
                    	<select class="form-control" onChange="return Show_selectDiv(this);" id="selectId">
                            <option value="0">Select Date</option>
                            <option value="1">01/18/2016</option>
                            <option value="2">01/19/2016</option>
                            <option value="3">01/20/2016</option>
                            <option value="4">01/20/2016</option>
                            <option value="5">01/20/2016</option> 
                        </select>
                    </div>
                    <div class="col-sm-12" style="display:none" id="lefttoright">
                                     	<div class="row">
                                            <div class="form-group col-xs-5">
                                            <p> Unassigned Students </p>
                                                <select name="from[]" id="search" class="form-control ofy ht350" multiple="multiple">
                                               		<option value='1'>Yoda</option>                                                    
                                                    <option value='2'>Bill</option>
                                                    <option value='3'>Linda</option>
                                                    <option value='4'>George</option>
                                                    <option value='5'>Bella</option>
                                                    <option value='6'>Harry</option>
                                                    <option value='7'>George</option>
                                                    <option value='8'>Peter</option>
                                                    <option value='9'>John</option>
                                                    <option value='10'>Hannah</option>
                                                    <option value='11'>Lily</option>
                                                    <option value='12'>Emma</option>
                                                    <option value='13'>Sophia</option>
                                                    <option value='14'>Ava</option>
                                                    <option value='15'>Mia</option>
                                                    <option value='16'>Jasmine</option>
                                                    <option value='17'>Avalon</option>
                                                    <option value='18'>Adam</option>
                                                    <option value='19'>Daniel</option>
                                                    <option value='20'>Sammule</option>
                                                 </select>
                                            </div>
                                            
                                            <div class=" form-group col-xs-2">
                                             <p class="text-center"> Action </p>
                                                <button type="button" id="search_rightAll" class="btn btn-block" title="Move all to right"><i class="glyphicon glyphicon-forward"></i></button>
                                                <button type="button" id="search_rightSelected" class="btn btn-block" title="Move selected to right"><i class="glyphicon glyphicon-chevron-right"></i></button>
                                                <button type="button" id="search_leftSelected" class="btn btn-block" title="Move selected to left"><i class="glyphicon glyphicon-chevron-left"></i></button>
                                                <button type="button" id="search_leftAll" class="btn btn-block" title="Move all to left"><i class="glyphicon glyphicon-backward"></i></button>
                                            </div>
                                            
                                            <div class="form-group col-xs-5">
                                             <p> Assigned Students</p>
                                                <select name="to[]" id="search_to" class="form-control ofy ht350" multiple="multiple">
                                                 <option value='1'>Jack</option>
                                                </select>
                                               
                                            </div>
                                            
                                        </div> 
                                        <button type="button" class="bttn">SAVE</button>
                                        <button type="button" class="bttn" onClick="return enable_Div();" id="enable">CANCEL</button>

                                    </div>
                </div>
            </div>
          </div>
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel --> 
  
</section>
<script src="js/jquery.js"></script>
<script src="js/bootstrap.js"></script>
<script src="js/bootstrap-select.min.js"></script>
<script src="js/multiselect.min.js"></script>
<script src="js/prettify.min.js"></script>


<script type="text/javascript">


	
	function Show_selectDiv(elem) {
			if(elem.value==0){
			document.getElementById('lefttoright').style.display = "none";
			}
			else if(elem.value==1){
			document.getElementById('lefttoright').style.display = "block";
			document.getElementById('selectID').disabled = true;
			document.getElementById('courseSelect').disabled = true;
			}
			else if(elem.value==2){
			document.getElementById('lefttoright').style.display = "block";
			document.getElementById('selectID').disabled = true;
			document.getElementById('courseSelect').disabled = true;
			}
			else if(elem.value==3){
			document.getElementById('lefttoright').style.display = "block";
			document.getElementById('selectID').disabled = true;
			document.getElementById('courseSelect').disabled = true;
			}
			else if(elem.value==4){
			document.getElementById('lefttoright').style.display = "block";
			document.getElementById('selectID').disabled = true;
			document.getElementById('courseSelect').disabled = true;
			}
			else if(elem.value==5){
			document.getElementById('lefttoright').style.display = "block";
			document.getElementById('selectID').disabled = true;
			document.getElementById('courseSelect').disabled = true;
			}
			
		}
		function enable_Div() {
			
			document.getElementById('selectID').disabled = false;
			document.getElementById('courseSelect').disabled = false;
			
		}
		
    </script>
    <script type="text/javascript">
		$(document).ready(function(){
		 $("#selectId").change(function() {
		  $("#selectId").attr('disabled', true);
		  $("#courseSelect").attr('disabled', true);
		 });
		
		 $("#enable").click(function(){
		 	 $("select").attr('disabled', false);
			 $("#courseSelect").attr('disabled', false);
		 });
		});
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