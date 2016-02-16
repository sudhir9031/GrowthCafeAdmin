package com.slms.persistance.dao.impl;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.slms.persistance.dao.iface.DashboardDao;
import com.slms.persistance.factory.LmsDaoAbstract;
import com.slms.webapp.form.DashboardVo;
import com.slms.webapp.form.UserVo;

public class DashboardDaoImpl extends LmsDaoAbstract implements DashboardDao{
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs ;

	@Override
	public DashboardVo getDashboardData(UserVo loginUser) {
		String sql = "";
		DashboardVo dashboardVo = new DashboardVo();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			int totalOrganisations=0;
			int totalCourses=0;
			int totalTeachers=0;
			int totalStudents=0;
			sql = "SELECT count(*) as count FROM school_mstr";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				totalOrganisations = rs.getInt("count");
			}
			
			/**
			 * Total teacher count
			 * */
			if(loginUser.getUserType()==4){
			sql = "SELECT count(*) as count FROM user_login  where USER_TYPE_ID=3";
			}else{
				sql = "SELECT count(*) as count FROM user_cls_map  where SCHOOL_ID="+loginUser.getOrganisationId();
						}
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				totalStudents = rs.getInt("count");
			}
			
			/**
			 * Total teacher count
			 * */
			
			if(loginUser.getUserType()==4){
				sql = "SELECT count(*) as count FROM user_login  where USER_TYPE_ID=2";
			}
			else{
				sql = "SELECT count(*) as count FROM user_login ul INNER JOIN school_user_map scum on scum.USER_ID=ul.USER_ID WHERE ul.USER_TYPE_ID=2 and scum.SCHOOL_ID="+loginUser.getOrganisationId();
			}
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				totalTeachers = rs.getInt("count");
			}
			/**
			 * Total course count
			 * */
			if(loginUser.getUserType()==4){
			sql = "SELECT count(*) as count FROM course_mstr";
			}else{
				sql = "SELECT count(*) as count FROM school_course_map WHERE SCHOOL_ID="+loginUser.getOrganisationId();
			}		
			 rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				totalCourses = rs.getInt("count");
			}
			
			dashboardVo.setTotalOrganisations(totalOrganisations);
			dashboardVo.setTotalStudents(totalStudents);
			dashboardVo.setTotalTeachers(totalTeachers);
			dashboardVo.setTotalCourses(totalCourses);
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getDashBoardDetail # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getDashBoardDetail # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return dashboardVo;
	}

	@Override
	public UserVo login(String email, String password) {
		UserVo userVo =null;
		String sql ="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			 sql = "SELECT ul.USER_ID, ul.USER_TYPE_ID, ul.USER_NM, sd.FNAME, sd.LNAME, sd.TITLE, sd.PROFILE_IMG, ul.ENABLE_FL FROM user_login ul, student_dtls sd WHERE ul.DELETED_FL=0 and ul.USER_NM='"+email+"' and ul.USER_PWD='"+password+"' and ul.USER_ID=sd.USER_ID and ul.USER_TYPE_ID in (1 , 4)";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				userVo = new UserVo();
				userVo.setUserId(rs.getInt("USER_ID"));
				userVo.setUserType(rs.getInt("USER_TYPE_ID"));
				userVo.setEmail(rs.getString("USER_NM"));
				userVo.setFname(rs.getString("FNAME"));
				userVo.setLname(rs.getString("LNAME"));
				userVo.setTitle(rs.getString("TITLE"));
				userVo.setProfileImgName(rs.getString("PROFILE_IMG"));
				userVo.setStatus(Integer.parseInt(rs.getString("ENABLE_FL")));
			}
			if(userVo != null && userVo.getUserType()==1){  
				conn = getConnection();
				stmt = conn.createStatement();
				sql="SELECT distinct schum.SCHOOL_ID, cm.CLASS_ID, sm.SCHOOL_NAME FROM school_user_map schum inner join school_cls_map scm on scm.SCHOOL_ID=schum.SCHOOL_ID "+
						" inner join class_mstr cm on cm.CLASS_ID = scm.CLASS_ID  inner join school_mstr sm on sm.SCHOOL_ID=schum.SCHOOL_ID where cm.CREATED_BY=0 and schum.USER_ID="+userVo.getUserId();
				 /*sql = "SELECT * FROM school_user_map where USER_ID='"+userVo.getUserId()+"'";*/
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					userVo.setOrganisationId(rs.getInt("SCHOOL_ID"));
					userVo.setDepartmentId(rs.getInt("CLASS_ID"));
					userVo.setOrgName(rs.getString("SCHOOL_NAME"));
				}
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getDashBoardDetail # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getDashBoardDetail # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return userVo;
	}

}
