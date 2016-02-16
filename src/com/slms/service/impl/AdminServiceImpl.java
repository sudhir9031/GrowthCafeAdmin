package com.slms.service.impl;

import java.util.List;

import com.slms.persistance.dao.iface.AdminDao;
import com.slms.persistance.factory.LmsDaoFactory;
import com.slms.service.iface.AdminServiceIface;
import com.slms.webapp.form.UserVo;

public class AdminServiceImpl implements AdminServiceIface{

	@Override
	public boolean saveAdmin(UserVo userVo, int loginId) {
		boolean status=false;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			status = dao.saveAdmin(userVo,loginId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public List<UserVo> getAdmins(int organistionId) {
		List<UserVo> adminList=null;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			adminList = dao.getAdmins(organistionId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return adminList;
	}

	@Override
	public List<UserVo> getAdminsToMap() {
		List<UserVo> adminList=null;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			adminList = dao.getAdminsToMap();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return adminList;
	}

	@Override
	public boolean mapAdmin(int userMapId, int organisationId) {
		boolean status=false;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			status = dao.mapAdmin(userMapId,organisationId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updateAdmin(UserVo userVo, int userId) {
		boolean status=false;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			status = dao.updateAdmin(userVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean changeAdminStatus(UserVo userVo) {
		boolean status=false;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			status = dao.changeAdminStatus(userVo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public UserVo getUserDetail(int userId) {
		UserVo user=null;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			user = dao.getUserDetail(userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}

	@Override
	public boolean updateProfile(UserVo userVo, int userId) {
		boolean status=false;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			status = dao.updateProfile(userVo,userId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

	@Override
	public boolean updatePassword(String password, UserVo loginUser) {
		boolean status=false;
		try {
			AdminDao dao = (AdminDao) LmsDaoFactory.getDAO(AdminDao.class);
			status = dao.updatePassword(password,loginUser);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return status;
	}

}
