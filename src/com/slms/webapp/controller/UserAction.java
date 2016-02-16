package com.slms.webapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletResponseAware;
import org.json.JSONArray;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.slms.common.Email.Emailer;
import com.slms.service.iface.OrganisationServiceIface;
import com.slms.service.iface.UserServiceIface;
import com.slms.service.impl.OrganisationServiceImpl;
import com.slms.service.impl.UserServiceImpl;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public class UserAction extends ActionSupport implements ModelDriven<UserVo>, ServletResponseAware{

	/**
	 * 
	 */
	
	UserVo userVo;
	boolean status;
	List<UserVo> teacherList;
	UserServiceIface userService;
	List<UserVo> studentsList;
	UserVo loginUser;
	int mapTeacherId;
	HttpServletResponse response;
	List<OrganisationVo> selectDepartmentsList;
	List<CourseVo> coursesList;
	List<OrganisationVo> suggestedContainer;
	Logger logger = LoggerFactory.getLogger(UserAction.class);
	public UserVo getModel(){
		 userVo = new UserVo();
		return userVo;
	}
	
	@Override
	public void setServletResponse(HttpServletResponse arg0) {
		response=arg0;
		
	}
	
	private static final long serialVersionUID = 1L;
	
	public String execute(){
		HttpServletRequest request= ServletActionContext.getRequest();
		 userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 //selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 teacherList = userService.getTeachers(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("execute() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "1");
		return SUCCESS;
	}
	
	
	public String getCoachContainerDetail(){
		HttpServletRequest request= ServletActionContext.getRequest();
		OrganisationServiceIface orgServiceIface = new OrganisationServiceImpl();
		 userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 suggestedContainer =  orgServiceIface.getContainerSessions(loginUser, "");
			 userVo.setDepartmentId(loginUser.getDepartmentId());
			 userVo.setOrganisationId(loginUser.getOrganisationId());
			 selectDepartmentsList =  orgServiceIface.getContainerOfCoach(userVo, "");
			 suggestedContainer.removeAll(selectDepartmentsList);
			 //selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 teacherList = userService.getTeachers(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("execute() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "1");
		return SUCCESS;
	}
	
	public String saveTeacher(){
		 userService = new UserServiceImpl();
		 HttpServletRequest request= ServletActionContext.getRequest();
		 try{
			 loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 String emailId= userVo.getEmail();
				 userVo = userService.saveTeacher(userVo,loginUser);
				 if(userVo.getStatus()==1){
					 mapTeacherId = userVo.getUserId();
					 addActionError(emailId +" is allready created and/or mapped to other organization(s) do you want him to be associate with your organisation");
				 }else if(userVo.getStatus()==2){
					 addActionMessage("Successfully Saved");
				 }
				 else if(userVo.getStatus()==3){
					 if(userVo.getUserType()==1){
						 addActionMessage(emailId +" is allready created as admin");
					 }
					 else if(userVo.getUserType()==3){
						 addActionMessage(emailId +" is allready created as student");
					 }else if(userVo.getUserType()==4){
						 addActionMessage(emailId +" is allready created as super Admin");
					 }
				 }
			 }
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 teacherList = userService.getTeachers(loginUser.getOrganisationId());
		 }catch (Exception e) {
			e.printStackTrace();
			logger.error("saveTeacher() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String mapTeacher(){
		HttpServletRequest request= ServletActionContext.getRequest();
		 userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 userVo.setDepartmentId(loginUser.getDepartmentId());
			 userVo.setOrganisationId(loginUser.getOrganisationId());
			 status = userService.mapTeacher(userVo,loginUser.getUserId());
			 if(status){
				 addActionMessage("Successfully Mapped");
			 }
			 teacherList = userService.getTeachers(userVo.getOrganisationId());
		 }catch (Exception e) {
			e.printStackTrace();
			logger.error("mapTeacher() : "+e.getMessage());
		}
		return SUCCESS;
	}

	
	public String mapTeaherNewOrg(){
		HttpServletRequest request= ServletActionContext.getRequest();
		 userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 status = userService.mapTeaherNewOrg(mapTeacherId,loginUser.getOrganisationId());
			 if(status){
				 addActionMessage("Successfully Mapped");
			 }
			 teacherList = userService.getTeachers(loginUser.getOrganisationId());
		 }catch (Exception e) {
			e.printStackTrace();
			logger.error("mapTeaherNewOrg() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String students(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
				List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 studentsList = userService.getStudents(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String saveStudent(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 int statusFlag = userService.saveStudent(userVo,loginUser);
				List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 studentsList = userService.getStudents(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String mapStudToNewDep(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 int statusFlag = userService.mapStudToNewDep(userVo,loginUser);
				List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 studentsList = userService.getStudents(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String mapContainerToUser(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 	int statusFlag = userService.mapContainerToUser(userVo,loginUser);
				List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 studentsList = userService.getStudents(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	
	
	public String newRegistration(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 studentsList = userService.newRegistration(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String changeNewUserStatus(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 userService.changeNewUserStatus(userVo,loginUser.getUserId());
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 studentsList = userService.newRegistration(loginUser.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String sessionRequest(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		int groupId=0;
		int depId=0;
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 coursesList = userService.sessionRequestPending(loginUser.getOrganisationId(),depId,groupId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String changeCourseReqStatus(){
		HttpServletRequest request= ServletActionContext.getRequest();
		userService = new UserServiceImpl();
		int groupId=0;
		int depId=0;
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 userService.changeCourseReqStatus(userVo);
			 List<OrganisationVo> organisationList = (List<OrganisationVo>) request.getSession().getAttribute("organisationList");
			 selectDepartmentsList = organisationList.get(0).getDepartmentList();
			 coursesList = userService.sessionRequestPending(loginUser.getOrganisationId(),depId,groupId);
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("students() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "2");
		return SUCCESS;
	}
	
	public String getStudentTable(){
		userService = new UserServiceImpl();
		try {
			studentsList = userService.getStudents(userVo.getOrganisationId());
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("getStudentTable() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String changeUserLoginStatus(){
		userService = new UserServiceImpl();
		HttpServletRequest request = ServletActionContext.getRequest();
		int userId = Integer.parseInt(request.getParameter("userId"));
		int login_Status = Integer.parseInt(request.getParameter("status"));
		try {
			UserVo student = userService.changeUserLoginStatus(userId, login_Status);
			if(student != null && student.getStatus()==1){
				//student.setEmail("yogendra.kumar@ixeet.com");
				String adminEmail="system@ixeet.com";
				String subject=" Growth Cafe : Your registration is approved";
				String message="";
				
				
				  StringBuffer temp=new StringBuffer("<font face=\"calibri\">");
	              temp.append("Hello ").append(student.getFname() +" "+student.getLname()).append(",").append("<br/><br/>");
	              temp.append("Your registration for  growth cafe app is approved by <b>").append(student.getOrgName()).append("</b> admin you belong to <b>").append(student.getDepName()).append("</b>  and <b>").append(student.getGroupName()).append(" </b><br/><br/>");
	              temp.append(" Your userid and password is <b>").append(student.getEmail()).append("</b> and <b>").append(student.getPassword()).append("</b>  respectively.<br/><br/>");
	              temp.append(" You can download app from here. <br/>");
	              temp.append("Web : ").append("<br/>");
	              temp.append("Android : ").append("<br/>");
	              temp.append("IPhone : ");
	              temp.append("</font>");
	              message=temp.toString();
				Emailer mail = new Emailer();
				mail.mailto(adminEmail, student.getEmail(), subject, message);
			}
			getStudentTable();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("changeUserLoginStatus() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String changeTeacherStatus(){
		try {
			userService = new UserServiceImpl();
			HttpServletRequest request = ServletActionContext.getRequest();
			int userId = Integer.parseInt(request.getParameter("userId"));
			int login_Status = Integer.parseInt(request.getParameter("status"));
			status = userService.changeTeacherStatus(userId,login_Status);
			execute();
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("changeTeacherStatus() : "+e.getMessage());
		}
		return SUCCESS;
	}

	public String sendforgetPassword(){
		
		try {
			userService = new UserServiceImpl();
			UserVo user = userService.getUserPassword(userVo.getEmail());
			   if(user !=null){
	            	
					String subject="LMS forgot password notification.";
		            String message = "Dear "+user.getFname()+" "+user.getLname()+", <br/> Greetings! <br/> Your password is "+user.getPassword();
		            
		            Emailer emailer = new Emailer();
		            String email_from="system@ixeet.com";
		            emailer.mailto(email_from, userVo.getEmail(), subject, message);
		            addActionMessage("Your password is sent to "+userVo.getEmail()+", please check SPAM folder if not received in inbox");
	            }else{
            	addActionMessage("Email doesn't match with database, please enter a registered email Id to get password");
            }
			
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("sendforgetPassword() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	public String updateTeacher(){
		 userService = new UserServiceImpl();
		 HttpServletRequest request = ServletActionContext.getRequest();
		 try{
			 loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 status = userService.updateTeacher(userVo, loginUser.getUserId());
			 teacherList = userService.getTeachers(userVo.getOrganisationId());
		 }catch (Exception e) {
			e.printStackTrace();
			logger.error("updateTeacher() : "+e.getMessage());
		}
		return SUCCESS;
	}
	
	
	
	

	public void getTeacherChoice(){
		 HttpServletRequest request = ServletActionContext.getRequest();
		try{
			userService = new UserServiceImpl();
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 teacherList = userService.getTeacherChoice(userVo);
			 }
			 if(teacherList !=null && teacherList.size()>0){
			 JSONArray jsonArr = new JSONArray();
			 for(UserVo user : teacherList){
						 JSONObject jsonObj = new JSONObject();
						 jsonObj.put("userEmail", user.getEmail());
						 jsonObj.put("userName", user.getFname()+" "+user.getLname());
						 jsonObj.put("userId", user.getUserId());
						 jsonArr.put(jsonObj);
				 }
			 response.getWriter().print(jsonArr);
			 }
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("getTeacherChoice() : "+e.getMessage());
		}
	}
	
	
	/**
	 * @return the teacherList
	 */
	public List<UserVo> getTeacherList() {
		return teacherList;
	}

	/**
	 * @param teacherList the teacherList to set
	 */
	public void setTeacherList(List<UserVo> teacherList) {
		this.teacherList = teacherList;
	}

	/**
	 * @return the studentsList
	 */
	public List<UserVo> getStudentsList() {
		return studentsList;
	}

	/**
	 * @param studentsList the studentsList to set
	 */
	public void setStudentsList(List<UserVo> studentsList) {
		this.studentsList = studentsList;
	}

	public List<OrganisationVo> getSelectDepartmentsList() {
		return selectDepartmentsList;
	}

	public void setSelectDepartmentsList(List<OrganisationVo> selectDepartmentsList) {
		this.selectDepartmentsList = selectDepartmentsList;
	}

	public UserVo getUserVo() {
		return userVo;
	}

	public void setUserVo(UserVo userVo) {
		this.userVo = userVo;
	}

	public int getMapTeacherId() {
		return mapTeacherId;
	}

	public void setMapTeacherId(int mapTeacherId) {
		this.mapTeacherId = mapTeacherId;
	}

	public List<OrganisationVo> getSuggestedContainer() {
		return suggestedContainer;
	}

	public void setSuggestedContainer(List<OrganisationVo> suggestedContainer) {
		this.suggestedContainer = suggestedContainer;
	}

	public List<CourseVo> getCoursesList() {
		return coursesList;
	}

	public void setCoursesList(List<CourseVo> coursesList) {
		this.coursesList = coursesList;
	}


}
