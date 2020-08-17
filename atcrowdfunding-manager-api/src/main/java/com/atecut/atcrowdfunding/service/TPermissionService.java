package com.atecut.atcrowdfunding.service;

import java.util.List;

import com.atecut.atcrowdfunding.bean.TPermission;

public interface TPermissionService {

	List<TPermission> getPermissionTree();

	void savePermission(TPermission permission);

	TPermission getPermissionById(Integer id);

	void updateMenu(TPermission permission);

	void deletePermission(Integer id);
	
}
