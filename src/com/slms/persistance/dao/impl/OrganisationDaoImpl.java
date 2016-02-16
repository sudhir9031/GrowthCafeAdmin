package com.slms.persistance.dao.impl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.slms.persistance.dao.iface.OrganisationDao;
import com.slms.persistance.factory.LmsDaoAbstract;
import com.slms.webapp.form.CourseVo;
import com.slms.webapp.form.KeyValueVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.ReviewVo;
import com.slms.webapp.form.UserVo;
import com.sun.mail.imap.protocol.ListInfo;

public class OrganisationDaoImpl extends LmsDaoAbstract implements OrganisationDao{

	Connection conn = null;
	Statement stmt = null;
	ResultSet rs ;
	
	/**
	 * return organisations List
	 */
	
	@Override
	public List<OrganisationVo> getMasterDataOrganisations() {
		String sql = "";
		List<OrganisationVo> organisationList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT SCHOOL_ID, SCHOOL_ADDRESS, DELETED_FL, SCHOOL_NAME, WEBSITE_URL  FROM school_mstr WHERE DELETED_FL=0";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo organisation = new OrganisationVo();
				organisation.setOrganisationName(rs.getString("SCHOOL_NAME"));
				organisation.setOrganisationId(rs.getInt("SCHOOL_ID"));
				organisation.setWebsite(rs.getString("WEBSITE_URL"));
				organisation.setAddress(rs.getString("SCHOOL_ADDRESS"));
				String flag= rs.getString("DELETED_FL");
				if(flag !=null && !flag.equalsIgnoreCase("")){
					organisation.setStatus(Integer.parseInt(flag));
				}
				
				organisationList.add(organisation);
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
		return organisationList;
	}
	
	
	@Override
	public List<OrganisationVo> getOrganisations() {
		String sql = "";
		List<OrganisationVo> organisationList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT SCHOOL_ID, SCHOOL_ADDRESS, DELETED_FL, SCHOOL_NAME, WEBSITE_URL, DESC_TXT, SCHOOL_LOGO, METADATA  FROM school_mstr";
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo organisation = new OrganisationVo();
				organisation.setOrganisationName(rs.getString("SCHOOL_NAME"));
				organisation.setOrganisationId(rs.getInt("SCHOOL_ID"));
				organisation.setWebsite(rs.getString("WEBSITE_URL"));
				organisation.setAddress(rs.getString("SCHOOL_ADDRESS"));
				organisation.setDescription(rs.getString("DESC_TXT"));
				organisation.setLogoFileName(rs.getString("SCHOOL_LOGO"));
				organisation.setMetadata(rs.getString("METADATA"));
				String flag= rs.getString("DELETED_FL");
				if(flag !=null && !flag.equalsIgnoreCase("")){
					organisation.setStatus(Integer.parseInt(flag));
				}
				
				organisationList.add(organisation);
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
		return organisationList;
	}
	

	@Override
	public boolean saveOrganisation(OrganisationVo organisationVo) {
		String sql = "";
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			PreparedStatement pStmt = null;
			int orgId=0; 
			
			sql="SELECT SCHOOL_ID FROM school_mstr WHERE SCHOOL_NAME='"+organisationVo.getOrganisationName().replaceAll("'", "\\\\'")+"'";
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				orgId = rs.getInt("SCHOOL_ID");
			}
			
			if(orgId==0){
				sql="SELECT MAX(SCHOOL_ID) as SCHOOL_ID FROM school_mstr";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					orgId = rs.getInt("SCHOOL_ID");
				}
				orgId++;
				sql = "INSERT INTO school_mstr(SCHOOL_ID, SCHOOL_NAME, SCHOOL_ADDRESS, DESC_TXT, WEBSITE_URL, SCHOOL_LOGO, OTHER_IMG, METADATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) "+ 
						" VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, utc_timestamp)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, orgId);
				pStmt.setString(2, organisationVo.getOrganisationName());
				pStmt.setString(3, "");
				pStmt.setString(4, organisationVo.getDescription());//DESC_TXT
				pStmt.setString(5, organisationVo.getWebsite());
				pStmt.setString(6, organisationVo.getLogoFileName());//SCHOOL_LOGO
				pStmt.setString(7, "OTHER_IMG");//OTHER_IMG
				pStmt.setString(8, "");//METADATA
				pStmt.setString(9, "0");//DELETED_FL
				pStmt.setInt(10, orgId);//DISPLAY_NO
				pStmt.setString(11, "0");//ENABLE_FL
				pStmt.setInt(12, 1);//CREATED_BY
				pStmt.setInt(13, 1);//LAST_USERID_CD
				int temp=pStmt.executeUpdate();
				if(temp>0)
					status=true;
				if(status){
					organisationVo.setOrganisationId(orgId);
					saveDefaultDepartment(organisationVo,1);
					}
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
		
