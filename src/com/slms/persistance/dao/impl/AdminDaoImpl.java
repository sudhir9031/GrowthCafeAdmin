package com.slms.persistance.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import com.slms.persistance.dao.iface.AdminDao;
import com.slms.persistance.factory.LmsDaoAbstract;
import com.slms.webapp.form.UserVo;

public class AdminDaoImpl extends LmsDaoAbstract implements AdminDao{
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs ;

	@Override
	public boolean saveAdmin(UserVo userVo, int loginId) {
		PreparedStatement pStmt = null;
		boolean status=false;
		String sql="";
		int userId=0;
		int id=0;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			/**
			 *  INSERT into user_login
			 */
			
				sql="SELECT USER_ID FROM user_login WHERE USER_NM='"+userVo.getEmail()+"' and USER_TYPE_ID=1";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					userId=rs.getInt("USER_ID");
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
				pStmt.setInt(5, 1);//USER_TYPE_ID
				pStmt.setString(6, "0");//DELETED_FL
				pStmt.setString(7, "0");//ENABLE_FL
				pStmt.setInt(8, loginId);//LAST_USERID_CD
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
				pStmt.setString(7, userVo.getContactNo());//CONTACT_NO
				pStmt.setString(8, null);//BIRTH_DT
				pStmt.setString(9, null);//JOINING_DATE
				pStmt.setString(10, "default-profile.jpg");//PROFILE_IMG
				pStmt.setString(11, "");//SOCIAL_PROFILE
				pStmt.setString(12, "");
				pStmt.setInt(13, loginId);
				pStmt.setString(14, userVo.getEmail());
				int temp = pStmt.executeUpdate();
				if(temp>0)
					status=true;
				
				
					sql ="INSERT INTO school_user_map(SCHOOL_ID, USER_ID) VALUES(?, ?)";
					
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, userVo.getOrganisationId());
					pStmt.setInt(2, userId);
					pStmt.executeUpdate();
				
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
	public List<UserVo> getAdmins(int organisationId) {
		List<UserVo> adminList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="";
				if(organisationId >0){
				sql="SELECT distinct stud.USER_ID, stud.TITLE, stud.CONTACT_NO, stud.ADDRESS, stud.FNAME, stud.LNAME, stud.EMAIL_ID , usl.ENABLE_FL,usl.USER_PWD, sm.SCHOOL_ID, sm.SCHOOL_NAME FROM  user_login usl , student_dtls stud "+
					" INNER JOIN school_user_map sumap on sumap.USER_ID=stud.USER_ID INNER JOIN school_mstr sm on sm.SCHOOL_ID=sumap.SCHOOL_ID WHERE usl.USER_ID=stud.USER_ID and usl.USER_TYPE_ID=1 and sumap.SCHOOL_ID="+organisationId;
				}else{
					
					sql="SELECT distinct stud.USER_ID, stud.TITLE, stud.CONTACT_NO, stud.ADDRESS, stud.FNAME, stud.LNAME, stud.EMAIL_ID , usl.ENABLE_FL,usl.USER_PWD FROM  user_login usl , student_dtls stud WHERE usl.USER_ID=stud.USER_ID and usl.USER_TYPE_ID=1";
				}
				rs = stmt.executeQuery(sql);
				adminList = new ArrayList<UserVo>();
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
					user.setStatus(rs.getInt("ENABLE_FL"));
					if(organisationId>0){
					user.setOrgName(rs.getString("SCHOOL_NAME"));
					user.setOrganisationId(rs.getInt("SCHOOL_ID"));
					}
					adminList.add(user);
				}
				if(organisationId==0){
					for(UserVo userVo : adminList){
						sql="SELECT sm.SCHOOL_NAME, sm.SCHOOL_ID FROM school_user_map scum INNER JOIN school_mstr sm on sm.SCHOOL_ID = scum.SCHOOL_ID INNER JOIN user_login ul on ul.USER_ID=scum.USER_ID WHERE ul.USER_TYPE_ID=1 and scum.USER_ID="+userVo.getUserId();
						rs = stmt.executeQuery(sql);
						if(rs.next()){
							userVo.setOrgName(rs.getString("SCHOOL_NAME"));
							userVo.setOrganisationId(rs.getInt("SCHOOL_ID"));
						}else{
							userVo.setOrgName("Not Assign");
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
		return adminList;
	}

	@Override
	public List<UserVo> getAdminsToMap() {
		List<UserVo> adminList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="";
				
				sql="SELECT distinct usl.USER_ID, sd.FNAME, sd.LNAME FROM user_login usl INNER JOIN student_dtls sd on sd.USER_ID=usl.USER_ID WHERE usl.USER_ID NOT IN (SELECT USER_ID  FROM   school_user_map) and usl.USER_TYPE_ID=1";
				
				rs = stmt.executeQuery(sql);
				adminList = new ArrayList<UserVo>();
				while(rs.next()){
					UserVo  user = new UserVo();
					user.setUserId(rs.getInt("USER_ID"));
					user.setFname(rs.getString("FNAME"));
					user.setLname(rs.getString("LNAME"));
					adminList.add(user);
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
		return adminList;
	}

	@Override
	public boolean mapAdmin(int userMapId, int organisationId) {
		PreparedStatement pStmt = null;
		boolean status=false;
		String sql="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql ="INSERT INTO school_user_map(SCHOOL_ID, USER_ID) VALUES(?, ?)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, organisationId);
				pStmt.setInt(2, userMapId);
				int temp = pStmt.executeUpdate();
				if(temp>0){
					status=true;
				}
				
		} catch (SQLException se) {
			System.out.println("mapAdmin # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("mapAdmin # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public boolean updateAdmin(UserVo userVo, int userId) {
		String sql = "";
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				sql="UPDATE student_dtls SET  TITLE='"+userVo.getTitle()+"', FNAME='"+userVo.getFname()+"', LNAME='"+userVo.getLname()+"', CONTACT_NO='"+userVo.getContactNo()+
						"', LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp WHERE USER_ID="+userVo.getUserId();
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
	public boolean changeAdminStatus(UserVo userVo) {
		PreparedStatement pStmt = null;
		boolean status=false;
		String sql="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				sql="SELECT scum.USER_ID FROM school_user_map scum inner join user_login ul on ul.USER_ID=scum.USER_ID and ul.USER_TYPE_ID=1 where scum.SCHOOL_ID="+userVo.getOrganisationId();
						rs = stmt.executeQuery(sql);
				while(rs.next()){
						sql ="UPDATE user_login SET  ENABLE_FL='0' WHERE USER_ID="+rs.getInt("USER_ID");
						pStmt =  conn.prepareStatement(sql);
						pStmt.executeUpdate();
				}
				sql ="UPDATE user_login SET  ENABLE_FL=? WHERE USER_ID=?";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, userVo.getStatus()+"");
				pStmt.setInt(2, userVo.getUserId());
				int temp = pStmt.executeUpdate();
				if(temp>0){
					status=true;
				}
				
		} catch (SQLException se) {
			System.out.println("mapAdmin # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("mapAdmin # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return status;
	}

	@Override
	public UserVo getUserDetail(int userId) {
		UserVo user=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			String sql="";
				
				sql="SELECT sd.TITLE, sd.FNAME, sd.LNAME, sd.EMAIL_ID, sd.CONTACT_NO, sd.PROFILE_IMG, sd.ADDRESS, ul.USER_PWD FROM student_dtls sd INNER JOIN user_login ul on ul.USER_ID=sd.USER_ID WHERE sd.USER_ID="+userId;
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					user = new UserVo();
					user.setTitle(rs.getString("TITLE"));
					user.setFname(rs.getString("FNAME"));
					user.setLname(rs.getString("LNAME"));
					user.setEmail(rs.getString("EMAIL_ID"));
					user.setContactNo(rs.getString("CONTACT_NO"));
					user.setProfileImgName(rs.getString("PROFILE_IMG"));
					user.setAddress(rs.getString("ADDRESS"));
					user.setPassword(rs.getString("USER_PWD"));
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
	public boolean updateProfile(UserVo userVo, int userId) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="UPDATE student_dtls SET  TITLE=?, FNAME=?, LNAME=?, CONTACT_NO=?,ADDRESS=?, LAST_USERID_CD=?, LAST_UPDT_TM=utc_timestamp WHERE USER_ID=?";	
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, userVo.getTitle());
				pStmt.setString(2, userVo.getFname());
				pStmt.setString(3, userVo.getLname());
				pStmt.setString(4, userVo.getContactNo());
				//pStmt.setString(5, userVo.getProfileImgName());
				pStmt.setString(5, userVo.getAddress());
				pStmt.setInt(6, userId);
				pStmt.setInt(7, userId);
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
	public boolean updatePassword(String password, UserVo loginUser) {
		String sql = "";
		PreparedStatement pStmt = null;
		boolean status= false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
				sql="UPDATE user_login SET  USER_PWD=?, LAST_USERID_CD=?, LAST_UPDT_TM=utc_timestamp WHERE USER_ID=? and USER_PWD=?";	
				pStmt =  conn.prepareStatement(sql);
				pStmt.setString(1, password);
				pStmt.setInt(2, loginUser.getUserId());
				pStmt.setInt(3, loginUser.getUserId());
				pStmt.setString(4, loginUser.getPassword());
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

}
