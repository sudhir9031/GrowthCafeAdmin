package com.slms.service.iface;

import java.util.List;

import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public interface UserServiceIface {

	UserVo saveTeacher(UserVo userVo, UserVo loginUser);

	List<UserVo> getTeachers(int organisationId);

	boolean mapTeacher(UserVo userVo, int userId);

	List<UserVo> getStudents(int organisationId);

	UserVo changeUserLoginStatus(int userId, int Status);

	boolean changeTeacherStatus(int userId, int Status);

	UserVo getUserPassword(String email);


	boolean updateTeacher(UserVo userVo, int userId);

	List<UserVo> getTeacherChoice(UserVo userVo);

	boolean mapTeaherNewOrg(int mapTeacherId, int organisationId);

	int saveStudent(UserVo userVo, UserVo loginUser);

	List<UserVo> newRegistration(int organisationId);

	void changeNewUserStatus(UserVo userVo, int userId);

	List<CourseVo> sessionRequestPending(int organisationId, int departmentId, int groupId);

	void changeCourseReqStatus(UserVo userVo);

	int mapContainerToUser(UserVo userVo, UserVo loginUser);

	int mapStudToNewDep(UserVo userVo, UserVo loginUser);

}
