package com.slms.webapp.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.slms.common.AdminConstant;
import com.slms.service.iface.AdminServiceIface;
import com.slms.service.iface.CoursesServiceIface;
import com.slms.service.iface.DashboardServiceIface;
import com.slms.service.iface.OrganisationServiceIface;
import com.slms.service.impl.AdminServiceImpl;
import com.slms.service.impl.CoursesServiceImpl;
import com.slms.service.impl.DashboardServiceImpl;
import com.slms.service.impl.OrganisationServiceImpl;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.KeyValueVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.ReviewVo;
import com.slms.webapp.form.UserVo;

public class OrganizationAction extends ActionSupport implements ModelDriven<OrganisationVo>, ServletResponseAware{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	HttpServletResponse response;
	List<OrganisationVo> organisationList;
	List<OrganisationVo> departmentsList;
	List<OrganisationVo> selectDepartmentsList;
	/*List<OrganisationVo> suggestedDepList;
	List<OrganisationVo> suggestedgroupList;*/
	List<OrganisationVo> groupsList;
	List<OrganisationVo> suggestedContainer;
	OrganisationServiceIface orgServiceIface;
	List<KeyValueVo> paramList;
	List<KeyValueVo> gradeList;
	public List<KeyValueVo> getGradeList() {
		return gradeList;
	}

	public void setGradeList(List<KeyValueVo> gradeList) {
		this.gradeList = gradeList;
	}
	List<ReviewVo> reviewList;
	List<CourseVo> coursesList;
	List<CourseVo> selfCoursesList;
	
	OrganisationVo organisationVo;
	boolean status;
	UserVo loginUser ;
	AdminServiceIface adminService;
	List<UserVo> adminList;
	Logger logger = LoggerFactory.getLogger(OrganizationAction.class);
	
	@Override
	public OrganisationVo getModel() {
		organisationVo = new OrganisationVo();
		return organisationVo;
	}
	
