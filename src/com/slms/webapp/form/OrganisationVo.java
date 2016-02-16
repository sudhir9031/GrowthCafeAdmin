package com.slms.webapp.form;

import java.io.File;
import java.util.List;


public class OrganisationVo {
	
	private String organisationName;
	private int organisationId;
	private String departmentName;
	private int courseId;
	private int courseType;
	private String courseName;
	private String metadata;
	private String description;
	private File logo;
	public File getLogo() {
		return logo;
	}
	private String logoFileName;
	private String logoContentType;
	private int departmentId;
	private String groupName;
	private int groupId;
	private String phone;
	private String address;
	private String city;
	private String state;
	private String website;
	private String startDate;
	private String endDate;
	private String[] startedOn;
	private String[] endOn;
	private int[] containers;
	private int status;
	List<UserVo> adminList;
	
	private List<OrganisationVo> departmentList;
	private List<OrganisationVo> groupList;
	/**
	 * @return the organisationName
	 */
	public String getOrganisationName() {
		return organisationName;
	}
	/**
	 * @param organisationName the organisationName to set
	 */
	public void setOrganisationName(String organisationName) {
		this.organisationName = organisationName;
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
	 * @return the departmentName
	 */
	public String getDepartmentName() {
		return departmentName;
	}
	/**
	 * @param departmentName the departmentName to set
	 */
	public void setDepartmentName(String departmentName) {
		this.departmentName = departmentName;
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
	 * @return the departmentList
	 */
	public List<OrganisationVo> getDepartmentList() {
		return departmentList;
	}
	/**
	 * @param departmentList the departmentList to set
	 */
	public void setDepartmentList(List<OrganisationVo> departmentList) {
		this.departmentList = departmentList;
	}
	/**
	 * @return the groupList
	 */
	public List<OrganisationVo> getGroupList() {
		return groupList;
	}
	/**
	 * @param groupList the groupList to set
	 */
	public void setGroupList(List<OrganisationVo> groupList) {
		this.groupList = groupList;
	}
	/**
	 * @return the phone
	 */
	public String getPhone() {
		return phone;
	}
	/**
	 * @param phone the phone to set
	 */
	public void setPhone(String phone) {
		this.phone = phone;
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
	 * @return the city
	 */
	public String getCity() {
		return city;
	}
	/**
	 * @param city the city to set
	 */
	public void setCity(String city) {
		this.city = city;
	}
	/**
	 * @return the state
	 */
	public String getState() {
		return state;
	}
	/**
	 * @param state the state to set
	 */
	public void setState(String state) {
		this.state = state;
	}
	/**
	 * @return the website
	 */
	public String getWebsite() {
		return website;
	}
	/**
	 * @param website the website to set
	 */
	public void setWebsite(String website) {
		this.website = website;
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
	public String getMetadata() {
		return metadata;
	}
	public void setMetadata(String metadata) {
		this.metadata = metadata;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public List<UserVo> getAdminList() {
		return adminList;
	}
	public void setAdminList(List<UserVo> adminList) {
		this.adminList = adminList;
	}
	public String[] getStartedOn() {
		return startedOn;
	}
	public void setStartedOn(String[] startedOn) {
		this.startedOn = startedOn;
	}
	public String[] getEndOn() {
		return endOn;
	}
	public void setEndOn(String[] endOn) {
		this.endOn = endOn;
	}
	public int getCourseId() {
		return courseId;
	}
	public void setCourseId(int courseId) {
		this.courseId = courseId;
	}
	public String getCourseName() {
		return courseName;
	}
	public void setCourseName(String courseName) {
		this.courseName = courseName;
	}
	public int getCourseType() {
		return courseType;
	}
	public void setCourseType(int courseType) {
		this.courseType = courseType;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getEndDate() {
		return endDate;
	}
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public int[] getContainers() {
		return containers;
	}
	public void setContainers(int[] containers) {
		this.containers = containers;
	}
	public String getLogoFileName() {
		return logoFileName;
	}
	public void setLogoFileName(String logoFileName) {
		this.logoFileName = logoFileName;
	}
	public String getLogoContentType() {
		return logoContentType;
	}
	public void setLogoContentType(String logoContentType) {
		this.logoContentType = logoContentType;
	}
	public void setLogo(File logo) {
		this.logo = logo;
	}
}
