package com.slms.service.impl;

import java.util.List;

import com.slms.persistance.dao.iface.UserDao;
import com.slms.persistance.factory.LmsDaoFactory;
import com.slms.service.iface.UserServiceIface;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public class UserServiceImpl implements UserServiceIface{

	@Override
	public UserVo saveTeacher(UserVo userVo, UserVo loginUser) {
		UserVo user=null;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			user=dao.saveTeacher(userVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public List<UserVo> getTeachers(int organisationId) {
		 List<UserVo> teachers= null;
		 List<UserVo> teacherDetailList= null;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			teachers = dao.getTeachers(organisationId);
			for(UserVo user : teachers){
			teacherDetailList = dao.teacherDeatil(user.getUserId(),organisationId);
			user.setCount(teacherDetailList.size());
			user.setDetailList(teacherDetailList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return teachers;
	}

	@Override
	public boolean mapTeacher(UserVo userVo, int userId) {
		boolean status=false;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			status=dao.mapTeacher(userVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<UserVo> getStudents(int organisationId) {
		 List<UserVo> studnetsList= null;
			try {
				UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
				studnetsList = dao.getStudents(organisationId);
				for(int i=0;i<studnetsList.size();i++){
					studnetsList.get(i).setDepartmentList(dao.studentDepartmentsByUserId(studnetsList.get(i).getUserId()));
					studnetsList.get(i).setContainerList(dao.studentContainersByUserId(studnetsList.get(i).getUserId()));
					studnetsList.get(i).setAvailableDep(dao.availableDep(organisationId,studnetsList.get(i).getUserId()));
					studnetsList.get(i).setAvailableContainer(dao.availableContainer(organisationId,studnetsList.get(i).getUserId()));
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			return studnetsList;
	}

	@Override
	public UserVo changeUserLoginStatus(int userId, int login_Status) {
		UserVo studnet= null;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			studnet = dao.changeUserLoginStatus(userId,login_Status);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return studnet;
	}

	@Override
	public boolean changeTeacherStatus(int userId, int login_Status) {
		boolean status=false;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			status = dao.changeTeacherStatus(userId,login_Status);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public UserVo getUserPassword(String email) {
		UserVo userVo=null;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			userVo = dao.getUserPassword(email);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return userVo;
	}

	@Override
	public boolean updateTeacher(UserVo userVo, int userId) {
		boolean status=false;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			status=dao.updateTeacher(userVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<UserVo> getTeacherChoice(UserVo userVo) {
		 List<UserVo> teachers= null;
			try {
				UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
				teachers = dao.getTeacherChoice(userVo);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return teachers;
	}

	@Override
	public boolean mapTeaherNewOrg(int mapTeacherId, int organisationId) {
		boolean status=false;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			status=dao.mapTeaherNewOrg(mapTeacherId,organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public int saveStudent(UserVo userVo, UserVo loginUser) {
		int statusFlag=0;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			statusFlag=dao.saveStudent(userVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statusFlag;
	}

	@Override
	public List<UserVo> newRegistration(int organisationId) {
		List<UserVo> studnetsList= null;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			studnetsList = dao.newRegistration(organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return studnetsList;
	}

	@Override
	public void changeNewUserStatus(UserVo userVo, int userId) {
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			dao.changeNewUserStatus(userVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<CourseVo> sessionRequestPending(int organisationId,int departmentId, int groupId) {
		List<CourseVo> coursesList= null;
		List<UserVo> studentList= null;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			coursesList = dao.getInsLedCoursesByOrgId(organisationId);
			for(CourseVo course :coursesList){
				studentList = dao.sessionRequestPending(course.getCourseId(),departmentId,groupId);
				course.setStudentList(studentList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return coursesList;
	}

	@Override
	public void changeCourseReqStatus(UserVo userVo) {
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			dao.changeCourseReqStatus(userVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public int mapContainerToUser(UserVo userVo, UserVo loginUser) {
		int statusFlag=0;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			statusFlag=dao.mapContainerToUser(userVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statusFlag;
	}

	@Override
	public int mapStudToNewDep(UserVo userVo, UserVo loginUser) {
		int statusFlag=0;
		try {
			UserDao dao = (UserDao) LmsDaoFactory.getDAO(UserDao.class);
			statusFlag=dao.mapStudToNewDep(userVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return statusFlag;
	}

}
