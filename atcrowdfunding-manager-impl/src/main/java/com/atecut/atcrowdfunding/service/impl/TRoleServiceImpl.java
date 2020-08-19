package com.atecut.atcrowdfunding.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.atecut.atcrowdfunding.bean.TAdminRole;
import com.atecut.atcrowdfunding.bean.TAdminRoleExample;
import com.atecut.atcrowdfunding.bean.TRole;
import com.atecut.atcrowdfunding.bean.TRoleExample;
import com.atecut.atcrowdfunding.bean.TRolePermissionExample;
import com.atecut.atcrowdfunding.mapper.TAdminRoleMapper;
import com.atecut.atcrowdfunding.mapper.TRoleMapper;
import com.atecut.atcrowdfunding.mapper.TRolePermissionMapper;
import com.atecut.atcrowdfunding.service.TRoleService;
import com.github.pagehelper.PageInfo;

@Service
public class TRoleServiceImpl implements TRoleService {
	
	@Autowired
	TRoleMapper roleMapper;
	
	
	@Autowired
	TAdminRoleMapper adminRoleMapper;
	
	@Autowired
	TRolePermissionMapper rolePermissionMapper;

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

	@Override
	public Map<String, List<TRole>> getAssignedAndUnssignedRole(Integer id) {
		TAdminRoleExample example = new TAdminRoleExample();
		example.createCriteria().andAdminidEqualTo(id);
		List<TAdminRole> list = adminRoleMapper.selectByExample(example);
		Map<String,List<TRole>> map = new HashMap<String,List<TRole>>();
		//如果没有任何角色
		if(list.size() == 0) {
			map.put("assigned", null);
			map.put("unassigned", roleMapper.selectByExample(null));
			return map;
		}
		//存放已存在的角色id
		List<Integer> roleIdList = new ArrayList<Integer>();
		for (TAdminRole adminRole : list) {
			roleIdList.add(adminRole.getRoleid());
		}
		TRoleExample e = new TRoleExample();
		e.createCriteria().andIdIn(roleIdList);
		List<TRole> assigned = roleMapper.selectByExample(e);
		e.clear();
		e.createCriteria().andIdNotIn(roleIdList);
		List<TRole> unassigned = roleMapper.selectByExample(e);
		map.put("assigned", assigned);
		map.put("unassigned", unassigned);
		return map;
	}

	@Override
	public void saveAdminAndRoleRelationship(Integer adminId, Integer[] roleId) {
		adminRoleMapper.saveAdminAndRoleRelationship(adminId, roleId);
	}

	@Override
	public void deleteAdminAndRoleRelationship(Integer adminId, Integer[] roleId) {
		adminRoleMapper.deleteAdminAndRoleRelationship(adminId, roleId);
	}

	@Override
	public void deleteRolePernissionRelationship(Integer roleId) {
		TRolePermissionExample example = new TRolePermissionExample();
		example.createCriteria().andRoleidEqualTo(roleId);
		rolePermissionMapper.deleteByExample(example);
	}

	@Override
	public void saveRolePernissionRelationship(Integer roleId, List<Integer> ids) {
		rolePermissionMapper.saveRolePernissionRelationship(roleId, ids);
	}

	@Override
	public List<Integer> getRolePermissionId(Integer roleId) {
		List<Integer> list = rolePermissionMapper.getRolePermissionId(roleId);
		return list;
	}
	
	
}
