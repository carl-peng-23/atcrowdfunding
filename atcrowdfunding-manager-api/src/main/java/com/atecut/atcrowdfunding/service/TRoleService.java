package com.atecut.atcrowdfunding.service;

import java.util.List;
import java.util.Map;

import com.atecut.atcrowdfunding.bean.TRole;
import com.github.pagehelper.PageInfo;

public interface TRoleService {

	PageInfo<TRole> listRolePage(Map<String, Object> paramMap);

	TRole getRoleById(Integer id);

	int updateRole(TRole role);

	void saveRole(String name);

	void deleteRole(Integer id);

	Map<String, List<TRole>> getAssignedAndUnssignedRole(Integer id);

	void saveAdminAndRoleRelationship(Integer adminId, Integer[] roleId);

	void deleteAdminAndRoleRelationship(Integer adminId, Integer[] roleId);

	void deleteRolePernissionRelationship(Integer roleId);

	void saveRolePernissionRelationship(Integer roleId, List<Integer> ids);

	List<Integer> getRolePermissionId(Integer roleId);

}
