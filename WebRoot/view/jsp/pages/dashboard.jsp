 <%@ taglib prefix="s" uri="/struts-tags"%>

<div class="mainpanel"> 
    
    <!--<div class="pageheader">
      <h2><i class="fa fa-home"></i> Dashboard</h2>
    </div>-->
    
    <div class="contentpanel">
      <div class="row">
        <div class="col-md-12 col-lg-8 dash-left">
          
          <!-- panel --> 
          
          <!-- panel -->
          
          <div class="row panel-statistics" id="bdx">
            <s:if test="#session.loginDetail !=null && #session.loginDetail.userType==4">
            <div class="col-sm-6">
              <div class="panel panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-success">Total Number of Organizations</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalOrganisations}</h3>                      
                     <!--  <p>just 9500 school to limit</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                      	<img src="view/helper/images/school.png" class="img-responsive">
                    </div>
                  </div>
                </div>
              </div>
              <!-- panel --> 
            </div>
            
            <div class="col-sm-6">
              <div class="panel panel-danger-full panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-warning">Total Courses</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalCourses}</h3>
                      
                      <!-- <p>Last Year 20 Course Upgrade</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                      <i class="fa fa-book"></i>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
              <div class="col-sm-6 margin30">
              <div class="panel panel-success-full panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-success">Total Number of Coach</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalTeachers}</h3>
                      
                      <!-- <p>Last Year 200 Techer..</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                    	<i class="fa fa-users"></i>                      
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <div class="col-sm-6">
              <div class="panel panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-danger">Total Number of Students</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalStudents}</h3>
                      
                      <!-- <p>Last Year Admission: 2250</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                     	 <i class="fa fa-users"></i> 
                    </div>
                  </div>
                </div>
              </div>
              <!-- panel --> 
            </div>
            </s:if>
            <s:else>
            <div class="col-sm-6">
            <a href="department">
              <div class="panel panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <img style="float: left; width: 100px;" src="view/helper/images/richmond.png" class="img-responsive">
                  </div>
                </div>
              </div></a>
              <!-- panel --> 
            </div>
            <!-- Total Course Start  -->
            <a href="courseManagement">
            <div class="col-sm-6">
              <div class="panel panel-danger-full panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-warning">Total Courses</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalCourses}</h3>
                      
                      <!-- <p>Last Year 20 Course Upgrade</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                      <i class="fa fa-book"></i>
                    </div>
                  </div>
                </div>
              </div>
              <!-- panel --> 
            </div></a>
            <!-- Total Course Ends  -->
            
             <!-- Total Coach Start-->
             <a href="teacherManagment">
            <div class="col-sm-6 margin30">
              <div class="panel panel-success-full panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-success">Total Number of Coach</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalTeachers}</h3>
                      
                      <!-- <p>Last Year 200 Techer..</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                    	<i class="fa fa-users"></i>                      
                    </div>
                  </div>
                </div>
              </div>
              <!-- panel --> 
            </div></a>
             <!-- Total Coach Ends  -->
           

            <a href="students">
            <div class="col-sm-6">
              <div class="panel panel-updates">
                <div class="panel-body">
                  <div class="row">
                    <div class="col-xs-7 col-lg-8">
                      <h4 class="panel-title text-danger">Total Number of Students</h4>
                      <h3 style="margin-top: 30px;">${dashboardVo.totalStudents}</h3>
                      
                      <!-- <p>Last Year Admission: 2250</p> -->
                    </div>
                    <div class="col-xs-5 col-lg-4 text-right">
                     	 <i class="fa fa-users"></i> 
                    </div>
                  </div>
                </div>
              </div>
              <!-- panel --> 
            </div></a>
             </s:else>
            
          </div>
          <!-- row --> 
          <!-- <div class="col-md-12">
          	<div class="panel">
            <div class="panel-heading">
              <h4 class="panel-title">Line Chart</h4>
              <p>A line graph is a type of chart which displays information as a series of data points connected by straight line segments.</p>
            </div>
            <div class="panel-body">
              <div id="line-chart" class="body-chart"></div>
            </div>
          </div>
          </div> -->
          
          
        </div>
      </div>
      <!-- row --> 
      
    </div>
    <!-- contentpanel --> 
    
  </div>
  <!-- mainpanel -->  
  