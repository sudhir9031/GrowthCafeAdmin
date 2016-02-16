package com.slms.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.slms.persistance.dao.iface.DashboardDao;
import com.slms.persistance.dao.iface.OrganisationDao;
import com.slms.persistance.factory.LmsDaoFactory;
import com.slms.service.iface.DashboardServiceIface;
import com.slms.webapp.form.DashboardVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public class DashboardServiceImpl implements DashboardServiceIface{

	@Override
	public DashboardVo getDashboardData(UserVo loginUser) {
		DashboardVo dashboardVo=null;
		 try {
	            DashboardDao dao = (DashboardDao) LmsDaoFactory.getDAO(DashboardDao.class);
	            dashboardVo = dao.getDashboardData(loginUser);
	        } catch (Exception ex) {
	            System.out.println("LmsServiceException # updateSchoolMasterDetail = "+ex);
	        }
		return dashboardVo;
	}

	@Override
	public List<OrganisationVo> getMasterData() {
		List<OrganisationVo> organisationList=null;
		List<OrganisationVo> departmentList =null;
		List<OrganisationVo> groupList =null;
		 try {
			 OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			 organisationList = dao.getMasterDataOrganisations();
			 if(organisationList.size()>0){
				 departmentList = new ArrayList<OrganisationVo>();
				 for(OrganisationVo org :organisationList){
					 departmentList = dao.getDepartmentsByOrgId(org.getOrganisationId());
					 for(OrganisationVo dep :departmentList){
						 groupList = dao.getGroupsByDepartmentId(dep.getDepartmentId());
						 dep.setGroupList(groupList);
					 }
					 org.setDepartmentList(departmentList);
				 }
			 }
	        } catch (Exception ex) {
	            System.out.println("LmsServiceException # updateSchoolMasterDetail = "+ex);
	        }
		return organisationList;
	}

	@Override
	public UserVo login(String email, String password) {
		UserVo user=null;
		 try {
	            DashboardDao dao = (DashboardDao) LmsDaoFactory.getDAO(DashboardDao.class);
	            user = dao.login(email,password);
	        } catch (Exception ex) {
	            System.out.println("LmsServiceException # updateSchoolMasterDetail = "+ex);
	        }
		return user;
	}
	
	
}
