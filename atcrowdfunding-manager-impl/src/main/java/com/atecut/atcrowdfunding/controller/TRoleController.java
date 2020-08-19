package com.atecut.atcrowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atecut.atcrowdfunding.bean.TRole;
import com.atecut.atcrowdfunding.service.TRoleService;
import com.atecut.atcrowdfunding.util.Datas;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class TRoleController {
	Logger log = LoggerFactory.getLogger(TRoleController.class);
	
	@Autowired
	TRoleService roleService;
	
	@RequestMapping("/role/index")
	public String index() {
		log.debug("跳转到role主页面");
		return "role/index";
	}

	@ResponseBody
	@RequestMapping("/role/loadData")
	public PageInfo<TRole> loadDate(@RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum,
									@RequestParam(value = "pageSize", required = false, defaultValue = "2") Integer pageSize,
									@RequestParam(value = "condition", required = false, defaultValue = "") String condition
									) {

		log.debug("查询role信息");
		PageHelper.startPage(pageNum, pageSize);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		PageInfo<TRole> page = roleService.listRolePage(map);
		return page;
	}

	@ResponseBody
	@RequestMapping("/role/getRole")
	public TRole loadDate(@RequestParam(value = "id", required = true) Integer id) {
		log.debug("通过id查询role.name信息");
		TRole role = roleService.getRoleById(id);
		log.debug("roleName={}", role);
		return role;
	}

	@ResponseBody
	@RequestMapping("/role/updateRole")
	public String updateRole(TRole role) {
		log.debug("修改角色信息");
		int i = roleService.updateRole(role);
		log.debug("修改影响的条数:{}", i);
		if(i == 1)
			return "ok";
		return "null";
	}

	@ResponseBody
	@RequestMapping("/role/saveRole")
	public String saveRole(String name) {
		log.debug("添加角色信息");
		log.debug("name:{}", name);
		roleService.saveRole(name);
		return "ok";
	}

	@ResponseBody
	@RequestMapping("/role/deleteRole")
	public String deleteRole(Integer id) {
		log.debug("删除角色信息");
		log.debug("id:{}", id);
		roleService.deleteRole(id);
		return "ok";
	}

	@ResponseBody
	@RequestMapping("/role/saveRolePernissionRelationship")
	public String saveRolePernissionRelationship(Integer roleId, Datas ids) {
		log.debug("roleId:{}", roleId);
		log.debug("ids:{}", ids.getIds());
		roleService.deleteRolePernissionRelationship(roleId);
		roleService.saveRolePernissionRelationship(roleId, ids.getIds());
		return "ok";
	}

	@ResponseBody
	@RequestMapping("/role/getRolePermissionId")
	public List<Integer> getRolePermissionId(Integer roleId) {
		log.debug("roleId:{}", roleId);
		List<Integer> list = roleService.getRolePermissionId(roleId);
		return list;
	}

	@ResponseBody
	@RequestMapping("/role/deleteRolePernissionRelationship")
	public String deleteRolePernissionRelationship(Integer roleId) {
		log.debug("roleId:{}", roleId);
		roleService.deleteRolePernissionRelationship(roleId);
		return "ok";
	}
	
}
