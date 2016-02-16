package com.slms.persistance.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.slms.persistance.dao.iface.CoursesDao;
import com.slms.persistance.factory.LmsDaoAbstract;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.UserVo;

public class CoursesDaoImpl extends LmsDaoAbstract implements CoursesDao{
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs ;

	/**
	 * @return courseList
	 */
	@Override
	public List<CourseVo> getCourseList(int orgId, int depId, int groupId,int userType,String email) {
		String sql = "";
		List<CourseVo> courseList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(userType==4){
				if(orgId>0){
			sql = "SELECT distinct cm.COURSE_ID, cm.COURSE_NAME,cm.COURSE_AUTHOR,cm.COURSE_DURATION,cm.DESC_TXT,cm.METADATA, sm.SCHOOL_NAME, cm.DELETED_FL FROM course_mstr cm INNER JOIN school_course_map scm on scm.COURSE_ID = cm.COURSE_ID INNER JOIN school_mstr sm on sm.SCHOOL_ID=scm.SCHOOL_ID";
				}else{
					sql = "SELECT distinct cm.COURSE_ID, cm.COURSE_NAME,cm.COURSE_AUTHOR,cm.COURSE_DURATION,cm.DESC_TXT,cm.METADATA, cm.DELETED_FL FROM course_mstr cm";
				}
			}if(userType==1){
				if(depId>0){
					sql="SELECT distinct cm.COURSE_ID, cm.COURSE_NAME,cm.COURSE_AUTHOR,cm.COURSE_DURATION,cm.DESC_TXT,cm.METADATA, hm.HRM_NAME,clm.CLASS_NAME, cm.is_self_driven FROM course_mstr cm INNER JOIN hrm_course_map hcm on hcm.COURSE_ID = cm.COURSE_ID INNER JOIN homeroom_mstr hm on hm.HRM_ID=hcm.HRM_ID "+
						" INNER JOIN class_hrm_map chm on chm.HRM_ID=hm.HRM_ID INNER JOIN class_mstr clm on clm.CLASS_ID=chm.CLASS_ID INNER JOIN school_cls_map scm on scm.CLASS_ID = clm.CLASS_ID ";
				}else{
					
					sql="SELECT distinct cm.COURSE_ID, cm.COURSE_NAME,cm.COURSE_AUTHOR,cm.COURSE_DURATION,cm.DESC_TXT,cm.METADATA, cm.is_self_driven, cm.DELETED_FL FROM course_mstr cm INNER JOIN school_course_map scm on scm.COURSE_ID = cm.COURSE_ID ";
				}
				
				
					if(orgId !=0){
						sql=sql+" where scm.SCHOOL_ID="+orgId;
						
						if(depId !=0){
							sql=sql+" and chm.CLASS_ID="+depId;
						}
						if(groupId !=0){
							sql=sql+" and hcm.HRM_ID="+groupId;
						}
						
					}
			}
			
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo course = new CourseVo();
				course.setCourseName(rs.getString("COURSE_NAME"));
				course.setCourseId(rs.getInt("COURSE_ID"));
				course.setAuthor(rs.getString("COURSE_AUTHOR"));
				course.setDuration(rs.getInt("COURSE_DURATION"));
				course.setDescription(rs.getString("DESC_TXT"));
				course.setMetadata(rs.getString("METADATA"));
				course.setType(Integer.parseInt(rs.getString("is_self_driven")));
				course.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				if(userType==1 && depId>0){
				course.setGroupName(rs.getString("HRM_NAME"));
				course.setDepartmentName(rs.getString("CLASS_NAME"));
				}
				if(userType==4){
					if(orgId>0){
					course.setOrgName(rs.getString("SCHOOL_NAME"));
					}
					course.setAuthor(rs.getString("COURSE_AUTHOR"));
					course.setDuration(rs.getInt("COURSE_DURATION"));
					course.setDescription(rs.getString("DESC_TXT"));
					course.setMetadata(rs.getString("METADATA"));
					course.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
					}
				courseList.add(course);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return courseList;
	}