		return status;
	}
	
	
	public boolean saveDefaultDepartment(OrganisationVo organisationVo,int userId) {
		String sql = "";
		PreparedStatement pStmt = null;
		int departmentId=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				
				sql="SELECT cm.CLASS_ID FROM class_mstr cm, school_cls_map scm where  scm.CLASS_ID = cm.CLASS_ID and cm.CLASS_NAME='"+organisationVo.getOrganisationName()+"-DefaultDepartment".replaceAll("'", "\\\\'")+"' and scm.SCHOOL_ID="+organisationVo.getOrganisationId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					departmentId = rs.getInt("CLASS_ID");
				}
				if(departmentId==0){
				sql="SELECT MAX(CLASS_ID) as CLASS_ID FROM class_mstr";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					departmentId = rs.getInt("CLASS_ID");
				}
				departmentId++;
				
				
				sql="INSERT INTO class_mstr(CLASS_ID, CLASS_NAME, DESC_TXT, METEDATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, utc_timestamp)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, departmentId);
				pStmt.setString(2, organisationVo.getOrganisationName()+"-DefaultDepartment");
				pStmt.setString(3, "Organization Default Department");
				pStmt.setString(4, "");
				pStmt.setString(5, "0");//DELETED_FL
				pStmt.setInt(6, departmentId);//DISPLAY_NO
				pStmt.setString(7, "1");//ENABLE_FL
				pStmt.setInt(8, 0);//CREATED_BY
				pStmt.setInt(9, userId);
				pStmt.execute();
				
				sql="INSERT INTO school_cls_map(SCHOOL_ID, CLASS_ID) VALUES(?, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, organisationVo.getOrganisationId());
				pStmt.setInt(2, departmentId);
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

	
	
	
	

	/**
	 * get organisation id as argument
	 * return department list
	 */
	
	@Override
	public List<OrganisationVo> getDepartmentsByOrgId(int organisationId) {
		String sql = "";
		List<OrganisationVo> departmentList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT cm.CLASS_ID, cm.CLASS_NAME, cm.DESC_TXT, cm.METEDATA FROM class_mstr cm, school_cls_map scm WHERE cm.CREATED_BY !=0 and cm.DELETED_FL=0 and cm.CLASS_ID=scm.CLASS_ID and scm.SCHOOL_ID="+organisationId;
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo department = new OrganisationVo();
				department.setDepartmentId(rs.getInt("CLASS_ID"));
				department.setDepartmentName(rs.getString("CLASS_NAME"));
				department.setDescription(rs.getString("DESC_TXT"));
				department.setMetadata(rs.getString("METEDATA"));
				departmentList.add(department);
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
		return departmentList;
	}



	@Override
	public List<OrganisationVo> getGroupsByDepartmentId(int departmentId) {
		String sql = "";
		List<OrganisationVo> groupList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT hm.HRM_ID, hm.HRM_NAME FROM homeroom_mstr hm, class_hrm_map chm WHERE hm.CREATED_BY !=0 and hm.DELETED_FL=0 and chm.HRM_ID =hm.HRM_ID and chm.CLASS_ID="+departmentId;
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo group = new OrganisationVo();
				group.setGroupId(rs.getInt("HRM_ID"));
				group.setGroupName(rs.getString("HRM_NAME"));
				groupList.add(group);
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
		return groupList;
	}



	@Override
	public List<OrganisationVo> getDepartments(int organisationId) {
		String sql = "";
		List<OrganisationVo> departmentList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct cm.CLASS_ID, cm.CLASS_NAME, sm.SCHOOL_NAME, cm.DESC_TXT, cm.METEDATA, sm.SCHOOL_ID, cm.DELETED_FL FROM class_mstr cm, school_cls_map scm, school_mstr sm WHERE cm.CREATED_BY !=0 and sm.DELETED_FL=0 and cm.CLASS_ID=scm.CLASS_ID and sm.SCHOOL_ID=scm.SCHOOL_ID";
			if(organisationId>0){
				sql=sql+" and sm.SCHOOL_ID="+organisationId;
			}
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo department = new OrganisationVo();
				department.setOrganisationName(rs.getString("SCHOOL_NAME"));
				department.setOrganisationId(rs.getInt("SCHOOL_ID"));
				department.setDepartmentId(rs.getInt("CLASS_ID"));
				department.setDepartmentName(rs.getString("CLASS_NAME"));
				department.setDescription(rs.getString("DESC_TXT"));
				department.setMetadata(rs.getString("METEDATA"));
				String deletFlag = rs.getString("DELETED_FL");
				if(deletFlag !=null){
					department.setStatus(Integer.parseInt(deletFlag));
				}
				departmentList.add(department);
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
		return departmentList;
	}



	@Override
	public boolean saveDepartment(OrganisationVo organisationVo,int userId) {
		String sql = "";
		PreparedStatement pStmt = null;
		int departmentId=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(organisationVo.getDepartmentName()!=null && organisationVo.getDepartmentName()!=""){
				
				sql="SELECT cm.CLASS_ID FROM class_mstr cm, school_cls_map scm where  scm.CLASS_ID = cm.CLASS_ID and cm.CLASS_NAME='"+organisationVo.getDepartmentName().replaceAll("'", "\\\\'")+"' and scm.SCHOOL_ID="+organisationVo.getOrganisationId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					departmentId = rs.getInt("CLASS_ID");
				}
				if(departmentId==0){
				sql="SELECT MAX(CLASS_ID) as CLASS_ID FROM class_mstr";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					departmentId = rs.getInt("CLASS_ID");
				}
				departmentId++;
				
				
				sql="INSERT INTO class_mstr(CLASS_ID, CLASS_NAME, DESC_TXT, METEDATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, utc_timestamp)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, departmentId);
				pStmt.setString(2, organisationVo.getDepartmentName());
				pStmt.setString(3, organisationVo.getDescription());
				pStmt.setString(4, "");
				pStmt.setString(5, "0");//DELETED_FL
				pStmt.setInt(6, departmentId);//DISPLAY_NO
				pStmt.setString(7, "1");//ENABLE_FL
				pStmt.setInt(8, userId);
				pStmt.setInt(9, userId);
				pStmt.execute();
				
				sql="INSERT INTO school_cls_map(SCHOOL_ID, CLASS_ID) VALUES(?, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, organisationVo.getOrganisationId());
				pStmt.setInt(2, departmentId);
				int temp = pStmt.executeUpdate();
				if(temp>0)
					status=true;
					if(status){
						int groupId=0;
						sql="SELECT MAX(HRM_ID) as HRM_ID FROM homeroom_mstr";
						rs = stmt.executeQuery(sql);
						while(rs.next()){
							groupId = rs.getInt("HRM_ID");
						}
						groupId++;
						
						sql="INSERT INTO homeroom_mstr(HRM_ID, HRM_NAME, DESC_TXT, METADATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, utc_timestamp)";
						
						pStmt =  conn.prepareStatement(sql);
						pStmt.setInt(1, groupId);
						pStmt.setString(2,organisationVo.getDepartmentName()+"-Default");
						pStmt.setString(3,"Default Course Container for Department : "+organisationVo.getDepartmentName());
						pStmt.setString(4, "");
						pStmt.setString(5, "0");//DELETED_FL
						pStmt.setInt(6, groupId);
						pStmt.setString(7, "0");//ENABLE_FL
						pStmt.setInt(8, 0);
						pStmt.setInt(9, userId);
						pStmt.execute();
						
						sql="INSERT INTO class_hrm_map(CLASS_ID, HRM_ID) VALUES(?, ?)";
						pStmt =  conn.prepareStatement(sql);
						pStmt.setInt(1, departmentId);
						pStmt.setInt(2, groupId);
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
		return status;
	}



	@Override
	public List<OrganisationVo> getGroups(int organisationId, int departmentId, int courseId) {
		String sql = "";
		List<OrganisationVo> groupsList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT hm.HRM_ID, hm.HRM_NAME, hm.start_dt,hm.end_dt, hm.DELETED_FL FROM homeroom_mstr hm inner join class_hrm_map chm on chm.HRM_ID =hm.HRM_ID "+
					" inner join hrm_course_map hcm on hcm.HRM_ID=hm.HRM_ID where hcm.COURSE_ID="+courseId+" and chm.CLASS_ID="+departmentId;
			/*if(organisationId>0){
				sql=sql+" and sm.SCHOOL_ID="+organisationId;
			}
			
			if(departmentId>0){
				sql=sql+" and cm.CLASS_ID="+departmentId;
			}*/
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo group = new OrganisationVo();
				//group.setOrganisationName(rs.getString("SCHOOL_NAME"));
				//group.setOrganisationId(rs.getInt("SCHOOL_ID"));
				//group.setDepartmentId(rs.getInt("CLASS_ID"));
				//group.setDepartmentName(rs.getString("CLASS_NAME"));
				group.setGroupId(rs.getInt("HRM_ID"));
				group.setGroupName(rs.getString("HRM_NAME"));
				group.setStatus(Integer.parseInt(rs.getString("DELETED_FL")));
				SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat dateForma2= new SimpleDateFormat("MM/dd/yyyy");
				if(rs.getString("start_dt") !=null || rs.getString("end_dt") !=null){
				System.out.println(rs.getString("start_dt"));
				Date date = dateFormat.parse(rs.getString("start_dt"));
				Date date2 = dateFormat.parse(rs.getString("end_dt"));
				group.setStartDate(dateForma2.format(date));
				group.setEndDate(dateForma2.format(date2));
				}
				groupsList.add(group);
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
		return groupsList;
	}



	@Override
	public boolean saveGroup(OrganisationVo organisationVo, int userId) {
		String sql = "";
		PreparedStatement pStmt = null;
		int groupId=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			int x=0;
			do{
				if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("")){
				 SimpleDateFormat convertObj = new SimpleDateFormat("MM/dd/yyyy");
			     
			      //parse the string into Date object
			      Date start = convertObj.parse(organisationVo.getStartedOn()[x]);
			      Date end = convertObj.parse(organisationVo.getEndOn()[x]);
			     
			      //create SimpleDateFormat object with desired date format
			      SimpleDateFormat setObj = new SimpleDateFormat("yyyy/MM/dd");
			     
			      //parse the date into another format
			      organisationVo.getStartedOn()[x] = setObj.format(start).toString();
			      organisationVo.getEndOn()[x] = setObj.format(end).toString();
				}
				if(organisationVo.getGroupId()==0){
			if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("") || organisationVo.getCourseType()==1){
				String dateFilter ="";
				if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("")){
					dateFilter =" and hm.start_dt='"+organisationVo.getStartedOn()[x]+"' and hm.end_dt='"+organisationVo.getEndOn()[x]+"'";;
				}
				
				sql="SELECT distinct hm.HRM_ID FROM homeroom_mstr hm, class_hrm_map chm WHERE hm.HRM_ID=chm.HRM_ID "+dateFilter+" and hm.HRM_NAME='"+organisationVo.getCourseName().replaceAll("'", "\\\\'")+"' and chm.CLASS_ID="+organisationVo.getDepartmentId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					groupId = rs.getInt("HRM_ID");
				}
				
				if(groupId==0){
				sql="SELECT MAX(HRM_ID) as HRM_ID FROM homeroom_mstr";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					groupId = rs.getInt("HRM_ID");
				}
				groupId++;
				
				sql="INSERT INTO homeroom_mstr(HRM_ID, HRM_NAME, DESC_TXT, METADATA, DELETED_FL, DISPLAY_NO, ENABLE_FL, CREATED_BY, LAST_USERID_CD, LAST_UPDT_TM, start_dt, end_dt) VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, utc_timestamp,?,?)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, groupId);
				pStmt.setString(2, organisationVo.getCourseName());
				pStmt.setString(3, "");
				pStmt.setString(4, "");
				pStmt.setString(5, "0");//DELETED_FL
				pStmt.setInt(6, groupId);
				pStmt.setString(7, "0");//ENABLE_FL
				pStmt.setInt(8, userId);
				pStmt.setInt(9, userId);
				if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("")){
					pStmt.setString(10, organisationVo.getStartedOn()[x]);
					pStmt.setString(11, organisationVo.getEndOn()[x]);
				}else if(organisationVo.getStartedOn()==null){
					pStmt.setString(10, null);
					pStmt.setString(11, null);
				}
				pStmt.execute();
				
				sql="INSERT INTO class_hrm_map(CLASS_ID, HRM_ID) VALUES(?, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, organisationVo.getDepartmentId());
				pStmt.setInt(2, groupId);
				pStmt.executeUpdate();
				
				sql="INSERT INTO hrm_course_map(HRM_ID, COURSE_ID) VALUES(?, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, groupId);
				pStmt.setInt(2, organisationVo.getCourseId());
				int temp = pStmt.executeUpdate();
				if(temp>0)
					status=true;
			}
			
			}
		}else{
			if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("")){
				String dateFilter ="";
				if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("")){
					dateFilter =" and hm.start_dt='"+organisationVo.getStartedOn()[x]+"' and hm.end_dt='"+organisationVo.getEndOn()[x]+"'";;
				}
				
				sql="SELECT distinct hm.HRM_ID FROM homeroom_mstr hm, class_hrm_map chm WHERE hm.HRM_ID=chm.HRM_ID "+dateFilter+" and hm.HRM_NAME='"+organisationVo.getCourseName().replaceAll("'", "\\\\'")+"' and chm.CLASS_ID="+organisationVo.getDepartmentId();
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					groupId = rs.getInt("HRM_ID");
				}
				
				if(groupId==0){
					sql="UPDATE homeroom_mstr SET LAST_USERID_CD=?, LAST_UPDT_TM=utc_timestamp, start_dt=?, end_dt=?  WHERE HRM_ID=?";
					
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, userId);
					if(organisationVo.getStartedOn()!=null && !organisationVo.getStartedOn()[x].equalsIgnoreCase("")){
						pStmt.setString(2, organisationVo.getStartedOn()[x]);
						pStmt.setString(3, organisationVo.getEndOn()[x]);
					}else if(organisationVo.getStartedOn()==null){
						pStmt.setString(2, null);
						pStmt.setString(3, null);
					}
					pStmt.setInt(4, organisationVo.getGroupId());
					pStmt.executeUpdate();
				}
				}
			
		}
			x++;
			if(organisationVo.getStartedOn()==null){
				return status;
			}
			
			}while(x<organisationVo.getStartedOn().length);
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
	public List<OrganisationVo> getAllDepartments() {
		String sql = "";
		List<OrganisationVo> departmentList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct cm.CLASS_ID, cm.CLASS_NAME FROM class_mstr cm";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo department = new OrganisationVo();
				department.setDepartmentId(rs.getInt("CLASS_ID"));
				department.setDepartmentName(rs.getString("CLASS_NAME"));
				departmentList.add(department);
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
		return departmentList;
	}



	@Override
	public List<OrganisationVo> getNewGroup() {
		String sql = "";
		List<OrganisationVo> groupList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct HRM_ID, HRM_NAME FROM homeroom_mstr";
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo group = new OrganisationVo();
				group.setGroupId(rs.getInt("HRM_ID"));
				group.setGroupName(rs.getString("HRM_NAME"));
				groupList.add(group);
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
		return groupList;
	}



	@Override
	public List<KeyValueVo> getParamValue(int organisationId) {
		String sql = "";
		List<KeyValueVo> paramList = new ArrayList<KeyValueVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT GRADE_PARAM_ID, GRADE_PARAM FROM assignment_grade_params WHERE SCHOOL_ID="+organisationId;
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				KeyValueVo keyValuevo = new KeyValueVo();
				keyValuevo.setValue(rs.getString("GRADE_PARAM"));
				keyValuevo.setKey(rs.getInt("GRADE_PARAM_ID"));
				paramList.add(keyValuevo);
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
		return paramList;
	}



	@Override
	public List<KeyValueVo> getReviewValue(int paramId) {
		String sql = "";
		List<KeyValueVo> paramList = new ArrayList<KeyValueVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT GRADE_VALUE_ID, GRADE_LABEL FROM assignment_grade_values WHERE GRADE_PARAM_ID="+paramId;
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				KeyValueVo keyValuevo = new KeyValueVo();
				keyValuevo.setValue(rs.getString("GRADE_LABEL"));
				keyValuevo.setKey(rs.getInt("GRADE_VALUE_ID"));
				paramList.add(keyValuevo);
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
		return paramList;
	}



	@Override
	public boolean saveParamAndValue(int orgId, String param, String value) {
		String sql = "";
		PreparedStatement pStmt = null;
		int gradeParamId=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				
				sql="SELECT GRADE_PARAM_ID FROM assignment_grade_params WHERE GRADE_PARAM='"+param.replaceAll("'", "\\\\'")+"' and SCHOOL_ID="+orgId;
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					gradeParamId = rs.getInt("GRADE_PARAM_ID");
				}
				
				if(gradeParamId==0){
				sql="SELECT MAX(GRADE_PARAM_ID) as GRADE_PARAM_ID FROM assignment_grade_params";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					gradeParamId = rs.getInt("GRADE_PARAM_ID");
				}
				gradeParamId++;
				
				sql="INSERT INTO assignment_grade_params(GRADE_PARAM_ID, GRADE_PARAM, SCHOOL_ID, LAST_UPDT_BY, LAST_UPDT_TM) VALUES(?, ?, ?, ?, utc_timestamp)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, gradeParamId);
				pStmt.setString(2, param);
				pStmt.setInt(3, orgId);
				pStmt.setInt(4, 0);
				int temp = pStmt.executeUpdate();
				if(temp>0){
					status=true;
					saveParamValue(gradeParamId, value);
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
	public boolean saveParamValue(int paramId, String value) {
		String sql = "";
		PreparedStatement pStmt = null;
		int gradeValueId=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				
				sql="SELECT GRADE_VALUE_ID FROM assignment_grade_values WHERE GRADE_LABEL='"+value.replaceAll("'", "\\\\'")+"' and GRADE_PARAM_ID="+paramId;
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					gradeValueId = rs.getInt("GRADE_VALUE_ID");
				}
				
				
				if(gradeValueId==0){
				sql="SELECT MAX(GRADE_VALUE_ID) as GRADE_VALUE_ID FROM assignment_grade_values";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					gradeValueId = rs.getInt("GRADE_VALUE_ID");
				}
				gradeValueId++;
				
				sql="INSERT INTO assignment_grade_values(GRADE_VALUE_ID, GRADE_PARAM_ID, GRADE_LABEL, GRADE_VALUE, GRADE_RGB, LAST_UPDT_BY, LAST_UPDT_TM) "+
						" VALUES(?, ?, ?, ?, ?, ?, utc_timestamp)";
				
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, gradeValueId);
				pStmt.setInt(2, paramId);
				pStmt.setString(3, value);
				pStmt.setString(4, "");
				pStmt.setString(5, "");
				pStmt.setInt(6, 0);
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
	public List<ReviewVo> getReviewParameter(int organisationId) {
		String sql = "";
		List<ReviewVo> reviewParameterList = new ArrayList<ReviewVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT sc.SCHOOL_NAME, agp.GRADE_PARAM, agp.GRADE_PARAM_ID, agv.GRADE_LABEL, agv.GRADE_VALUE_ID FROM assignment_grade_values agv LEFT JOIN assignment_grade_params  agp on agp.GRADE_PARAM_ID=agv.GRADE_PARAM_ID "+
					" LEFT JOIN school_mstr sc on sc.SCHOOL_ID=agp.SCHOOL_ID";
			
			if(organisationId>0){
				sql=sql+" WHERE sc.SCHOOL_ID="+organisationId;
			}
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				ReviewVo reviewParam = new ReviewVo();
				reviewParam.setOrganisationName(rs.getString("SCHOOL_NAME"));
				reviewParam.setParam(rs.getString("GRADE_PARAM"));
				reviewParam.setValueLabel(rs.getString("GRADE_LABEL"));
				reviewParam.setParamId(rs.getInt("GRADE_PARAM_ID"));
				reviewParam.setValueId(rs.getInt("GRADE_VALUE_ID"));
				reviewParameterList.add(reviewParam);
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
		return reviewParameterList;
	}



	@Override
	public void activeDeactive(int id, String flag, String contentType) {
		boolean status=false;
		String sql="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(contentType.equalsIgnoreCase("org")){
				sql="UPDATE school_mstr SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE SCHOOL_ID="+id;
			}else if(contentType.equalsIgnoreCase("dep")){
				sql="UPDATE class_mstr SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE CLASS_ID="+id;
			}else if(contentType.equalsIgnoreCase("group")){
				sql="UPDATE homeroom_mstr SET DELETED_FL='"+flag+"', LAST_UPDT_TM=utc_timestamp WHERE HRM_ID="+id;
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
	}


	@Override
	public boolean deleteParameter(int paramId, int valueId) {
		String sql = "";
		int count=0;
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				
				sql="SELECT COUNT(*) as count FROM assignment_grade_values WHERE  GRADE_PARAM_ID="+paramId;
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					count = rs.getInt("count");
				}
				
				sql="DELETE  FROM assignment_grade_values WHERE  GRADE_VALUE_ID="+valueId;
				int temp = stmt.executeUpdate(sql);
				if(temp>0)
					status=true;
				
				if(count==1){
					sql="DELETE  FROM assignment_grade_params WHERE  GRADE_PARAM_ID="+paramId;
				 stmt.executeUpdate(sql);
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
	public boolean updateDepartment(OrganisationVo org,int userId) {
		String sql = "";
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				sql="UPDATE class_mstr SET  CLASS_NAME='"+org.getDepartmentName()+"', DESC_TXT='"+org.getDescription()+"', LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp WHERE CLASS_ID="+org.getDepartmentId();
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
	public boolean updateGroup(OrganisationVo org, int userId) {
		String sql = "";
		boolean status=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				sql="UPDATE homeroom_mstr SET  HRM_NAME='"+org.getGroupName()+"', DESC_TXT='"+org.getDescription()+"', LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp WHERE HRM_ID="+org.getGroupId();
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
	public boolean updateOrg(OrganisationVo org, int userId) {
		String sql = "";
		boolean status=false;
		String fileName="";
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			if(org.getLogoFileName() !=null){
				fileName =" SCHOOL_LOGO='"+org.getLogoFileName()+"',";
			}
				sql="UPDATE school_mstr SET SCHOOL_NAME='"+org.getOrganisationName()+"', DESC_TXT='"+org.getDescription()+"'," +
						" WEBSITE_URL='"+org.getWebsite()+"',"+fileName+" LAST_USERID_CD="+userId+", LAST_UPDT_TM=utc_timestamp "+
						" WHERE SCHOOL_ID="+org.getOrganisationId();
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
	public List<CourseVo> getOrgCourseList(UserVo user) {
		String sql = "";
		List<CourseVo> courseList = new ArrayList<CourseVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
					sql="SELECT * FROM course_mstr where LAST_USERID_CD="+user.getUserId();
				
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				CourseVo course = new CourseVo();
				course.setCourseName(rs.getString("COURSE_NAME"));
				course.setCourseId(rs.getInt("COURSE_ID"));
				course.setCourseType(rs.getString("is_self_driven"));
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
	public List<OrganisationVo> getOrgCourseContainerNames(UserVo loginUser) {
		String sql = "";
		List<OrganisationVo> groupList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct hm.HRM_NAME, cm.is_self_driven FROM homeroom_mstr hm inner join class_hrm_map chm on hm.HRM_ID=chm.HRM_ID " +
					" inner join hrm_course_map hcm on hcm.HRM_ID=hm.HRM_ID inner join course_mstr cm on cm.COURSE_ID=hcm.COURSE_ID WHERE hm.CREATED_BY!=0 and chm.CLASS_ID="+loginUser.getDepartmentId();
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo group = new OrganisationVo();
					group.setGroupName(rs.getString("HRM_NAME"));
					group.setCourseType(Integer.parseInt(rs.getString("is_self_driven")));
				groupList.add(group);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getOrgCourseContainerNames # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getOrgCourseContainerNames # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return groupList;
	}


	@Override
	public List<OrganisationVo> getContainerSessions(UserVo loginUser, String groupName) {
		String sql = "";
		List<OrganisationVo> groupList = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			sql = "SELECT distinct hm.HRM_ID, hm.HRM_NAME, hm.start_dt, hm.end_dt FROM homeroom_mstr hm inner join class_hrm_map chm on hm.HRM_ID=chm.HRM_ID "+
					" inner join hrm_course_map hcm on hcm.HRM_ID=hm.HRM_ID inner join course_mstr cm on cm.COURSE_ID=hcm.COURSE_ID WHERE hm.CREATED_BY!=0 and cm.is_self_driven=0 and chm.CLASS_ID="+loginUser.getDepartmentId();
			if(groupName !=null && !groupName.equalsIgnoreCase("")){
				sql=sql+" and hm.HRM_NAME='"+groupName+"'";
			}
			
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo group = new OrganisationVo();
				group.setGroupId(rs.getInt("HRM_ID"));
				group.setGroupName(rs.getString("HRM_NAME"));
				
				SimpleDateFormat dateFormat= new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat dateForma2= new SimpleDateFormat("MM/dd/yyyy");
				if(rs.getString("start_dt") !=null || rs.getString("end_dt") !=null){
				System.out.println(rs.getString("start_dt"));
				Date date = dateFormat.parse(rs.getString("start_dt"));
				Date date2 = dateFormat.parse(rs.getString("end_dt"));
				group.setStartDate(dateForma2.format(date));
				group.setEndDate(dateForma2.format(date2));
				}
				groupList.add(group);
				
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getContainerSessions # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getContainerSessions # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return groupList;
	}

	@Override
	public boolean mapDepCourseContainer(OrganisationVo organisationVo,UserVo loginUser) {
		String sql = "";
		boolean status=false;
		boolean courseStatus=false;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				sql="DELETE chm.* FROM class_hrm_map chm WHERE chm.HRM_ID in (Select hm.HRM_ID from homeroom_mstr hm where hm.HRM_ID=chm.HRM_ID and hm.CREATED_BY!=0 and chm.CLASS_ID="+organisationVo.getDepartmentId()+")";
				int temp = stmt.executeUpdate(sql);
				for(int i=0;i<organisationVo.getContainers().length;i++){
					sql="INSERT INTO class_hrm_map(CLASS_ID, HRM_ID) VALUES("+organisationVo.getDepartmentId()+", "+organisationVo.getContainers()[i]+")";
					temp = stmt.executeUpdate(sql);
				}
				if(temp>0)
					status=true;
				if(status){
					
					/*fatching students registered in group*/
					sql="SELECT distinct ucm.USER_ID FROM class_hrm_map chm inner join homeroom_mstr hm on chm.HRM_ID=hm.HRM_ID inner join user_cls_map ucm on ucm.HRM_ID=hm.HRM_ID "+
							" WHERE hm.CREATED_BY=0 and ucm.end_dt IS NULL and chm.CLASS_ID="+organisationVo.getDepartmentId();
					rs = stmt.executeQuery(sql);
					List<Integer> studentList = new ArrayList<Integer>();
					while(rs.next()){
						studentList.add(rs.getInt("USER_ID"));
					}
				
					/*removing course not started mapped against students user_cls_map*/
					for(int userId :studentList){
						new UserDaoImpl().removeCourseNotStart(userId);
						
						/*mapping default course to student*/
						courseStatus = assignDefaultCourse(userId,organisationVo.getDepartmentId(),loginUser.getOrganisationId());
					}
					
					
					
					/*sql="SELECT HRM_ID FROM class_hrm_map WHERE CLASS_ID="+organisationVo.getDepartmentId();
					rs = stmt.executeQuery(sql);
					List<Integer> containers = new ArrayList<Integer>();
					while(rs.next()){
						containers.add(rs.getInt("HRM_ID"));
					}*/
					
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
	
	


	private boolean assignDefaultCourse(int userId, int departmentId, int organisationId) {
		String sql = "";
		PreparedStatement pStmt =null;
		int status=0;
		try{
		ArrayList<Integer> containerList = new ArrayList<Integer>();
			
		sql="SELECT distinct chm.HRM_ID FROM class_hrm_map chm " +
				" WHERE chm.CLASS_ID="+departmentId+" and chm.HRM_ID not in(SELECT distinct HRM_ID FROM user_cls_map WHERE USER_ID="+userId+")";
		rs = stmt.executeQuery(sql);
			while(rs.next()){
				containerList.add(rs.getInt("HRM_ID"));
			}
			for(int id : containerList){
				sql="INSERT INTO user_cls_map(USER_ID, SCHOOL_ID, CLASS_ID, HRM_ID, start_dt, end_dt, REQUEST_STATUS, ASSIGN_TYPE) VALUES(?, ?, ?, ?, utc_timestamp, null, '2', '0')";
				pStmt=conn.prepareStatement(sql);
				pStmt.setInt(1, userId);
				pStmt.setInt(2, departmentId);
				pStmt.setInt(3, organisationId);
				pStmt.setInt(4, id);
				pStmt.executeUpdate();
			}
		}catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}


	@Override
	public List<OrganisationVo> getContainerOfCoach(UserVo loginUser, String groupName) {
		String sql = "";
		List<OrganisationVo> containers = new ArrayList<OrganisationVo>();
		try {
			conn = getConnection();
			stmt = conn.createStatement();
			
			/*sql = "SELECT distinct hm.HRM_NAME, hm.HRM_ID, hm.start_dt, hm.end_dt FROM teacher_courses tc inner join homeroom_mstr hm on hm.HRM_ID=tc.HRM_ID WHERE tc.ENABLE_FL='1' and hm.CREATED_BY !=0 and tc.TEACHER_ID="+loginUser.getUserId()+" and tc.CLASS_ID="+loginUser.getDepartmentId()+" and tc.SCHOOL_ID="+loginUser.getOrganisationId();*/
			
			sql = "SELECT distinct hm.HRM_NAME, hm.HRM_ID, hm.start_dt, hm.end_dt FROM teacher_courses tc inner join homeroom_mstr hm on hm.HRM_ID=tc.HRM_ID inner join teacher_course_session_map tcsm on tcsm.TEACHER_COURSE_ID=tc.TEACHER_COURSE_ID " +
					"WHERE tc.ENABLE_FL='1' and hm.CREATED_BY !=0 and tc.TEACHER_ID="+loginUser.getUserId()+" and tc.CLASS_ID="+loginUser.getDepartmentId()+" and tc.SCHOOL_ID="+loginUser.getOrganisationId();
			rs = stmt.executeQuery(sql);
			
			while(rs.next()){
				OrganisationVo group = new OrganisationVo();
				group.setGroupId(rs.getInt("HRM_ID"));
				group.setGroupName(rs.getString("HRM_NAME"));
				group.setStartDate(rs.getString("start_dt"));
				group.setEndDate(rs.getString("end_dt"));
				containers.add(group);
			}
			
			System.out.println("get records into the table...");
		} catch (SQLException se) {
			System.out.println("getContainerSessions # " + se);
			se.printStackTrace();
		} catch (Exception e) {
			System.out.println("getContainerSessions # " + e);
			e.printStackTrace();
		} finally {
			closeResources(conn, stmt, null);
		}
		return containers;
	}

/**
 * @author Yogendra
 * @param loginUser, paramId, param
 * paramId equal to zero for new and for edit paramId greater than zero
 * @return updated List of parameter
 * call form OrganisationServiceIpml saveParam method
 */
	@Override
	public List<KeyValueVo> saveParam(UserVo loginUser, int paramId, String param) {
		String sql = "";
		PreparedStatement pStmt = null;
		int id =0;
		List<KeyValueVo> paramList=null;
		try {
			conn = getConnection();
			stmt = conn.createStatement();
				if(paramId==0){
				sql="SELECT GRADE_PARAM_ID FROM assignment_grade_params WHERE SCHOOL_ID="+loginUser.getOrganisationId()+" and GRADE_PARAM='"+param+"'";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id =rs.getInt("GRADE_PARAM_ID");
				}
				
				if(id==0){
					
					sql="SELECT MAX(GRADE_PARAM_ID) as GRADE_PARAM_ID FROM assignment_grade_params";
					rs = stmt.executeQuery(sql);
					while(rs.next()){
						id =rs.getInt("GRADE_PARAM_ID");
					}
					id++;
					sql="INSERT INTO assignment_grade_params(GRADE_PARAM_ID, GRADE_PARAM, SCHOOL_ID, LAST_UPDT_BY, LAST_UPDT_TM) VALUES(?, ?, ?, ?, utc_timestamp)";
					pStmt =  conn.prepareStatement(sql);
					pStmt.setInt(1, id);
					pStmt.setString(2, param);
					pStmt.setInt(3, loginUser.getOrganisationId());
					pStmt.setInt(4, loginUser.getUserId());
					pStmt.executeUpdate();
				}
			}else{
				sql="Update  assignment_grade_params SET  GRADE_PARAM='"+param+"', LAST_UPDT_TM=utc_timestamp WHERE GRADE_PARAM_ID="+paramId;
				stmt.executeUpdate(sql);
			}
				sql="SELECT GRADE_PARAM_ID, GRADE_PARAM FROM assignment_grade_params WHERE SCHOOL_ID="+loginUser.getOrganisationId();
				rs = stmt.executeQuery(sql);
				paramList = new ArrayList<KeyValueVo>();
				while(rs.next()){
					KeyValueVo paramObj = new KeyValueVo();
					paramObj.setKey(rs.getInt("GRADE_PARAM_ID"));
					paramObj.setValue(rs.getString("GRADE_PARAM"));
					paramList.add(paramObj);
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
			return paramList;
	}


@Override
public boolean saveGrade(UserVo loginUser, int gradeId, String grade, String value) {
	String sql = "";
	boolean status=false;
	PreparedStatement pStmt = null;
	int id =0;
	int temp =0;
	try {
		conn = getConnection();
		stmt = conn.createStatement();
			if(gradeId==0){
				
				//Check the grade is same.....
				sql="SELECT GRADE_VALUE_ID,GRADE_LABEL FROM assignment_grade_values WHERE SCHOOL_ID="+loginUser.getOrganisationId()+" and LAST_UPDT_BY="+loginUser.getUserId()+" and GRADE_VALUE="+value;
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id =rs.getInt("GRADE_VALUE_ID");
					String label = rs.getString("GRADE_LABEL");
				}
				
				//check the grade label is same....
				sql="SELECT GRADE_VALUE_ID FROM assignment_grade_values WHERE SCHOOL_ID="+loginUser.getOrganisationId()+" and GRADE_LABEL='"+grade+"'";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id =rs.getInt("GRADE_VALUE_ID");
				}
			
			if(id==0){
				
				sql="SELECT MAX(GRADE_VALUE_ID) as GRADE_VALUE_ID FROM assignment_grade_values";
				rs = stmt.executeQuery(sql);
				while(rs.next()){
					id =rs.getInt("GRADE_VALUE_ID");
				}
				id++;
				sql="INSERT INTO assignment_grade_values(GRADE_VALUE_ID, GRADE_PARAM_ID, GRADE_LABEL, GRADE_VALUE, GRADE_RGB, LAST_UPDT_BY, LAST_UPDT_TM, SCHOOL_ID) VALUES(?, 0, ?, ?, '', ?,utc_timestamp, ?)";
				pStmt =  conn.prepareStatement(sql);
				pStmt.setInt(1, id);
				pStmt.setString(2, grade);//GRADE_LABEL
				pStmt.setString(3, value);//GRADE_VALUE
				pStmt.setInt(4, loginUser.getUserId());//LAST_UPDT_BY
				pStmt.setInt(5, loginUser.getOrganisationId());
				temp =pStmt.executeUpdate();
				if(temp>0)
					status=true;
			}
		}else{
			int gradeValueId = 0;
			sql="SELECT GRADE_VALUE_ID,GRADE_LABEL FROM assignment_grade_values WHERE SCHOOL_ID="+loginUser.getOrganisationId()+" and LAST_UPDT_BY="+loginUser.getUserId()+" and GRADE_VALUE="+value;
			rs = stmt.executeQuery(sql);
			while(rs.next()){
				gradeValueId =rs.getInt("GRADE_VALUE_ID");
				String label = rs.getString("GRADE_LABEL");
			}
			if(gradeValueId==0){
				sql="Update  assignment_grade_values SET  GRADE_LABEL='"+grade+"', GRADE_VALUE='"+value+"', LAST_UPDT_TM=utc_timestamp WHERE GRADE_VALUE_ID="+gradeId;
				temp = stmt.executeUpdate(sql);
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
public List<KeyValueVo> getGrade(int organisationId) {
	String sql = "";
	List<KeyValueVo> paramList=null;
	try {
		conn = getConnection();
		stmt = conn.createStatement();
			
			sql="SELECT GRADE_VALUE_ID, GRADE_LABEL, GRADE_VALUE FROM assignment_grade_values WHERE SCHOOL_ID="+organisationId;
			rs = stmt.executeQuery(sql);
			paramList = new ArrayList<KeyValueVo>();
			while(rs.next()){
				KeyValueVo paramObj = new KeyValueVo();
				paramObj.setKey(rs.getInt("GRADE_VALUE_ID"));
				paramObj.setValue(rs.getString("GRADE_LABEL"));
				paramObj.setStartDate(rs.getString("GRADE_VALUE"));
				paramList.add(paramObj);
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
		return paramList;
}


@Override
public List<OrganisationVo> getDepartmentCourses(int departmentId) {
	String sql = "";
	List<OrganisationVo> containers = new ArrayList<OrganisationVo>();
	try {
		conn = getConnection();
		stmt = conn.createStatement();
		
		/*sql = "SELECT distinct hm.HRM_NAME, hm.HRM_ID, hm.start_dt, hm.end_dt FROM teacher_courses tc inner join homeroom_mstr hm on hm.HRM_ID=tc.HRM_ID WHERE tc.ENABLE_FL='1' and hm.CREATED_BY !=0 and tc.TEACHER_ID="+loginUser.getUserId()+" and tc.CLASS_ID="+loginUser.getDepartmentId()+" and tc.SCHOOL_ID="+loginUser.getOrganisationId();*/
		
		sql = "SELECT hm.HRM_NAME, hm.start_dt,tcs.IS_COMPLETE FROM class_hrm_map  chm inner join homeroom_mstr hm on hm.HRM_ID=chm.HRM_ID LEFT join  teacher_courses tc on tc.HRM_ID=chm.HRM_ID "+
				" LEFT join teacher_course_sessions tcs on tcs.TEACHER_COURSE_ID=tc.TEACHER_COURSE_ID WHERE hm.CREATED_BY !=0 and chm.CLASS_ID="+departmentId;
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			OrganisationVo group = new OrganisationVo();
			group.setGroupName(rs.getString("HRM_NAME"));
			group.setStartDate(rs.getString("start_dt"));
			if(rs.getString("IS_COMPLETE") ==null){
				group.setStatus(2);
			}else{
				group.setStatus(Integer.parseInt(rs.getString("IS_COMPLETE")));
			}
			
			containers.add(group);
		}
		
		System.out.println("get records into the table...");
	} catch (SQLException se) {
		System.out.println("getContainerSessions # " + se);
		se.printStackTrace();
	} catch (Exception e) {
		System.out.println("getContainerSessions # " + e);
		e.printStackTrace();
	} finally {
		closeResources(conn, stmt, null);
	}
	return containers;
}

}
