package com.slms.webapp.form;

import java.io.File;
import java.util.List;

public class CourseVo {
	private String courseName;
	private File courseIcon;
	private String courseIconFileName;
	private String courseIconContentType;
	private File upload;
	private String uploadFileName;
	private String uploadContentType;
	private int courseId;
	private int moduleId;
	private String moduleName;
	private int organisationId;
	private int departmentId;
	private int assignmentId;
	private int groupId;
	private String author;
	private int duration;
	private String startDate;
	private String question;
	private String metadata;
	private String endDate;
	private String description;
	private String assignmentName;
	private String resourceTitle;
	private String resourceDesc;
	private String resourceUrl;
	private String orgName;
	private String groupName;
	private String departmentName;
	private String tf;
	private int count;
	private int questionId;
	private int[] check;
	private String[] choice;
	private int status;
	private String courseType;
	private int type;
	private int resourceId;
	private int resDuration;
	private String resMetadata;
	private String resAuthor;
	private String resAuthorImgName;
	private String thumbImgName;
	private List<UserVo> studentList;
	private List<CourseVo> resourceList;
	private List<CourseVo> moduleList;
	private List<CourseVo> assignmentList;
	private List<CourseVo> questionList;
	private List<OrganisationVo> groupList;
	/**
	 * @return the courseName
	 */
	public String getCourseName() {
		return courseName;
	}
	/**
	 * @param courseName the courseName to set
	 */
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	/**
	 * @return the courseId
	 */
	public int getCourseId() {
		return courseId;
	}
	/**
	 * @param courseId the courseId to set
	 */
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	/**
	 * @return the organisationId
	 */
	public int getOrganisationId() {
		return organisationId;
	}
	/**
	 * @param organisationId the organisationId to set
	 */
	public void setOrganisationId(int organisationId) {
		this.organisationId = organisationId;
	}
	/**
	 * @return the departmentId
	 */
	public int getDepartmentId() {
		return departmentId;
	}
	/**
	 * @param departmentId the departmentId to set
	 */
	public void setDepartmentId(int departmentId) {
		this.departmentId = departmentId;
	}
	/**
	 * @return the groupId
	 */
	public int getGroupId() {
		return groupId;
	}
	/**
	 * @param groupId the groupId to set
	 */
	public void setGroupId(int groupId) {
		this.groupId = groupId;
	}
	/**
	 * @return the author
	 */
	public String getAuthor() {
		return author;
	}
	/**
	 * @param author the author to set
	 */
	public void setAuthor(String author) {
		this.author = author;
	}
	/**
	 * @return the duration
	 */
	public int getDuration() {
		return duration;
	}
	/**
	 * @param duration the duration to set
	 */
	public void setDuration(int duration) {
		this.duration = duration;
	}
	
