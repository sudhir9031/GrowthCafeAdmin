package com.slms.webapp.controller;

import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.Enumeration;
import java.util.List;

import javax.imageio.ImageIO;
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
import com.slms.service.iface.CoursesServiceIface;
import com.slms.service.impl.CoursesServiceImpl;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public class CoursesAction extends ActionSupport implements ModelDriven<CourseVo>, ServletResponseAware{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	CoursesServiceIface coursesServiceIface;
	List<CourseVo> coursesList;
	List<CourseVo> orgCoursesList;
	List<CourseVo> adminCoursesList;
	List<CourseVo> moduleList;
	List<CourseVo> assList;
	CourseVo courseVo;
	HttpServletResponse response;
	boolean status;
	UserVo loginUser;
	List<OrganisationVo> selectDepartmentsList;
	Logger logger = LoggerFactory.getLogger(CoursesAction.class);
	private static final int IMG_WIDTH = 20;
	private static final int IMG_HEIGHT = 20;
	
	@Override
	public CourseVo getModel() {
		courseVo = new CourseVo();
		return courseVo;
	}
	
	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		response=arg0;
		
	}
	
	public String execute(){
		coursesServiceIface = new CoursesServiceImpl();
		HttpServletRequest request= ServletActionContext.getRequest();
		 
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 if(loginUser.getUserType()==4){
					 if(courseVo.getOrganisationId()>0){
						 orgCoursesList = coursesServiceIface.getCourseList(courseVo.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser.getUserType(),loginUser.getEmail());
					 }else{
						 coursesList = coursesServiceIface.getCourseList(courseVo.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser.getUserType(),loginUser.getEmail());
					 }
				 }else{
					 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
					 if(courseVo.getDepartmentId()==0){
						 selectDepartmentsList = organisationList.get(0).getDepartmentList(); 
					 }
					 coursesList = coursesServiceIface.getCourseList(loginUser.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser.getUserType(),loginUser.getEmail());
				 }
			 }
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("execute() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftCorserManagementId");
		return SUCCESS;
	}
	
	public void getCourses(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try{
			coursesServiceIface = new CoursesServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 coursesList = coursesServiceIface.getCourseList(courseVo.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser.getUserType(),loginUser.getEmail());
				 if(coursesList !=null && coursesList.size()>0){
					 JSONArray jsonArr = new JSONArray();
					 for(CourseVo course : coursesList){
								 JSONObject jsonObj = new JSONObject();
								 jsonObj.put("courseId", course.getCourseId());
								 jsonObj.put("courseName", course.getCourseName());
								 jsonArr.put(jsonObj);
						 }
					 response.getWriter().print(jsonArr);
					 }
			 }
			 
			}catch (Exception e) {
				e.printStackTrace();
				logger.error("getCourses() : "+e.getMessage());
			}
		
	}
	
	public void getOrgCourse(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try{
			coursesServiceIface = new CoursesServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 if(courseVo.getOrganisationId()>0){
					 orgCoursesList = coursesServiceIface.getOrgCourses(courseVo.getOrganisationId());
				 }else{
					 coursesList = coursesServiceIface.getOrgCourses(courseVo.getOrganisationId());
				 }
			 }
			 
			}catch (Exception e) {
				e.printStackTrace();
				logger.error("getOrgCourse() : "+e.getMessage());
			}
	}
	
	public String mapOrgCourse(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try{
			coursesServiceIface = new CoursesServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 status = coursesServiceIface.mapOrgCourse(courseVo.getOrganisationId(),courseVo.getCourseId());
				 if(status){
					 addActionMessage("Successfully Mapped");
				 }
				 coursesList = coursesServiceIface.getOrgCourses(0);
			 }
			 
			}catch (Exception e) {
				e.printStackTrace();
				logger.error("mapOrgCourse() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	
	
	public String saveCourse(){
		try{
		coursesServiceIface = new CoursesServiceImpl();
		HttpServletRequest request= ServletActionContext.getRequest();
		loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
		 if(loginUser==null){
			 return LOGIN;
		 }
		 	if(courseVo.getCourseId()==0){
			 	status = coursesServiceIface.saveCourse(courseVo,loginUser);
			 	if(status){
			 		String[] iconName =courseVo.getCourseIconFileName().split("\\.");
			 		File coursIcon = new File(AdminConstant.COURSE_ICON,courseVo.getCourseName()+"."+iconName[1]);
			 		FileUtils.copyFile( courseVo.getCourseIcon(), coursIcon);
			 		
			 		BufferedImage originalImage = ImageIO.read(courseVo.getCourseIcon());
			 		int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
			 		
			 		BufferedImage resizeImageJpg = resizeImage(originalImage, type);
					ImageIO.write(resizeImageJpg, "jpg", new File(AdminConstant.RESIZE_COURSE_ICON+courseVo.getCourseName()+".jpg")); 
						
					BufferedImage resizeImagePng = resizeImage(originalImage, type);
					ImageIO.write(resizeImagePng, "png", new File(AdminConstant.RESIZE_COURSE_ICON+courseVo.getCourseName()+".png")); 
				
			 	 
					 addActionMessage(courseVo.getCourseName()+" Added Successfully");
				 }else{
					 addActionMessage(courseVo.getCourseName()+" Already Exist");
				 }
		 	}else{
		 		status = coursesServiceIface.updateCourse(courseVo,loginUser);
		 		if(status){
					 addActionMessage(courseVo.getCourseName()+" Updated Successfully");
				 }
		 	}
		 	if(loginUser.getUserType()==1){
		 		courseVo.setOrganisationId(loginUser.getOrganisationId());
		 	}
		 coursesList = coursesServiceIface.getCourseList(courseVo.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser.getUserType(),loginUser.getEmail());
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("saveCourse() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	/* Method to resize the image */
	
	private static BufferedImage resizeImage(BufferedImage originalImage, int type){
		BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();
			
		return resizedImage;
	    }
	
	
	public String saveModule(){
		try{
		coursesServiceIface = new CoursesServiceImpl();
		HttpServletRequest request= ServletActionContext.getRequest();
		loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
		 if(loginUser==null){
			 return LOGIN;
		 }
		status = coursesServiceIface.saveModule(courseVo,loginUser.getUserId(),loginUser.getUserType());
		 moduleList = coursesServiceIface.getModules(courseVo.getCourseId());
		 if(status){
			 addActionMessage(courseVo.getModuleName()+" Added Successfully");
		 }else{
			 addActionMessage(courseVo.getModuleName()+" Already Exist");
		 }
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("saveModule() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String updatModule(){
		try{
		coursesServiceIface = new CoursesServiceImpl();
		HttpServletRequest request= ServletActionContext.getRequest();
		loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
		 if(loginUser==null){
			 return LOGIN;
		 }
		 status = coursesServiceIface.updatModule(courseVo,loginUser);
		 moduleList = coursesServiceIface.getModules(courseVo.getCourseId());
		 if(status){
			 addActionMessage(courseVo.getModuleName()+" Updated Successfully");
		 }
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("updatModule() : "+e.getMessage());
		}
		return SUCCESS;
	}
	

	
	public void getCourseChoice(){
		try{
		coursesServiceIface = new CoursesServiceImpl();
		 HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 coursesList = coursesServiceIface.getCourseChoiceList(courseVo.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser);
			 }
		 if(coursesList !=null && coursesList.size()>0){
			 JSONArray jsonArr = new JSONArray();
			 for(CourseVo course : coursesList){
						 JSONObject jsonObj = new JSONObject();
						 jsonObj.put("courseId", course.getCourseId());
						 jsonObj.put("courseName", course.getCourseName());
						 jsonArr.put(jsonObj);
				 }
			 response.getWriter().print(jsonArr);
			 }
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("getCourseChoice() : "+e.getMessage());
		}
	}
	
	
	public void getModule(){
		try{
		coursesServiceIface = new CoursesServiceImpl();
		moduleList = coursesServiceIface.getModules(courseVo.getCourseId());
		 if(moduleList !=null && moduleList.size()>0){
			 JSONArray jsonArr = new JSONArray();
			 for(CourseVo module : moduleList){
				 		if(module.getStatus()==0){
						 JSONObject jsonObj = new JSONObject();
						 jsonObj.put("moduleId", module.getModuleId());
						 jsonObj.put("moduleName", module.getModuleName());
						 jsonArr.put(jsonObj);
				 		}
				 }
			 response.getWriter().print(jsonArr);
			 }
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("getModule() : "+e.getMessage());
		}
	}
	
	public String module(){
			HttpServletRequest request = ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 coursesServiceIface = new CoursesServiceImpl();
			 if(courseVo.getCourseId()==0){
			 coursesList = coursesServiceIface.getActiveCourseList();
			 }
			 moduleList = coursesServiceIface.getModules(courseVo.getCourseId());
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("module() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftCorserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String assignment(){
			HttpServletRequest request = ServletActionContext.getRequest();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 coursesServiceIface = new CoursesServiceImpl();
			 if(courseVo.getCourseId()==0){
				 coursesList = coursesServiceIface.getActiveCourseList();
				 }
			 assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());
			 CourseVo cour = coursesServiceIface.getNames(courseVo.getCourseId(),courseVo.getModuleId());
			 courseVo.setCourseName(cour.getCourseName());
			 courseVo.setModuleName(cour.getModuleName());
			 request.getSession().setAttribute("currentAss", courseVo);
			 
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("assignment() :"+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String saveAssignment(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 status = coursesServiceIface.saveAssignment(courseVo,loginUser.getUserId(),loginUser.getUserType());
			if(status){
				addActionMessage(courseVo.getAssignmentName()+" Added Successfully");				
			}else{
				addActionMessage(courseVo.getAssignmentName()+" Already Exist.");	
			}
			CourseVo cou = (CourseVo) request.getSession().getAttribute("currentAss");
			courseVo.setCourseId(cou.getCourseId());
			courseVo.setModuleId(cou.getModuleId());
			courseVo.setCourseName(cou.getCourseName());
			courseVo.setModuleName(cou.getModuleName());
			courseVo.setType(cou.getType());
			assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("saveAssignment() : "+e.getMessage());
			}
			return SUCCESS;
	}
	
	public String saveQuestion(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 status = coursesServiceIface.saveQuestion(courseVo,loginUser.getUserId(),loginUser.getUserType());
			if(status){
				addActionMessage(courseVo.getQuestion()+" Added Successfully");				
			}else{
				addActionMessage(courseVo.getQuestion()+" Already Exist.");	
			}
			assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());
			CourseVo cou = (CourseVo) request.getSession().getAttribute("currentAss");
			courseVo.setCourseId(cou.getCourseId());
			courseVo.setModuleId(cou.getModuleId());
			courseVo.setCourseName(cou.getCourseName());
			courseVo.setModuleName(cou.getModuleName());
			courseVo.setType(cou.getType());
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("saveAssignment() : "+e.getMessage());
			}
			return SUCCESS;
	}
	
	
	
	public String updateQuestion(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 status = coursesServiceIface.updateQuestion(courseVo,loginUser.getUserId(),loginUser.getUserType());
			if(status){
				addActionMessage(courseVo.getQuestion()+" Update Successfully");				
			}else{
				addActionMessage(courseVo.getQuestion()+" Already Exist.");	
			}
			assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());
			CourseVo cou = (CourseVo) request.getSession().getAttribute("currentAss");
			courseVo.setCourseId(cou.getCourseId());
			courseVo.setModuleId(cou.getModuleId());
			courseVo.setCourseName(cou.getCourseName());
			courseVo.setModuleName(cou.getModuleName());
			courseVo.setType(cou.getType());
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("saveAssignment() : "+e.getMessage());
			}
		
		return SUCCESS;
	}
	
	
	public String updateAssignment(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			status = coursesServiceIface.updateAssignment(courseVo,loginUser);
			if(status){
				addActionMessage(courseVo.getAssignmentName()+" Updated Successfully");				
			}
			assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("updateAssignment() : "+e.getMessage());
			}
			return SUCCESS;
	}
	
	public String saveResource(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			status = coursesServiceIface.saveResource(courseVo,loginUser.getUserId(),loginUser.getUserType());
			if(status){
				addActionMessage(courseVo.getResourceTitle()+" Added Successfully");				
			}else{
				addActionMessage(courseVo.getResourceTitle()+" Already Exist.");	
			}
			coursesList = coursesServiceIface.getCourseList(loginUser.getOrganisationId(), courseVo.getDepartmentId(), courseVo.getGroupId(),loginUser.getUserType(),loginUser.getEmail());
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("saveResource() : "+e.getMessage());
			}
			return SUCCESS;
	}
	
	public String mapCourse(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			status = coursesServiceIface.mapCourse(courseVo);
			if(status){
				addActionMessage("Successfully Mapped");				
			}else{
				addActionMessage("The course is already mapped for this selection");
			}
			 adminCoursesList = coursesServiceIface.getCourseList(courseVo.getOrganisationId(), 0, 0,loginUser.getUserType(),loginUser.getEmail());
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList(); 
		
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("mapCourse() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	public String updateResource(){
		try{
			coursesServiceIface = new CoursesServiceImpl();
			HttpServletRequest request= ServletActionContext.getRequest();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			status = coursesServiceIface.updateResource(courseVo);
			if(status){
				addActionMessage("Successfully Updated");				
			}
			 coursesServiceIface = new CoursesServiceImpl();
			 if(courseVo.getCourseId()==0){
			 coursesList = coursesServiceIface.getActiveCourseList();
			 }
			 moduleList = coursesServiceIface.getModules(courseVo.getCourseId());
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("updateResource() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	
	public String courseActiveDeactive(){
			int id=0;
			String flag="0";
			String contentType=null;
			HttpServletRequest request = ServletActionContext.getRequest();
			coursesServiceIface = new CoursesServiceImpl();
		try{
			String sid = request.getParameter("id");
			flag = request.getParameter("flag");
			contentType = request.getParameter("contentType");
			if(sid!=null){
				id=Integer.parseInt(sid);
			}
			if(id>0 && flag!=null &&  contentType!=null){
				status = coursesServiceIface.courseActiveDeactive(id,flag,contentType);
			}
			
			
			if(contentType.equalsIgnoreCase("course")){
				execute();
				return "course";
			}if(contentType.equalsIgnoreCase("module")){
				moduleList = coursesServiceIface.getModules(courseVo.getCourseId());	
				return "module";
			}if(contentType.equalsIgnoreCase("resource")){
				moduleList = coursesServiceIface.getModules(courseVo.getCourseId());	
				return "module";
			}if(contentType.equalsIgnoreCase("assignment")){
				assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());		
				return "assignment";
			}if(contentType.equalsIgnoreCase("question")){
				assList = coursesServiceIface.assignment(courseVo.getCourseId(),courseVo.getModuleId());
				return "question"; 
			}
		}catch (Exception e) {
				e.printStackTrace();
				logger.error("courseActiveDeactive() : "+e.getMessage());
			}
		return null;
	}
	
	
	
	/**
	 * @return the coursesList
	 */
	public List<CourseVo> getCoursesList() {
		return coursesList;
	}

	/**
	 * @param coursesList the coursesList to set
	 */
	public void setCoursesList(List<CourseVo> coursesList) {
		this.coursesList = coursesList;
	}



	public List<CourseVo> getModuleList() {
		return moduleList;
	}



	public void setModuleList(List<CourseVo> moduleList) {
		this.moduleList = moduleList;
	}

	
	public List<OrganisationVo> getSelectDepartmentsList() {
		return selectDepartmentsList;
	}

	public void setSelectDepartmentsList(List<OrganisationVo> selectDepartmentsList) {
		this.selectDepartmentsList = selectDepartmentsList;
	}

	public List<CourseVo> getAdminCoursesList() {
		return adminCoursesList;
	}

	public void setAdminCoursesList(List<CourseVo> adminCoursesList) {
		this.adminCoursesList = adminCoursesList;
	}

	public List<CourseVo> getOrgCoursesList() {
		return orgCoursesList;
	}

	public void setOrgCoursesList(List<CourseVo> orgCoursesList) {
		this.orgCoursesList = orgCoursesList;
	}

	public CourseVo getCourseVo() {
		return courseVo;
	}

	public void setCourseVo(CourseVo courseVo) {
		this.courseVo = courseVo;
	}

	public List<CourseVo> getAssList() {
		return assList;
	}

	public void setAssList(List<CourseVo> assList) {
		this.assList = assList;
	}

	

	
}
