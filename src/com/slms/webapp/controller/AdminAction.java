package com.slms.webapp.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import com.slms.service.iface.AdminServiceIface;
import com.slms.service.impl.AdminServiceImpl;
import com.slms.webapp.form.UserVo;

public class AdminAction extends ActionSupport implements ModelDriven<UserVo>{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	UserVo userVo;
	UserVo loginUser;
	AdminServiceIface adminService;
	boolean status;
	int userMapId;
	List<UserVo> adminList;
	List<UserVo> adminToMapList;
	Logger logger = LoggerFactory.getLogger(AdminAction.class);

	@Override
	public UserVo getModel() {
		userVo = new UserVo();
		return userVo;
	}
	
	public String execute(){
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }
			 adminList = adminService.getAdmins(userVo.getOrganisationId());
			 if(adminList.size()==0){
				 adminToMapList = adminService.getAdminsToMap();
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("execute() : "+e.getMessage());
			}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "3");
		return SUCCESS;
	}

	public String  saveAdmin() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 status = adminService.saveAdmin(userVo,loginUser.getUserId());
				 if(status){
					 addActionMessage(userVo.getFname()+" " +userVo.getLname()+" Successfully Added");
				 }else{
					 addActionMessage("You have allready created organization admin with email id '"+userVo.getEmail()+"'");
				 }
				 adminList = adminService.getAdmins(userVo.getOrganisationId());
				/*if(adminList.size()==0){
				 adminToMapList = adminService.getAdminsToMap();
				}*/
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("saveAdmin() : "+e.getMessage());
			}
		request.getSession().setAttribute("selectedTab", "leftUserManagementId");
		request.getSession().setAttribute("subMenu", "3");
		return SUCCESS;
	}
	
	public String  updateAdmin() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 status = adminService.updateAdmin(userVo,loginUser.getUserId());
				 if(status){
					 addActionMessage(userVo.getFname()+" " +userVo.getLname()+" Successfully Updated");
				 }
				 adminList = adminService.getAdmins(userVo.getOrganisationId());
				 if(adminList.size()==0){
					 adminToMapList = adminService.getAdminsToMap();
				 }
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("updateAdmin() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	public String  mapAdmin() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 status = adminService.mapAdmin(userMapId,userVo.getOrganisationId());
				 if(status){
					 addActionMessage("Successfully Mapped");
				 }
				 adminList = adminService.getAdmins(0);
				 if(adminList.size()==0){
					 adminToMapList = adminService.getAdminsToMap();
				 }
			 	}
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("mapAdmin() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	public String  changeAdminStatus() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser!=null){
				 status = adminService.changeAdminStatus(userVo);
				 if(status){
					 addActionMessage(" Successfully Updated");
				 }
				 adminList = adminService.getAdmins(userVo.getOrganisationId());
				 if(adminList.size()==0){
					 adminToMapList = adminService.getAdminsToMap();
				 }
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("changeAdminStatus() : "+e.getMessage());
			}
		return SUCCESS;
	}
	
	public String  changePassword() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("changePassword() : "+e.getMessage());
			}
		request.getSession().setAttribute("selectedTab", "changePasswordTabId");
		return SUCCESS;
	}
	
	public String  updatePassword() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 loginUser.setPassword(userVo.getPassword());
				 status = adminService.updatePassword(userVo.getNewPassword(),loginUser);
				 if(status){
					 addActionMessage("Successfully Updated");
				 }else{
					 addActionError("Old password not match");
				 }
			 }
			 userVo = adminService.getUserDetail(loginUser.getUserId());
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("updatePassword() : "+e.getMessage());
			}
		return SUCCESS;
	}
	public String  profile() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				userVo = adminService.getUserDetail(loginUser.getUserId());
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("profile() : "+e.getMessage());
			}
		request.getSession().setAttribute("selectedTab", "myProfileTabId");
		return SUCCESS;
	}
	
	public String  editProfile() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				userVo = adminService.getUserDetail(loginUser.getUserId());
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("profile() : "+e.getMessage());
			}
		request.getSession().setAttribute("selectedTab", "editProfileTabId");
		return SUCCESS;
	}
	
	
	public String  updateProfile() {
		HttpServletRequest request= ServletActionContext.getRequest();
		adminService = new AdminServiceImpl();
		try {
			loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser==null){
				 return LOGIN;
			 }else{
				 userVo.setEmail(loginUser.getEmail());
				status = adminService.updateProfile(userVo,loginUser.getUserId());
				if(status){
				userVo.setEmail(loginUser.getEmail());
				userVo.setUserId(loginUser.getUserId());
				request.getSession().setAttribute("loginDetail",userVo);
				addActionMessage("Successfully Updated");
				}
				userVo = adminService.getUserDetail(loginUser.getUserId());
			 }
			 }catch (Exception e) {
				e.printStackTrace();
				logger.error("updateProfile() : "+e.getMessage());
			}
		request.getSession().setAttribute("selectedTab", "myProfileTabId");
		return SUCCESS;
	}

	public List<UserVo> getAdminList() {
		return adminList;
	}

	public void setAdminList(List<UserVo> adminList) {
		this.adminList = adminList;
	}

	public List<UserVo> getAdminToMapList() {
		return adminToMapList;
	}

	public void setAdminToMapList(List<UserVo> adminToMapList) {
		this.adminToMapList = adminToMapList;
	}

	public int getUserMapId() {
		return userMapId;
	}

	public void setUserMapId(int userMapId) {
		this.userMapId = userMapId;
	}

	public UserVo getUserVo() {
		return userVo;
	}

	public void setUserVo(UserVo userVo) {
		this.userVo = userVo;
	}
}