	@Override
	public boolean saveCourse(CourseVo courseVo, UserVo loginUser) {
		String sql = "";
		PreparedStatement pStmt = null;
		int courseId=0;
		boolean status = false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getCourseName()!=null && courseVo.getCourseName()!=""){
				
					sql="SELECT COURSE_ID FROM course_mstr WHERE COURSE_NAME='"+courseVo.getCourseName().replaceAll("'", "\\\\'")+"'";
				
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					courseId = rs.getInt("COURSE_ID");
				}
				if(courseId==0){
					
					sql="SELECT MAX(COURSE_ID) as COURSE_ID FROM course_mstr";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						courseId = rs.getInt("COURSE_ID");
					}
					courseId++;
					sql="INSERT INTO course_mstr(COURSE_ID, COURSE_NAME, COURSE_AUTHOR, AUTHOR_IMG, COURSE_DURATION, CREATED_DT, DESC_TXT, METADATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT,COURSE_ICON,is_self_driven) " +
							"VALUES(?, ?, ?, ?, ?, current_date, ?, ?, ?, ?, ?, ?, ?, utc_timestamp,?,?)";	
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, courseId);
					pStmt.setString(2, courseVo.getCourseName());
					pStmt.setString(3, courseVo.getAuthor());
					pStmt.setString(4, courseVo.getAuthor());//AUTHOR_IMG
					pStmt.setInt(5, courseVo.getDuration());
					pStmt.setString(6, courseVo.getDescription());
					pStmt.setString(7, courseVo.getMetadata());//METADATA
					pStmt.setString(8, "0");//DELETED_FL
					pStmt.setInt(9, courseId);//DISPLAY_NO
					pStmt.setString(10, "0");//ENABLE_FL
					pStmt.setInt(11, loginUser.getUserType());//CREATED_BY
					pStmt.setInt(12, loginUser.getUserId());//LAST_USERID_CD
					pStmt.setString(13, courseVo.getCourseIconFileName());//COURSE_ICON
					pStmt.setString(14, courseVo.getCourseType());//is_self_driven
					int temp = pStmt.executeUpdate();
					if(temp>0)
						status=true;
					if(loginUser.getUserType()==1){
						if(status){
							sql="INSERT INTO school_course_map(SCHOOL_ID,COURSE_ID) values(?,?)";	
							pStmt =  conn.prepareStatement(sql);
							pStmt.setInt(1, loginUser.getOrganisationId());
							pStmt.setInt(2, courseId);
							pStmt.executeUpdate();
						}
					}
				/*	if(loginUser.getUserType()==1){
						sql="INSERT INTO school_course_map(SCHOOL_ID,COURSE_ID) values(?,?)";	
						pStmt =  conn.prepareStatement(sql);
						pStmt.setInt(1, loginUser.getOrganisationId());
						pStmt.setInt(1, courseId);
					}*/
					
				}
			}
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		
		return status;
	}

	@Override
	public List<CourseVo> getModules(int courseId) {
		String sql = "";
		List<CourseVo> moduleList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql="SELECT distinct mm.MODULE_ID, mm.MODULE_NAME,mm.DESC_TXT,mm.METADATA, mm.DELETED_FL, (select count(MRM.MODULE_ID) from module_resource_map MRM, resourse_mstr rm  where MRM.MODULE_ID=mm.MODULE_ID and rm.RESOURSE_ID=MRM.RESOURCE_ID and rm.CREATED_BY='4') as RESOURCE_COUNT  FROM module_mstr mm JOIN course_module_map cmm on cmm.MODULE_ID=mm.MODULE_ID "+
					" JOIN course_mstr cm on cm.COURSE_ID=cmm.COURSE_ID WHERE cm.DELETED_FL='0' ";
			
			
				if(courseId !=0){
					sql=sql+" and cmm.COURSE_ID="+courseId;
				}
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				CourseVo module = new CourseVo();
				module.setModuleName(rs.getString("MODULE_NAME"));
				module.setDescription(rs.getString("DESC_TXT"));
				module.setMetadata(rs.getString("METADATA"));
				module.setModuleId(rs.getInt("MODULE_ID"));
				module.setCount(rs.getInt("RESOURCE_COUNT"));
				module.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				moduleList.add(module);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return moduleList;
	}

	@Override
	public List<CourseVo> getResoucesByModuleId(int moduleId){
		String sql = "";
		 List<CourseVo> resourceList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT rm.RESOURSE_ID, rm.RESOURSE_NAME, rm.RESOURCE_URL, rm.DELETED_FL, rm.DESC_TXT, rm.RESOURCE_TYP_ID, rm.RESOURCE_DURATION, rm.METADATA, rm.THUMB_IMG, rm.AUTHOR_IMG," +
					" rm.RESOURCE_AUTHOR FROM resourse_mstr rm, module_resource_map mrm where rm.RESOURSE_ID=mrm.RESOURCE_ID and mrm.MODULE_ID="+moduleId;
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo resource = new CourseVo();
				resource.setResourceId(rs.getInt("RESOURSE_ID"));
				resource.setResourceTitle(rs.getString("RESOURSE_NAME"));
				resource.setResourceUrl(rs.getString("RESOURCE_URL"));
				resource.setResDuration(rs.getInt("RESOURCE_DURATION"));
				resource.setType(rs.getInt("RESOURCE_TYP_ID"));
				resource.setResourceDesc(rs.getString("DESC_TXT"));
				resource.setResMetadata(rs.getString("METADATA"));
				resource.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				resource.setThumbImgName(rs.getString("THUMB_IMG"));
				resource.setResAuthorImgName(rs.getString("AUTHOR_IMG"));
				resource.setResAuthor(rs.getString("RESOURCE_AUTHOR"));
				resourceList.add(resource);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return resourceList;
	}
	
	
	@Override
	public boolean saveModule(CourseVo courseVo, int userId,int userType) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status=false;
		int moduleId=0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getModuleName()!=null && courseVo.getModuleName()!=""){
				sql="SELECT mm.MODULE_ID FROM module_mstr mm,  course_module_map cmm WHERE mm.MODULE_NAME='"+courseVo.getModuleName().replaceAll("'", "\\\\'")+"' and cmm.MODULE_ID=mm.MODULE_ID and cmm.COURSE_ID="+courseVo.getCourseId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					moduleId = rs.getInt("MODULE_ID");
				}
				
				if(moduleId==0){
					
					sql="SELECT MAX(MODULE_ID) as MODULE_ID FROM module_mstr";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						moduleId = rs.getInt("MODULE_ID");
					}
					moduleId++;
					sql="INSERT INTO module_mstr(MODULE_ID, MODULE_NAME, DESC_TXT, METADATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) "+ 
								" VALUES(?, ?, ?,?, ?, ?, ?, ?, ?,utc_timestamp)";	
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, moduleId);
					pStmt.setString(2, courseVo.getModuleName());
					pStmt.setString(3,courseVo.getDescription());
					pStmt.setString(4, "");
					pStmt.setString(5, "0");//DELETED_FL
					pStmt.setInt(6, moduleId);//DISPLAY_NO
					pStmt.setString(7, "0");//ENABLE_FL
					pStmt.setInt(8, userId);//CREATED_BY
					pStmt.setInt(9, userId);//LAST_USERID_CD
					pStmt.execute();
					
					sql="INSERT INTO course_module_map(COURSE_ID, MODULE_ID) VALUES(?, ?)";
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, courseVo.getCourseId());
					pStmt.setInt(2, moduleId);
					int temp = pStmt.executeUpdate();
					if(temp>0)
						status=true;
