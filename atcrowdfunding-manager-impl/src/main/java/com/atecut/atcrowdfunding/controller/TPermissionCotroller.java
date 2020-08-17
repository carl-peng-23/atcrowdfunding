package com.atecut.atcrowdfunding.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atecut.atcrowdfunding.bean.TPermission;
import com.atecut.atcrowdfunding.service.TPermissionService;

@Controller
public class TPermissionCotroller {
	
	@Autowired
	TPermissionService permissionService;

	@RequestMapping("/permission/index")
	public String index() {
		return "permission/index";
	}
	
	@ResponseBody
	@RequestMapping("/permission/getPermissionTree")
	public List<TPermission> getPermissionTree() {
		List<TPermission> list = permissionService.getPermissionTree();
		System.out.println(list);
		return list;
	}
	
	@ResponseBody
	@RequestMapping("/permission/savePermission")
	public String savePermission(TPermission permission) {
		permissionService.savePermission(permission);
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping("/permission/getPermissionById")
	public TPermission getMentById(@RequestParam(value = "id") Integer id) {
		TPermission permission = permissionService.getPermissionById(id);
		return permission;
	}
	
	@ResponseBody
	@RequestMapping("/permission/updatePermission")
	public String updateMenu(TPermission permission) {
		permissionService.updateMenu(permission);
		return "ok";
	}
	
	@ResponseBody
	@RequestMapping("/permission/deletePermission")
	public String deletePermission(@RequestParam(value = "id") Integer id) {
		permissionService.deletePermission(id);
		return "ok";
	}
}
