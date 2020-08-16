package com.atecut.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atecut.atcrowdfunding.bean.TMenu;
import com.atecut.atcrowdfunding.mapper.TMenuMapper;
import com.atecut.atcrowdfunding.service.TMenuService;

@Service
public class TMenuServiceImpl implements TMenuService {
	
	Logger log = org.slf4j.LoggerFactory.getLogger(TMenuServiceImpl.class);
	
	@Autowired
	TMenuMapper menuMapper;

	@Override
	public List<TMenu> listMenuAll() {
		// 存放所有menu
		List<TMenu> allList = menuMapper.selectByExample(null);
		
		// 存放父Menu的id，以及TMenu
		Map<Integer,TMenu> cache = new HashMap<Integer,TMenu>();

		// 存放所有父menu，其中带children参数
		List<TMenu> menuList = new ArrayList<TMenu>();
		for (TMenu menu : allList) {
			if(menu.getPid() == 0) {
				menuList.add(menu);
				cache.put(menu.getId(), menu);
			}
		}
		
		// 将父节点的children赋值
		for (TMenu menu : allList) {
			if(menu.getPid() != 0) {
				Integer pid = menu.getPid();
				TMenu parent = cache.get(pid);
				parent.getChildren().add(menu);
			}
		}
		log.debug("菜单={}", menuList);
		return menuList;
	}

	@Override
	public List<TMenu> getMenuTree() {
		return menuMapper.selectByExample(null);
	}

	@Override
	public void saveMenu(TMenu menu) {
		menuMapper.insertSelective(menu);
	}

	@Override
	public TMenu getMenuById(Integer id) {
		return menuMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateMenu(TMenu menu) {
		menuMapper.updateByPrimaryKeySelective(menu);
	}

	@Override
	public void deleteMenu(Integer id) {
		menuMapper.deleteByPrimaryKey(id);
	}
}
