package com.atecut.atcrowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atecut.atcrowdfunding.bean.TRole;
import com.atecut.atcrowdfunding.bean.TRoleExample;
import com.atecut.atcrowdfunding.mapper.TRoleMapper;
import com.atecut.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageInfo;

@Service
public class TRoleServiceImpl implements TRoleService {
	
	@Autowired
	TRoleMapper roleMapper;

	@Override
	public PageInfo<TRole> listRolePage(Map<String, Object> paramMap) {
		TRoleExample example = new TRoleExample();
		String condition = (String) paramMap.get("condition");
		List<TRole> list;
		if("".equals(condition)) {
			list = roleMapper.selectByExample(null);
		}else {
			example.createCriteria().andNameLike("%" + condition + "%");
			list = roleMapper.selectByExample(example);
		}
		PageInfo<TRole> page = new PageInfo<TRole>(list, 5);
		return page;
	}

	@Override
	public TRole getRoleById(Integer id) {
		TRole role = roleMapper.selectByPrimaryKey(id);
		return role;
	}

	@Override
	public int updateRole(TRole role) {
		return roleMapper.updateByPrimaryKey(role);
	}

	@Override
	public void saveRole(String name) {
		TRole role = new TRole();
		role.setName(name);
		roleMapper.insertSelective(role);
	}

	@Override
	public void deleteRole(Integer id) {
		roleMapper.deleteByPrimaryKey(id);
	}
}
