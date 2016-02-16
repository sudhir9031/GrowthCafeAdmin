package com.slms.persistance.dao.iface;

import java.util.List;

import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.UserVo;

public interface CoursesDao {

	List<CourseVo> getCourseList(int orgId, int depId, int groupId, int userType, String email);

	boolean saveCourse(CourseVo courseVo, UserVo loginUser);

	List<CourseVo> getModules(int moduleId);

	boolean saveModule(CourseVo courseVo, int userId, int userType);

	List<CourseVo> assignment( int courseId, int moduleId);

	boolean saveAssignment(CourseVo courseVo, int userId, int userType);
	
	boolean saveQuestion(CourseVo courseVo, int userId, int userType);

	List<CourseVo> getResoucesByModuleId(int moduleId);

	boolean saveResource(CourseVo courseVo, int userId, int userType);

	List<CourseVo> getCourseChoiceList(int organisationId, int departmentId,int groupId, UserVo loginUser);

	boolean mapCourse(CourseVo courseVo);

	boolean courseActiveDeactive(int id, String flag, String contentType);

	List<CourseVo> getActiveCourseList();

	List<CourseVo> getOrgCourses(int organisationId);

	boolean mapOrgCourse(int organisationId, int courseId);

	boolean updateAssignment(CourseVo courseVo, UserVo loginUser);

	boolean updateCourse(CourseVo courseVo, UserVo loginUser);

	boolean updatModule(CourseVo courseVo, UserVo loginUser);

	boolean updateResource(CourseVo courseVo);

	List<CourseVo> getQuestionByAssId(int assignmentId);

	CourseVo getOptionByQuesId(int questionId);

	boolean updateQuestion(CourseVo courseVo, int userId, int userType);

	CourseVo getNames(int courseId, int moduleId);

}
