package com.slms.service.iface;

import java.util.List;

import com.slms.webapp.form.UserVo;

public interface AdminServiceIface {

	boolean saveAdmin(UserVo userVo, int loginId);

	List<UserVo> getAdmins(int organistionId);

	List<UserVo> getAdminsToMap();

	boolean mapAdmin(int userMapId, int organisationId);

	boolean updateAdmin(UserVo userVo, int userId);

	boolean changeAdminStatus(UserVo userVo);

	UserVo getUserDetail(int userId);

	boolean updateProfile(UserVo userVo, int userId);

	boolean updatePassword(String password, UserVo loginUser);

}