	/**
	 * @return the startDate
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate the startDate to set
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return the endDate
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate the endDate to set
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	/**
	 * @return the description
	 */
	public String getDescription() {
		return description;
	}
	/**
	 * @param description the description to set
	 */
	public void setDescription(String description) {
		this.description = description;
	}
	/**
	 * @return the moduleId
	 */
	public int getModuleId() {
		return moduleId;
	}
	/**
	 * @param moduleId the moduleId to set
	 */
	public void setModuleId(int moduleId) {
		this.moduleId = moduleId;
	}
	/**
	 * @return the moduleName
	 */
	public String getModuleName() {
		return moduleName;
	}
	/**
	 * @param moduleName the moduleName to set
	 */
	public void setModuleName(String moduleName) {
		this.moduleName = moduleName;
	}
	public int getAssignmentId() {
		return assignmentId;
	}
	public void setAssignmentId(int assignmentId) {
		this.assignmentId = assignmentId;
	}
	public String getAssignmentName() {
		return assignmentName;
	}
	public void setAssignmentName(String assignmentName) {
		this.assignmentName = assignmentName;
	}
	/**
	 * @return the resourceList
	 */
	public List<CourseVo> getResourceList() {
		return resourceList;
	}
	/**
	 * @param resourceList the resourceList to set
	 */
	public void setResourceList(List<CourseVo> resourceList) {
		this.resourceList = resourceList;
	}
	/**
	 * @return the resourceTitle
	 */
	public String getResourceTitle() {
		return resourceTitle;
	}
	/**
	 * @param resourceTitle the resourceTitle to set
	 */
	public void setResourceTitle(String resourceTitle) {
		this.resourceTitle = resourceTitle;
	}
	/**
	 * @return the resourceDesc
	 */
	public String getResourceDesc() {
		return resourceDesc;
	}
	/**
	 * @param resourceDesc the resourceDesc to set
	 */
	public void setResourceDesc(String resourceDesc) {
		this.resourceDesc = resourceDesc;
	}
	/**
	 * @return the resourceUrl
	 */
	public String getResourceUrl() {
		return resourceUrl;
	}
	/**
	 * @param resourceUrl the resourceUrl to set
	 */
	public void setResourceUrl(String resourceUrl) {
		this.resourceUrl = resourceUrl;
	}
	/**
	 * @return the count
	 */
	public int getCount() {
		return count;
	}
	/**
	 * @param count the count to set
	 */
	public void setCount(int count) {
		this.count = count;
	}
	public String getMetadata() {
		return metadata;
	}
	public void setMetadata(String metadata) {
		this.metadata = metadata;
	}
	public int getResourceId() {
		return resourceId;
	}
	public void setResourceId(int resourceId) {
		this.resourceId = resourceId;
	}
	public int getResDuration() {
		return resDuration;
	}
	public void setResDuration(int resDuration) {
		this.resDuration = resDuration;
	}
	public String getResMetadata() {
		return resMetadata;
	}
	public void setResMetadata(String resMetadata) {
		this.resMetadata = resMetadata;
	}
	public String getResAuthorImgName() {
		return resAuthorImgName;
	}
	public void setResAuthorImgName(String resAuthorImgName) {
		this.resAuthorImgName = resAuthorImgName;
	}
	public String getThumbImgName() {
		return thumbImgName;
	}
	public void setThumbImgName(String thumbImgName) {
		this.thumbImgName = thumbImgName;
	}
	public String getResAuthor() {
		return resAuthor;
	}
	public void setResAuthor(String resAuthor) {
		this.resAuthor = resAuthor;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
	public String getGroupName() {
		return groupName;
	}
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	public String getDepartmentName() {
		return departmentName;
	}
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
	}
	public String getOrgName() {
		return orgName;
	}
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	public File getCourseIcon() {
		return courseIcon;
	}
	public void setCourseIcon(File courseIcon) {
		this.courseIcon = courseIcon;
	}
	public String getCourseIconFileName() {
		return courseIconFileName;
	}
	public void setCourseIconFileName(String courseIconFileName) {
		this.courseIconFileName = courseIconFileName;
	}
	public String getCourseIconContentType() {
		return courseIconContentType;
	}
	public void setCourseIconContentType(String courseIconContentType) {
		this.courseIconContentType = courseIconContentType;
	}
	public List<CourseVo> getModuleList() {
		return moduleList;
	}
	public void setModuleList(List<CourseVo> moduleList) {
		this.moduleList = moduleList;
	}
	public List<CourseVo> getAssignmentList() {
		return assignmentList;
	}
	public void setAssignmentList(List<CourseVo> assignmentList) {
		this.assignmentList = assignmentList;
	}
	public String getCourseType() {
		return courseType;
	}
	public void setCourseType(String courseType) {
		this.courseType = courseType;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getQuestion() {
		return question;
	}
	public void setQuestion(String question) {
		this.question = question;
	}
	public int[] getCheck() {
		return check;
	}
	public void setCheck(int[] check) {
		this.check = check;
	}
	public String[] getChoice() {
		return choice;
	}
	public void setChoice(String[] choice) {
		this.choice = choice;
	}
	public String getTf() {
		return tf;
	}
	public void setTf(String tf) {
		this.tf = tf;
	}
	public List<CourseVo> getQuestionList() {
		return questionList;
	}
	public void setQuestionList(List<CourseVo> questionList) {
		this.questionList = questionList;
	}
	public int getQuestionId() {
		return questionId;
	}
	public void setQuestionId(int questionId) {
		this.questionId = questionId;
	}
	public File getUpload() {
		return upload;
	}
	public void setUpload(File upload) {
		this.upload = upload;
	}
	public String getUploadFileName() {
		return uploadFileName;
	}
	public void setUploadFileName(String uploadFileName) {
		this.uploadFileName = uploadFileName;
	}
	public String getUploadContentType() {
		return uploadContentType;
	}
	public void setUploadContentType(String uploadContentType) {
		this.uploadContentType = uploadContentType;
	}
	public List<OrganisationVo> getGroupList() {
		return groupList;
	}
	public void setGroupList(List<OrganisationVo> groupList) {
		this.groupList = groupList;
	}
	public List<UserVo> getStudentList() {
		return studentList;
	}
	public void setStudentList(List<UserVo> studentList) {
		this.studentList = studentList;
	}
	
}
