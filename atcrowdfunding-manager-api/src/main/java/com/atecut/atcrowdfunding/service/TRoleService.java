package com.atecut.atcrowdfunding.service;

import java.util.Map;

import com.atecut.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

public interface TRoleService {

	PageInfo<TRole> listRolePage(Map<String, Object> paramMap);

	TRole getRoleById(Integer id);

	int updateRole(TRole role);

	void saveRole(String name);

	void deleteRole(Integer id);

}