	public String execute(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			orgServiceIface = new OrganisationServiceImpl();
			adminService = new AdminServiceImpl();
			organisationList = orgServiceIface.getOrganisations();
			for(OrganisationVo org :organisationList){
				adminList = adminService.getAdmins(org.getOrganisationId());
				org.setAdminList(adminList);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("execute() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftOrgManagementId");
		request.getSession().setAttribute("subMenu", "1");
		return SUCCESS;
	}
	
	
	public String saveOrganisation(){
		try {
			orgServiceIface = new OrganisationServiceImpl();
			status = orgServiceIface.saveOrganisation(organisationVo);
			if(status){
				String[] iconName =organisationVo.getLogoFileName().split("\\.");
		 		File orgLogo = new File(AdminConstant.ORG_LOGO_PATH,organisationVo.getLogoFileName()+"."+iconName[1]);
		 		FileUtils.copyFile(organisationVo.getLogo(), orgLogo);
		 		
			new DashboardAction().execute();
				addActionMessage(organisationVo.getOrganisationName()+" Added Successfully");
			}else{
				addActionMessage(organisationVo.getOrganisationName()+" Already Exist.");
			}
			organisationList = orgServiceIface.getOrganisations();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveOrganisation() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String department(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
			orgServiceIface = new OrganisationServiceImpl();
			departmentsList = orgServiceIface.getDepartments(loginUser.getOrganisationId());
			 }
			 suggestedContainer =  orgServiceIface.getContainerSessions(loginUser, "");
			 UserVo user = new UserVo();
			 user.setDepartmentId(departmentsList.get(0).getDepartmentId());
			 groupsList =  orgServiceIface.getContainerSessions(user, "");
			 suggestedContainer.removeAll(groupsList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("department() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftDepartmentId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String getDepartmentContainer(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 orgServiceIface = new OrganisationServiceImpl();
			
			 suggestedContainer =  orgServiceIface.getContainerSessions(loginUser, "");
			 UserVo user = new UserVo();
			 user.setDepartmentId(organisationVo.getDepartmentId());
			 groupsList =  orgServiceIface.getContainerSessions(user, "");
			 suggestedContainer.removeAll(groupsList);
			 }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("department() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftDepartmentId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String saveDepartment(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			orgServiceIface = new OrganisationServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			status = orgServiceIface.saveDepartment(organisationVo,loginUser.getUserId());
			if(status){
				new DashboardAction().execute();
					addActionMessage(organisationVo.getDepartmentName()+" Added Successfully");
				}else{
					addActionMessage(organisationVo.getDepartmentName()+" Already Exist.");
				}
			 departmentsList = orgServiceIface.getDepartments(organisationVo.getOrganisationId());
			 suggestedContainer =  orgServiceIface.getContainerSessions(loginUser, "");
			 UserVo user = new UserVo();
			 user.setDepartmentId(departmentsList.get(0).getDepartmentId());
			 groupsList =  orgServiceIface.getContainerSessions(user, "");
			 suggestedContainer.removeAll(groupsList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveDepartment() : "+e.getMessage());
		}
		
		return SUCCESS;
	}
	
	public String mapDepCourseContainer(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			orgServiceIface = new OrganisationServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			status = orgServiceIface.mapDepCourseContainer(organisationVo,loginUser);
			if(status){
					addActionMessage("Mapped Successfully");
				}else{
					addActionMessage("Problem in mapping.");
				}
			 organisationVo.setOrganisationId(loginUser.getOrganisationId());
			 departmentsList = orgServiceIface.getDepartments(organisationVo.getOrganisationId());
			 suggestedContainer =  orgServiceIface.getContainerSessions(loginUser, "");
			 UserVo user = new UserVo();
			 user.setDepartmentId(departmentsList.get(0).getDepartmentId());
			 groupsList =  orgServiceIface.getContainerSessions(user, "");
			 suggestedContainer.removeAll(groupsList);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveDepartment() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	
	
	public String group(){
		HttpServletRequest request= ServletActionContext.getRequest();
		CoursesServiceIface coursesServiceIface  = new CoursesServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			orgServiceIface = new OrganisationServiceImpl();
			/*List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");*/
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 if(loginUser.getUserType()==1){
					 /*selectDepartmentsList = organisationList.get(0).getDepartmentList();
					 groupsList = orgServiceIface.getGroups(loginUser.getOrganisationId(),organisationVo.getDepartmentId());*/
					 coursesList = orgServiceIface.getOrgCourseList(loginUser);
					 /*selfCoursesList = new ArrayList<CourseVo>();
					 coursesList = new ArrayList<CourseVo>();
					 int x=courses.size();
					 for(int i=0;i<x;i++){
						 CourseVo course = courses.get(i);
						 if(course.getCourseType().equalsIgnoreCase("1")){
							 selfCoursesList.add(course);
						 }else{
							 coursesList.add(course);
						 }
					 }*/
					 groupsList = orgServiceIface.getOrgCourseContainerNames(loginUser);
					 for(CourseVo course :coursesList){
						 List<OrganisationVo> sessionList = orgServiceIface.getContainerSessions(loginUser, course.getCourseName());
						 course.setGroupList(sessionList);
					 }
				 }
				 
				
			 }
			/*suggestedgroupList = orgServiceIface.getNewGroup();*/
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("group() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftGroupId");
		request.getSession().setAttribute("subMenu", "3");
		return SUCCESS;
	}
	
	public String saveGroup(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			orgServiceIface = new OrganisationServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 organisationVo.setDepartmentId(loginUser.getDepartmentId());
			status = orgServiceIface.saveGroup(organisationVo,loginUser.getUserId());
			if(status){
				new DashboardAction().execute();
					addActionMessage(organisationVo.getGroupName()+" Added Successfully");
				}else{
					addActionMessage(organisationVo.getGroupName()+" Already Exist.");
				}
					coursesList = orgServiceIface.getOrgCourseList(loginUser);
				/* selfCoursesList = new ArrayList<CourseVo>();
				 coursesList = new ArrayList<CourseVo>();
				 int x=courses.size();
				 for(int i=0;i<x;i++){
					 CourseVo course = courses.get(i);
					 if(course.getCourseType().equalsIgnoreCase("1")){
						 selfCoursesList.add(course);
					 }else{
						 coursesList.add(course);
					 }
				 }*/
					for(CourseVo course :coursesList){
							groupsList = orgServiceIface.getGroups(organisationVo.getOrganisationId(),organisationVo.getDepartmentId(),course.getCourseId());
							course.setGroupList(groupsList);
					}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveGroup() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public void getDepartment(){
		try {
			 HttpServletRequest request= ServletActionContext.getRequest();
			 int orgId = Integer.parseInt(request.getParameter("organisationId"));
			// int orgId = organisationVo.getOrganisationId();
			 organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 if(organisationList !=null){
				 for(OrganisationVo org : organisationList){
					 if(org.getOrganisationId()==orgId){
						 JSONArray jsonArr = new JSONArray();
						 for(OrganisationVo dep : org.getDepartmentList()){
							 JSONObject jsonObj = new JSONObject();
							 jsonObj.put("departmentId", dep.getDepartmentId());
							 jsonObj.put("departmentName", dep.getDepartmentName());
							 jsonArr.put(jsonObj);
						 }
						 response.getWriter().print(jsonArr);
						 break;
					 }
					 
				 }
				 
			 }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("getDepartment() : "+e.getMessage());
		}
	}
	
	
	public void getGroups(){
		try {
			 HttpServletRequest request= ServletActionContext.getRequest();
			 int orgId = organisationVo.getOrganisationId();
			 int depId = organisationVo.getDepartmentId();
			 organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 if(organisationList !=null){
				 for(OrganisationVo org : organisationList){
					 if(org.getOrganisationId()==orgId){
						 for(OrganisationVo dep : org.getDepartmentList()){
							 if(dep.getDepartmentId()==depId){
								 JSONArray jsonArr = new JSONArray();
								 for(OrganisationVo group : dep.getGroupList()){
									 JSONObject jsonObj = new JSONObject();
									 jsonObj.put("groupId", group.getGroupId());
									 jsonObj.put("groupName", group.getGroupName());
									 jsonArr.put(jsonObj);
								 }
								 response.getWriter().print(jsonArr);
								 break;
							 }
						 }
						
					 }
					 
				 }
				 
			 }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("getGroups() : "+e.getMessage());
		}
	}

	public String reviewParameter(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			orgServiceIface = new OrganisationServiceImpl();
			//reviewList = orgServiceIface.getReviewParameter(loginUser.getOrganisationId());
			paramList = orgServiceIface.getParamValue(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("reviewParameter() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftReviewParamId");
		request.getSession().setAttribute("subMenu", "3");
		return SUCCESS;
	}
	
	public String getParamValue(){
		try {
			orgServiceIface = new OrganisationServiceImpl();
			paramList = orgServiceIface.getParamValue(organisationVo.getOrganisationId());
			reviewList = orgServiceIface.getReviewParameter(organisationVo.getOrganisationId());
			/*JSONArray jsonArr = new JSONArray();
			if(paramList !=null && paramList.size()>0){
				for(KeyValueVo kv :paramList){
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("value", kv.getValue());
					jsonObj.put("key", kv.getKey());
					jsonArr.put(jsonObj);
				}
			}
			response.getWriter().print(jsonArr);*/
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("getParamValue() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public void getReviewValue(){
		try {
			HttpServletRequest request= ServletActionContext.getRequest();
			int paramId = Integer.parseInt(request.getParameter("paramId"));
			orgServiceIface = new OrganisationServiceImpl();
			paramList = orgServiceIface.getReviewValue(paramId);
			JSONArray jsonArr = new JSONArray();
			if(paramList !=null && paramList.size()>0){
				for(KeyValueVo kv :paramList){
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("value", kv.getValue());
					jsonObj.put("key", kv.getKey());
					jsonArr.put(jsonObj);
				}
			}
			response.getWriter().print(jsonArr);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("getReviewValue() : "+e.getMessage());
		}
	}
	
	public String saveReviewParameter(){
		try {
			int paramId =0;
			int orgId=0;
			
			orgServiceIface = new OrganisationServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			String param = request.getParameter("param");
			String value = request.getParameter("value");
			String paramIds = request.getParameter("paramId");
			String orgIds = request.getParameter("organisationId");
			if(orgIds !=null){
				orgId= Integer.parseInt(orgIds);
			}
			if(paramIds == null){
				status = orgServiceIface.saveParamAndValue(orgId,param,value);
				if(status){
					addActionMessage(param+" Added Successfully");
				}else{
					addActionMessage("Already Exist.");
				}
				
			}
			if(paramIds !=null){
				paramId =Integer.parseInt(paramIds);
				status = orgServiceIface.saveParamValue(paramId,value);
				if(status){
					addActionMessage(value+" Added Successfully");
				}else{
					addActionMessage("Already Exist.");
				}
			}
			reviewList = orgServiceIface.getReviewParameter(organisationVo.getOrganisationId());
			paramList = orgServiceIface.getParamValue(orgId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveReviewParameter() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String saveParam(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
			int paramId =0;
			
			orgServiceIface = new OrganisationServiceImpl();
			String param = request.getParameter("param");
			paramId = Integer.parseInt(request.getParameter("paramId"));
			paramList = orgServiceIface.saveParam(loginUser,paramId,param);
		  }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveReviewParameter() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String grade(){
		HttpServletRequest request= ServletActionContext.getRequest();
		orgServiceIface = new OrganisationServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			gradeList = orgServiceIface.getGrade(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveReviewParameter() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftReviewParamId");
		request.getSession().setAttribute("subMenu", "4");
		return SUCCESS;
	}
	
	public String saveGrade(){
		HttpServletRequest request= ServletActionContext.getRequest();
		orgServiceIface = new OrganisationServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 	String grade = request.getParameter("grade");
				 	String value = request.getParameter("value");
					int gradeId = Integer.parseInt(request.getParameter("gradeId"));
				 status = orgServiceIface.saveGrade(loginUser,gradeId,grade,value);
				 gradeList = orgServiceIface.getGrade(loginUser.getOrganisationId());
		  }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("saveReviewParameter() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String activeDeactive(){
		int id=0;
		String flag="";
		String contentType="";
		DashboardServiceIface dashboardServiceIface = new DashboardServiceImpl();
		HttpServletRequest request = ServletActionContext.getRequest();
		try {
			
			orgServiceIface = new OrganisationServiceImpl();
			String sid = request.getParameter("id");
			flag = request.getParameter("flag");
			contentType = request.getParameter("contentType");
			if(sid!=null){
				id=Integer.parseInt(sid);
			}
			if(id>0 && flag!=null &&  contentType!=null){
				orgServiceIface.activeDeactive(id,flag,contentType);
			}
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("activeDeactive() : "+e.getMessage());
		}
		organisationList = dashboardServiceIface.getMasterData();
		request.getSession().setAttribute("organisationList", organisationList);
		if(contentType.equalsIgnoreCase("org")){
			execute();
			return "org";
		}else if(contentType.equalsIgnoreCase("dep")){
			department();
			return "dep";
		}else{
			group();
			return "group";
		}
	}
	
	public String updateDepartment(){
			HttpServletRequest request = ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			try {
				orgServiceIface = new OrganisationServiceImpl();
				status = orgServiceIface.updateDepartment(organisationVo,loginUser.getUserId());
				if(status){
				new DashboardAction().execute();
					addActionMessage(organisationVo.getDepartmentName()+" Successfully Updated");
				}
				departmentsList = orgServiceIface.getDepartments(organisationVo.getOrganisationId());
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("updateDepartment() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	
		public String updateGroup(){
			HttpServletRequest request = ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			try {
				orgServiceIface = new OrganisationServiceImpl();
				status = orgServiceIface.updateGroup(organisationVo,loginUser.getUserId());
				if(status){
				new DashboardAction().execute();
					addActionMessage("Successfully Updated");
				}
				//groupsList = orgServiceIface.getGroups(organisationVo.getOrganisationId(),organisationVo.getDepartmentId(), );
				
			} catch (Exception e) {
				e.printStackTrace();
				logger.error("updateGroup() : "+e.getMessage());
			}
		return SUCCESS;
	}
		
	
	public String updateOrg(){
		HttpServletRequest request = ServletActionContext.getRequest();
		loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
		try {
			orgServiceIface = new OrganisationServiceImpl();
			status = orgServiceIface.updateOrg(organisationVo,loginUser.getUserId());
			if(status){
			new DashboardAction().execute();
				addActionMessage("Successfully Updated");
			}
			organisationList = orgServiceIface.getOrganisations();
			adminService = new AdminServiceImpl();
			for(OrganisationVo org :organisationList){
				adminList = adminService.getAdmins(org.getOrganisationId());
				org.setAdminList(adminList);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("updateOrg() : "+e.getMessage());
		}
	return SUCCESS;
}
	public String deleteParameter(){
		try {
			HttpServletRequest request = ServletActionContext.getRequest();
			int paramId = Integer.parseInt(request.getParameter("paramId"));
			int valueId = Integer.parseInt(request.getParameter("valueId"));
			int organisationId = Integer.parseInt(request.getParameter("organisationId"));
			orgServiceIface = new OrganisationServiceImpl();
			status = orgServiceIface.deleteParameter(paramId,valueId);
			if(status){
				addActionMessage("Successfully Deleted");
			}
			reviewList = orgServiceIface.getReviewParameter(organisationId);
			paramList = orgServiceIface.getParamValue(organisationId);
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("deleteParameter() : "+e.getMessage());
		}
	return SUCCESS;
}
	
	
	public String mapStudnet(){
		HttpServletRequest request= ServletActionContext.getRequest();
		CoursesServiceIface coursesServiceIface  = new CoursesServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			orgServiceIface = new OrganisationServiceImpl();
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 if(loginUser.getUserType()==1){
					 /*selectDepartmentsList = organisationList.get(0).getDepartmentList();
					 groupsList = orgServiceIface.getGroups(loginUser.getOrganisationId(),organisationVo.getDepartmentId());*/
					 coursesList = orgServiceIface.getOrgCourseList(loginUser);
					 /*selfCoursesList = new ArrayList<CourseVo>();
					 coursesList = new ArrayList<CourseVo>();
					 int x=courses.size();
					 for(int i=0;i<x;i++){
						 CourseVo course = courses.get(i);
						 if(course.getCourseType().equalsIgnoreCase("1")){
							 selfCoursesList.add(course);
						 }else{
							 coursesList.add(course);
						 }
					 }*/
					 groupsList = orgServiceIface.getOrgCourseContainerNames(loginUser);
					 for(CourseVo course :coursesList){
						 List<OrganisationVo> sessionList = orgServiceIface.getContainerSessions(loginUser, course.getCourseName());
						 course.setGroupList(sessionList);
					 }
				 }
				 
				
			 }
			/*suggestedgroupList = orgServiceIface.getNewGroup();*/
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("group() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	
	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		response=arg0;
	}


	/**
	 * @return the organisationList
	 */
	public List<OrganisationVo> getOrganisationList() {
		return organisationList;
	}


	/**
	 * @param organisationList the organisationList to set
	 */
	public void setOrganisationList(List<OrganisationVo> organisationList) {
		this.organisationList = organisationList;
	}

	/**
	 * @return the departmentsList
	 */
	public List<OrganisationVo> getDepartmentsList() {
		return departmentsList;
	}

	/**
	 * @param departmentsList the departmentsList to set
	 */
	public void setDepartmentsList(List<OrganisationVo> departmentsList) {
		this.departmentsList = departmentsList;
	}

	/**
	 * @return the groupsList
	 */
	public List<OrganisationVo> getGroupsList() {
		return groupsList;
	}

	/**
	 * @param groupsList the groupsList to set
	 */
	public void setGroupsList(List<OrganisationVo> groupsList) {
		this.groupsList = groupsList;
	}

	/**
	 * @return the organisationVo
	 */
	public OrganisationVo getOrganisationVo() {
		return organisationVo;
	}

	/**
	 * @param organisationVo the organisationVo to set
	 */
	public void setOrganisationVo(OrganisationVo organisationVo) {
		this.organisationVo = organisationVo;
	}

	/**
	 * @return the reviewList
	 */
	public List<ReviewVo> getReviewList() {
		return reviewList;
	}

	/**
	 * @param reviewList the reviewList to set
	 */
	public void setReviewList(List<ReviewVo> reviewList) {
		this.reviewList = reviewList;
	}

	public List<KeyValueVo> getParamList() {
		return paramList;
	}

	public void setParamList(List<KeyValueVo> paramList) {
		this.paramList = paramList;
	}

	public List<OrganisationVo> getSelectDepartmentsList() {
		return selectDepartmentsList;
	}

	public void setSelectDepartmentsList(List<OrganisationVo> selectDepartmentsList) {
		this.selectDepartmentsList = selectDepartmentsList;
	}

	public List<CourseVo> getCoursesList() {
		return coursesList;
	}

	public void setCoursesList(List<CourseVo> coursesList) {
		this.coursesList = coursesList;
	}

	public List<CourseVo> getSelfCoursesList() {
		return selfCoursesList;
	}

	public void setSelfCoursesList(List<CourseVo> selfCoursesList) {
		this.selfCoursesList = selfCoursesList;
	}

	public List<OrganisationVo> getSuggestedContainer() {
		return suggestedContainer;
	}

	public void setSuggestedContainer(List<OrganisationVo> suggestedContainer) {
		this.suggestedContainer = suggestedContainer;
	}

}
