package com.slms.service.iface;

import java.util.List;

import com.slms.webapp.form.DashboardVo;
import com.slms.webapp.form.OrganisationVo;
import com.slms.webapp.form.UserVo;

public interface DashboardServiceIface {
	
	public DashboardVo getDashboardData(UserVo loginUser);

	public List<OrganisationVo> getMasterData();

	public UserVo login(String email, String password);
}
