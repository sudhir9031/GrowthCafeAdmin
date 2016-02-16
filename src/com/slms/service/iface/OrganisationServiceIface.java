package com.slms.service.iface;

import java.util.List;

import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.KeyValueVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.ReviewVo;
import com.slms.webapp.form.UserVo;

public interface OrganisationServiceIface {

	List<OrganisationVo> getOrganisations();

	List<OrganisationVo> getDepartments(int organisationId);

	boolean saveDepartment(OrganisationVo organisationVo, int userId );

	List<OrganisationVo> getGroups(int organisationId, int departmentId, int courseId);

	boolean saveGroup(OrganisationVo organisationVo, int userId );

	List<OrganisationVo> getAllDepartments();

	List<OrganisationVo> getNewGroup();

	boolean saveOrganisation(OrganisationVo organisationVo);

	List<KeyValueVo> getParamValue(int organisationId);

	List<KeyValueVo> getReviewValue(int paramId);

	boolean saveParamAndValue(int orgId, String param, String value);

	boolean saveParamValue(int paramId, String value);

	List<ReviewVo> getReviewParameter(int organisationId);

	void activeDeactive(int id, String flag, String contentType);

	boolean deleteParameter(int paramId, int valueId);

	boolean updateDepartment(OrganisationVo organisationVo, int userId);

	boolean updateGroup(OrganisationVo organisationVo, int userId);

	boolean updateOrg(OrganisationVo organisationVo, int userId);

	List<CourseVo> getOrgCourseList(UserVo user);

	List<OrganisationVo> getOrgCourseContainerNames(UserVo loginUser);

	List<OrganisationVo> getContainerSessions(UserVo loginUser, String groupName);

	boolean mapDepCourseContainer(OrganisationVo organisationVo, UserVo loginUser);

	List<OrganisationVo> getContainerOfCoach(UserVo loginUser, String string);

	List<KeyValueVo> saveParam(UserVo loginUser, int orgId, String param);

	boolean saveGrade(UserVo loginUser, int gradeId, String grade, String value);

	List<KeyValueVo> getGrade(int organisationId);


}
