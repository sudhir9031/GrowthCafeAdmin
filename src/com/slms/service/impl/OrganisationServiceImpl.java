package com.slms.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.slms.persistance.dao.iface.OrganisationDao;
import com.slms.persistance.factory.LmsDaoFactory;
import com.slms.service.iface.OrganisationServiceIface;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.KeyValueVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.ReviewVo;
import com.slms.webapp.form.UserVo;

public class OrganisationServiceImpl implements OrganisationServiceIface{

	@Override
	public List<OrganisationVo> getOrganisations() {
		List<OrganisationVo> orgList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			orgList = dao.getOrganisations();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return orgList;
	}

	@Override
	public List<OrganisationVo> getDepartments(int organisationId) {
		List<OrganisationVo> departmentList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			departmentList = dao.getDepartments(organisationId);
			List<OrganisationVo> container = null;
			for(OrganisationVo dep : departmentList){
				container = new ArrayList<OrganisationVo>();
				container = getDepartmentCourses(dep.getDepartmentId());
				dep.setGroupList(container);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return departmentList;
	}

	private List<OrganisationVo> getDepartmentCourses(int departmentId) {
		List<OrganisationVo> containers=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			containers =dao.getDepartmentCourses(departmentId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return containers;
	}

	@Override
	public boolean saveDepartment(OrganisationVo organisationVo,int userId) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status =dao.saveDepartment(organisationVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return status;
	}

	@Override
	public List<OrganisationVo> getGroups(int organisationId, int departmentId, int courseId) {
		List<OrganisationVo> groupsList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			groupsList = dao.getGroups(organisationId,departmentId,courseId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return groupsList;
	}

	@Override
	public boolean saveGroup(OrganisationVo organisationVo,int userId) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status = dao.saveGroup(organisationVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<OrganisationVo> getAllDepartments() {
		List<OrganisationVo> departmentList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			departmentList = dao.getAllDepartments();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return departmentList;
	}

	@Override
	public List<OrganisationVo> getNewGroup() {
		List<OrganisationVo> groupList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			groupList = dao.getNewGroup();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return groupList;
	}

	@Override
	public boolean saveOrganisation(OrganisationVo organisationVo) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status=dao.saveOrganisation(organisationVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<KeyValueVo> getParamValue(int organisationId) {
		List<KeyValueVo> paramList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			paramList = dao.getParamValue(organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return paramList;
	}

	@Override
	public List<KeyValueVo> getReviewValue(int paramId) {
		List<KeyValueVo> paramList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			paramList = dao.getReviewValue(paramId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return paramList;
	}

	@Override
	public boolean saveParamAndValue(int orgId, String param, String value) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status=dao.saveParamAndValue(orgId,param,value);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean saveParamValue(int paramId, String value) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status=dao.saveParamValue(paramId,value);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<ReviewVo> getReviewParameter(int organisationId) {
		List<ReviewVo> reviewParamList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			reviewParamList = dao.getReviewParameter(organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reviewParamList;
	}

	@Override
	public void activeDeactive(int id, String flag, String contentType) {
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			dao.activeDeactive(id,flag,contentType);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public boolean deleteParameter(int paramId, int valueId) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status=dao.deleteParameter(paramId,valueId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateDepartment(OrganisationVo organisationVo,int userId) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status =dao.updateDepartment(organisationVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateGroup(OrganisationVo organisationVo, int userId) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status =dao.updateGroup(organisationVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateOrg(OrganisationVo organisationVo, int userId) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status =dao.updateOrg(organisationVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}


	@Override
	public List<CourseVo> getOrgCourseList(UserVo user) {
		List<CourseVo> courseList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			courseList = dao.getOrgCourseList(user);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return courseList;
	}

	@Override
	public List<OrganisationVo> getOrgCourseContainerNames(UserVo loginUser) {
		List<OrganisationVo> containers=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			containers = dao.getOrgCourseContainerNames(loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return containers;
	}

	@Override
	public List<OrganisationVo> getContainerSessions(UserVo loginUser, String groupName) {
		List<OrganisationVo> sessions=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			sessions = dao.getContainerSessions(loginUser,groupName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sessions;
	}

	@Override
	public boolean mapDepCourseContainer(OrganisationVo organisationVo, UserVo loginUser) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status =dao.mapDepCourseContainer(organisationVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return status;
	}

	@Override
	public List<OrganisationVo> getContainerOfCoach(UserVo loginUser, String string) {
		List<OrganisationVo> containers=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			containers = dao.getContainerOfCoach(loginUser,string);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return containers;
	}

	@Override
	public List<KeyValueVo> saveParam(UserVo loginUser, int paramId, String param) {
		List<KeyValueVo> paramList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			paramList = dao.saveParam(loginUser,paramId,param);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return paramList;
	}

	@Override
	public boolean saveGrade(UserVo loginUser, int gradeId, String grade,String value) {
		boolean status=false;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			status =dao.saveGrade(loginUser,gradeId,grade,value);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return status;
	}

	@Override
	public List<KeyValueVo> getGrade(int organisationId) {
		List<KeyValueVo> gradeList=null;
		try {
			OrganisationDao dao = (OrganisationDao) LmsDaoFactory.getDAO(OrganisationDao.class);
			gradeList = dao.getGrade(organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return gradeList;
	}

}
