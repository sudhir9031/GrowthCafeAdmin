package com.slms.persistance.dao.iface;

import com.slms.webapp.form.DashboardVo;
import com.slms.webapp.form.UserVo;

public interface DashboardDao {

	DashboardVo getDashboardData(UserVo loginUser);

	UserVo login(String email, String password);

}
