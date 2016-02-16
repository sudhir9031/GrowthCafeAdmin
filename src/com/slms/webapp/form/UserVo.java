package com.slms.webapp.form;

import java.util.List;

public class UserVo {
	
	private String UserName;
	private String fname;
	private String lname;
	private String password;
	private String newPassword;
	private String email;
	private String orgName;
	private String contactNo;
	private String joiningDate;
	private String leaveDate;
	private String dateOfBirth;
	private String depName;
	private String groupName;
	private String courseName;
	private String title;
	private String startDate;
	private int UserId;
	private String address;
	private String qualification;
	private String profileImgName;
	private String profileImgFile;
	private String profileImgContentType;
	private String experience;
	private int organisationId;
	private int departmentId;
	private int groupId;
	private int courseId;
	private int userType;
	private int count;
	private int status;
	private int[] containers;
	private int[] users;
	private List<UserVo> detailList;
	private List<OrganisationVo> departmentList;
	private List<OrganisationVo> containerList;
	private List<KeyValueVo> availableDep;
	private List<KeyValueVo> availableContainer;
	
	
	/**
	 * @return the userName
	 */
	public String getUserName() {
		return UserName;
	}
	/**
	 * @param userName the userName to set
	 */
	public void setUserName(String userName) {
		UserName = userName;
	}
	/**
	 * @return the userId
	 */
	public int getUserId() {
		return UserId;
	}
	/**
	 * @param userId the userId to set
	 */
	public void setUserId(int userId) {
		UserId = userId;
	}
	/**
	 * @return the address
	 */
	public String getAddress() {
		return address;
	}
	/**
	 * @param address the address to set
	 */
	public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return the qualification
	 */
	public String getQualification() {
		return qualification;
	}
	/**
	 * @param qualification the qualification to set
	 */
	public void setQualification(String qualification) {
		this.qualification = qualification;
	}
	/**
	 * @return the profileImgName
	 */
	public String getProfileImgName() {
		return profileImgName;
	}
	/**
	 * @param profileImgName the profileImgName to set
	 */
	public void setProfileImgName(String profileImgName) {
		this.profileImgName = profileImgName;
	}
	/**
	 * @return the experience
	 */
	public String getExperience() {
		return experience;
	}
	/**
	 * @param experience the experience to set
	 */
	public void setExperience(String experience) {
		this.experience = experience;
	}
	/**
	 * @return the profileImgFile
	 */
	public String getProfileImgFile() {
		return profileImgFile;
	}
	/**
	 * @param profileImgFile the profileImgFile to set
	 */
	public void setProfileImgFile(String profileImgFile) {
		this.profileImgFile = profileImgFile;
	}
	/**
	 * @return the profileImgContentType
	 */
	public String getProfileImgContentType() {
		return profileImgContentType;
	}
	/**
	 * @param profileImgContentType the profileImgContentType to set
	 */
	public void setProfileImgContentType(String profileImgContentType) {
		this.profileImgContentType = profileImgContentType;
	}
	
	/**
	 * @return the email
	 */
	public String getEmail() {
		return email;
	}
	/**
	 * @param email the email to set
	 */
	public void setEmail(String email) {
		this.email = email;
	}
	/**
	 * @return the fname
	 */
	public String getFname() {
		return fname;
	}
	/**
	 * @param fname the fname to set
	 */
	public void setFname(String fname) {
		this.fname = fname;
	}
	/**
	 * @return the lname
	 */
	public String getLname() {
		return lname;
	}
	/**
	 * @param lname the lname to set
	 */
	public void setLname(String lname) {
		this.lname = lname;
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
	/**
	 * @return the orgName
	 */
	public String getOrgName() {
		return orgName;
	}
	/**
	 * @param orgName the orgName to set
	 */
	public void setOrgName(String orgName) {
		this.orgName = orgName;
	}
	/**
	 * @return the depName
	 */
	public String getDepName() {
		return depName;
	}
	/**
	 * @param depName the depName to set
	 */
	public void setDepName(String depName) {
		this.depName = depName;
	}
	/**
	 * @return the groupName
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName the groupName to set
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
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
	 * @return the detailList
	 */
	public List<UserVo> getDetailList() {
		return detailList;
	}
	/**
	 * @param detailList the detailList to set
	 */
	public void setDetailList(List<UserVo> detailList) {
		this.detailList = detailList;
	}
	/**
	 * @return the status
	 */
	public int getStatus() {
		return status;
	}
	/**
	 * @param status the status to set
	 */
	public void setStatus(int status) {
		this.status = status;
	}
	/**
	 * @return the password
	 */
	public String getPassword() {
		return password;
	}
	/**
	 * @param password the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}
	public String getContactNo() {
		return contactNo;
	}
	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}
	public String getJoiningDate() {
		return joiningDate;
	}
	public void setJoiningDate(String joiningDate) {
		this.joiningDate = joiningDate;
	}
	public String getDateOfBirth() {
		return dateOfBirth;
	}
	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}
	public int getUserType() {
		return userType;
	}
	public void setUserType(int userType) {
		this.userType = userType;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getNewPassword() {
		return newPassword;
	}
	public void setNewPassword(String newPassword) {
		this.newPassword = newPassword;
	}
	public int[] getContainers() {
		return containers;
	}
	public void setContainers(int[] containers) {
		this.containers = containers;
	}
	public String getLeaveDate() {
		return leaveDate;
	}
	public void setLeaveDate(String leaveDate) {
		this.leaveDate = leaveDate;
	}
	public List<OrganisationVo> getDepartmentList() {
		return departmentList;
	}
	public void setDepartmentList(List<OrganisationVo> departmentList) {
		this.departmentList = departmentList;
	}
	public List<OrganisationVo> getContainerList() {
		return containerList;
	}
	public void setContainerList(List<OrganisationVo> containerList) {
		this.containerList = containerList;
	}
	public List<KeyValueVo> getAvailableDep() {
		return availableDep;
	}
	public void setAvailableDep(List<KeyValueVo> availableDep) {
		this.availableDep = availableDep;
	}
	public List<KeyValueVo> getAvailableContainer() {
		return availableContainer;
	}
	public void setAvailableContainer(List<KeyValueVo> availableContainer) {
		this.availableContainer = availableContainer;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public int[] getUsers() {
		return users;
	}
	public void setUsers(int[] users) {
		this.users = users;
	}
	

}
