package com.slms.service.impl;

import java.util.ArrayList;
import java.util.List;

import com.slms.persistance.dao.iface.CoursesDao;
import com.slms.persistance.factory.LmsDaoFactory;
import com.slms.service.iface.CoursesServiceIface;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.UserVo;

public class CoursesServiceImpl implements CoursesServiceIface{
	

	@Override
	public List<CourseVo> getCourseList(int orgId, int depId, int groupId,int userType, String email) {
		List<CourseVo> courseList=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			courseList = dao.getCourseList(orgId, depId, groupId,userType,email);
			for(CourseVo course : courseList){
				course.setModuleList(getModules(course.getCourseId()));
				for(CourseVo module : course.getModuleList()){
					module.setAssignmentList(assignment(course.getCourseId(), module.getModuleId()));
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return courseList;
	}

	@Override
	public boolean saveCourse(CourseVo courseVo, UserVo loginUser) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.saveCourse(courseVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<CourseVo> getModules(int courseId) {
		List<CourseVo> moduleList=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			moduleList = dao.getModules(courseId);
			for(CourseVo module : moduleList){
				List<CourseVo> resourceList = new ArrayList<CourseVo>();
				resourceList = dao.getResoucesByModuleId(module.getModuleId());
				module.setResourceList(resourceList);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return moduleList;
	}

	@Override
	public boolean saveModule(CourseVo courseVo, int userId, int userType) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.saveModule(courseVo,userId,userType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<CourseVo> assignment(int courseId, int moduleId) {
		List<CourseVo> assignmentList=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			assignmentList = dao.assignment(courseId,moduleId);
			for(CourseVo assign :assignmentList){
				assign.setQuestionList(dao.getQuestionByAssId(assign.getAssignmentId()));
				if(assign.getType()==3){
					for(int j=0;j<assign.getQuestionList().size();j++){
						CourseVo option = dao.getOptionByQuesId(assign.getQuestionList().get(j).getQuestionId());
						assign.getQuestionList().get(j).setChoice(option.getChoice());
						assign.getQuestionList().get(j).setCheck(option.getCheck());
						assign.getQuestionList().get(j).setCourseId(assign.getCourseId());
						assign.getQuestionList().get(j).setModuleId(assign.getModuleId());
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return assignmentList;
	}

	@Override
	public boolean saveAssignment(CourseVo courseVo,int userId,int userType) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.saveAssignment(courseVo,userId,userType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}
	
	@Override
	public boolean saveQuestion(CourseVo courseVo,int userId,int userType) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.saveQuestion(courseVo,userId,userType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean saveResource(CourseVo courseVo, int userId ,int userType) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.saveResource(courseVo,userId,userType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<CourseVo> getCourseChoiceList(int organisationId, int departmentId, int groupId,UserVo loginUser) {
		List<CourseVo> courseList=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			courseList = dao.getCourseChoiceList(organisationId, departmentId, groupId,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return courseList;
	}

	@Override
	public boolean mapCourse(CourseVo courseVo) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.mapCourse(courseVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean courseActiveDeactive(int id, String flag, String contentType) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.courseActiveDeactive(id,flag,contentType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<CourseVo> getActiveCourseList() {
		List<CourseVo> courseList=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			courseList = dao.getActiveCourseList();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return courseList;
	}

	@Override
	public List<CourseVo> getOrgCourses(int organisationId) {
		List<CourseVo> courseList=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			courseList = dao.getOrgCourses(organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return courseList;
	}

	@Override
	public boolean mapOrgCourse(int organisationId, int courseId) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.mapOrgCourse(organisationId,courseId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateAssignment(CourseVo courseVo, UserVo loginUser) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.updateAssignment(courseVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateCourse(CourseVo courseVo, UserVo loginUser) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.updateCourse(courseVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updatModule(CourseVo courseVo, UserVo loginUser) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.updatModule(courseVo,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateResource(CourseVo courseVo) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.updateResource(courseVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateQuestion(CourseVo courseVo, int userId, int userType) {
		boolean status=false;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			status = dao.updateQuestion(courseVo,userId,userType);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public CourseVo getNames(int courseId, int moduleId) {
		CourseVo course=null;
		try {
			CoursesDao dao = (CoursesDao) LmsDaoFactory.getDAO(CoursesDao.class);
			course = dao.getNames(courseId,moduleId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return course;
	}

}
