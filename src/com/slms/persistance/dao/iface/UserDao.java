package com.slms.persistance.dao.iface;

import java.util.List;

import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.KeyValueVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public interface UserDao {

	UserVo saveTeacher(UserVo userVo, UserVo loginUser);

	List<UserVo> getTeachers(int organisationId);

	boolean mapTeacher(UserVo userVo, int userId);

	List<UserVo> teacherDeatil(int userId, int organisationId);

	List<UserVo> getStudents(int organisationId);

	UserVo changeUserLoginStatus(int userId, int Status);

	boolean changeTeacherStatus(int userId, int Status);

	UserVo getUserPassword(String email);

	boolean updateTeacher(UserVo userVo, int userId);

	List<UserVo> getTeacherChoice(UserVo userVo);

	boolean mapTeaherNewOrg(int mapTeacherId, int organisationId);

	int saveStudent(UserVo userVo, UserVo loginUser);

	List<OrganisationVo> studentDepartmentsByUserId(int userId);

	List<OrganisationVo> studentContainersByUserId(int userId);

	List<KeyValueVo> availableDep(int organisationId, int userId);

	List<KeyValueVo> availableContainer(int organisationId, int userId);

	List<UserVo> newRegistration(int organisationId);

	void changeNewUserStatus(UserVo userVo, int userId);

	List<UserVo> sessionRequestPending(int courseId, int departmentId,int groupId);

	List<CourseVo> getInsLedCoursesByOrgId(int organisationId);

	void changeCourseReqStatus(UserVo userVo);

	int mapContainerToUser(UserVo userVo, UserVo loginUser);

	int mapStudToNewDep(UserVo userVo, UserVo loginUser);
}
