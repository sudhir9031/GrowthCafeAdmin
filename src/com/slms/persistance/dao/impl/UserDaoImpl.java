package com.slms.persistance.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.slms.persistance.dao.iface.UserDao;
import com.slms.persistance.factory.LmsDaoAbstract;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.KeyValueVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public class UserDaoImpl extends LmsDaoAbstract implements UserDao {

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs ;
	
	
	@Override
	public UserVo saveTeacher(UserVo userVo, UserVo loginUser) {
		PreparedStatement pStmt = null;
		UserVo user=null;
		String sql="";
		int userId=0;
		int id=0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			/**
			 *  INSERT into user_login
			 */
			
				sql="SELECT USER_ID, USER_TYPE_ID FROM user_login WHERE USER_NM='"+userVo.getEmail()+"'";
				rs = stmt.executeQuery(sql);
				user = new UserVo();
				while(rs.next()){
					userId=rs.getInt("USER_ID");
					int userType = rs.getInt("USER_TYPE_ID");
					if(userType==2){
						user.setUserId(userId);
						user.setStatus(1);
					}else{
						user.setStatus(3);
						user.setUserType(userType);
					}
				}
				if(userId==0){
				sql="SELECT MAX(USER_ID) as USER_ID FROM user_login";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					userId=rs.getInt("USER_ID");
				}
				userId++;
				if(userId>0){
					sql ="INSERT INTO user_login(USER_ID, USER_NM, USER_PWD, USER_FB_ID, USER_TYPE_ID, DELETED_FL, ENABLE_FL, LAST_USERID_CD, LAST_UPDT_TM)  VALUES( ?,?,?,?, ?, ?, ?, ?, utc_timestamp)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, userId);
				pStmt.setString(2, userVo.getEmail());
				pStmt.setString(3, userVo.getPassword());
				pStmt.setString(4, "");//USER_FB_ID
				pStmt.setInt(5, 2);//USER_TYPE_ID
				pStmt.setString(6, "0");//DELETED_FL
				pStmt.setString(7, "0");//ENABLE_FL
				pStmt.setInt(8, loginUser.getUserId());
				pStmt.execute();
				
				/**
				 *  INSERT into feed_user_access
				 */
				
				sql="SELECT MAX(feed_user_access_id) as feed_user_access_id FROM feed_user_access";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id=rs.getInt("feed_user_access_id");
				}
				id++;
				sql="INSERT INTO feed_user_access(feed_user_access_id, user_id, access_type_id, access_for_id) VALUES(?,?,?,?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, id);
				pStmt.setInt(2, userId);
				pStmt.setInt(3, 1);
				pStmt.setInt(4, 0);
				 pStmt.executeUpdate();
				
				
				/**
				 *  INSERT into student_dtls
				 */
				sql="SELECT MAX(STUDENT_DTLS_ID) as STUDENT_DTLS_ID FROM student_dtls";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id=rs.getInt("STUDENT_DTLS_ID");
				}
				id++;
				sql="INSERT INTO student_dtls(STUDENT_DTLS_ID, USER_ID, TITLE, FNAME, LNAME, EMAIL_ID, CONTACT_NO, BIRTH_DT, JOINING_DATE, PROFILE_IMG, SOCIAL_PROFILE, ADDRESS, LAST_USERID_CD, LAST_UPDT_TM, ADMIN_EMAIL_ID) "+
							" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,utc_timestamp, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, id);
				pStmt.setInt(2, userId);
				pStmt.setString(3, userVo.getTitle());
				pStmt.setString(4, userVo.getFname());
				pStmt.setString(5, userVo.getLname());
				pStmt.setString(6, userVo.getEmail());
				pStmt.setString(7, userVo.getContactNo());//CONTACT_NO
				pStmt.setString(8, null);//BIRTH_DT
				pStmt.setString(9, null);//JOINING_DATE
				pStmt.setString(10, "default-profile.jpg");//PROFILE_IMG
				pStmt.setString(11, "");//SOCIAL_PROFILE
				pStmt.setString(12, "");//ADDRESS
				pStmt.setInt(13, loginUser.getUserId());
				pStmt.setString(14, "admin@admin.com");
				 pStmt.executeUpdate();
				 
				 
				 sql="INSERT INTO school_user_map(SCHOOL_ID, USER_ID) VALUES(?, ?)";
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, loginUser.getOrganisationId());
					pStmt.setInt(2, userId);
					pStmt.executeUpdate();
				}
				user.setStatus(2);
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
		return user;
	}


	@Override
	public List<UserVo> getTeachers(int organisationId) {
		List<UserVo> teachers=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="";
				
				sql="SELECT distinct stud.USER_ID, stud.TITLE, stud.CONTACT_NO, stud.ADDRESS, stud.FNAME, stud.LNAME, stud.EMAIL_ID ,usl.ENABLE_FL, usl.USER_PWD, (SELECT count(*) FROM teacher_courses WHERE TEACHER_ID=stud.EMAIL_ID  and SCHOOL_ID="+organisationId+") as courseCount "+
						" FROM  user_login usl , student_dtls stud  INNER JOIN school_user_map scm on scm.USER_ID=stud.USER_ID WHERE usl.USER_ID=stud.USER_ID and usl.USER_TYPE_ID=2 ";
				if(organisationId>0){
					sql = sql+" and scm.SCHOOL_ID="+organisationId;
				}
				rs = stmt.executeQuery(sql);
				teachers = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  user = new UserVo();
					user.setTitle(rs.getString("TITLE"));
					user.setUserId(rs.getInt("USER_ID"));
					user.setContactNo(rs.getString("CONTACT_NO"));
					user.setPassword(rs.getString("USER_PWD"));
					user.setAddress(rs.getString("ADDRESS"));
					user.setFname(rs.getString("FNAME"));
					user.setLname(rs.getString("LNAME"));
					user.setEmail(rs.getString("EMAIL_ID"));
					user.setCount(rs.getInt("courseCount"));
					user.setStatus(rs.getInt("ENABLE_FL"));
					teachers.add(user);
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
		return teachers;
	}


	@Override
	public boolean mapTeacher(UserVo userVo,int userId) {
		PreparedStatement pStmt = null;
		boolean status=false;
		String sql="";
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql="Delete from teacher_course_session_map where TEACHER_ID=?";
			
			PreparedStatement pt= conn.prepareStatement(sql);
			pt.setInt(1, userVo.getUserId());//TEACHER_ID
			pt.execute();
			
			for(int i=0;i<userVo.getContainers().length;i++){
				int teacourseId=0;
				sql="SELECT COURSE_ID FROM hrm_course_map WHERE HRM_ID="+userVo.getContainers()[i];
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					int courseId=rs.getInt("COURSE_ID");
					userVo.setCourseId(courseId);
					userVo.setGroupId(userVo.getContainers()[i]);
				}
				
				
				sql="SELECT TEACHER_COURSE_ID FROM teacher_courses WHERE CLASS_ID="+userVo.getDepartmentId()+" and SCHOOL_ID="+userVo.getOrganisationId()+" and HRM_ID="+userVo.getGroupId()+" and COURSE_ID="+userVo.getCourseId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					teacourseId=rs.getInt("TEACHER_COURSE_ID");
				}
				
					if(teacourseId==0){
						teacourseId =	insertDataIntoCoursesTable(userVo,userId);
					}/*else{
					
					updateCoachContainerMap(userVo.getUserId(), teacourseId);
				}*/
					
					sql="INSERT INTO teacher_course_session_map(TEACHER_ID, TEACHER_COURSE_ID, IS_ACTIVE) VALUES(?, ?, '1')";
					
					PreparedStatement pStmt1 = conn.prepareStatement(sql);
					pStmt1.setInt(1, userVo.getUserId());//TEACHER_ID
					pStmt1.setInt(2, teacourseId);//TEACHER_ID
					pStmt1.executeUpdate();
					
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
	
	
	public boolean updateCoachContainerMap(int userId,int teacourseId) {
		PreparedStatement pStmt = null;
		boolean status=false;
		String sql="";
		
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				
				sql="UPDATE teacher_courses SET TEACHER_ID="+userId+", LAST_UPDT_TM=utc_timestamp WHERE TEACHER_COURSE_ID="+teacourseId;
				stmt.executeUpdate(sql);
				
				sql="SELECT COURSE_SESSION_ID FROM teacher_course_sessions WHERE TEACHER_COURSE_ID="+teacourseId;
				rs = stmt.executeQuery(sql);
				int id=0;
				while(rs.next()){
					id =rs.getInt("COURSE_SESSION_ID");
				}
				
				sql="UPDATE teacher_course_session_dtls SET TEACHER_ID="+userId+", LAST_UPDT_TM=utc_timestamp WHERE COURSE_SESSION_ID="+id;
				int i = stmt.executeUpdate(sql);
				if(i>0){
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
	
	/**
	 *method inserting fresh transaction data into courses transaction tables
	 *while mapping course container to coach. when that container not already assign to any coach
	 */
	
	public int insertDataIntoCoursesTable(UserVo userVo, int userId) {
		PreparedStatement pStmt = null;
		boolean status=false;
		String sql="";
		int teacourseId=0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();	
		
				/**
				 *  INSERT into teacher_courses
				 */
			
			sql="SELECT MAX(TEACHER_COURSE_ID) as TEACHER_COURSE_ID FROM teacher_courses";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				teacourseId=rs.getInt("TEACHER_COURSE_ID");
			}
			teacourseId++;
			if(teacourseId>0){
				sql ="INSERT INTO teacher_courses(TEACHER_COURSE_ID, COURSE_ID, TEACHER_ID, CLASS_ID, SCHOOL_ID, HRM_ID, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) "+
						" VALUES(?, ?, ?, ?,?, ?, ?, ?, ?, ?, utc_timestamp)";
			pStmt =  conn.prepareStatement(sql);
			pStmt.setInt(1, teacourseId);
			pStmt.setInt(2, userVo.getCourseId());
			pStmt.setInt(3, userVo.getUserId());
			pStmt.setInt(4, userVo.getDepartmentId());
			pStmt.setInt(5, userVo.getOrganisationId());
			pStmt.setInt(6, userVo.getGroupId());
			pStmt.setInt(7, teacourseId);//DISPLAY_NO
			pStmt.setString(8, "1");
			pStmt.setInt(9, userId);
			pStmt.setInt(10, userId);
			pStmt.execute();
			
			/**
			 *  INSERT into teacher_course_sessions
			 */
			
			sql="SELECT MAX(COURSE_SESSION_ID) as COURSE_SESSION_ID FROM teacher_course_sessions";
			rs = stmt.executeQuery(sql);
			int id=0;
			while(rs.next()){
				id=rs.getInt("COURSE_SESSION_ID");
			}
			id++;
			sql="INSERT INTO teacher_course_sessions(COURSE_SESSION_ID, TEACHER_COURSE_ID, START_SESSION_TM, END_SESSION_TM, STATUS_TXT, IS_COMPLETE, LAST_USERID_CD, LAST_UPDT_TM, COURSE_ID, COURSE_NAME, COURSE_AUTHOR, AUTHOR_IMG, COURSE_DURATION, CREATED_DT, DESC_TXT, METADATA, DELETED_FL) "+
					" SELECT ?,?,null, null, ?, ?,?,utc_timestamp,COURSE_ID,COURSE_NAME,COURSE_AUTHOR,AUTHOR_IMG,COURSE_DURATION,null,DESC_TXT,METADATA,DELETED_FL FROM course_mstr where COURSE_ID=?";
			pStmt =  conn.prepareStatement(sql);
			pStmt.setInt(1, id);//COURSE_SESSION_ID
			pStmt.setInt(2, teacourseId);//TEACHER_COURSE_ID
			pStmt.setString(3, "");//STATUS_TXT
			pStmt.setString(4, "2");//IS_COMPLETE
			pStmt.setInt(5, userId);//LAST_USERID_CD
			pStmt.setInt(6, userVo.getCourseId());
			 pStmt.executeUpdate();
			
			
			 
			/**
			 *  INSERT into teacher_course_session_dtls
			 */
			sql="SELECT mm.MODULE_ID FROM module_mstr mm, course_module_map cmm WHERE mm.DELETED_FL='0' and cmm.MODULE_ID=mm.MODULE_ID and cmm.COURSE_ID="+userVo.getCourseId();
			rs = stmt.executeQuery(sql);
				List<Integer> modules = new ArrayList<Integer>();
				while(rs.next()){
					int module=rs.getInt("MODULE_ID");
					modules.add(module);
				}
				
				for(int i=0;i<modules.size();i++){
				int moduleId=modules.get(i);
				sql="INSERT INTO teacher_course_session_dtls( COURSE_SESSION_ID, TEACHER_ID, MODULE_ID, CONTENT_ID, START_SESSION_TM, END_SESSION_TM, IS_COMPLETED, LAST_USERID_CD, LAST_UPDT_TM, MODULE_NAME, DESC_TXT, METADATA, DELETED_FL) "+
						" SELECT ?, ?, ?, ?, null, null, '2', ?, utc_timestamp, MODULE_NAME, DESC_TXT, METADATA, DELETED_FL FROM module_mstr where MODULE_ID=?";
				
				PreparedStatement pStmt1 =  conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				pStmt1.setInt(1, id);//COURSE_SESSION_ID
				pStmt1.setInt(2, userVo.getUserId());//TEACHER_ID
				pStmt1.setInt(3, moduleId);//MODULE_ID
				pStmt1.setInt(4,0);
				pStmt1.setInt(5, userId);//LAST_USERID_CD
				pStmt1.setInt(6,moduleId);
				pStmt1.executeUpdate();
				
				
				ResultSet rs1 = pStmt1.getGeneratedKeys();
				int generatedKey = 0;
				if (rs1.next()) {
				    generatedKey = rs1.getInt(1);
				}
				 
				
				sql="SELECT RESOURSE_ID FROM resourse_mstr rm, module_resource_map mrm WHERE rm.DELETED_FL='0' and mrm.RESOURCE_ID=rm.RESOURSE_ID and mrm.MODULE_ID="+moduleId;
				ResultSet rs2 = stmt.executeQuery(sql);
				int resourceId=0;
				while(rs2.next()){
					resourceId=rs2.getInt("RESOURSE_ID");
					
					/**
					 *  INSERT into teacher_module_session_dtls
					 */
					
					sql="INSERT INTO teacher_module_session_dtls (COURSE_SESSION_DTLS_ID, CONTENT_ID, START_SESSION_TM, END_SESSION_TM, IS_COMPLETED, LAST_USERID_CD, LAST_UPDT_TM, RESOURSE_NAME, RESOURCE_AUTHOR, RESOURCE_DURATION, DESC_TXT, RESOURCE_TYP_ID, METADATA, RESOURCE_URL, AUTHOR_IMG, THUMB_IMG, DELETED_FL) "+
							" SELECT ?, ?, null, null, '0', ?, utc_timestamp, RESOURSE_NAME, RESOURCE_AUTHOR, RESOURCE_DURATION, DESC_TXT, RESOURCE_TYP_ID, METADATA, RESOURCE_URL, AUTHOR_IMG, THUMB_IMG, DELETED_FL  FROM resourse_mstr where RESOURSE_ID=?";
					PreparedStatement pStmt2 =  conn.prepareStatement(sql);
					pStmt2.setInt(1, generatedKey);//COURSE_SESSION_ID
					pStmt2.setInt(2, resourceId);//TEACHER_COURSE_ID
					pStmt2.setInt(3, userId);//LAST_USERID_CD
					pStmt2.setInt(4, resourceId);
					pStmt2.executeUpdate();
				}
			}
		}
		
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return teacourseId;
	}


	@Override
	public List<UserVo> teacherDeatil(int userId, int organisationId) {
		List<UserVo> teacherDetail=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="";
				
			/*	sql="SELECT sm.SCHOOL_NAME, cm.CLASS_NAME, hm.HRM_NAME, course.COURSE_NAME  FROM teacher_courses tc inner JOIN school_mstr sm on sm.SCHOOL_ID=tc.SCHOOL_ID "+
						" inner JOIN class_mstr cm on cm.CLASS_ID=tc.CLASS_ID inner JOIN homeroom_mstr hm on hm.HRM_ID = tc.HRM_ID inner JOIN course_mstr course on course.COURSE_ID = tc.COURSE_ID "+
						" WHERE tc.TEACHER_ID="+userId+"  and tc.SCHOOL_ID="+organisationId;*/
				
				sql="SELECT hm.HRM_NAME, hm.start_dt, tcm.IS_COMPLETE FROM teacher_course_session_map tcsm inner join teacher_courses tc on tc.TEACHER_COURSE_ID=tcsm.TEACHER_COURSE_ID "+
						" inner join teacher_course_sessions tcm on tcm.TEACHER_COURSE_ID=tc.TEACHER_COURSE_ID inner join homeroom_mstr  hm on hm.HRM_ID = tc.HRM_ID "+
						" WHERE tcsm.TEACHER_ID="+userId+"  and tc.SCHOOL_ID="+organisationId;
				
				rs = stmt.executeQuery(sql);
				teacherDetail = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  user = new UserVo();
					user.setJoiningDate(rs.getString("start_dt"));
					user.setGroupName(rs.getString("HRM_NAME"));
					user.setStatus(Integer.parseInt(rs.getString("IS_COMPLETE")));
					teacherDetail.add(user);
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
		return teacherDetail;
	}

	
	
	
	
	

	@Override
	public List<UserVo> getStudents(int organisationId) {
		List<UserVo> studentsList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT distinct sd.STUDENT_DTLS_ID, sd.USER_ID, sd.TITLE, sd.FNAME, sd.LNAME, sd.EMAIL_ID, sm.SCHOOL_NAME, ul.DELETED_FL, ul.USER_PWD, ucm.CLASS_ID " +
					" FROM student_dtls sd JOIN user_cls_map ucm on ucm.USER_ID = sd.USER_ID JOIN user_login ul on ul.USER_ID= sd.USER_ID JOIN school_mstr sm on sm.SCHOOL_ID = ucm.SCHOOL_ID "+
					" JOIN class_mstr cm on cm.CLASS_ID=ucm.CLASS_ID JOIN homeroom_mstr hm on hm.HRM_ID=ucm.HRM_ID  WHERE ucm.end_dt  IS NULL and ul.ENABLE_FL='1' and ul.USER_TYPE_ID=3";
				
				if(organisationId>0){
					sql=sql+" and ucm.SCHOOL_ID="+organisationId;
				}
				rs = stmt.executeQuery(sql);
				studentsList = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  student = new UserVo();
					student.setUserId(rs.getInt("USER_ID"));
					student.setFname(rs.getString("FNAME"));
					student.setEmail(rs.getString("EMAIL_ID"));
					student.setLname(rs.getString("LNAME"));
					student.setOrgName(rs.getString("SCHOOL_NAME"));
					student.setPassword(rs.getString("USER_PWD"));
					student.setTitle(rs.getString("TITLE"));
					student.setDepartmentId(rs.getInt("CLASS_ID"));
					student.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
					studentsList.add(student);
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
		return studentsList;
	}


	@Override
	public UserVo changeUserLoginStatus(int userId, int login_Status) {
		UserVo student=null;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="UPDATE user_login SET  ENABLE_FL='"+login_Status+"', LAST_UPDT_TM=utc_timestamp  WHERE USER_ID="+userId;
			int temp = stmt.executeUpdate(sql);
			if(temp>0)
				status=true;
				if(status){
				sql="SELECT ul.USER_ID, ul.USER_NM, ul.ENABLE_FL, ul.USER_PWD, sd.FNAME, sd.LNAME, sm.SCHOOL_NAME, cm.CLASS_NAME, hm.HRM_NAME FROM user_login  ul "+
						" JOIN student_dtls sd on sd.USER_ID=ul.USER_ID JOIN user_cls_map ucm on ucm.USER_ID=ul.USER_ID JOIN school_mstr sm on sm.SCHOOL_ID=ucm.SCHOOL_ID "+
						" JOIN class_mstr cm on cm.CLASS_ID= ucm.CLASS_ID JOIN homeroom_mstr hm on hm.HRM_ID= ucm.HRM_ID WHERE ul.USER_ID="+userId;
				
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					student= new UserVo();
					student.setEmail(rs.getString("USER_NM"));
					student.setStatus(Integer.parseInt(rs.getString("ENABLE_FL")));
					student.setPassword(rs.getString("USER_PWD"));
					student.setFname(rs.getString("FNAME"));
					student.setLname(rs.getString("LNAME"));
					student.setOrgName(rs.getString("SCHOOL_NAME"));
					student.setDepName(rs.getString("CLASS_NAME"));
					student.setGroupName(rs.getString("HRM_NAME"));
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
		return student;
	}


	@Override
	public boolean changeTeacherStatus(int userId, int login_Status) {
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="UPDATE user_login SET  ENABLE_FL='"+login_Status+"', LAST_UPDT_TM=utc_timestamp  WHERE USER_ID="+userId;
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
	public UserVo getUserPassword(String email) {
		UserVo userVo =null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT ul.USER_PWD, sd.FNAME, sd.LNAME FROM user_login ul, student_dtls sd WHERE ul.USER_NM='"+email+"' and ul.USER_ID=sd.USER_ID";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				userVo= new UserVo();
				userVo.setPassword(rs.getString("USER_PWD"));
				userVo.setFname(rs.getString("FNAME"));
				userVo.setLname(rs.getString("LNAME"));
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
		return userVo;
	}


	@Override
	public boolean updateTeacher(UserVo userVo, int userId) {
		String sql = "";
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				sql="UPDATE student_dtls SET  TITLE='"+userVo.getTitle()+"', FNAME='"+userVo.getFname()+"', LNAME='"+userVo.getLname()+"', CONTACT_NO='"+userVo.getContactNo()+
						"', ADDRESS='"+userVo.getAddress()+"', LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp WHERE USER_ID="+userVo.getUserId();
				stmt.executeUpdate(sql);
				
				sql="UPDATE user_login SET  USER_PWD='"+userVo.getPassword()+"', LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp WHERE USER_ID="+userVo.getUserId();
				int temp = stmt.executeUpdate(sql);
				if(temp>0)
					status=true;
				
			} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
			return status;
	}


	@Override
	public List<UserVo> getTeacherChoice(UserVo userVo) {
		List<UserVo> teachers=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT sd.EMAIL_ID, sd.FNAME, sd.LNAME, sd.USER_ID FROM school_user_map scum INNER JOIN student_dtls sd on sd.USER_ID= scum.USER_ID INNER JOIN user_login ul on ul.USER_ID=scum.USER_ID WHERE ul.USER_TYPE_ID=2 and scum.SCHOOL_ID="+userVo.getOrganisationId()+" and sd.EMAIL_ID "+
					" not in (SELECT TEACHER_ID FROM teacher_courses WHERE SCHOOL_ID="+userVo.getOrganisationId()+" and  CLASS_ID="+userVo.getDepartmentId()+" and HRM_ID="+userVo.getGroupId()+" and COURSE_ID="+userVo.getCourseId()+")";
				
				rs = stmt.executeQuery(sql);
				teachers = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  user = new UserVo();
					user.setEmail(rs.getString("EMAIL_ID"));
					user.setFname(rs.getString("FNAME"));
					user.setLname(rs.getString("LNAME"));
					user.setUserId(rs.getInt("USER_ID"));
					teachers.add(user);
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
		return teachers;
	}


	@Override
	public boolean mapTeaherNewOrg(int mapTeacherId, int organisationId) {
			String sql = "";
			boolean status=false;
			try {
				conn = getConnection();
				stmt = conn.createStatement();
				 sql="INSERT INTO school_user_map(SCHOOL_ID, USER_ID) VALUES("+organisationId+","+mapTeacherId+")";
				 int temp = stmt.executeUpdate(sql);
					if(temp>0)
						status=true;
					
				} catch (SQLException se) {
					System.out.println("updateTeacher # " + se);
					se.printStackTrace();
				} catch (Exception e) {
					System.out.println("updateTeacher # " + e);
					e.printStackTrace();
				} finally {
					closeResources(conn, stmt, null);
				}
				return status;
	}


	@Override
	public int saveStudent(UserVo userVo, UserVo loginUser) {
		int saveCase=0;
		PreparedStatement pStmt = null;
		String sql = "";
		int userId=0;
		int id=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			sql="SELECT USER_ID FROM user_login WHERE USER_NM='"+userVo.getEmail()+"' AND USER_TYPE_ID=3";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				UserVo  user = new UserVo();
				userId=rs.getInt("USER_ID");
			}
			if(userId==0){
				saveCase=1;
				sql="SELECT MAX(USER_ID) as USER_ID FROM user_login";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					userId=rs.getInt("USER_ID");
				}
				userId++;
				if(userId>0){
					sql ="INSERT INTO user_login(USER_ID, USER_NM, USER_PWD, USER_FB_ID, USER_TYPE_ID, DELETED_FL, ENABLE_FL, LAST_USERID_CD, LAST_UPDT_TM)  VALUES( ?,?,?,?, ?, ?, ?, ?, utc_timestamp)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, userId);
				pStmt.setString(2, userVo.getEmail());
				pStmt.setString(3, userVo.getPassword());
				pStmt.setString(4, "");//USER_FB_ID
				pStmt.setInt(5, 3);//USER_TYPE_ID
				pStmt.setString(6, "0");//DELETED_FL
				pStmt.setString(7, "1");//ENABLE_FL
				pStmt.setInt(8, loginUser.getUserId());//LAST_USERID_CD
				pStmt.execute();
				
				
				/**
				 *  INSERT into student_dtls
				 */
				sql="SELECT MAX(STUDENT_DTLS_ID) as STUDENT_DTLS_ID FROM student_dtls";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id=rs.getInt("STUDENT_DTLS_ID");
				}
				id++;
				sql="INSERT INTO student_dtls(STUDENT_DTLS_ID, USER_ID, TITLE, FNAME, LNAME, EMAIL_ID, CONTACT_NO, BIRTH_DT, JOINING_DATE, PROFILE_IMG, SOCIAL_PROFILE, ADDRESS, LAST_USERID_CD, LAST_UPDT_TM, ADMIN_EMAIL_ID) "+
							" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,utc_timestamp, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, id);
				pStmt.setInt(2, userId);
				pStmt.setString(3, userVo.getTitle());
				pStmt.setString(4, userVo.getFname());
				pStmt.setString(5, userVo.getLname());
				pStmt.setString(6, userVo.getEmail());
				pStmt.setString(7, "");//CONTACT_NO
				pStmt.setString(8, null);//BIRTH_DT
				pStmt.setString(9, null);//JOINING_DATE
				pStmt.setString(10, "default-profile.jpg");//PROFILE_IMG
				pStmt.setString(11, "");//SOCIAL_PROFILE
				pStmt.setString(12, userVo.getAddress());
				pStmt.setInt(13, loginUser.getUserId());
				pStmt.setString(14, loginUser.getEmail());
				int temp = pStmt.executeUpdate();
				if(temp>0)
					status=true;
				if(status){
					saveCase=2;
					status=false;
					
					sql="SELECT HRM_ID FROM class_hrm_map WHERE CLASS_ID="+userVo.getDepartmentId();
					rs = stmt.executeQuery(sql);
					
					while(rs.next()){
						 sql="INSERT INTO user_cls_map(USER_ID, SCHOOL_ID, CLASS_ID, HRM_ID,start_dt,REQUEST_STATUS) VALUES(?, ?, ?, ?,utc_timestamp,'1')";
						 pStmt =  conn.prepareStatement(sql);
						 pStmt.setInt(1, userId);
						 pStmt.setInt(2, loginUser.getOrganisationId());
						 pStmt.setInt(3, userVo.getDepartmentId());
						 pStmt.setInt(4, rs.getInt("HRM_ID"));
						 temp = pStmt.executeUpdate();
					}
					
					
						if(temp>0)
							status=true;
				}
				
			}
			
			}else{
				if(userId==userVo.getUserId()){
					sql="UPDATE student_dtls SET  TITLE='"+userVo.getTitle()+"', FNAME='"+userVo.getFname()+"', LNAME='"+userVo.getLname()+"', EMAIL_ID='"+userVo.getPassword()+"', LAST_USERID_CD="+loginUser.getUserId()+", LAST_UPDT_TM=utc_timestamp  WHERE  USER_ID="+userVo.getUserId();
					stmt.executeUpdate(sql);
				}
				
			}
				
			} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
			return saveCase;
	}

	/**
	 * @author Yogendra
	 * @param userId
	 * @return department List of a student
	 * call from UserServiceImpl getStudents() method
	 * 
	 */

	@Override
	public List<OrganisationVo> studentDepartmentsByUserId(int userId) {
		List<OrganisationVo> depList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT distinct cm.CLASS_ID, cm.CLASS_NAME, ucm.start_dt, ucm.end_dt FROM user_cls_map ucm inner join class_mstr cm on cm.CLASS_ID=ucm.CLASS_ID " +
					"WHERE ucm.USER_ID="+userId;
				
				rs = stmt.executeQuery(sql);
				depList = new ArrayList<OrganisationVo>();
				while(rs.next()){
					OrganisationVo  dep = new OrganisationVo();
					dep.setDepartmentId(rs.getInt("CLASS_ID"));
					dep.setDepartmentName(rs.getString("CLASS_NAME"));
					dep.setStartDate(rs.getString("start_dt"));
					dep.setEndDate(rs.getString("end_dt"));
					depList.add(dep);
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
		return depList;
	}

	/**
	 * @author Yogendra
	 * @param userId
	 * @return container List of a student
	 * call from UserServiceImpl getStudents() method
	 * 
	 */
	@Override
	public List<OrganisationVo> studentContainersByUserId(int userId) {
		List<OrganisationVo> containerList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT distinct hm.HRM_ID, hm.HRM_NAME, ucm.start_dt, ucm.end_dt FROM user_cls_map ucm inner join homeroom_mstr hm on hm.HRM_ID=ucm.HRM_ID " +
					"WHERE hm.CREATED_BY !=0 and ucm.USER_ID="+userId;
				
				rs = stmt.executeQuery(sql);
				containerList = new ArrayList<OrganisationVo>();
				while(rs.next()){
					OrganisationVo  container = new OrganisationVo();
					container.setGroupId(rs.getInt("HRM_ID"));
					container.setGroupName(rs.getString("HRM_NAME"));
					container.setStartDate(rs.getString("start_dt"));
					container.setEndDate(rs.getString("end_dt"));
					containerList.add(container);
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
		return containerList;
	}

	
	/**
	 * @author Yogendra
	 * @param organisationId , userId
	 * @return department List availabe for student mapping (excluding current department)
	 * call from UserServiceImpl getStudents() method
	 * 
	 */
	@Override
	public List<KeyValueVo> availableDep(int organisationId, int userId) {
		List<KeyValueVo> depList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT cm.CLASS_ID, cm.CLASS_NAME FROM class_mstr cm inner join school_cls_map scm on scm.CLASS_ID=cm.CLASS_ID "+
					" WHERE cm.CREATED_BY !=0 and scm.SCHOOL_ID="+organisationId+" and cm.CLASS_ID not in( SELECT distinct CLASS_ID FROM user_cls_map WHERE end_dt IS NULL and USER_ID="+userId+" and SCHOOL_ID="+organisationId+")";
				
				rs = stmt.executeQuery(sql);
				depList = new ArrayList<KeyValueVo>();
				while(rs.next()){
					KeyValueVo  dep = new KeyValueVo();
					dep.setKey(rs.getInt("CLASS_ID"));
					dep.setValue(rs.getString("CLASS_NAME"));
					depList.add(dep);
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
		return depList;
	}


	@Override
	public List<KeyValueVo> availableContainer(int organisationId, int userId) {
		List<KeyValueVo> containerList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT distinct hm.HRM_ID, hm.HRM_NAME, hm.start_dt FROM homeroom_mstr hm inner join class_hrm_map chm on chm.HRM_ID=hm.HRM_ID inner join class_mstr cm on cm.CLASS_ID=chm.CLASS_ID "+
					" inner join school_cls_map scm on scm.CLASS_ID=chm.CLASS_ID WHERE cm.CREATED_BY =0 and scm.SCHOOL_ID="+organisationId+" and hm.HRM_ID not in(SELECT distinct HRM_ID FROM user_cls_map WHERE USER_ID="+userId+" and SCHOOL_ID="+organisationId+")";
				
				rs = stmt.executeQuery(sql);
				containerList = new ArrayList<KeyValueVo>();
				while(rs.next()){
					KeyValueVo  container = new KeyValueVo();
					container.setKey(rs.getInt("HRM_ID"));
					container.setValue(rs.getString("HRM_NAME"));
					container.setStartDate(rs.getString("start_dt"));
					containerList.add(container);
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
		return containerList;
	}


	@Override
	public List<UserVo> newRegistration(int organisationId) {
		List<UserVo> studentsList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT distinct sd.STUDENT_DTLS_ID,cm.CLASS_NAME, sd.USER_ID, sd.FNAME, sd.LNAME, sd.EMAIL_ID, sm.SCHOOL_NAME, ul.ENABLE_FL " +
					" FROM student_dtls sd JOIN user_cls_map ucm on ucm.USER_ID = sd.USER_ID JOIN user_login ul on ul.USER_ID= sd.USER_ID JOIN school_mstr sm on sm.SCHOOL_ID = ucm.SCHOOL_ID "+
					" JOIN class_mstr cm on cm.CLASS_ID=ucm.CLASS_ID JOIN homeroom_mstr hm on hm.HRM_ID=ucm.HRM_ID  WHERE ul.ENABLE_FL !='1' and ul.USER_TYPE_ID=3";
				
				if(organisationId>0){
					sql=sql+" and ucm.SCHOOL_ID="+organisationId;
				}
				rs = stmt.executeQuery(sql);
				studentsList = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  student = new UserVo();
					student.setUserId(rs.getInt("USER_ID"));
					student.setFname(rs.getString("FNAME"));
					student.setEmail(rs.getString("EMAIL_ID"));
					student.setLname(rs.getString("LNAME"));
					student.setOrgName(rs.getString("SCHOOL_NAME"));
					student.setDepName(rs.getString("CLASS_NAME"));
					student.setStatus(Integer.parseInt(rs.getString("ENABLE_FL")));
					studentsList.add(student);
				}
				
		} catch (SQLException se) {
			System.out.println("newRegistration # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("newRegistration # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return studentsList;
	}


	@Override
	public void changeNewUserStatus(UserVo userVo, int userId) {
		String sql = "";
		int flag=0;
		boolean status=false;
		if(userVo.getStatus()==1){
			 flag=1;
		}else{
			flag=3;
		}
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			for(int id :userVo.getContainers()){
			 sql="UPDATE user_login SET  ENABLE_FL='"+flag+"', LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp WHERE USER_ID="+id;
			 int temp = stmt.executeUpdate(sql);
				if(temp>0)
					status=true;
			}
			} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
	}


	@Override
	public List<UserVo> sessionRequestPending(int courseId, int departmentId, int groupId) {
		List<UserVo> courseList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT distinct sd.FNAME, sd.LNAME,sd.USER_ID, hm.HRM_ID, hm.HRM_NAME, hm.start_dt,ucm.REQUEST_STATUS,cm.CLASS_NAME,cm.CLASS_ID FROM user_cls_map ucm  inner join hrm_course_map hcm on hcm.HRM_ID=ucm.HRM_ID "+
					" inner join homeroom_mstr hm on hm.HRM_ID=ucm.HRM_ID inner join class_mstr cm on cm.CLASS_ID=ucm.CLASS_ID inner join student_dtls sd on sd.USER_ID=ucm.USER_ID WHERE ucm.REQUEST_STATUS !=2 and hm.CREATED_BY !=0 and  hcm.COURSE_ID="+courseId;
				if(departmentId>0){
					 sql=sql+" and ucm.CLASS_ID="+departmentId;
				}
				if(groupId>0){
					 sql=sql+" and ucm.HRM_ID="+groupId;
				}
				rs = stmt.executeQuery(sql);
				courseList = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  student = new UserVo();
					student.setUserId(rs.getInt("USER_ID"));
					student.setGroupId(rs.getInt("HRM_ID"));
					student.setFname(rs.getString("FNAME"));
					student.setLname(rs.getString("LNAME"));
					student.setDepName(rs.getString("CLASS_NAME"));
					student.setStartDate(rs.getString("start_dt"));
					student.setStatus(Integer.parseInt(rs.getString("REQUEST_STATUS")));
					courseList.add(student);
				}
				
		} catch (SQLException se) {
			System.out.println("sessionRequestPending # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("sessionRequestPending # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return courseList;
	}


	@Override
	public List<CourseVo> getInsLedCoursesByOrgId(int organisationId) {
		List<CourseVo> courseList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="SELECT cm.COURSE_ID, cm.COURSE_NAME FROM school_course_map scm inner join course_mstr cm on cm.COURSE_ID= scm.COURSE_ID "+
					" WHERE cm.DELETED_FL='0' and cm.is_self_driven !=1 and scm.SCHOOL_ID="+organisationId;
				rs = stmt.executeQuery(sql);
				courseList = new ArrayList<CourseVo>();
				while(rs.next()){
					CourseVo  course = new CourseVo();
					course.setCourseId(rs.getInt("COURSE_ID"));
					course.setCourseName(rs.getString("COURSE_NAME"));
					courseList.add(course);
				}
				
		} catch (SQLException se) {
			System.out.println("sessionRequestPending # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("sessionRequestPending # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return courseList;
	}


	@Override
	public void changeCourseReqStatus(UserVo userVo) {
		String sql = "";
		int flag=0;
		boolean status=false;
		if(userVo.getStatus()==1){
			 flag=2;
		}else{
			flag=3;
		}
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			for(int i=0;i<userVo.getContainers().length;i++){
			 sql="UPDATE user_cls_map SET REQUEST_STATUS='"+flag+"' WHERE USER_ID="+userVo.getUsers()[i]+" and HRM_ID="+userVo.getContainers()[i];
			 int temp = stmt.executeUpdate(sql);
				if(temp>0)
					status=true;
			}
			} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
	}


	@Override
	public int mapContainerToUser(UserVo userVo, UserVo loginUser) {
		String sql = "";
		PreparedStatement pStmt =null;
		int status=0;
		try {
			conn = getConnection();
			 sql="INSERT INTO user_cls_map(USER_ID, SCHOOL_ID, CLASS_ID, HRM_ID, start_dt, end_dt, REQUEST_STATUS, ASSIGN_TYPE) VALUES(?, ?, ?, ?, utc_timestamp, null, ?, ?)";
			 pStmt = conn.prepareStatement(sql);
			 pStmt.setInt(1, userVo.getUserId());
			 pStmt.setInt(2, loginUser.getOrganisationId());
			 pStmt.setInt(3, userVo.getDepartmentId());
			 pStmt.setInt(4, userVo.getGroupId());
			 pStmt.setString(5, "2");
			 pStmt.setString(6, "1");
			 int temp = pStmt.executeUpdate();
				if(temp>0)
					status=1;
				if(status==1){
					stmt=conn.createStatement();
					sql="SELECT cm.is_self_driven, cm.COURSE_ID FROM hrm_course_map hrm inner join course_mstr cm on cm.COURSE_ID=hrm.COURSE_ID WHERE hrm.COURSE_ID="+userVo.getGroupId();
					rs = stmt.executeQuery(sql);
					int type=0;
					while(rs.next()){
						type=Integer.parseInt(rs.getString("is_self_driven"));
						userVo.setCourseId(rs.getInt("COURSE_ID"));
						userVo.setOrganisationId(loginUser.getOrganisationId());
					}
					if(type==1){
						insertDataIntoCoursesTable(userVo,loginUser.getUserId());
					}
				}
				
			} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
			return status;
	}


	@Override
	public int mapStudToNewDep(UserVo userVo, UserVo loginUser) {
		userVo.setOrganisationId(loginUser.getOrganisationId());
		removeCourseNotStart(userVo.getUserId());
		addDepDefaultContainer(userVo);
		return 0;
	}
	
	public int removeCourseNotStart( int userId) {
		String sql = "";
		int status=0;
		try {
			conn = getConnection();
			stmt=conn.createStatement();
			sql="SELECT distinct ucm.HRM_ID FROM user_cls_map ucm inner join homeroom_mstr hm on hm.HRM_ID=ucm.HRM_ID inner join hrm_course_map hcm on hcm.HRM_ID=ucm.HRM_ID "+
					" inner join course_mstr cm on cm.COURSE_ID=hcm.COURSE_ID inner join teacher_courses tc on tc.HRM_ID=ucm.HRM_ID "+
					" inner join teacher_course_sessions tcs on tcs.TEACHER_COURSE_ID=tc.TEACHER_COURSE_ID WHERE ucm.end_dt IS NULL and ucm.ASSIGN_TYPE=0 and hm.CREATED_BY !=0 and tcs.IS_COMPLETE=2 and ucm.USER_ID="+userId;
			rs = stmt.executeQuery(sql);
			Statement stmt1=conn.createStatement();
				while(rs.next()){
					sql="DELETE FROM user_cls_map WHERE USER_ID="+userId+" and HRM_ID="+rs.getInt("HRM_ID");
					int temp = stmt1.executeUpdate(sql);
					if(temp>0){
						status=1;
					}
				}
			} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
		return status;
	}

	
	public int addDepDefaultContainer( UserVo userVo) {
		String sql = "";
		PreparedStatement pStmt =null;
		int status=0;
		ArrayList<Integer> containerList = new ArrayList<Integer>();
		try {
			conn = getConnection();
			stmt=conn.createStatement();
			sql="UPDATE user_cls_map SET end_dt=utc_timestamp WHERE end_dt IS NULL and USER_ID="+userVo.getUserId();
			stmt.executeUpdate(sql);
			
			sql="SELECT distinct chm.HRM_ID FROM class_hrm_map chm " +
					" WHERE chm.CLASS_ID="+userVo.getDepartmentId()+" and chm.HRM_ID not in(SELECT distinct HRM_ID FROM user_cls_map WHERE USER_ID="+userVo.getUserId()+")";
			rs = stmt.executeQuery(sql);
				while(rs.next()){
					containerList.add(rs.getInt("HRM_ID"));
				}
				for(int id : containerList){
					sql="INSERT INTO user_cls_map(USER_ID, SCHOOL_ID, CLASS_ID, HRM_ID, start_dt, end_dt, REQUEST_STATUS, ASSIGN_TYPE) VALUES(?, ?, ?, ?, utc_timestamp, null, '2', '0')";
					pStmt=conn.prepareStatement(sql);
					pStmt.setInt(1, userVo.getUserId());
					pStmt.setInt(2, userVo.getOrganisationId());
					pStmt.setInt(3, userVo.getDepartmentId());
					pStmt.setInt(4, id);
					pStmt.executeUpdate();
				}
		} catch (SQLException se) {
				System.out.println("updateTeacher # " + se);
				se.printStackTrace();
			} catch (Exception e) {
				System.out.println("updateTeacher # " + e);
				e.printStackTrace();
			} finally {
				closeResources(conn, stmt, null);
			}
		return status;
	}

}
