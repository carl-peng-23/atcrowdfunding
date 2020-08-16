package com.atecut.atcrowdfunding.service;

import java.util.List;

import com.atecut.atcrowdfunding.bean.TMenu;

public interface TMenuService {
	List<TMenu> listMenuAll();

	List<TMenu> getMenuTree();

	void saveMenu(TMenu menu);

	TMenu getMenuById(Integer id);

	void updateMenu(TMenu menu);

	void deleteMenu(Integer id);
}
