package com.slms.webapp.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.opensymphony.xwork2.ActionSupport;
import com.slms.service.iface.DashboardServiceIface;
import com.slms.service.impl.DashboardServiceImpl;
import com.slms.webapp.form.DashboardVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public class DashboardAction extends ActionSupport {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	DashboardVo dashboardVo;
	List<OrganisationVo> organisationList;
	UserVo loginUser;
	String email;
	String password;
	Logger logger = LoggerFactory.getLogger(DashboardAction.class);
	
	
	public String execute(){
		logger.debug("execute()");
		DashboardServiceIface dashboardServiceIface = new DashboardServiceImpl();
		HttpServletRequest request= ServletActionContext.getRequest();
		try{
			 loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser ==null){
				 loginUser = dashboardServiceIface.login(email,password);
				 if(loginUser==null){
					 addActionError("Email id or Password is incorrect");
					 return "message";
				 } if(loginUser.getStatus()==0){
					 addActionError("User is not active user");
					 return "message";
				 }
				 dashboardVo = dashboardServiceIface.getDashboardData(loginUser);
				 organisationList = dashboardServiceIface.getMasterData();
				 if(loginUser.getUserType()==4){
					 request.getSession().setAttribute("organisationList", organisationList);
				 }else{
					 if(loginUser.getOrganisationId()==0){
						 addActionMessage("Organisation not allotted");
						 return "message";
					 }
					 for(OrganisationVo org :organisationList){
						 if(org.getOrganisationId()== loginUser.getOrganisationId()){
							 organisationList = new ArrayList<OrganisationVo>();
							 organisationList.add(org);
							 request.getSession().setAttribute("organisationList", organisationList);
							 break;
						 }
					  }
				 	}
				 request.getSession().setAttribute("loginDetail", loginUser);
			 }
			 	//updating organisationList in session
			 else{
					 dashboardVo = dashboardServiceIface.getDashboardData(loginUser);
					 organisationList = dashboardServiceIface.getMasterData();
					 if(loginUser.getUserType()==4){
						 
						 request.getSession().setAttribute("organisationList", organisationList);
					 }else{
						 for(OrganisationVo org :organisationList){
							 if(org.getOrganisationId()== loginUser.getOrganisationId()){
								 organisationList = new ArrayList<OrganisationVo>();
								 organisationList.add(org);
								 request.getSession().setAttribute("organisationList", organisationList);
								 break;
							 }
						  }
					 	}
			 }
			 
			 
		}catch (Exception e) {
			e.printStackTrace();
			logger.error("execute() : "+e.getMessage());
		}
		request.getSession().setAttribute("selectedTab", "leftDashboardId");
		
		return SUCCESS;
	}

	public String login(){
		HttpServletRequest request= ServletActionContext.getRequest();
		try{
			 loginUser = (UserVo) request.getSession().getAttribute("loginDetail");
			 if(loginUser !=null){
				 return LOGIN;
			 }
		}catch (Exception e) {
			e.printStackTrace();
		}
		return SUCCESS;
	}

	public String logout(){
		try {
			HttpServletRequest request= ServletActionContext.getRequest();
			request.getSession().removeAttribute("organisationList");
			request.getSession().removeAttribute("loginDetail");
			request.getSession().removeAttribute("selectedTab");
		} catch (Exception e) {
			e.printStackTrace();
			logger.error("logout() : "+e.getMessage());
		}
		
		return SUCCESS;
	}
	/**
	 * @return the dashboardVo
	 */
	public DashboardVo getDashboardVo() {
		return dashboardVo;
	}


	/**
	 * @param dashboardVo the dashboardVo to set
	 */
	public void setDashboardVo(DashboardVo dashboardVo) {
		this.dashboardVo = dashboardVo;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
		
}