/*
					courseVo.setModuleId(moduleId);
					status = saveResource(courseVo,userId,userType);*/
				}
				
			}
		} catch (SQLException se) {
			System.out.println("getOrganisations #" + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations #" + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public List<CourseVo> assignment(int courseId, int moduleId) {
		String sql = "";
		List<CourseVo> assignmentList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct assign.ASSIGNMENT_ID, cm.COURSE_NAME,mm.MODULE_NAME, assign.ASSIGNMENT_NAME,assign.DESC_TXT,assign.ASSIGNMENT_TYP_ID, assign.DELETED_FL FROM assignment assign JOIN module_assignment_map mam on mam.ASSIGNMENT_ID=assign.ASSIGNMENT_ID "+
					" JOIN module_mstr mm on mm.MODULE_ID=mam.MODULE_ID JOIN course_module_map cmm on cmm.MODULE_ID=mm.MODULE_ID JOIN course_mstr cm on cm.COURSE_ID=cmm.COURSE_ID WHERE cm.DELETED_FL='0' and mm.DELETED_FL='0'";
			
				if(courseId !=0){
					sql=sql+"and cmm.COURSE_ID="+courseId;
				}
				if(moduleId !=0){
					sql=sql+" and mam.MODULE_ID="+moduleId;
				}
			
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				CourseVo assignment = new CourseVo();
				assignment.setAssignmentName(rs.getString("ASSIGNMENT_NAME"));
				assignment.setAssignmentId(rs.getInt("ASSIGNMENT_ID"));
				assignment.setType(rs.getInt("ASSIGNMENT_TYP_ID"));
				assignment.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				assignment.setDescription(rs.getString("DESC_TXT"));
				assignment.setCourseName(rs.getString("COURSE_NAME"));
				assignment.setCourseId(courseId);
				assignment.setModuleName(rs.getString("MODULE_NAME"));
				assignment.setModuleId(moduleId);
				assignmentList.add(assignment);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return assignmentList;
	
	}

	@Override
	public boolean saveAssignment(CourseVo courseVo,int userId,int userType) {
		String sql = "";
		PreparedStatement pStmt = null;
		int assignmentId=0;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getAssignmentName()!=null && courseVo.getAssignmentName()!=""){
				sql="SELECT assign.ASSIGNMENT_ID, assign.ASSIGNMENT_NAME FROM assignment assign, module_assignment_map mam " +
						"WHERE assign.ASSIGNMENT_ID=mam.ASSIGNMENT_ID and assign.ASSIGNMENT_NAME='"+courseVo.getAssignmentName().replaceAll("'", "\\\\'")+"' and mam.MODULE_ID="+courseVo.getModuleId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					assignmentId = rs.getInt("ASSIGNMENT_ID");
				}
				
				
				if(assignmentId==0){
					
					sql="SELECT MAX(ASSIGNMENT_ID) as ASSIGNMENT_ID FROM assignment";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						assignmentId = rs.getInt("ASSIGNMENT_ID");
					}
					assignmentId++;
					sql="INSERT INTO assignment(ASSIGNMENT_ID, ASSIGNMENT_NAME, ASSIGNMENT_TYP_ID, DESC_TXT, DISPLAY_NO, ENABLE_FL, LAST_USERID_CD, LAST_UPDT_TM, DELETED_FL, CREATED_BY) "+
							" VALUES(?, ?, ?, ?, ?, ?, ?,utc_timestamp,?,?)";	
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, assignmentId);
					pStmt.setString(2, courseVo.getAssignmentName());
					pStmt.setInt(3,courseVo.getType());//ASSIGNMENT_TYP_ID
					pStmt.setString(4, courseVo.getDescription());
					pStmt.setInt(5, assignmentId);//DISPLAY_NO
					pStmt.setString(6, "0");//ENABLE_FL
					pStmt.setInt(7, userId);
					pStmt.setString(8, "0");//DELETED_FL
					pStmt.setString(9, ""+userType);//CREATED_BY
					pStmt.executeUpdate();
					
					sql="INSERT INTO module_assignment_map(MODULE_ID, ASSIGNMENT_ID) VALUES(?, ?)";
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, courseVo.getModuleId());
					pStmt.setInt(2, assignmentId);
					int count = pStmt.executeUpdate();
					
					if(count>0)
						status=true;
				}
				
			}
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}
	
	
	@Override
	public boolean saveQuestion(CourseVo courseVo,int userId,int userType) {
		String sql = "";
		PreparedStatement pStmt = null;
		int questionId=0;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getQuestion()!=null && !courseVo.getQuestion().equalsIgnoreCase("")){
				sql="SELECT qm.QUESTION_ID FROM assignment_quest_mstr qm " +
						"WHERE qm.ASSIGNMENT_ID="+courseVo.getAssignmentId()+" and qm.QUESTION_NM='"+courseVo.getQuestion().replaceAll("'", "\\\\'")+"'";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					questionId = rs.getInt("QUESTION_ID");
				}
				
				
				if(questionId==0){
					
					sql="SELECT MAX(QUESTION_ID) as QUESTION_ID FROM assignment_quest_mstr";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						questionId = rs.getInt("QUESTION_ID");
					}
					questionId++;
					if(courseVo.getType()==2){
						sql="INSERT INTO assignment_quest_mstr(QUESTION_ID, QUESTION_NM, ASSIGNMENT_ID, DISPLAY_NO, ENABLE_FL, DELETED_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) "+
								" VALUES(?, ?, ?, ?, ?, ?, ?, ?,utc_timestamp)";
						pStmt =  conn.prepareStatement(sql);
						pStmt.setInt(1, questionId);
						pStmt.setString(2, courseVo.getQuestion());
						pStmt.setInt(3,courseVo.getAssignmentId());//ASSIGNMENT_ID
						pStmt.setInt(4, 1);//DISPLAY_NO
						pStmt.setInt(5, 1);//ENABLE_FL
						pStmt.setString(6, "0");//DELETED_FL
						pStmt.setInt(7, userId);//CREATED_BY
						pStmt.setInt(8, userId);//LAST_USERID_CD
						int count = pStmt.executeUpdate();
						if(count>0)
							status=true;
					}
					else if(courseVo.getType()==4){
						sql="INSERT INTO assignment_quest_mstr(QUESTION_ID, QUESTION_NM, ASSIGNMENT_ID, DISPLAY_NO, ENABLE_FL, DELETED_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM, answer) "+
								" VALUES(?, ?, ?, ?, ?, ?, ?, ?,utc_timestamp, ?)";
						pStmt =  conn.prepareStatement(sql);
						pStmt.setInt(1, questionId);
						pStmt.setString(2, courseVo.getQuestion());
						pStmt.setInt(3,courseVo.getAssignmentId());//ASSIGNMENT_ID
						pStmt.setInt(4, 1);//DISPLAY_NO
						pStmt.setInt(5, 1);//ENABLE_FL
						pStmt.setString(6, "0");//DELETED_FL
						pStmt.setInt(7, userId);//CREATED_BY
						pStmt.setInt(8, userId);//LAST_USERID_CD
						pStmt.setString(9, courseVo.getTf());//LAST_USERID_CD
						int count = pStmt.executeUpdate();
						if(count>0)
							status=true;
					}
					else if(courseVo.getType()==3){
						sql="INSERT INTO assignment_quest_mstr(QUESTION_ID, QUESTION_NM, ASSIGNMENT_ID, DISPLAY_NO, ENABLE_FL, DELETED_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) "+
								" VALUES(?, ?, ?, ?, ?, ?, ?, ?,utc_timestamp)";
						pStmt =  conn.prepareStatement(sql);
						pStmt.setInt(1, questionId);
						pStmt.setString(2, courseVo.getQuestion());
						pStmt.setInt(3,courseVo.getAssignmentId());//ASSIGNMENT_ID
						pStmt.setInt(4, 1);//DISPLAY_NO
						pStmt.setInt(5, 1);//ENABLE_FL
						pStmt.setString(6, "0");//DELETED_FL
						pStmt.setInt(7, userId);//CREATED_BY
						pStmt.setInt(8, userId);//LAST_USERID_CD
						int count = pStmt.executeUpdate();
						if(count>0)
							status=true;
						if(status){
							saveMultiChoice(courseVo, userId, questionId);
						}
						
					}
					
				}
				
			}
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}
	
	public void saveMultiChoice(CourseVo courseVo,int userId,int questionId) {
		String sql = "";
		PreparedStatement pStmt = null;
		int optionId=0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			for(int i=0;i<courseVo.getChoice().length;i++){
				optionId=0;
				String checked="0";
				if(courseVo.getCheck() !=null){
					for(int j=0;j<courseVo.getCheck().length;j++){
						if(courseVo.getCheck()[j]==i+1){
							checked="1";
						}
					}
				}
			if(courseVo.getChoice()[i]!=null && !courseVo.getChoice()[i].equalsIgnoreCase("")){
				sql="SELECT OPTION_ID, OPTION_NM FROM assignment_mcq_options assign " +
						"WHERE QUESTION_ID="+questionId+" and OPTION_NM='"+courseVo.getChoice()[i].replaceAll("'", "\\\\'")+"'";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					optionId = rs.getInt("OPTION_ID");
				}
				
				
				if(optionId==0){
					
					sql="SELECT MAX(OPTION_ID) as OPTION_ID FROM assignment_mcq_options";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						optionId = rs.getInt("OPTION_ID");
					}
					optionId++;
					sql="INSERT INTO assignment_mcq_options(OPTION_ID, OPTION_NM, QUESTION_ID, DISPLAY_FL, ENABLE_FL, DELETED_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM, answer) "+
								" VALUES(?, ?, ?, ?, ?, ?, ?, ?, utc_timestamp, ?)";	
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, optionId);
					pStmt.setString(2, courseVo.getChoice()[i]);
					pStmt.setInt(3,questionId);//QUESTION_ID
					pStmt.setString(4, "1");//DISPLAY_FL
					pStmt.setString(5, "1");//ENABLE_FL
					pStmt.setString(6, "0");//DELETED_FL
					pStmt.setInt(7, userId);//CREATED_BY
					pStmt.setInt(8, userId);//LAST_USERID_CD
					pStmt.setString(9, checked);//answer
					 pStmt.executeUpdate();
				}
				
			}
		}
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
	}
	
	
	@Override
	public List<CourseVo> getQuestionByAssId(int assignmentId) {
		String sql = "";
		 List<CourseVo> questionList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT * FROM assignment_quest_mstr WHERE ASSIGNMENT_ID="+assignmentId;
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo que = new CourseVo();
				que.setQuestionId(rs.getInt("QUESTION_ID"));
				que.setQuestion(rs.getString("QUESTION_NM"));
				que.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				if(rs.getString("answer") !=null){
					que.setTf(rs.getString("answer"));
				}
				questionList.add(que);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getQuestionByAssId # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getQuestionByAssId # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return questionList; 
	}
	
	@Override
	public CourseVo getOptionByQuesId(int questionId) {
		String sql = "";
		CourseVo option = new CourseVo();
		 List<String> optionList = new ArrayList<String>();
		 List<Integer> checkList = new ArrayList<Integer>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT * FROM assignment_mcq_options WHERE QUESTION_ID="+questionId;
			
			rs = stmt.executeQuery(sql);
			int index=0;
			while(rs.next()){
				++index;
				optionList.add(rs.getString("OPTION_NM"));
				if(rs.getString("answer").equalsIgnoreCase("1")){
					checkList.add(index);
				}
			}
			String[] op = new String[optionList.size()];
			int[] ch = new int[checkList.size()];
			option.setChoice(optionList.toArray(op));
			for(int i=0;i<checkList.size();i++){
				ch[i]=checkList.get(i);
			}
			option.setCheck(ch);
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getQuestionByAssId # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getQuestionByAssId # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return option;
	}
	
	@Override
	public boolean saveResource(CourseVo courseVo,int userId,int userType) {
		String sql = "";
		PreparedStatement pStmt = null;
		int resourceId=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getResourceTitle()!=null && courseVo.getResourceTitle()!=""){
				sql="SELECT rm.RESOURSE_ID FROM resourse_mstr rm, module_resource_map mrm WHERE mrm.RESOURCE_ID=rm.RESOURSE_ID and rm.RESOURSE_NAME='"+courseVo.getResourceTitle().replaceAll("'", "\\\\'")+"' and mrm.MODULE_ID="+courseVo.getModuleId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					resourceId = rs.getInt("RESOURSE_ID");
				}
				
				
				if(resourceId==0){
					
					sql="SELECT MAX(RESOURSE_ID) as RESOURSE_ID FROM resourse_mstr";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						resourceId = rs.getInt("RESOURSE_ID");
					}
					resourceId++;
					sql="INSERT INTO resourse_mstr(RESOURSE_ID, RESOURSE_NAME, RESOURCE_AUTHOR, RESOURCE_DURATION, DESC_TXT, RESOURCE_TYP_ID, METADATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM, RESOURCE_URL, AUTHOR_IMG,THUMB_IMG) "+
								" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?,?, ?, ?,utc_timestamp, ?,?,?)";	
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, resourceId);
					pStmt.setString(2, courseVo.getResourceTitle());
					pStmt.setString(3, courseVo.getResAuthor());
					pStmt.setInt(4,courseVo.getResDuration());
					pStmt.setString(5, courseVo.getResourceDesc());
					pStmt.setInt(6, courseVo.getType());
					pStmt.setString(7, courseVo.getResMetadata());//METADATA
					pStmt.setString(8, "0");//DELETED_FL
					pStmt.setInt(9, resourceId);
					pStmt.setString(10, "0");//ENABLE_FL
					pStmt.setInt(11, userId);
					pStmt.setInt(12, userId);
					if(courseVo.getType()==1){
						pStmt.setString(13, courseVo.getResourceUrl());
					}if(courseVo.getType()==2||courseVo.getType()==4){
						pStmt.setString(13, courseVo.getUploadFileName());
					}if(courseVo.getType()==3){
						pStmt.setString(13,"");
					}
					pStmt.setString(14, "http://191.239.57.54:8081/resources/profile/default-profile.jpg");
					pStmt.setString(15, "http://www.projectwet.org/sites/default/files/content/images/video-default-thumb_0.png");
					pStmt.execute();
					
					sql="INSERT INTO module_resource_map(MODULE_ID, RESOURCE_ID) VALUES(?, ?)";
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, courseVo.getModuleId());
					pStmt.setInt(2, resourceId);
					int temp = pStmt.executeUpdate();
					if(temp>0)
						status=true;
				}
				
			}
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public List<CourseVo> getCourseChoiceList(int organisationId, int departmentId, int groupId, UserVo loginUser) {
		String sql = "";
		List<CourseVo> courseList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(loginUser.getUserType()==4){
			sql ="SELECT distinct COURSE_ID,COURSE_NAME FROM course_mstr where DELETED_FL='0' and COURSE_ID not in (SELECT COURSE_ID FROM school_course_map where SCHOOL_ID="+organisationId+")";
			}else{
				sql ="SELECT distinct cm.COURSE_ID, cm.COURSE_NAME FROM course_mstr cm INNER JOIN school_course_map scm on scm.COURSE_ID=cm.COURSE_ID WHERE cm.DELETED_FL='0' and scm.SCHOOL_ID="+organisationId+"  and cm.COURSE_ID not in (SELECT COURSE_ID FROM hrm_course_map WHERE HRM_ID="+groupId+")";
			}
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo course = new CourseVo();
				course.setCourseName(rs.getString("COURSE_NAME"));
				course.setCourseId(rs.getInt("COURSE_ID"));
				courseList.add(course);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return courseList;
	}

	@Override
	public boolean mapCourse(CourseVo courseVo) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status=false;
		int courseid=0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="SELECT COURSE_ID FROM hrm_course_map WHERE HRM_ID="+courseVo.getGroupId()+" and COURSE_ID="+courseVo.getCourseId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					courseid = rs.getInt("COURSE_ID");
				}
			if(courseid==0){	
				sql="INSERT INTO hrm_course_map(HRM_ID, COURSE_ID) VALUES(?, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, courseVo.getGroupId());
				pStmt.setInt(2, courseVo.getCourseId());
				int temp = pStmt.executeUpdate();
				if(temp>0)
					status=true;
			}
					
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean courseActiveDeactive(int id, String flag, String contentType) {
		boolean status=false;
		String sql="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(contentType.equalsIgnoreCase("course")){
				sql="UPDATE course_mstr SET DELETED_FL='"+flag+"', LAST_UPDT=utc_timestamp WHERE COURSE_ID="+id;
			}else if(contentType.equalsIgnoreCase("module")){
				sql="UPDATE module_mstr SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE MODULE_ID="+id;
			}else if(contentType.equalsIgnoreCase("assignment")){
				sql="UPDATE assignment SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE ASSIGNMENT_ID="+id;
			}else if(contentType.equalsIgnoreCase("resource")){
				sql="UPDATE resourse_mstr SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE RESOURSE_ID="+id;
			}else if(contentType.equalsIgnoreCase("question")){
				sql="UPDATE assignment_quest_mstr SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE QUESTION_ID="+id;
			}
			int temp = stmt.executeUpdate(sql);
			if(temp>0)
				status=true;
		
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public List<CourseVo> getActiveCourseList() {
		String sql = "";
		List<CourseVo> courseList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct cm.COURSE_ID, cm.COURSE_NAME, cm.DELETED_FL FROM course_mstr cm LEFT JOIN hrm_course_map hcm on hcm.COURSE_ID=cm.COURSE_ID LEFT JOIN class_hrm_map chm on chm.HRM_ID=hcm.HRM_ID "+
					"	LEFT JOIN school_cls_map scm on scm.CLASS_ID=chm.CLASS_ID WHERE cm.DELETED_FL='0' ";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo course = new CourseVo();
				course.setCourseName(rs.getString("COURSE_NAME"));
				course.setCourseId(rs.getInt("COURSE_ID"));
				course.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				courseList.add(course);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return courseList;
	}

	@Override
	public List<CourseVo> getOrgCourses(int organisationId) {
		String sql = "";
		List<CourseVo> courseList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(organisationId==0){
			sql = "SELECT distinct cm.COURSE_ID, cm.COURSE_NAME,cm.COURSE_AUTHOR,cm.COURSE_DURATION,cm.DESC_TXT,cm.METADATA, cm.DELETED_FL FROM course_mstr cm ";
			}else{
				sql = "SELECT distinct cm.COURSE_ID, cm.COURSE_NAME,cm.COURSE_AUTHOR,cm.COURSE_DURATION,cm.DESC_TXT,cm.METADATA,sm.SCHOOL_NAME, cm.DELETED_FL FROM course_mstr cm INNER JOIN school_course_map scm on scm.COURSE_ID=cm.COURSE_ID "+
						" INNER JOIN school_mstr sm on sm.SCHOOL_ID=scm.SCHOOL_ID WHERE  scm.SCHOOL_ID="+organisationId;
			}
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo course = new CourseVo();
				course.setCourseName(rs.getString("COURSE_NAME"));
				course.setCourseId(rs.getInt("COURSE_ID"));
				if(organisationId>0){
					course.setOrgName(rs.getString("SCHOOL_NAME"));
				}
				course.setAuthor(rs.getString("COURSE_AUTHOR"));
				course.setDuration(rs.getInt("COURSE_DURATION"));
				course.setDescription(rs.getString("DESC_TXT"));
				course.setMetadata(rs.getString("METADATA"));
				course.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				courseList.add(course);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return courseList;
	}

	@Override
	public boolean mapOrgCourse(int organisationId, int courseId) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
					sql="INSERT INTO school_course_map(SCHOOL_ID, COURSE_ID) VALUES(?, ?)";	
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, organisationId);
					pStmt.setInt(2,courseId);
					int count = pStmt.executeUpdate();
					if(count>0)
						status=true;
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean updateAssignment(CourseVo courseVo, UserVo loginUser) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="UPDATE assignment SET  ASSIGNMENT_NAME=?, DESC_TXT=?, LAST_USERID_CD=?, LAST_UPDT_TM=utc_timestamp WHERE ASSIGNMENT_ID=?";	
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, courseVo.getAssignmentName());
				pStmt.setString(2, courseVo.getDescription());
				pStmt.setInt(3, loginUser.getUserId());
				pStmt.setInt(4, courseVo.getAssignmentId());
				int count = pStmt.executeUpdate();
				if(count>0)
					status=true;
			
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean updateCourse(CourseVo courseVo, UserVo loginUser) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		String courseIcon="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getCourseIconFileName()!=null){
				courseIcon=" ,COURSE_ICON=? ";
			}
				
				sql="UPDATE course_mstr SET  COURSE_NAME=?, COURSE_AUTHOR=?, COURSE_DURATION=?, DESC_TXT=?, METADATA=?, LAST_USERID_CD=?, LAST_UPDT=utc_timestamp"+courseIcon+" WHERE COURSE_ID=?";	
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, courseVo.getCourseName());
				pStmt.setString(2, courseVo.getAuthor());
				pStmt.setInt(3, courseVo.getDuration());
				pStmt.setString(4, courseVo.getDescription());
				pStmt.setString(5, courseVo.getMetadata());
				pStmt.setInt(6, loginUser.getUserId());
				if(courseVo.getCourseIconFileName()!=null){
					pStmt.setString(7, courseVo.getCourseIconFileName());
					pStmt.setInt(8, courseVo.getCourseId());
				}else{
					pStmt.setInt(7, courseVo.getCourseId());
				}
				int count = pStmt.executeUpdate();
				if(count>0)
					status=true;
			
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean updatModule(CourseVo courseVo, UserVo loginUser) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="UPDATE module_mstr SET  MODULE_NAME=?, DESC_TXT=?, METADATA=?, LAST_USERID_CD=?, LAST_UPDT_TM=utc_timestamp WHERE MODULE_ID=?";	
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, courseVo.getModuleName());
				pStmt.setString(2, courseVo.getDescription());
				pStmt.setString(3, "");
				pStmt.setInt(4, loginUser.getUserId());
				pStmt.setInt(5, courseVo.getModuleId());
				int count = pStmt.executeUpdate();
				if(count>0)
					status=true;
			
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean updateResource(CourseVo courseVo) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="UPDATE resourse_mstr SET  RESOURSE_NAME=?, RESOURCE_AUTHOR=?, RESOURCE_DURATION=?, DESC_TXT=?, METADATA=?, LAST_UPDT_TM=utc_timestamp, RESOURCE_URL=? WHERE RESOURSE_ID=?";	
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, courseVo.getResourceTitle());
				pStmt.setString(2, courseVo.getResAuthor());
				pStmt.setInt(3, courseVo.getResDuration());
				pStmt.setString(4, courseVo.getResourceDesc());
				pStmt.setString(5, courseVo.getResMetadata());
				pStmt.setString(6, courseVo.getResourceUrl());
				/*pStmt.setString(7, courseVo.getThumbImgName());
				pStmt.setString(8, courseVo.getResAuthorImgName());*/
				pStmt.setInt(7, courseVo.getResourceId());
				int count = pStmt.executeUpdate();
				if(count>0)
					status=true;
			
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean updateQuestion(CourseVo courseVo, int userId, int userType) {
		String sql = "";
		PreparedStatement pStmt = null;
		int questionId=0;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			if(courseVo.getQuestion()!=null && !courseVo.getQuestion().equalsIgnoreCase("")){
				sql="SELECT qm.QUESTION_ID FROM assignment_quest_mstr qm " +
						"WHERE qm.ASSIGNMENT_ID="+courseVo.getAssignmentId()+" and qm.QUESTION_NM='"+courseVo.getQuestion()+"' and qm.QUESTION_ID!="+courseVo.getQuestionId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					questionId = rs.getInt("QUESTION_ID");
				}
				
				if(questionId==0){
				if(courseVo.getQuestionId()!=0){
					if(courseVo.getType()==2){
						sql="UPDATE assignment_quest_mstr  SET  QUESTION_NM='"+courseVo.getQuestion()+"', ASSIGNMENT_ID="+courseVo.getAssignmentId()+", " +
								"DISPLAY_NO=1, ENABLE_FL=1, DELETED_FL='0', CREATED_BY="+userId+", LAST_USERID_CD="+userId+"  " +
								" WHERE QUESTION_ID="+courseVo.getQuestionId()+"";
						pStmt =  conn.prepareStatement(sql);
						 
						int count = pStmt.executeUpdate();
						if(count>0)
							status=true;
					}
					
					else if(courseVo.getType()==3){
						 
						sql="UPDATE assignment_quest_mstr  SET  QUESTION_NM='"+courseVo.getQuestion()+"', ASSIGNMENT_ID="+courseVo.getAssignmentId()+", " +
								"DISPLAY_NO=1, ENABLE_FL=1, DELETED_FL='0', CREATED_BY="+userId+", LAST_USERID_CD="+userId+"  " +
								" WHERE QUESTION_ID="+courseVo.getQuestionId()+"";
						pStmt =  conn.prepareStatement(sql);
						int count = pStmt.executeUpdate();
						if(count>0)
							status=true;
						if(status){
							
							delMultiChoiceRow(courseVo, userId, courseVo.getQuestionId());
							saveMultiChoice(courseVo, userId, courseVo.getQuestionId());
						}
						
					}
					
					else if(courseVo.getType()==4){
						
						sql="UPDATE assignment_quest_mstr  SET  QUESTION_NM='"+courseVo.getQuestion()+"', ASSIGNMENT_ID="+courseVo.getAssignmentId()+", " +
								"DISPLAY_NO=1, ENABLE_FL=1, DELETED_FL='0', CREATED_BY="+userId+", LAST_USERID_CD="+userId+" ,answer='"+courseVo.getTf()+"' " +
								" WHERE QUESTION_ID="+courseVo.getQuestionId()+" ";
						
						pStmt =  conn.prepareStatement(sql);
						int count = pStmt.executeUpdate();
						if(count>0)
							status=true;
					}
				
					
				}
				}
			}
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	private void delMultiChoiceRow(CourseVo courseVo, int userId, int questionId) {
		String sql = "";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql="DELETE FROM assignment_mcq_options WHERE QUESTION_ID="+questionId+"";
			stmt.execute(sql);
			
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		
	}

	@Override
	public CourseVo getNames(int courseId, int moduleId) {
		String sql = "";
		CourseVo course=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="SELECT cm.COURSE_NAME,mm.MODULE_NAME FROM course_mstr cm inner join course_module_map cmm on cmm.COURSE_ID=cm.COURSE_ID inner join module_mstr mm " +
						" on mm.MODULE_ID=cmm.MODULE_ID WHERE cm.COURSE_ID="+courseId+" and mm.MODULE_ID="+moduleId;
				rs = stmt.executeQuery(sql);
				course = new CourseVo();
				while(rs.next()){
					course.setCourseName(rs.getString("COURSE_NAME"));
					course.setModuleName(rs.getString("MODULE_NAME"));
				}
					
		} catch (SQLException se) {
			System.out.println("getOrganisations # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrganisations # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return course;
	}

}
